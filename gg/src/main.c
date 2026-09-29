// Pocket Dash - Game Gear proof of concept (Dry Out).
//
// Screen is 160x144, same as the Game Boy. The VDP nametable is 32x28 tiles
// (224px tall) but the level is 32 tile rows + 2 ground rows = 34 rows, so
// world tile row R lives in nametable row R % 28 and rows are streamed in as
// the camera moves vertically, the same way columns are streamed horizontally.

#include <gbdk/platform.h>
#include <stdint.h>
#include <string.h>

#include "gg_data.h"
#include "gg_music.h"
#include "player.h"

#define MAP_W            GG_LEVEL_WIDTH
#define level_map        dryout_map

#define VIEW_MT_W        10
#define RING_MT_W        16      // 16 metatile columns = 32 tile columns = nametable width
#define RING_ROWS        28      // nametable height in tiles
#define WORLD_ROWS       34      // 32 map tile rows + 2 ground tile rows
#define MAP_H            16      // metatile rows
#define MAX_V0           (WORLD_ROWS - RING_ROWS)

#define CAM_PY_MAX       128     // (256 + 16 ground) - 144
#define CAM_Y_TOP_ZONE   20
#define CAM_Y_BOTTOM_ZONE 100

// 8.8 fixed-point scroll speed, same value as the Game Boy build
#define SCROLL_SPEED_FP  714

#define BG_TRIGGER_LEAD_PX 160

// Level object types (same ids as the Game Boy build)
#define OBJ_CUBE_PORTAL   0
#define OBJ_SHIP_PORTAL   1
#define OBJ_BALL_PORTAL   2
#define OBJ_ORB_BLUE      5
#define OBJ_ORB_PINK      6
#define OBJ_GRAVITY_DOWN  8
#define OBJ_GRAVITY_UP    9
#define OBJ_PAD_YELLOW    10
#define OBJ_ORB_YELLOW    11
#define OBJ_PAD_YELLOW_UP 12
#define OBJ_PAD_BLUE      13
#define OBJ_PAD_BLUE_UP   14
#define OBJ_LEVEL_END     15
#define OBJ_PAD_PINK      37

// Sprite slots 0/1 are the player, the rest are level objects
#define PLAYER_SPRITES   2
#define FIRST_OBJ_SPRITE 2

static Player player;
static uint16_t cam_px;
static uint16_t cam_py;
static uint16_t scroll_acc;
static uint16_t loaded_mc;       // last metatile column written to the nametable
static uint8_t  v0;              // first world tile row currently valid in the nametable
static uint16_t max_scroll_px;
static uint16_t cached_col = 0xFFFF;
static uint8_t  collision_columns[32];

static uint8_t  obj_done[GG_OBJ_COUNT];   // activated flags
static uint8_t  obj_lo;                   // first object that can still be on/near screen
static uint8_t  prev_used_sprites;

static uint16_t bg_pal[16];
static uint8_t  pal_dirty;

#ifdef DEBUG_PROFILE
// Profiling aid: tints the sky while the CPU is busy (a screenshot then shows how far down the
// frame the work reaches) and draws two bars: how many of the last 64 loop iterations took more
// than one frame (top row), and the frame count of the latest iteration (second row).
#define PROF_SKY(c) do { set_palette_entry(0, 0, (c)); set_palette_entry(0, 4, (c)); set_palette_entry(0, 8, (c)); } while (0)
#define PROF_RESTORE() do { set_palette_entry(0, 0, bg_pal[0]); set_palette_entry(0, 4, bg_pal[4]); set_palette_entry(0, 8, bg_pal[8]); } while (0)
static uint16_t prof_last_t;
static uint8_t  prof_iter, prof_lag, prof_bar, prof_delta;
#else
#define PROF_SKY(c)
#define PROF_RESTORE()
#endif

static uint8_t col_full[2][WORLD_ROWS];   // both tile columns of a metatile column, world order
static uint8_t col_buf[2][RING_ROWS];     // same, in nametable ring order
static uint8_t row_buf[32];
static const uint8_t empty_col[MAP_H];

