#pragma bank 13

#include <gb/gb.h>
#include <gbdk/font.h>

#include "sp_draw.h"
#include "gameplay.h"
#include "player.h"
#include "assets.h"
#include "famidash_sprites.h"
#include "famidash_bg.h"
#include "settings.h"

#define DEBUG_MODE
#include "famidash_metatiles.h"

// The object cache is always gameplay.c's active_sp: address it directly. Through the
// SpCache* parameter SDCC reloads the pointer from the stack for every cache->x[i]
// access, which made the per-frame object loops several times slower (DMG frame drops).
extern SpCache active_sp;
#define cache (&active_sp)

// ID Mappings for SP Layer Logic
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
#define OBJ_PAD_PINK      37
#define OBJ_LEVEL_END     15
#define OBJ_MIRROR_PORTAL 126
#define OBJ_MIRROR_EXIT   121
#define OBJ_PORTAL_DN_HORIZ_DN  16
#define OBJ_PORTAL_DN_HORIZ_UP  17
#define OBJ_PORTAL_UP_HORIZ_DN  18
#define OBJ_PORTAL_UP_HORIZ_UP  19
#define OBJ_COIN1         7
#define OBJ_MINI_PORTAL   24
#define OBJ_GROW_PORTAL   25
#define OBJ_COIN2         26
#define OBJ_COIN3         27
#define OBJ_MUSIC_NOTE    74

static inline uint8_t coin_bit(uint8_t o) {
    return (o == OBJ_COIN1) ? 1 : (o == OBJ_COIN2) ? 2 : 4;
}

// Coins (Famidash): collected this attempt, and the flying-away animation per coin
uint8_t coins_collected;
uint8_t coins_saved;       // coins of this level already in the save (drawn as "X" coins)
static uint8_t coin_anim_timer[3];
static uint16_t coin_anim_x[3];
static uint16_t coin_anim_y[3];   // world y in 8.8 fixed point
static uint16_t coin_anim_speed[3];
static uint8_t coin_frame_ctr;

void coins_reset(void) BANKED {
    coins_collected = 0;
    coin_anim_timer[0] = coin_anim_timer[1] = coin_anim_timer[2] = 0;
}

// Orb / pad launch velocities per game mode, normal and mini size
// (Famidash sprite_gamemode_adjust_heights, 60fps value x 714/708).
// [mini][kind][mode]: kind 0 yellow orb, 1 yellow pad, 2 pink orb, 3 pink pad;
// mode 0 cube, 1 ship, 2 ball.
static const int16_t launch_force[2][4][3] = {
    { { JUMP_FORCE,         -1113, BALL_YELLOW_ORB },
      { PAD_JUMP_FORCE,      -968, BALL_YELLOW_PAD },
      { MAGENTA_JUMP_FORCE,  -516, BALL_PINK_ORB },
      { PINK_PAD_FORCE,      -629, BALL_PINK_PAD } },
    { { -1242, -1194, -1113 },
      { -1678, -1081, -1242 },
      {  -855,  -484,  -855 },
      { -1017,  -484,  -920 } },
};
#define LAUNCH(p, kind) launch_force[(p)->mini][(kind)][(p)->mode]

#define BG_TRIGGER_LEAD_TILES 10
#define BG_TRIGGER_LEAD_PX    ((BG_TRIGGER_LEAD_TILES) << 4)

extern const unsigned char FontPusab[];
#define FONT_PUSAB_START 0xD0

static uint8_t sp_has_drawn = 0;

// DMG draws the portals, orbs and pads, coins and mirror portals (the object cache keeps and
// draws only these there): bit (o & 7) of dmg_drawn_mask[o >> 3], for the object ids below 128.
static const uint8_t dmg_drawn_mask[16] = {
    0xE7, 0x7F, 0x0F, 0x0F, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x42
};
static inline uint8_t is_dmg_drawn(uint8_t o) {
    return o < 128 && (dmg_drawn_mask[o >> 3] & (uint8_t)(1u << (o & 7)));
}

static uint8_t dmg_portal_art_ready;
static void dmg_portal_art_init(void);

void sp_cache_reset(SpCache *cache_arg, uint16_t *stream_idx) BANKED {
    uint8_t i;
    *stream_idx = 0;
    sp_has_drawn = 0;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
    if (_cpu != CGB_TYPE && !dmg_portal_art_ready) dmg_portal_art_init();
}

// The cache update is split in two halves that run in different frames (see
// play_level): retiring objects behind the camera, then loading the new ones.
// Together with the per-frame object work they could overrun a DMG frame.
void sp_cache_retire(uint16_t cam_px) BANKED {
    uint8_t i;
    uint8_t count = 0;
    uint16_t keep_from = (cam_px >= 48u) ? (uint16_t)(cam_px - 48u) : 0;   // px + 48 >= cam_px

    /* Retire old entries and compact in a single pass */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (cache->active[i]) {
            if (cache->activated[i]) {
                uint8_t o = cache->obj[i];
                if (o >= 128) continue; // Any activated trigger can be safely pruned
                if (_cpu != CGB_TYPE && !is_dmg_drawn(o)) continue;
            }
            if (cache->px[i] >= keep_from) {
                if (count != i) {
                    cache->obj[count] = cache->obj[i];
                    cache->px[count] = cache->px[i];
                    cache->py[count] = cache->py[i];
                    cache->active[count] = 1;
                    cache->activated[count] = cache->activated[i];
                }
                count++;
            }
        }
    }
    for (i = count; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
}

void sp_cache_fill(const Level *l, uint16_t cam_px, uint16_t *stream_idx) BANKED {
    uint8_t i;
    const SpDef *sp_list = (_cpu == CGB_TYPE || !l->sp_list_dmg) ? l->sp_list : l->sp_list_dmg;

    sp_cache_load(l->sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);

    // Only draw_sprites on DMG reads sp_has_drawn
    sp_has_drawn = 0;
    if (_cpu == CGB_TYPE) return;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) break;
        uint8_t o = cache->obj[i];
        if (o < 128 && is_dmg_drawn(o)) {
            sp_has_drawn = 1;
            break;
        }
    }
}

