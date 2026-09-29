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
#include "player.h"

#define MAP_W            GG_LEVEL_WIDTH
#define level_map        dryout_map

#define VIEW_MT_W        10
#define RING_MT_W        16      // 16 metatile columns = 32 tile columns = nametable width
#define RING_ROWS        28      // nametable height in tiles
#define WORLD_ROWS       34      // 32 map tile rows + 2 ground tile rows
#define MAP_H            16      // metatile rows

#define CAM_PY_MAX       128     // (256 + 16 ground) - 144
#define CAM_Y_TOP_ZONE   20
#define CAM_Y_BOTTOM_ZONE 100

// 8.8 fixed-point scroll speed, same value as the Game Boy build
#define SCROLL_SPEED_FP  714

#define PLAYER_TILE_XOFF (-1)    // left half of the cube; right half is +8

static Player player;
static uint16_t cam_px;
static uint16_t cam_py;
static uint16_t scroll_acc;
static uint16_t loaded_mc;       // last metatile column written to the nametable
static uint8_t  v0;              // first world tile row currently valid in the nametable
static uint16_t max_scroll_px;
static uint8_t  prev_joy;
static uint16_t cached_col = 0xFFFF;
static uint8_t  collision_columns[32];

static uint8_t col_buf[2][RING_ROWS];
static uint8_t row_buf[32];

static inline uint8_t ring_row(uint8_t r) {
    return (r >= RING_ROWS) ? (uint8_t)(r - RING_ROWS) : r;
}

static uint8_t world_tile(uint16_t x, uint8_t r) {
    if (r >= WORLD_ROWS) return 0;
    if (r >= 32) return (r == 32 ? gg_ground_top : gg_ground_bot)[x & 7];
    uint16_t mc = x >> 1;
    if (mc >= MAP_W) return 0;
    return gg_mt[level_map[(mc << 4) + (r >> 1)]][((r & 1) << 1) | (x & 1)];
}

// Build the two tile columns of a metatile column (no VRAM access).
static void prepare_column(uint16_t mc) {
    for (uint8_t t = 0; t < 2; t++) {
        uint16_t x = (mc << 1) | t;
        uint8_t r = v0;
        uint8_t dst = ring_row(r);
        for (uint8_t i = 0; i < RING_ROWS; i++) {
            col_buf[t][dst] = world_tile(x, r);
            r++;
            if (++dst == RING_ROWS) dst = 0;
        }
    }
}

static void flush_column(uint16_t mc) {
    uint8_t x = (uint8_t)(mc << 1) & 31;
    set_bkg_tiles(x, 0, 1, RING_ROWS, col_buf[0]);
    set_bkg_tiles(x + 1, 0, 1, RING_ROWS, col_buf[1]);
}

// Build a full nametable row for world row r across the 16 loaded metatile columns.
static void prepare_row(uint8_t r) {
    uint16_t x = (uint16_t)(loaded_mc - (RING_MT_W - 1)) << 1;
    for (uint8_t i = 0; i < 32; i++, x++) {
        row_buf[x & 31] = world_tile(x, r);
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

static void hide_player(void) {
    move_sprite(0, 0, 0);
    move_sprite(1, 0, 0);
}

static void draw_player(uint8_t sx, int16_t sy) {
    uint8_t f = player.anim_frame;
    uint8_t y = (uint8_t)(sy + DEVICE_SPRITE_PX_OFFSET_Y);
    set_sprite_tile(0, gg_cube_frames[f][0]);
    set_sprite_tile(1, gg_cube_frames[f][1]);
    move_sprite(0, (uint8_t)(sx + DEVICE_SPRITE_PX_OFFSET_X + PLAYER_TILE_XOFF), y);
    move_sprite(1, (uint8_t)(sx + DEVICE_SPRITE_PX_OFFSET_X + 8), y);
}

static void set_scroll(uint16_t scroll_px, uint16_t py) {
    // Nametable row/column 0 is the top/left of the *visible* area here, so no
    // Game Gear screen offset is applied (verified in Mesen).
    move_bkg((uint8_t)scroll_px, (uint8_t)(py % 224u));
}

static uint16_t player_scroll_px(void) {
    return (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
}

static void start_level(void) {
    DISPLAY_OFF;

    player_init(&player, 0, 240);
    cam_px = 0;
    cam_py = CAM_PY_MAX;
    scroll_acc = 0;
    prev_joy = 0;
    cached_col = 0xFFFF;
    max_scroll_px = (uint16_t)(MAP_W - VIEW_MT_W) << 4;

    // Fill the nametable: columns 0..15, rows 6..33 (covers camera Y 128)
    v0 = WORLD_ROWS - RING_ROWS;
    loaded_mc = RING_MT_W - 1;
    for (uint16_t mc = 0; mc < RING_MT_W; mc++) {
        prepare_column(mc);
        flush_column(mc);
    }

    set_scroll(0, cam_py);
    hide_player();
    DISPLAY_ON;
}

void main(void) {
    DISPLAY_OFF;
    set_bkg_4bpp_data(0, GG_BG_TILE_COUNT, gg_bg_tiles);
    set_sprite_4bpp_data(0, GG_SPR_TILE_COUNT, gg_spr_tiles);
    set_palette(0, 1, gg_bg_palette);
    set_palette(1, 1, gg_spr_palette);
    SPRITES_8x16;
    SHOW_BKG;
    SHOW_SPRITES;

    start_level();

    uint8_t dead_timer = 0;

    while (1) {
        uint8_t joy = joypad();
        if (joy & (J_UP | J_B)) joy |= J_A;

        if (dead_timer) {
            hide_player();
            wait_vbl_done();
            if (--dead_timer == 0) start_level();
            continue;
        }

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
            dead_timer = 30;
            continue;
        }

        player.world_x = cam_px;
        if (px_curr != cached_col) {
            load_collision_columns(px_curr);
            cached_col = px_curr;
        }

        uint8_t died = player_update(&player, joy, collision_columns, MAP_H);
        prev_joy = joy;

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

        uint16_t scroll_px = player_scroll_px();
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
            } else if (cam_bot > v0 + RING_ROWS - 1 && v0 + RING_ROWS < WORLD_ROWS) {
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
        wait_vbl_done();
        set_scroll(scroll_px, cam_py);

        if (row_pending) {
            flush_row(row_to_load);
            v0 = new_v0;
        }
        if (needs_col) {
            flush_column(need_mc);
            loaded_mc = need_mc;
        }

        if (died) {
            hide_player();
            dead_timer = 30;
        } else {
            draw_player(sprite_x, final_py);
        }
    }
}