// ---------------------------------------------------------------- background streaming

static inline uint8_t ring_row(uint8_t r) {
    return (r >= RING_ROWS) ? (uint8_t)(r - RING_ROWS) : r;
}

// Build both tile columns of metatile column mc (no VRAM access).
static void prepare_column(uint16_t mc) {
    const uint8_t *mcol = (mc < MAP_W) ? &level_map[mc << 4] : empty_col;
    uint8_t *a = col_full[0];
    uint8_t *b = col_full[1];
    for (uint8_t r = 0; r < MAP_H; r++) {
        const uint8_t *t = gg_mt[*mcol++];
        *a++ = t[0]; *b++ = t[1];
        *a++ = t[2]; *b++ = t[3];
    }
    uint8_t xe = (uint8_t)(mc << 1) & 7;
    col_full[0][32] = gg_ground_top[xe];
    col_full[0][33] = gg_ground_bot[xe];
    col_full[1][32] = gg_ground_top[xe + 1];
    col_full[1][33] = gg_ground_bot[xe + 1];

    // World rows v0..v0+27 -> ring rows: v0..27 stay put, 28..v0+27 wrap to 0..v0-1
    for (uint8_t t = 0; t < 2; t++) {
        memcpy(&col_buf[t][v0], &col_full[t][v0], RING_ROWS - v0);
        if (v0) memcpy(&col_buf[t][0], &col_full[t][RING_ROWS], v0);
    }
}

static void flush_column(uint16_t mc) {
    uint8_t x = (uint8_t)(mc << 1) & 31;
    set_bkg_tiles(x, 0, 1, RING_ROWS, col_buf[0]);
    set_bkg_tiles(x + 1, 0, 1, RING_ROWS, col_buf[1]);
}

// Build a full nametable row for world row r across the 16 loaded metatile columns.
static void prepare_row(uint8_t r) {
    uint16_t mc = loaded_mc - (RING_MT_W - 1);
    if (r >= 32) {
        uint8_t x = (uint8_t)(mc << 1);
        const uint8_t *g = (r == 32) ? gg_ground_top : gg_ground_bot;
        for (uint8_t i = 0; i < 32; i++, x++) row_buf[x & 31] = g[x & 7];
        return;
    }
    uint8_t half = r >> 1;
    uint8_t sub = (r & 1) << 1;
    uint8_t xi = (uint8_t)(mc << 1) & 31;
    const uint8_t *p = &level_map[(mc << 4) + half];
    for (uint8_t k = 0; k < RING_MT_W; k++) {
        const uint8_t *t = gg_mt[(mc < MAP_W) ? *p : 0];
        row_buf[xi] = t[sub];
        row_buf[xi + 1] = t[sub + 1];
        xi = (xi + 2) & 31;
        p += 16;
        mc++;
    }
}

static void flush_row(uint8_t r) {
    set_bkg_tiles(0, ring_row(r), 32, 1, row_buf);
}

static void load_collision_columns(uint16_t mc) {
    const uint8_t *left = &level_map[mc << 4];
    const uint8_t *right = (mc + 1u < MAP_W) ? left + 16 : left;
    memcpy(collision_columns, left, 16);
    memcpy(collision_columns + 16, right, 16);
}

// ---------------------------------------------------------------- colour triggers

static void apply_g_trigger(uint8_t id) {
    uint8_t idx = (id == 31) ? 0x2C : (id == 46) ? 0x2A : (id & 0x3F);
    const uint16_t *g = gg_gnd_tab[idx];
    bg_pal[5] = g[1];
    bg_pal[6] = g[0];
    bg_pal[13] = g[0];
    bg_pal[14] = g[2];
    bg_pal[15] = g[3];
    pal_dirty = 1;
}