// OAM sprite drawing routines
// 2x1 metasprite (orbs, pads)
static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }
    return 2;
}

// 2x3 metasprite (gravity portals)
static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }
    return 6;
}

// 3x3 metasprite (cube/ship portals)
static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;

        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;

        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;

        *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;

        *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }
    return 9;
}

// Horizontal gravity portal (48px wide ring)
static uint8_t draw_oam_horizontal_portal(uint8_t obj, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t pal = (obj >= 18) ? S_PAL(3) : S_PAL(2);
    uint8_t flip_v = (obj == 17 || obj == 19) ? S_FLIPY : 0;
    uint8_t base_props = pal | flip_v;

    // PT_4D = 36, PT_4F = 38, PT_51 = 40
    uint8_t t0 = 36 + tile_base;
    uint8_t t1 = 38 + tile_base;
    uint8_t t2 = 40 + tile_base;

    if (!reversed) {
        *oam++ = sy; *oam++ = sx;      *oam++ = t0; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx + 8;  *oam++ = t1; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx + 16; *oam++ = t2; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx + 24; *oam++ = t2; *oam++ = base_props | S_FLIPX;
        *oam++ = sy; *oam++ = sx + 32; *oam++ = t1; *oam++ = base_props | S_FLIPX;
        *oam++ = sy; *oam++ = sx + 40; *oam++ = t0; *oam++ = base_props | S_FLIPX;
    } else {
        // In mirror mode, the 48px portal extends to the left of sx: [sx - 40 .. sx]
        *oam++ = sy; *oam++ = sx - 40; *oam++ = t0; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx - 32; *oam++ = t1; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx - 24; *oam++ = t2; *oam++ = base_props;
        *oam++ = sy; *oam++ = sx - 16; *oam++ = t2; *oam++ = base_props | S_FLIPX;
        *oam++ = sy; *oam++ = sx - 8;  *oam++ = t1; *oam++ = base_props | S_FLIPX;
        *oam++ = sy; *oam++ = sx;      *oam++ = t0; *oam++ = base_props | S_FLIPX;
    }
    return 6;
}

inline static uint8_t draw_oam_deco(const FamidashDeco *deco, uint8_t tile_base,
                             uint8_t oam_idx, uint8_t sx, uint8_t sy,
                             uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t count = deco->count;
    const int8_t *dx = deco->x;
    const int8_t *dy = deco->y;
    const uint8_t *dt = deco->tile;
    const uint8_t *dp = deco->props;

    if (!reversed) {
        *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
        if (count > 1) {
            *oam++ = sy + dy[1]; *oam++ = sx + dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1];
            if (count > 2) {
                *oam++ = sy + dy[2]; *oam++ = sx + dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2];
            }
        }
    } else {
        uint8_t rx = sx + deco->width - 8;
        *oam++ = sy + dy[0]; *oam++ = rx - dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0] ^ S_FLIPX;
        if (count > 1) {
            *oam++ = sy + dy[1]; *oam++ = rx - dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1] ^ S_FLIPX;
            if (count > 2) {
                *oam++ = sy + dy[2]; *oam++ = rx - dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2] ^ S_FLIPX;
            }
        }
    }
    return count;
}

// 4 columns x 2 rows (8 8x16 hardware sprites = 32x32 pixels)
static uint8_t draw_oam_mirror_portal(uint8_t obj, uint8_t tile_base, uint8_t oam_idx,
                                      uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t t_base = (obj == OBJ_MIRROR_PORTAL) ? (tile_base + MIRROR_PORTAL_ENTER_TILE)
                                                : (tile_base + MIRROR_PORTAL_EXIT_TILE);
    uint8_t pal = S_PAL(6);   // entrance and exit share palette 6 (see gbc_palettes.c)
    uint8_t flip = (obj == OBJ_MIRROR_PORTAL) ? reversed : (!reversed);

    if (!flip) {
        // Row 0 (Top 16px)
        *oam++ = sy;      *oam++ = sx;      *oam++ = t_base + 0;  *oam++ = pal;
        *oam++ = sy;      *oam++ = sx + 8;  *oam++ = t_base + 2;  *oam++ = pal;
        *oam++ = sy;      *oam++ = sx + 16; *oam++ = t_base + 4;  *oam++ = pal;
        *oam++ = sy;      *oam++ = sx + 24; *oam++ = t_base + 6;  *oam++ = pal;
        // Row 1 (Bottom 16px)
        *oam++ = sy + 16; *oam++ = sx;      *oam++ = t_base + 8;  *oam++ = pal;
        *oam++ = sy + 16; *oam++ = sx + 8;  *oam++ = t_base + 10; *oam++ = pal;
        *oam++ = sy + 16; *oam++ = sx + 16; *oam++ = t_base + 12; *oam++ = pal;
        *oam++ = sy + 16; *oam++ = sx + 24; *oam++ = t_base + 14; *oam++ = pal;
    } else {
        uint8_t props = pal | S_FLIPX;
        // Row 0 (Top 16px, columns reversed)
        *oam++ = sy;      *oam++ = sx + 24; *oam++ = t_base + 0;  *oam++ = props;
        *oam++ = sy;      *oam++ = sx + 16; *oam++ = t_base + 2;  *oam++ = props;
        *oam++ = sy;      *oam++ = sx + 8;  *oam++ = t_base + 4;  *oam++ = props;
        *oam++ = sy;      *oam++ = sx;      *oam++ = t_base + 6;  *oam++ = props;
        // Row 1 (Bottom 16px, columns reversed)
        *oam++ = sy + 16; *oam++ = sx + 24; *oam++ = t_base + 8;  *oam++ = props;
        *oam++ = sy + 16; *oam++ = sx + 16; *oam++ = t_base + 10; *oam++ = props;
        *oam++ = sy + 16; *oam++ = sx + 8;  *oam++ = t_base + 12; *oam++ = props;
        *oam++ = sy + 16; *oam++ = sx;      *oam++ = t_base + 14; *oam++ = props;
    }
    return 8;
}

// Player box of the current process_sprite_logic() call, for touch_object()
static uint16_t t_py, t_bottom;

// Player overlaps the object horizontally: portals, pads, orbs. act = its activated flag.
// (Separate from process_sprite_logic: SDCC compiles one huge function very slowly.)
static void touch_object(Player* p, uint8_t obj, uint16_t obj_y, uint8_t joy, uint8_t *act) {
    switch (obj) {
        case OBJ_MINI_PORTAL:
        case OBJ_GROW_PORTAL:
            if (t_py <= obj_y + 49 && t_bottom >= (obj_y - 1)) {
                if (!*act) {
                    p->mini = (obj == OBJ_MINI_PORTAL);
                    *act = 1;
                }
            }
            break;

        case OBJ_CUBE_PORTAL:
        case OBJ_SHIP_PORTAL:
        case OBJ_BALL_PORTAL:
            // FamiDash mode portal: height 52px (obj_y - 2 to obj_y + 50)
            if (t_py <= obj_y + 49 && t_bottom >= (obj_y - 1)) {
                if (!*act) {
                    if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
                    else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
                    else p->mode = MODE_BALL;
                    p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity on portal entry
                    *act = 1;
                }
            }
            break;

        case OBJ_GRAVITY_DOWN:
        case OBJ_GRAVITY_UP:
            // FamiDash gravity portal: height 40px (obj_y + 4 to obj_y + 44)
            if (t_py <= obj_y + 43 && t_bottom >= (obj_y + 5)) {
                if (!*act) {
                    uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                    if (p->gravity_flipped != target_flipped) {
                        p->gravity_flipped = target_flipped;
                        p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                    }
                    *act = 1;
                }
            }
            break;

        case OBJ_PAD_YELLOW:
        case OBJ_PAD_PINK:
        case OBJ_PAD_BLUE:
        case OBJ_PAD_YELLOW_UP:
        case OBJ_PAD_BLUE_UP:
        {
            uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
            uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
            uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);

            if (t_py <= pad_bot && t_bottom >= pad_top) {
                if (!*act) {
                    *act = 1;
                    if (obj == OBJ_PAD_BLUE) {
                        if (!p->gravity_flipped) {
                            p->gravity_flipped = 1;
                            p->vel_y.w = -BLUE_PAD_FORCE;
                            p->on_ground = 0;
                        }
                    } else if (obj == OBJ_PAD_BLUE_UP) {
                        if (p->gravity_flipped) {
                            p->gravity_flipped = 0;
                            p->vel_y.w = BLUE_PAD_FORCE;
                            p->on_ground = 0;
                        }
                    } else if (obj == OBJ_PAD_PINK) {
                        int16_t force = LAUNCH(p, 3);
                        p->vel_y.w = (p->gravity_flipped) ? -force : force;
                        p->on_ground = 0;
                    } else {
                        int16_t force = LAUNCH(p, 1);
                        p->vel_y.w = (p->gravity_flipped) ? -force : force;
                        p->on_ground = 0;
                    }
                }
            }
            break;
        }

        case OBJ_ORB_YELLOW:
        case OBJ_ORB_PINK:
        case OBJ_ORB_BLUE:
        {
            if (joy & J_A) {
                if ((!(p->last_joy & J_A) || p->orb_buffered) && t_py <= obj_y + 16 && t_bottom >= obj_y) {
                    if (!*act) {
                        *act = 1;
                        p->orb_buffered = 0; // Clear buffer after hit
                        if (obj == OBJ_ORB_BLUE) {
                            p->gravity_flipped = !p->gravity_flipped;
                            int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
                            p->vel_y.w = (p->gravity_flipped) ? -force : force;
                        } else if (obj == OBJ_ORB_PINK) {
                            int16_t force = LAUNCH(p, 2);
                            p->vel_y.w = (p->gravity_flipped) ? -force : force;
                        } else {
                            int16_t force = LAUNCH(p, 0);
                            p->vel_y.w = (p->gravity_flipped) ? -force : force;
                        }
                        p->on_ground = 0;
                    }
                }
            }
            break;
        }


        case OBJ_MIRROR_PORTAL:
        case OBJ_MIRROR_EXIT:
            if (t_py <= obj_y + 45 && t_bottom >= (obj_y - 1)) {
                if (!*act) {
                    p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
                    *act = 1;
                }
            }
            break;
    }
}