static void apply_bg_trigger(uint8_t id) {
    if (id == 46) {
        apply_g_trigger(46);
        return;
    }
    uint8_t idx = (id == 31) ? 0x2C : (id & 0x3F);
    uint16_t c = gg_sky_tab[idx][0];
    uint16_t d = gg_sky_tab[idx][1];
    bg_pal[0] = c;
    bg_pal[1] = d;
    bg_pal[4] = c;
    bg_pal[8] = c;
    bg_pal[9] = d;
    pal_dirty = 1;
}

// ---------------------------------------------------------------- level objects

static void process_objects(uint8_t joy) {
    uint16_t px = player.world_x;
    uint16_t py = player.world_y.b.h;
    uint16_t p_front = px + 15u;
    uint16_t p_bottom = py + PLAYER_SIZE;

    while (obj_lo < GG_OBJ_COUNT && gg_objs[obj_lo].x + 48u < px) obj_lo++;

    for (uint8_t i = obj_lo; i < GG_OBJ_COUNT; i++) {
        const GgObj *o = &gg_objs[i];
        uint16_t obj_x = o->x;
        if (obj_x > px + BG_TRIGGER_LEAD_PX) break;
        if (obj_done[i]) continue;

        uint8_t obj = o->type;

        if (obj >= 128 && obj <= 175) {
            apply_bg_trigger((uint8_t)(obj - 128));
            obj_done[i] = 1;
            continue;
        }
        if (obj >= 192 && obj <= 239) {
            apply_g_trigger((uint8_t)(obj - 192));
            obj_done[i] = 1;
            continue;
        }
        if (obj == OBJ_LEVEL_END || obj >= 38) continue;
        if (obj_x > px + 48u) continue;

        uint16_t obj_y = o->y;
        int16_t dy = (int16_t)py - (int16_t)obj_y;
        if (dy > 50 || dy < -20) continue;

        if (obj >= 16 && obj <= 19) {
            // 48-pixel wide horizontal gravity portal
            if (obj_x <= p_front && px <= obj_x + 48u && py <= obj_y + 14u && p_bottom >= obj_y) {
                uint8_t target_flipped = (obj >= 18);
                if (player.gravity_flipped != target_flipped) {
                    player.gravity_flipped = target_flipped;
                    player.vel_y.w = (player.vel_y.w >> 1);
                }
                obj_done[i] = 1;
            }
        } else if (obj_x <= p_front && px <= obj_x + 15u) {
            switch (obj) {
                case OBJ_CUBE_PORTAL:
                case OBJ_SHIP_PORTAL:
                case OBJ_BALL_PORTAL:
                    if (py <= obj_y + 49u && p_bottom >= (obj_y - 1u)) {
                        player.mode = (obj == OBJ_CUBE_PORTAL) ? MODE_CUBE
                                    : (obj == OBJ_SHIP_PORTAL) ? MODE_SHIP : MODE_BALL;
                        player.vel_y.w = (player.vel_y.w >> 1);
                        obj_done[i] = 1;
                    }
                    break;

                case OBJ_GRAVITY_DOWN:
                case OBJ_GRAVITY_UP:
                    if (py <= obj_y + 43u && p_bottom >= (obj_y + 5u)) {
                        uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                        if (player.gravity_flipped != target_flipped) {
                            player.gravity_flipped = target_flipped;
                            player.vel_y.w = (player.vel_y.w >> 1) + (player.vel_y.w >> 3);
                        }
                        obj_done[i] = 1;
                    }
                    break;

                case OBJ_PAD_YELLOW:
                case OBJ_PAD_PINK:
                case OBJ_PAD_BLUE:
                case OBJ_PAD_YELLOW_UP:
                case OBJ_PAD_BLUE_UP: {
                    uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
                    uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13u);
                    uint16_t pad_bot = is_ceiling ? (obj_y + 3u) : (obj_y + 16u);
                    if (py <= pad_bot && p_bottom >= pad_top) {
                        obj_done[i] = 1;
                        if (obj == OBJ_PAD_BLUE) {
                            if (!player.gravity_flipped) {
                                player.gravity_flipped = 1;
                                player.vel_y.w = -BLUE_PAD_FORCE;
                                player.on_ground = 0;
                            }
                        } else if (obj == OBJ_PAD_BLUE_UP) {
                            if (player.gravity_flipped) {
                                player.gravity_flipped = 0;
                                player.vel_y.w = BLUE_PAD_FORCE;
                                player.on_ground = 0;
                            }
                        } else if (obj == OBJ_PAD_PINK) {
                            int16_t force = (player.mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
                            player.vel_y.w = player.gravity_flipped ? -force : force;
                            player.on_ground = 0;
                        } else {
                            int16_t force = (player.mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
                            player.vel_y.w = player.gravity_flipped ? -force : force;
                            player.on_ground = 0;
                        }
                    }
                    break;
                }

                case OBJ_ORB_YELLOW:
                case OBJ_ORB_PINK:
                case OBJ_ORB_BLUE:
                    if ((joy & J_A) && (!(player.last_joy & J_A) || player.orb_buffered)
                        && py <= obj_y + 16u && p_bottom >= obj_y) {
                        obj_done[i] = 1;
                        player.orb_buffered = 0;
                        if (obj == OBJ_ORB_BLUE) {
                            player.gravity_flipped = !player.gravity_flipped;
                            int16_t force = (player.mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
                            player.vel_y.w = player.gravity_flipped ? -force : force;
                        } else if (obj == OBJ_ORB_PINK) {
                            int16_t force = (player.mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
                            player.vel_y.w = player.gravity_flipped ? -force : force;
                        } else {
                            int16_t force = (player.mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
                            player.vel_y.w = player.gravity_flipped ? -force : force;
                        }
                        player.on_ground = 0;
                    }
                    break;
            }
        }
    }
}

// ---------------------------------------------------------------- sprites

static inline void put_sprite(uint8_t slot, int16_t sx, int16_t sy, uint8_t tile) {
    move_sprite(slot, (uint8_t)(sx + DEVICE_SPRITE_PX_OFFSET_X), (uint8_t)(sy + DEVICE_SPRITE_PX_OFFSET_Y));
    set_sprite_tile(slot, tile);
}

// Metasprite item offsets are relative to the previous item: cube/ship halves are at dx -1 and +7.
static void draw_player(uint8_t sx, int16_t sy) {
    if (player.mode == MODE_SHIP) {
        uint8_t g = player.gravity_flipped ? 1 : 0;
        int16_t y = sy + (g ? 1 : -1);
        put_sprite(0, (int16_t)sx - 1, y, gg_ship_tiles[g][0]);
        put_sprite(1, (int16_t)sx + 7, y, gg_ship_tiles[g][1]);
    } else {
        const uint8_t *f = gg_cube_frames[(player.gravity_flipped ? 25 : 0) + player.anim_frame];
        put_sprite(0, (int16_t)sx - 1, sy, f[0]);
        put_sprite(1, (int16_t)sx + 7, sy, f[1]);
    }
}

static void hide_sprites_from(uint8_t first, uint8_t last) {
    for (uint8_t s = first; s < last; s++) hide_sprite(s);
}

static uint8_t draw_objects(uint16_t scroll_px, uint16_t cam_y) {
    uint8_t slot = FIRST_OBJ_SPRITE;
    for (uint8_t i = obj_lo; i < GG_OBJ_COUNT; i++) {
        const GgObj *o = &gg_objs[i];
        int16_t sx = (int16_t)o->x - (int16_t)scroll_px;
        if (sx > 160) break;
        if (o->type >= 64) continue;     // colour triggers have no sprites
        const GgObjDef *d = &gg_obj_defs[o->type];
        if (!d->count) continue;
        int16_t sy = (int16_t)o->y - (int16_t)cam_y;
        if (sx < -48 || sy < -48 || sy > 144) continue;

        const GgSprItem *it = &gg_spr_items[d->start];
        for (uint8_t n = d->count; n; n--, it++) {
            int16_t ix = sx + it->dx;
            int16_t iy = sy + it->dy;
            if (ix < -7 || ix > 159 || iy < -15 || iy > 143) continue;
            if (slot >= MAX_HARDWARE_SPRITES) return slot;
            put_sprite(slot++, ix, iy, it->tile);
        }
    }
    return slot;
}

// ---------------------------------------------------------------- level flow

static void set_scroll(uint16_t scroll_px, uint16_t py) {
    // Nametable pixel (0,0) is the top-left of the visible area, so no Game Gear
    // screen offset is applied (verified in Mesen).
    move_bkg((uint8_t)scroll_px, (uint8_t)py);
}

static void start_level(void) {
    DISPLAY_OFF;

    player_init(&player, 0, 240);
    cam_px = 0;
    cam_py = CAM_PY_MAX;
    scroll_acc = 0;
    cached_col = 0xFFFF;
    max_scroll_px = (uint16_t)(MAP_W - VIEW_MT_W) << 4;

    memset(obj_done, 0, sizeof(obj_done));
    obj_lo = 0;
    memcpy(bg_pal, gg_bg_palette, sizeof(bg_pal));
    set_palette(0, 1, bg_pal);
    pal_dirty = 0;

#ifdef DEBUG_START_PX
    cam_px = DEBUG_START_PX;   // debug builds can start part-way through the level
#endif
    uint16_t first_mc = cam_px >> 4;
    uint16_t scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
    first_mc = scroll_px >> 4;

    // Fill the nametable: 16 columns from the left edge of the screen, rows 6..33 (covers camera Y 128)
    v0 = MAX_V0;
    loaded_mc = first_mc + RING_MT_W - 1;
    for (uint16_t mc = first_mc; mc < first_mc + RING_MT_W; mc++) {
        prepare_column(mc);
        flush_column(mc);
    }

    set_scroll(scroll_px, cam_py);
    hide_sprites_from(0, MAX_HARDWARE_SPRITES);
    prev_used_sprites = 0;
    DISPLAY_ON;
    music_start();
}

void main(void) {
    DISPLAY_OFF;
    // Everything in the fixed banks (0/1) must stay resident, so the 0x4000 window is
    // used for the startup-only tile data (bank 3) and then the level map (bank 2).
    SWITCH_ROM(3);
    set_bkg_4bpp_data(0, GG_BG_TILE_COUNT, gg_bg_tiles);
    set_sprite_4bpp_data(0, GG_SPR_TILE_COUNT, gg_spr_tiles);
    SWITCH_ROM(2);
    set_palette(1, 1, gg_spr_palette);
    SPRITES_8x16;
    SHOW_BKG;
    SHOW_SPRITES;

#ifndef DEBUG_NOMUSIC
    add_VBL(music_tick);
#endif
    start_level();

    uint8_t dead_timer = 0;

    while (1) {
        uint8_t joy = joypad();
        if (joy & (J_UP | J_B)) joy |= J_A;
#ifdef DEBUG_PROFILE
        {
            uint16_t nt = sys_time;
            prof_delta = (uint8_t)(nt - prof_last_t);
            prof_last_t = nt;
            if (prof_delta > 1) prof_lag++;
            if (++prof_iter == 64) { prof_bar = prof_lag; prof_lag = 0; prof_iter = 0; }
        }
#endif

        if (dead_timer) {
            hide_sprites_from(0, prev_used_sprites);
            prev_used_sprites = 0;
            wait_vbl_done();
            if (--dead_timer == 0) start_level();
            continue;
        }

        PROF_SKY(RGB_YELLOW);

        // --- scroll ---
        uint16_t px_prev = cam_px >> 4;
        uint8_t needs_col = 0;
        uint16_t need_mc = 0;
        uint16_t px_curr = px_prev;

        if (cam_px < max_scroll_px) {
            scroll_acc += SCROLL_SPEED_FP;
            cam_px += scroll_acc >> 8;
            scroll_acc &= 0xFF;
            px_curr = cam_px >> 4;
            if (px_curr != px_prev) {
                uint16_t need = px_curr + VIEW_MT_W;
                if (need > loaded_mc && need < MAP_W) {
                    needs_col = 1;
                    need_mc = need;
                }
            }
        } else {
            // Reached the end of the level: restart
            music_stop();
            dead_timer = 30;
            continue;
        }

        player.world_x = cam_px;
        if (px_curr != cached_col) {
            load_collision_columns(px_curr);
            cached_col = px_curr;
        }

        process_objects(joy);
        uint8_t died = player_update(&player, joy, collision_columns, MAP_H);
#ifdef DEBUG_GODMODE
        if (died) {
            died = 0;
            player.dead = 0;
            player.world_y.w = (uint16_t)240 << 8;
            player.vel_y.w = 0;
        }
#endif

        // --- camera follow (vertical) ---
        if (!died) {
            int16_t py = (int16_t)player.world_y.b.h - (int16_t)cam_py;
            int16_t target = (int16_t)cam_py;
            if (py < CAM_Y_TOP_ZONE) target = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
            else if (py > CAM_Y_BOTTOM_ZONE) target = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
            if (target < 0) target = 0;
            if (target > CAM_PY_MAX) target = CAM_PY_MAX;
            cam_py = (uint16_t)target;
        }

        uint16_t scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
        uint8_t sprite_x = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
        int16_t final_py = (int16_t)player.world_y.b.h - (int16_t)cam_py;
        if (final_py < 0) final_py = 0;
        else if (final_py > 144) final_py = 144;

        // --- vertical streaming: decide which nametable row (if any) to load ---
        uint8_t row_pending = 0;
        uint8_t row_to_load = 0;
        uint8_t new_v0 = v0;
        {
            uint8_t cam_top = (uint8_t)(cam_py >> 3);
            uint8_t cam_bot = (uint8_t)((cam_py + 143) >> 3);
            if (cam_bot < WORLD_ROWS - 1) cam_bot++;          // 1 row of lookahead
            if (cam_top > 0) cam_top--;
            if (cam_top < v0) {
                new_v0 = v0 - 1;
                row_to_load = new_v0;
                row_pending = 1;
            } else if (cam_bot > v0 + RING_ROWS - 1 && v0 < MAX_V0) {
                row_to_load = v0 + RING_ROWS;
                new_v0 = v0 + 1;
                row_pending = 1;
            }
        }
        if (row_pending) prepare_row(row_to_load);

        if (needs_col) {
            // Columns are written for the row window that will be valid after this frame.
            uint8_t saved_v0 = v0;
            v0 = new_v0;
            prepare_column(need_mc);
            v0 = saved_v0;
        }

        // --- everything below touches VRAM/VDP registers: do it in vblank ---
        PROF_RESTORE();
        wait_vbl_done();
        set_scroll(scroll_px, cam_py);
        PROF_SKY(RGB_CYAN);

        if (pal_dirty) {
            set_palette(0, 1, bg_pal);
            pal_dirty = 0;
        }
        if (row_pending) {
            flush_row(row_to_load);
            v0 = new_v0;
        }
        if (needs_col) {
            flush_column(need_mc);
            loaded_mc = need_mc;
        }

        uint8_t used;
        if (died) {
            hide_sprites_from(0, prev_used_sprites);
            prev_used_sprites = 0;
            music_stop();
            dead_timer = 30;
        } else {
            draw_player(sprite_x, final_py);
            used = draw_objects(scroll_px, cam_py);
            if (used < prev_used_sprites) hide_sprites_from(used, prev_used_sprites);
            prev_used_sprites = used;
        }
#ifdef DEBUG_PROFILE
        PROF_RESTORE();
        for (uint8_t k = 0; k < 8; k++) {
            if (k < (prof_bar >> 3)) put_sprite(56 + k, 4 + k * 9, 2, gg_cube_frames[0][0]);
            else hide_sprite(56 + k);
            if (k < prof_delta) put_sprite(48 + k, 4 + k * 9, 20, gg_cube_frames[0][0]);
            else hide_sprite(48 + k);
        }
#endif
    }
}