void process_sprite_logic(
        SpCache *cache_arg, uint16_t cam_px,
        Player* p, uint8_t joy, uint8_t* target_bg_idx
) BANKED {
    uint8_t i;
    uint16_t px = p->world_x;
    uint16_t py = p->y_base + p->world_y.b.h;

    // Player box (mini: 8x7 at +4 like Famidash)
    uint16_t p_front = px + (p->mini ? MINI_BOX_RIGHT : 15u);
    uint16_t p_bottom = py + (p->mini ? (MINI_BOX_BOTTOM - 1) : PLAYER_SIZE);
    if (p->mini) py += MINI_BOX_TOP;
    t_py = py;
    t_bottom = p_bottom;
    // Loop limits, computed once (SDCC recomputes 16-bit sums on every pass otherwise)
    uint16_t lim_ahead = cam_px + 176u;
    uint16_t lim_lead = px + BG_TRIGGER_LEAD_PX;
    uint16_t lim_near = px + 48u;
    uint16_t lim_back = (px >= 48u) ? (uint16_t)(px - 48u) : 0;   // obj_x + 48 < px

    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) break;
        if (cache->activated[i]) continue;

        uint16_t obj_x = cache->px[i];
        if (obj_x > lim_ahead) break;

        uint8_t obj = cache->obj[i];

        if (obj == OBJ_LEVEL_END) {
            if (end_anim_state == END_ANIM_INACTIVE && px >= (obj_x - 180u)) {
                end_trigger_requested = 1;
                end_trigger_obj_x = obj_x;
                end_trigger_obj_y = cache->py[i];
                cache->activated[i] = 1;
            }
            continue;
        }

        if (obj != OBJ_LEVEL_END && obj_x > lim_lead) break;

        if (cache->activated[i]) continue;
        if (obj_x < lim_back) continue;

        if (obj >= 38 && obj < 64) continue;
        if (obj == OBJ_MUSIC_NOTE) continue;

        if (obj == OBJ_COIN1 || obj == OBJ_COIN2 || obj == OBJ_COIN3) {
            uint16_t cy = cache->py[i];
            if (obj_x <= p_front && px <= obj_x + 15u && py <= cy + 15u && p_bottom >= cy) {
                uint8_t n = (obj == OBJ_COIN1) ? 0 : (obj == OBJ_COIN2) ? 1 : 2;
                cache->activated[i] = 1;
                coins_collected |= coin_bit(obj);
                coin_anim_timer[n] = 1;
                coin_anim_x[n] = obj_x;
                coin_anim_y[n] = cy << 8;
                coin_anim_speed[n] = 0x0200;
            }
            continue;
        }

        if (obj >= 128 && obj <= 175) {
            if (lim_lead >= obj_x) {
                uint8_t pal_idx = (uint8_t)(obj - 128);

                if (_cpu == CGB_TYPE) {
                    famidash_apply_bg_trigger(pal_idx);
                }

                if (pal_idx < 16) {
                    *target_bg_idx = (pal_idx == 15) ? 3 : 2;
                } else if (pal_idx < 32) {
                    *target_bg_idx = 1;
                } else {
                    *target_bg_idx = 0;
                }

                cache->activated[i] = 1;
            }

            continue;
        }

        if (obj >= 192 && obj <= 239) {
            if (lim_lead >= obj_x) {
                if (_cpu == CGB_TYPE) {
                    uint8_t pal_idx = (uint8_t)(obj - 192);
                    famidash_apply_g_trigger(pal_idx);
                }
                cache->activated[i] = 1;
            }

            continue;
        }

        if (obj_x > lim_near) continue;

        uint16_t obj_y = cache->py[i];

        int16_t dy = (int16_t)py - (int16_t)obj_y;
        if (dy > 50 || dy < -20) continue;

        if (obj >= 16 && obj <= 19) {
            // 48-pixel (3 tile) wide horizontal gravity portal
            if (obj_x <= p_front && px <= obj_x + 48u) {
                if (py <= obj_y + 14u && p_bottom >= obj_y) {
                    if (!cache->activated[i]) {
                        uint8_t target_flipped = (obj >= 18);
                        if (p->gravity_flipped != target_flipped) {
                            p->gravity_flipped = target_flipped;
                            p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity
                        }
                        cache->activated[i] = 1;
                    }
                }
            }
        } else if (obj_x <= p_front && px <= obj_x + 15) {
            touch_object(p, obj, obj_y, joy, &cache->activated[i]);
        } else if (obj_x > p_front + 16) {
            break;
        }
    }
}

// Mini / growth portal (Famidash Mini_Portal / Growth_Portal: 7 8x16 sprites)
static uint8_t draw_oam_mini_portal(uint8_t obj, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    static const int8_t mx[7] = { 0, 8, -8, 0, 8, 0, 8 };
    static const uint8_t my[7] = { 0, 0, 16, 16, 16, 32, 32 };
    static const uint8_t mt[7] = { MINI_PORTAL_TILE_A, MINI_PORTAL_TILE_B, MINI_PORTAL_TILE_B + 2,
                                   MINI_PORTAL_TILE_B + 4, MINI_PORTAL_TILE_B + 6,
                                   MINI_PORTAL_TILE_A, MINI_PORTAL_TILE_B };
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t grow = (obj == OBJ_GROW_PORTAL);
    uint8_t pal = grow ? S_PAL(1) : S_PAL(4);
    for (uint8_t k = 0; k < 7; k++) {
        int8_t x = mx[k];
        if (grow) x += 8;                     // growth portal art starts 8px further right
        if (reversed) x = (int8_t)((grow ? 16 : 0) - x);  // mirror inside the portal box
        *oam++ = sy + my[k];
        *oam++ = (uint8_t)(sx + x);
        *oam++ = mt[k];
        *oam++ = pal | (k >= 5 ? S_FLIPY : 0) | (reversed ? S_FLIPX : 0);
    }
    return 7;
}

// Coin (tools/make_coin_tiles.py): 6 spin frames, 5 video frames each, 2 sprites (frame 3,
// edge on: 1 sprite, 4px in). Tile pair p: CGB COIN_TILE_BASE + 2p (VRAM bank 1); DMG
// dmg_coin_pair[p]. A coin already in the save ("gotten") is silver on CGB (the HUD text
// palette) and flickers on DMG (half transparent on the LCD).
#define COIN_FRAME_TICKS 5
static const uint8_t coin_frame_l[6] = { 0, 2, 4, 6, 7, 9 };
static const uint8_t coin_frame_r[6] = { 1, 3, 5, 0xFF, 8, 10 };
static const uint8_t coin_frame_x[6] = { 0, 0, 0, 4, 0, 0 };
static const uint8_t dmg_coin_pair[11] = {
    DMG_COIN_TILE_BASE, DMG_COIN_TILE_BASE + 2, DMG_COIN_TILE_BASE + 4, DMG_COIN_TILE_BASE + 6,
    DMG_COIN_TILE_BASE + 8, DMG_COIN_TILE_BASE + 10, DMG_COIN_TILE_BASE + 12, DMG_COIN_TILE_BASE + 14,
    DMG_COIN_TILE_B, DMG_COIN_TILE_B + 2, DMG_COIN_TILE_C
};
static uint8_t draw_oam_coin(uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t gotten) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t f = coin_frame_ctr / COIN_FRAME_TICKS;
    uint8_t l = coin_frame_l[f], r = coin_frame_r[f];
    uint8_t p, tl, tr;
    if (_cpu == CGB_TYPE) {
        p = (gotten ? S_PAL(7) : S_PAL(3)) | S_BANK;
        tl = COIN_TILE_BASE + (uint8_t)(l << 1);
        tr = COIN_TILE_BASE + (uint8_t)(r << 1);
    } else {
        if (gotten && (coin_frame_ctr & 1)) return 0;
        p = 0;
        tl = dmg_coin_pair[l];
        tr = (r == 0xFF) ? 0 : dmg_coin_pair[r];
    }
    *oam++ = sy; *oam++ = sx + coin_frame_x[f]; *oam++ = tl; *oam++ = p;
    if (r == 0xFF) return 1;
    *oam++ = sy; *oam++ = sx + 8; *oam++ = tr; *oam = p;
    return 2;
}

// Collected coins fly up and vanish after 40 frames (Famidash animate_coin_*)
static uint8_t draw_coin_anims(uint16_t cam_px, uint16_t cam_py, uint8_t reversed, uint8_t oam_start) {
    for (uint8_t n = 0; n < 3; n++) {
        if (!coin_anim_timer[n]) continue;
        coin_anim_y[n] -= coin_anim_speed[n] & 0xFF00;
        coin_anim_speed[n] -= 0x0040;
        if (++coin_anim_timer[n] >= 40) { coin_anim_timer[n] = 0; continue; }
        if (oam_start > MAX_HARDWARE_SPRITES - 2) continue;
        uint8_t dist_x = (uint8_t)coin_anim_x[n] - (uint8_t)cam_px;
        uint8_t sx = reversed ? (uint8_t)(MIRROR_PLAYER_SCREEN_X - dist_x + 8) : (uint8_t)(dist_x + PLAYER_SCREEN_X + 8);
        uint8_t sy = (uint8_t)((uint8_t)(coin_anim_y[n] >> 8) - (uint8_t)cam_py) + 16;
        if (sy > 160 && sy < 208) continue;
        oam_start += draw_oam_coin(oam_start, sx, sy, 0);
    }
    return oam_start;
}

// ---- DMG objects (tools/make_dmg_object_icons.py). Orbs and pads are ONE 8x16 sprite each, an
// icon of their type (the CGB art is 2 sprites and only differs by colour). Portals keep their
// art plus a badge with the mode symbol on their side (they also only differ by colour).
#define DMG_ICON_ORB_YELLOW 0
#define DMG_ICON_ORB_BLUE   1
#define DMG_ICON_ORB_PINK   2
#define DMG_ICON_PAD_YELLOW 3
#define DMG_ICON_PAD_BLUE   4
#define DMG_ICON_PAD_PINK   5
#define DMG_ICON_TILE       180   // orb / pad icons: over the CGB orb and pad art (tiles 180..191)
#define DMG_BADGE_CUBE      0
#define DMG_BADGE_SHIP      1
#define DMG_BADGE_BALL      2
#define DMG_BADGE_GRAVITY   3     // arrow down, S_FLIPY = up
#define DMG_BADGE_MINI      4
#define DMG_BADGE_GROW      5
// Badge tile pairs: sprite tiles 202..207 and 240..245 are unused on DMG
static const uint8_t dmg_badge_tile[6] = { 202, 204, 206, 240, 242, 244 };

// Per object id below 38. Orbs / pads: icon, its sprite y offset from the object's sprite
// position (centred: orbs 16x16, pads at the bottom of their cell, ceiling pads at the top - a
// flipped 8x16 sprite shows its top tile at the bottom) and attributes. Blue ones use OBP1
// (gameplay.c: OBP0 with shades 1 and 2 swapped). Portals: badge and its attributes.
#define NI 0xFF
const uint8_t dmg_icon[38] = {
    NI, NI, NI, NI, NI,   DMG_ICON_ORB_BLUE, DMG_ICON_ORB_PINK, NI,   NI, NI,
    DMG_ICON_PAD_YELLOW, DMG_ICON_ORB_YELLOW, DMG_ICON_PAD_YELLOW, DMG_ICON_PAD_BLUE, DMG_ICON_PAD_BLUE, NI,
    NI, NI, NI, NI,   NI, NI, NI, NI, NI, NI, NI, NI,   NI, NI, NI, NI, NI, NI, NI, NI, NI,
    DMG_ICON_PAD_PINK
};
const int8_t dmg_icon_y[38] = {
    0, 0, 0, 0, 0,   4, 4, 0,   0, 0,   8, 4, -8, 8, -8, 0,   0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 8
};
const uint8_t dmg_icon_prop[38] = {
    0, 0, 0, 0, 0,   S_PALETTE, 0, 0,   0, 0,   0, 0, S_FLIPY, S_PALETTE, S_PALETTE | S_FLIPY, 0,
    0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
static const uint8_t dmg_badge[38] = {
    DMG_BADGE_CUBE, DMG_BADGE_SHIP, DMG_BADGE_BALL, NI, NI,   NI, NI, NI,
    DMG_BADGE_GRAVITY, DMG_BADGE_GRAVITY,   NI, NI, NI, NI, NI, NI,
    DMG_BADGE_GRAVITY, DMG_BADGE_GRAVITY, DMG_BADGE_GRAVITY, DMG_BADGE_GRAVITY,
    NI, NI, NI, NI, DMG_BADGE_MINI, DMG_BADGE_GROW, NI, NI,   NI, NI, NI, NI, NI, NI, NI, NI, NI, NI
};
// Gravity portals 8 / 16 / 17 pull down (arrow down), 9 / 18 / 19 up
static const uint8_t dmg_badge_prop[38] = {
    0, 0, 0, 0, 0, 0, 0, 0,   0, S_FLIPY,   0, 0, 0, 0, 0, 0,   0, 0, S_FLIPY, S_FLIPY,
    0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
// Badge x: on the portal's side at mid height (mirror mode: the other side, mirrored). It
// must have the SAME x as the portal sprite column it covers: on DMG overlapping sprites are
// ordered by x first (smaller x in front) and only then by OAM index (the badge comes first).
// Portal sprite columns: cube/ship/ball 0/8/16, gravity 0/8, mini -8/0/8, growth 0/8/16.
// Horizontal gravity portals (48x16 ring, columns 0..40, mirror mode -40..0): the ring's
// middle is busy, so the badge goes just past its end, overlapping no portal sprite.
static const int8_t dmg_badge_x[38] = {
    16, 16, 16, 0, 0, 0, 0, 0,   8, 8,   0, 0, 0, 0, 0, 0,   48, 48, 48, 48,
    0, 0, 0, 0, 8, 16, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
static const int8_t dmg_badge_x_rev[38] = {
    0, 0, 0, 0, 0, 0, 0, 0,   0, 0,   0, 0, 0, 0, 0, 0,   -48, -48, -48, -48,
    0, 0, 0, 0, -8, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
#undef NI

// DMG object loop. The hot part (every cached object, every frame) is hand-written: SDCC kept
// all its locals on the stack and spent ~180 cycles per object. It writes the orb / pad icons
// to OAM itself and lists the rest (portals, coins, mirror portals: a few at a time) for C.
// In: dmgd_*; out: dmgd_oam, dmgd_slow_n entries of dmgd_slow (object, screen x, screen y,
// cache index).
static uint16_t dmgd_lim;      // cam_px + 176: the cache is sorted by x, stop past it
static uint16_t dmgd_ybias;    // 48 - cam_py
static uint8_t dmgd_camlo;     // (uint8_t)cam_px
static uint8_t dmgd_rev;       // mirror mode
static uint8_t dmgd_rej;       // dist_x in 137..dmgd_rej-1 is off screen (224 normal, 208 mirror)
static uint8_t dmgd_oam;       // next free OAM entry
static uint8_t dmgd_obj, dmgd_sx;
static uint8_t dmgd_slow_n;
static uint8_t dmgd_slow[MAX_ACTIVE_SP_OBJECTS * 4];

// DMG portals (and mirror portals): every frame they were drawn by the C metasprite helpers
// (9-10 sprites, up to 20% of a frame for two portals). Their sprites only depend on the portal
// kind and mirror mode, so they are recorded once (dmg_portal_art_init: the helpers drawn at
// 64, 64, plus the badge) and copied by dmg_copy_art: n, then n x (y, x, tile, attributes)
// relative to the object's sprite position.
#define DMG_PT_KINDS 13
#define DMG_PT_MAX   10
static uint8_t dmg_portal_art[2][DMG_PT_KINDS][1 + DMG_PT_MAX * 4];
static const uint8_t *dmgp_src;
static uint8_t dmgp_sx, dmgp_sy;
static const uint8_t dmg_pt_obj[DMG_PT_KINDS] = {
    OBJ_CUBE_PORTAL, OBJ_SHIP_PORTAL, OBJ_BALL_PORTAL, OBJ_GRAVITY_DOWN, OBJ_GRAVITY_UP,
    16, 17, 18, 19, OBJ_MINI_PORTAL, OBJ_GROW_PORTAL, OBJ_MIRROR_PORTAL, OBJ_MIRROR_EXIT
};

static uint8_t dmg_portal_kind(uint8_t obj) {
    if (obj <= OBJ_BALL_PORTAL) return obj;
    if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) return (uint8_t)(obj - 5);
    if (obj >= 16 && obj <= 19) return (uint8_t)(obj - 11);
    if (obj == OBJ_MINI_PORTAL || obj == OBJ_GROW_PORTAL) return (uint8_t)(obj - 15);
    if (obj == OBJ_MIRROR_PORTAL) return 11;
    if (obj == OBJ_MIRROR_EXIT) return 12;
    return 0xFF;
}

// A portal drawn the slow way: badge (in front: lower OAM index), then the art.
static uint8_t dmg_draw_portal_slow(uint8_t obj, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    if (obj == OBJ_MIRROR_PORTAL || obj == OBJ_MIRROR_EXIT)
        return draw_oam_mirror_portal(obj, FAMIDASH_SPRITE_TILE_BASE, oam_idx, sx, sy, reversed);
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t horiz = (obj >= 16 && obj <= 19);
    *oam++ = (uint8_t)(sy + (horiz ? 0 : 16));
    *oam++ = (uint8_t)(sx + (reversed ? dmg_badge_x_rev[obj] : dmg_badge_x[obj]));
    *oam++ = dmg_badge_tile[dmg_badge[obj]];
    *oam = dmg_badge_prop[obj] | (reversed ? S_FLIPX : 0);
    oam_idx++;
    if (obj == OBJ_MINI_PORTAL || obj == OBJ_GROW_PORTAL)
        return 1 + draw_oam_mini_portal(obj, oam_idx, sx, sy, reversed);
    if (horiz)
        return 1 + draw_oam_horizontal_portal(obj, FAMIDASH_SPRITE_TILE_BASE, oam_idx, sx, sy, reversed);
    if (obj >= OBJ_GRAVITY_DOWN)
        return 1 + draw_oam_2x3(famidash_sprite_table[obj], FAMIDASH_SPRITE_TILE_BASE, oam_idx, sx, sy, reversed);
    return 1 + draw_oam_3x3(famidash_sprite_table[obj], FAMIDASH_SPRITE_TILE_BASE, oam_idx, sx, sy, reversed);
}

// Uses shadow_OAM as scratch: call while the level is loading (it is redrawn every frame).
// Drawn at y 200 (below the screen: a VBlank meanwhile must not show it, which it did at the
// level start), offsets taken from (64, 200).
#define DMG_PT_REC_Y 200
static void dmg_portal_art_init(void) {
    for (uint8_t r = 0; r < 2; r++) {
        for (uint8_t k = 0; k < DMG_PT_KINDS; k++) {
            uint8_t n = dmg_draw_portal_slow(dmg_pt_obj[k], 0, 64, DMG_PT_REC_Y, r);
            uint8_t *t = dmg_portal_art[r][k];
            const uint8_t *o = (const uint8_t *)&shadow_OAM[0];
            *t++ = n;
            for (uint8_t i = 0; i < n; i++) {
                *t++ = (uint8_t)(*o++ - DMG_PT_REC_Y);
                *t++ = (uint8_t)(*o++ - 64);
                *t++ = *o++;
                *t++ = *o++;
            }
        }
    }
    dmg_portal_art_ready = 1;
}

// Copies portal art dmgp_src to OAM entry dmgd_oam at (dmgp_sx, dmgp_sy); advances dmgd_oam.
static void dmg_copy_art(void) __naked {
    __asm
        ld      hl, #_dmgp_src
        ld      a, (hl+)
        ld      h, (hl)
        ld      l, a
        ld      a, (hl+)
        ld      c, a                    ; c = sprite count (> 0)
        ld      a, (_dmgd_oam)
        ld      b, a
        add     a, c
        ld      (_dmgd_oam), a
        ld      a, b
        add     a, a
        add     a, a
        ld      e, a
        ld      d, #>_shadow_OAM        ; de = &shadow_OAM[dmgd_oam] (256 byte aligned)
        ld      a, (_dmgp_sy)
        ld      b, a
00001$:
        ld      a, (hl+)
        add     a, b
        ld      (de), a
        inc     e
        ld      a, (_dmgp_sx)
        add     a, (hl)
        inc     hl
        ld      (de), a
        inc     e
        ld      a, (hl+)
        ld      (de), a
        inc     e
        ld      a, (hl+)
        ld      (de), a
        inc     e
        dec     c
        jr      NZ, 00001$
        ret
    __endasm;
}

static void dmg_object_loop(void) __naked {
    __asm
        xor     a
        ld      (_dmgd_slow_n), a
        ld      b, a                    ; b = cache index
00001$:
        ld      a, b
        cp      a, #MAX_ACTIVE_SP_OBJECTS
        ret     NC
        ld      a, (_dmgd_oam)
        cp      a, #(MAX_HARDWARE_SPRITES - 2)
        ret     NC
        ; active[b]
        ld      hl, #(_active_sp + 80)
        ld      a, l
        add     a, b
        ld      l, a
        ld      a, h
        adc     a, #0
        ld      h, a
        ld      a, (hl)
        or      a, a
        ret     Z
        ; de = px[b]; past the screen: done (sorted by x)
        ld      a, b
        add     a, a
        add     a, #<(_active_sp + 16)
        ld      l, a
        ld      a, #>(_active_sp + 16)
        adc     a, #0
        ld      h, a
        ld      a, (hl+)
        ld      e, a
        ld      d, (hl)
        ld      a, (_dmgd_lim)
        sub     a, e
        ld      a, (_dmgd_lim + 1)
        sbc     a, d
        ret     C
        ; c = dist_x = (uint8_t)px - camlo
        ld      a, (_dmgd_camlo)
        ld      c, a
        ld      a, e
        sub     a, c
        ld      c, a
        ; obj = obj[b]
        ld      hl, #_active_sp
        ld      a, l
        add     a, b
        ld      l, a
        ld      a, h
        adc     a, #0
        ld      h, a
        ld      a, (hl)
        ld      (_dmgd_obj), a
        cp      a, #38
        jp      C, 00002$
        cp      a, #OBJ_MIRROR_PORTAL
        jp      Z, 00002$
        cp      a, #OBJ_MIRROR_EXIT
        jp      NZ, 00009$
00002$:
        ; off screen when 137 <= dist_x < rej
        ld      a, (_dmgd_rej)
        sub     a, #137
        ld      d, a
        ld      a, c
        sub     a, #137
        cp      a, d
        jp      C, 00009$
        ; screen x: normal dist_x + PLAYER_SCREEN_X + 8, mirror MIRROR_PLAYER_SCREEN_X + 8 - dist_x
        ld      a, (_dmgd_rev)
        or      a, a
        jp      NZ, 00003$
        ld      a, c
        add     a, #(PLAYER_SCREEN_X + 8)
        jp      00004$
00003$:
        ld      a, #(MIRROR_PLAYER_SCREEN_X + 8)
        sub     a, c
00004$:
        ld      (_dmgd_sx), a
        ; d = py[b] + ybias; on screen (48px margin) when <= 192
        ld      a, b
        add     a, a
        add     a, #<(_active_sp + 48)
        ld      l, a
        ld      a, #>(_active_sp + 48)
        adc     a, #0
        ld      h, a
        ld      a, (_dmgd_ybias)
        add     a, (hl)
        ld      e, a
        inc     hl
        ld      a, (_dmgd_ybias + 1)
        adc     a, (hl)
        jp      NZ, 00009$
        ld      a, #192
        cp      a, e
        jp      C, 00009$
        ld      a, e
        sub     a, #32
        ld      e, a                    ; e = screen y
        ; orb / pad: one icon sprite
        ld      a, (_dmgd_obj)
        cp      a, #38
        jp      NC, 00005$
        ld      c, a                    ; c = obj (dist_x no longer needed)
        ld      hl, #_dmg_icon
        add     a, l
        ld      l, a
        ld      a, h
        adc     a, #0
        ld      h, a
        ld      a, (hl)
        cp      a, #0xFF
        jp      Z, 00005$
        add     a, a
        add     a, #DMG_ICON_TILE
        ld      d, a                    ; d = tile
        ; hl = &shadow_OAM[dmgd_oam] (shadow_OAM is 256 byte aligned)
        ld      a, (_dmgd_oam)
        inc     a
        ld      (_dmgd_oam), a
        dec     a
        add     a, a
        add     a, a
        push    bc
        ld      c, a
        ; y = screen y + dmg_icon_y[obj]
        ld      hl, #_dmg_icon_y
        ld      a, (_dmgd_obj)
        add     a, l
        ld      l, a
        ld      a, h
        adc     a, #0
        ld      h, a
        ld      a, (hl)
        add     a, e
        ld      h, #>_shadow_OAM
        ld      l, c
        ld      (hl+), a
        ld      a, (_dmgd_sx)
        add     a, #4
        ld      (hl+), a
        ld      a, d
        ld      (hl+), a
        push    hl
        ld      hl, #_dmg_icon_prop
        ld      a, (_dmgd_obj)
        add     a, l
        ld      l, a
        ld      a, h
        adc     a, #0
        ld      h, a
        ld      a, (hl)
        pop     hl
        ld      (hl), a
        pop     bc
        jp      00009$
00005$:
        ; anything else: to the list for C (object, screen x, screen y, cache index)
        ld      a, (_dmgd_slow_n)
        cp      a, #MAX_ACTIVE_SP_OBJECTS
        jp      NC, 00009$
        inc     a
        ld      (_dmgd_slow_n), a
        dec     a
        add     a, a
        add     a, a
        add     a, #<_dmgd_slow
        ld      l, a
        ld      a, #>_dmgd_slow
        adc     a, #0
        ld      h, a
        ld      a, (_dmgd_obj)
        ld      (hl+), a
        ld      a, (_dmgd_sx)
        ld      (hl+), a
        ld      a, e
        ld      (hl+), a
        ld      (hl), b
00009$:
        inc     b
        jp      00001$
    __endasm;
}

static uint8_t draw_sprites_dmg(uint16_t cam_px, uint16_t cam_py, uint8_t reversed, uint8_t oam_start) {
    dmgd_lim = cam_px + 176u;
    dmgd_ybias = 48u - cam_py;
    dmgd_camlo = (uint8_t)cam_px;
    dmgd_rev = reversed;
    dmgd_rej = reversed ? 208 : 224;
    dmgd_oam = oam_start;
    dmg_object_loop();
    oam_start = dmgd_oam;

    const uint8_t *e = dmgd_slow;
    for (uint8_t n = dmgd_slow_n; n; n--, e += 4) {
        uint8_t obj = e[0], screen_x = e[1], screen_y = e[2];
        if (obj == OBJ_COIN1 || obj == OBJ_COIN2 || obj == OBJ_COIN3) {
            if (cache->activated[e[3]]) continue;
            if (oam_start > MAX_HARDWARE_SPRITES - 2) break;
            oam_start += draw_oam_coin(oam_start, screen_x, screen_y, coins_saved & coin_bit(obj));
            continue;
        }
        uint8_t kind = dmg_portal_kind(obj);
        if (kind == 0xFF) continue;
        const uint8_t *art = dmg_portal_art[reversed ? 1 : 0][kind];
        if ((uint8_t)(oam_start + art[0]) > MAX_HARDWARE_SPRITES) break;
        dmgd_oam = oam_start;
        dmgp_src = art;
        dmgp_sx = screen_x;
        dmgp_sy = screen_y;
        dmg_copy_art();
        oam_start = dmgd_oam;
    }
    return oam_start;
}

uint8_t draw_sprites(
        SpCache *cache_arg, uint16_t cam_px, uint16_t cam_py,
        uint8_t reversed, uint8_t oam_start
) BANKED {
    uint8_t i;
    uint8_t dist_x, screen_x, screen_y;
    uint8_t deco_drawn = 0;
    // Limit active decorations (4 on DMG, 12 on CGB) to keep 60 FPS
    uint8_t deco_max = (_cpu == CGB_TYPE) ? 12 : 4;

    if (++coin_frame_ctr >= 6 * COIN_FRAME_TICKS) coin_frame_ctr = 0;
    oam_start = draw_coin_anims(cam_px, cam_py, reversed, oam_start);

    // DMG: one icon sprite per object (skipped when the cache has nothing DMG draws)
    if (_cpu != CGB_TYPE) {
        if (!sp_has_drawn) return oam_start;
        return draw_sprites_dmg(cam_px, cam_py, reversed, oam_start);
    }

    uint16_t lim_ahead = cam_px + 176u;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
        if (!cache->active[i]) break;

        uint16_t obj_x = cache->px[i];
        if (obj_x > lim_ahead) break;

        uint8_t obj = cache->obj[i];
        if (obj == OBJ_LEVEL_END || obj >= 128) continue;

        dist_x = (uint8_t)obj_x - (uint8_t)cam_px;

        if (!reversed) {
            if (dist_x > 136 && dist_x < 224) continue;
            screen_x = dist_x + PLAYER_SCREEN_X + 8;
        } else {
            if (dist_x > 136 && dist_x < 208) continue;
            screen_x = MIRROR_PLAYER_SCREEN_X - dist_x + 8;
        }

        // 16-bit test: in a tall level an object 256px away would wrap onto the screen.
        // d = object y - camera y + 48, on screen (incl. 48px above) when d <= 192.
        uint16_t d = cache->py[i] - cam_py + 48u;
        if (d > 192u) continue;
        screen_y = (uint8_t)d - 32u;

        if (obj == OBJ_MINI_PORTAL || obj == OBJ_GROW_PORTAL) {
            if (oam_start > MAX_HARDWARE_SPRITES - 7) break;
            oam_start += draw_oam_mini_portal(obj, oam_start, screen_x, screen_y, reversed);
            continue;
        }

        if (obj == OBJ_COIN1 || obj == OBJ_COIN2 || obj == OBJ_COIN3) {
            if (cache->activated[i]) continue;
            if (oam_start > MAX_HARDWARE_SPRITES - 2) break;
            oam_start += draw_oam_coin(oam_start, screen_x, screen_y, coins_saved & coin_bit(obj));
            continue;
        }

        if (obj == OBJ_MIRROR_PORTAL || obj == OBJ_MIRROR_EXIT) {
            if (oam_start > MAX_HARDWARE_SPRITES - 8) break;
            oam_start += draw_oam_mirror_portal(obj, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
            continue;
        }

        if (obj >= 38) {
            if (deco_drawn >= deco_max) continue;

            if (_cpu == CGB_TYPE && obj < FAMIDASH_DECO_TABLE_SIZE) {
                const FamidashDeco *deco = famidash_deco_table[obj];
                if (deco) {
                    if (oam_start > MAX_HARDWARE_SPRITES - deco->count) break;
                    deco_drawn++;
                    oam_start += draw_oam_deco(deco, FAMIDASH_SPRITE_TILE_BASE,
                                               oam_start, screen_x, screen_y, reversed);
                }
            }
            continue;
        }

        if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
        const metasprite_t *sprite = famidash_sprite_table[obj];
        if (sprite == 0) continue;

        if (obj >= 16 && obj <= 19) {
            oam_start += draw_oam_horizontal_portal(obj, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
            oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
            oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        } else {
            oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        }
    }
    return oam_start;
}

void setup_menu_font(void) BANKED {
    set_bkg_data(FONT_PUSAB_START, 39, FontPusab);
}

void draw_text(uint8_t x, uint8_t y, const char *str) BANKED {
    uint8_t tile;
    while (*str) {
        char c = *str;
        if (c == ' ') tile = 0;
        else if (c == '%') tile = 1;
        else if (c == '/') tile = 2;
        else if (c >= '0' && c <= '9') tile = (c - '0') + 3;
        else if (c >= 'A' && c <= 'Z') tile = (c - 'A') + 13;
        else if (c >= 'a' && c <= 'z') tile = (c - 'a') + 13;
        else tile = 0;
        set_bkg_tile_xy(x++, y, FONT_PUSAB_START + tile);
        str++;
    }
}
