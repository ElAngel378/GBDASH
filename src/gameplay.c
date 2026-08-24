#pragma bank 10

#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <stdio.h>

#include "gameplay.h"
#include "player.h"
#include "assets.h"
#include "icon1.h"
#include "ship1.h"
#include "famidash_sprites.h"
#include "../levels/chr_data/chr_gb.h"
#include "famidash_metatiles.h"
#include "hUGEDriver.h"

#define BKG_MT_W 16
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9

// ID Mappings for SP Layer Logic
#define OBJ_CUBE_PORTAL   0
#define OBJ_SHIP_PORTAL   1
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

// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 714

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

// Reserve the last N hardware sprite slots exclusively for the player
// metasprite (icon/ship use 2 hw sprites each; 4 is a safe upper bound).
// Level objects must never write into this range, otherwise the player
// draw overflows past shadow_OAM[] and corrupts adjacent WRAM.
#define PLAYER_OAM_SLOTS 4
#define OBJ_OAM_MAX      (MAX_HARDWARE_SPRITES - PLAYER_OAM_SLOTS)

extern uint8_t music_ready;

static const uint8_t level_sprite_cost_table[38] = {
    9, 9, 0, 0, 0, 2, 2, 0, 9, 9, 2, 2, 2, 2, 2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    2
};

void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
    uint8_t i;
    *stream_idx = 0;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
}

void sp_cache_update(const Level *l, uint16_t cam_px,
                     SpCache *cache, uint16_t *stream_idx) {
    uint8_t i;
    uint8_t count = 0;
    uint8_t sp_bank = l->sp_bank;
    const SpDef *sp_list = l->sp_list;

    /* Retire old entries */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) continue;
        if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
    }

    /* Compact arrays */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (cache->active[i]) {
            if (count != i) {
                cache->obj[count] = cache->obj[i];
                cache->px[count] = cache->px[i];
                cache->py[count] = cache->py[i];
                cache->active[count] = cache->active[i];
                cache->activated[count] = cache->activated[i];
            }
            count++;
        }
    }
    while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;

    sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
}

// ==========================================
// DECO HARDWARE WRITER MACROS
// ==========================================
#define DECO_1X1(t1, p1, dx, dy) do { \
    if (!reversed) { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1); oam++; \
    } else { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + 8 - (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1) ^ S_FLIPX; oam++; \
    } \
} while(0)

#define DECO_1X2(t1, t2, p1, p2, dx, dy1, dy2) do { \
    uint8_t px_val = reversed ? (screen_x + 8 - (dx)) : (screen_x + (dx)); \
    shadow_OAM[oam].y = screen_y + (dy1); shadow_OAM[oam].x = px_val; \
    shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = reversed ? ((p1) ^ S_FLIPX) : (p1); oam++; \
    shadow_OAM[oam].y = screen_y + (dy2); shadow_OAM[oam].x = px_val; \
    shadow_OAM[oam].tile = (t2) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = reversed ? ((p2) ^ S_FLIPX) : (p2); oam++; \
} while(0)

#define DECO_2X1(t1, t2, p1, p2, dx, dy) do { \
    if (!reversed) { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1); oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx) + 8; \
        shadow_OAM[oam].tile = (t2) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p2); oam++; \
    } else { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + 8 - (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1) ^ S_FLIPX; oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x - (dx); \
        shadow_OAM[oam].tile = (t2) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p2) ^ S_FLIPX; oam++; \
    } \
} while(0)

#define DECO_3X1(t1, t2, t3, p1, p2, p3, dx, dy) do { \
    if (!reversed) { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1); oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx) + 8; \
        shadow_OAM[oam].tile = (t2) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p2); oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + (dx) + 16; \
        shadow_OAM[oam].tile = (t3) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p3); oam++; \
    } else { \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + 16 - (dx); \
        shadow_OAM[oam].tile = (t1) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p1) ^ S_FLIPX; oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x + 8 - (dx); \
        shadow_OAM[oam].tile = (t2) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p2) ^ S_FLIPX; oam++; \
        shadow_OAM[oam].y = screen_y + (dy); shadow_OAM[oam].x = screen_x - (dx); \
        shadow_OAM[oam].tile = (t3) + FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop = (p3) ^ S_FLIPX; oam++; \
    } \
} while(0)

// ==========================================
// GAMEPLAY SPRITE WRITER MACROS
// ==========================================
#define DRAW_META_2X1(meta) do { \
    const metasprite_t* m = (meta); \
    if (!reversed) { \
        shadow_OAM[oam].y=screen_y; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; \
    } else { \
        shadow_OAM[oam].y=screen_y; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; \
    } \
} while(0)

#define DRAW_META_2X3(meta) do { \
    const metasprite_t* m = (meta); \
    if (!reversed) { \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; \
    } else { \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+8; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x;   shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; \
    } \
} while(0)

#define DRAW_META_3X3(meta) do { \
    const metasprite_t* m = (meta); \
    if (!reversed) { \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props; oam++; \
    } else { \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y;    shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+16; shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+16; shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x+8;  shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; m++; \
        shadow_OAM[oam].y=screen_y+32; shadow_OAM[oam].x=screen_x;    shadow_OAM[oam].tile=m->dtile+FAMIDASH_SPRITE_TILE_BASE; shadow_OAM[oam].prop=m->props^S_FLIPX; oam++; \
    } \
} while(0)

static uint8_t process_and_draw_sprites(
        SpCache *cache, uint16_t cam_px, uint16_t cam_py,
        Player* p, uint8_t joy, uint8_t* target_bg_idx, uint8_t oam_start
) {
    uint8_t sp_idx; // Renamed to completely avoid shadowing!
    uint16_t px = p->world_x;
    uint16_t py = p->world_y.b.h;
    uint8_t reversed = p->reversed;

    // PRE-CALCULATE CONSTANTS OUTSIDE THE LOOP (Massive CPU saver)
    uint16_t p_front = px + 15;
    uint16_t p_bottom = py + PLAYER_SIZE + 16;
    uint16_t p_feet = py + PLAYER_SIZE;

    for (sp_idx = 0; sp_idx < MAX_ACTIVE_SP_OBJECTS && oam_start < OBJ_OAM_MAX; sp_idx++) {
        if (!cache->active[sp_idx]) break; // Early out

        uint16_t obj_x = cache->px[sp_idx];
        if (obj_x > cam_px + 176u) break;

        uint8_t obj = cache->obj[sp_idx];
        uint16_t obj_y = cache->py[sp_idx];

        // ==========================================
        // 1. COLLISION & LOGIC
        // ==========================================
        if (obj == OBJ_LEVEL_END) {
            if (px >= (obj_x - 180)) p->level_complete = 1;
            continue;
        }

        if (obj_x <= p_front) {
            switch (obj) {
                case OBJ_CUBE_PORTAL:
                case OBJ_SHIP_PORTAL:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[sp_idx]) {
                            p->mode = (obj == OBJ_CUBE_PORTAL) ? MODE_CUBE : MODE_SHIP;
                            cache->activated[sp_idx] = 1;
                        }
                    }
                    break;

                case OBJ_GRAVITY_DOWN:
                case OBJ_GRAVITY_UP:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[sp_idx]) {
                            uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                            if (p->gravity_flipped != target_flipped) {
                                p->gravity_flipped = target_flipped;
                                p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                            }
                            cache->activated[sp_idx] = 1;
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
                    uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 12);
                    uint16_t pad_bot = is_ceiling ? (obj_y + 4) : (obj_y + 16);

                    if (py <= pad_bot && p_feet >= pad_top) {
                        if (!cache->activated[sp_idx]) {
                            cache->activated[sp_idx] = 1;
                            if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
                                p->gravity_flipped = !p->gravity_flipped;
                                p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
                            } else if (obj == OBJ_PAD_PINK) {
                                p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
                            } else {
                                p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
                            }
                            p->on_ground = 0;
                        }
                    }
                    break;
                }

                case OBJ_ORB_YELLOW:
                case OBJ_ORB_PINK:
                case OBJ_ORB_BLUE:
                {
                    if (joy & J_A) {
                        if (py <= obj_y + 16 && p_feet >= obj_y) {
                            if (!cache->activated[sp_idx]) {
                                cache->activated[sp_idx] = 1;
                                if (obj == OBJ_ORB_BLUE) {
                                    p->gravity_flipped = !p->gravity_flipped;
                                    p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
                                } else if (obj == OBJ_ORB_PINK) {
                                    p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
                                } else {
                                    p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 120 : JUMP_FORCE - 120;
                                }
                                p->on_ground = 0;
                            }
                        }
                    }
                    break;
                }

                case 100: case 101: case 102: case 103:
                    if (!cache->activated[sp_idx]) {
                        *target_bg_idx = obj - 100;
                        cache->activated[sp_idx] = 1;
                    }
                    continue;

                case OBJ_MIRROR_PORTAL:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[sp_idx]) {
                            p->reversed = 1;
                            cache->activated[sp_idx] = 1;
                        }
                    }
                    break;

                case OBJ_MIRROR_EXIT:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[sp_idx]) {
                            p->reversed = 0;
                            cache->activated[sp_idx] = 1;
                        }
                    }
                    break;
            }
        }

        // ==========================================
        // 2. RENDERING (100% INLINED JUMP TABLE)
        // ==========================================

        // Calculate relative X ONCE to save math
        uint8_t rel_x = (uint8_t)obj_x - (uint8_t)cam_px;

        uint8_t screen_x = reversed ? (136 - rel_x) : (rel_x + 40); // 40 is PLAYER_SCREEN_X (32) + 8
        uint8_t screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;

        // FAST INTERVAL CULLING (Replaces slow && branches)
        // 160 + 24 = 184. 160 + 48 = 208.
        if ((uint8_t)(screen_x + 24u) > 184u) continue;
        if ((uint8_t)(screen_y + 48u) > 208u) continue;

        if (oam_start > OBJ_OAM_MAX - 9) break;

        // Ensure we use 'oam' exclusively for the hardware array index!
        uint8_t oam = oam_start;

        if (obj >= 42 && obj <= 63) {
            switch (obj) {
                case 42: DECO_1X2(D_CF, D_C9, DP, DP, 4, 0, -16); break;
                case 43: DECO_1X2(D_CF, D_CB, DP, DP, 4, 0, -16); break;
                case 44: DECO_1X1(D_CD, DP, 4, 0); break;
                case 45: DECO_1X2(D_D5, D_D7, DP, DP, 4, 0, -16); break;

                // BUG FIXED: Spikes are flat (2x1), not tall (1x2)!
                case 46: DECO_2X1(D_D9, D_DB, DP, DP, 0, -4); break;
                case 47: DECO_2X1(D_D9, D_DB, DP|S_FLIPY, DP|S_FLIPY, 0, 4); break;
                case 48: DECO_2X1(D_DD, D_DF, DP, DP, 0, -4); break;
                case 49: DECO_2X1(D_DD, D_DF, DP|S_FLIPY, DP|S_FLIPY, 0, 4); break;

                case 50: DECO_2X1(D_E1, D_E1, DP, DP|S_FLIPX, 0, 0); break;
                case 51: DECO_1X1(D_E1, DP|S_FLIPX, 8, 0); break;
                case 52: DECO_1X1(D_E3, DP, 4, 0); break;
                case 53: DECO_1X1(D_E5, DP, 4, 0); break;
                case 54: DECO_2X1(D_E7, D_E7, DP, DP|S_FLIPX, 0, 0); break;
                case 55: DECO_2X1(D_ED, D_ED, DP, DP|S_FLIPX, 0, 0); break;
                case 56: DECO_2X1(D_F1, D_F5, DP|S_FLIPX, DP|S_FLIPX, 0, -4); break;
                case 57: DECO_2X1(D_F5, D_F1, DP, DP, 0, -4); break;
                case 58: DECO_1X2(D_CF, D_C9, DP|S_FLIPY, DP|S_FLIPY, 4, 0, 16); break;
                case 59: DECO_1X2(D_CF, D_CB, DP|S_FLIPY, DP|S_FLIPY, 4, 0, 16); break;
                case 60: DECO_1X1(D_CD, DP|S_FLIPY, 4, 0); break;
                case 61: DECO_1X2(D_D7, D_D5, DP|S_FLIPY, DP|S_FLIPY, 4, 16, 0); break;
                case 62: DECO_3X1(D_F1, D_F7, D_F5, DP|S_FLIPX, DP|S_FLIPX, DP|S_FLIPX, 0, -4); break;
                case 63: DECO_3X1(D_F1, D_F7, D_F5, DP, DP, DP, 0, -4); break;
            }
            oam_start = oam; // Save the updated index!
            continue;
        }

        // --- GAMEPLAY METASPRITES (INLINED) ---
        // BUG FIX: Prevent out-of-bounds array reads!
        if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;
        const metasprite_t *sprite = famidash_sprite_table[obj];

        if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL) {
            DRAW_META_3X3(sprite);
        } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
            DRAW_META_2X3(sprite);
        } else {
            DRAW_META_2X1(sprite);
        }

        oam_start = oam; // Save the updated index!
    }
    return oam_start;
}

void setup_menu_font(void) BANKED {
    font_init();
    font_set(font_load(font_min));
}

void draw_menu(void) BANKED {
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    gotoxy(0, 0);
    printf("GBDASH DEMO 01\n");
    for (uint8_t i = 0; i < MAX_LEVELS; i++) {
        gotoxy(1, 2 + i);
        if (i == selected) printf("0 %s", game_levels[i]->name);
        else printf("  %s", game_levels[i]->name);
    }
    printf("\n\n\n\n\n\n\n\nSotospro24");
    SHOW_BKG;
    redraw = 0;
}

void play_level(uint8_t idx) BANKED {
    const Level* l;
    const uint8_t* level_tiles;
    const uint8_t* level_map;
    uint16_t level_tile_count;
    uint16_t level_map_w;
    uint16_t level_map_h;
    uint8_t level_tiles_bank;
    uint8_t level_map_bank;

    l = game_levels[idx];
    level_tiles = l->tiles;
    level_map = l->map;
    level_tile_count = l->tile_count;
    level_map_w = l->map_width;
    level_map_h = l->map_height;
    level_tiles_bank = BANK(chr_gb);
    level_map_bank = l->map_bank;

    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    if (level_songs[idx]) {
        init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
        current_song_bank = song_bank[idx];
        music_ready = 1;
    }

    uint16_t cam_px = 0;
    uint16_t cam_py = 112;
    uint16_t cam_py_max = (level_map_h << 4);
    if (cam_py_max > 144u) cam_py_max -= 144u;
    else cam_py_max = 0;
    uint16_t loaded_r = BKG_MT_W - 1;

    uint8_t died;
    int16_t py;

    uint8_t target_bg_idx = 0;
    const uint8_t bg_pals[] = {
            0xE4, // 0: White BG
            0xE4, // 1: Light Gray BG
            0xE4, // 2: Dark Gray BG
            0x1B  // 3: Black BG
    };

    Player player;
    player_init(&player, 0, 240);

    disable_interrupts();
    DISPLAY_OFF;
    load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
    set_sprite_data(0, 8, icon1_tiles);
    set_sprite_data(8, 4, ship_tiles);
    set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
    move_bkg(0, (uint8_t)cam_py);
    fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
    BGP_REG = bg_pals[0];
    OBP0_REG = 0xE4;
    SPRITES_8x16;
    OBP1_REG = 0xE4;
    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;
    TAC_REG = 0x04;
    enable_interrupts();

    uint16_t scroll_acc = 0;
    uint8_t prev_joy = 0;
    uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
    SpCache active_sp;
    uint16_t sp_stream_idx = 0;
    uint16_t sp_cache_col = 0xFFFF;
    uint8_t collision_columns[32];
    uint16_t cached_collision_col = 0xFFFF;
    uint8_t prev_reversed = player.reversed;
    sp_cache_reset(&active_sp, &sp_stream_idx);
    while (1) {
        uint8_t joy = joypad();
        if (joy & J_START) break;

        if ((joy & J_UP) || player.level_complete) {
            HIDE_SPRITES;
            move_bkg(0, 0);
            disable_interrupts();
            setup_menu_font();
            enable_interrupts();
            fill_bkg_rect(0, 0, 20, 18, 0x00);
            gotoxy(3, 6);
            printf("LEVEL COMPLETE");
            gotoxy(3, 12);
            printf("Press A to exit");
            waitpadup();
            while (!(joypad() & J_A)) wait_vbl_done();
            break;
        }

        if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
        prev_joy = joy;

        uint16_t px_prev = cam_px >> 4;
        uint8_t needs_render = 0;
        uint16_t need_col = 0;

        // PROGRESS FORWARD through the level map
        if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
            scroll_acc += SCROLL_SPEED_FP;
            cam_px += scroll_acc >> 8;
            scroll_acc &= 0xFF;
            uint16_t px_curr = cam_px >> 4;
            if (px_curr != px_prev) {
                uint16_t need = px_curr + VIEW_MT_W;
                if (need > loaded_r && need < level_map_w) {
                    needs_render = 1;
                    need_col = need;
                }
            }
        }

        player.world_x = cam_px;
        /* SP entries are aligned to 16-pixel columns, so the cache only
         * needs banked stream work when entering a new column. */
        if ((cam_px >> 4) != sp_cache_col) {
            sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
            sp_cache_col = cam_px >> 4;
        }

        if (player.reversed != prev_reversed) {
            disable_interrupts();

            // Swap tileset in VRAM to match mirror mode orientation
            const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
            load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);

            // Instant redraw of the entire 16-column buffer
            uint16_t start_col = cam_px >> 4;
            for (uint8_t i = 0; i < 16; i++) {
                uint16_t curr_col = start_col + i;
                if (curr_col < level_map_w) {
                    uint8_t vram_slot = (uint8_t)(curr_col & 15);
                    if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
                    draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
                }
            }
            enable_interrupts();
            // Reset loaded_r to match the last column we just drew
            loaded_r = start_col + 15;
            prev_reversed = player.reversed;
        }

        uint16_t collision_col = cam_px >> 4;
        if (collision_col != cached_collision_col) {
            load_collision_columns(collision_col, level_map, level_map_w,
                                   level_map_bank, collision_columns);
            cached_collision_col = collision_col;
        }
        died = player_update(&player, joy, collision_columns, level_map_h);

        py = player_screen_y(&player, cam_py);
        if (py < CAM_Y_TOP_ZONE) {
            int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
            if (target_cam_py < 0) target_cam_py = 0;
            if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
            cam_py = (uint16_t)target_cam_py;
        }
        else if (py > CAM_Y_BOTTOM_ZONE) {
            int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
            if (target_cam_py < 0) target_cam_py = 0;
            if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
            cam_py = (uint16_t)target_cam_py;
        }

        uint16_t scroll_px;
        uint8_t sprite_x_final;
        if (player.reversed) {
            // Mirror Mode: SCX decreases as we progress forward
            scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
            sprite_x_final = 128; // Mirrored player position
        } else {
            scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
            sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
        }
        int16_t final_py = player_screen_y(&player, cam_py);

        wait_vbl_done();
        BGP_REG = bg_pals[target_bg_idx];
        move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);

        if (needs_render) {
            loaded_r = need_col;
            uint8_t vram_slot = (uint8_t)(need_col & 15);
            // Reverse tile mapping in VRAM ring buffer to create mirrored level layout
            if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
            draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
        }

        uint8_t oam_index = process_and_draw_sprites(
            &active_sp, cam_px, cam_py,
            &player, joy, &target_bg_idx, 0
        );

        if (player.mode == MODE_SHIP) {
            if (player.gravity_flipped) {
                if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
                else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
            } else {
                if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
                else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
            }
        } else {
            if (player.gravity_flipped) {
                if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
                else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
            } else {
                if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
                else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
            }
        }
        // Only clear entries that were used by the previous frame but not by
        // this one. Newly needed entries are overwritten below/above.
        if (oam_index < previous_oam_index) {
            hide_sprites_range(oam_index, previous_oam_index);
        }
        previous_oam_index = oam_index;

        if (died) {
            TAC_REG = 0x00;
            NR52_REG = 0x00;
            NR52_REG = 0x80;
            NR51_REG = 0xFF;
            NR50_REG = 0x77;
            NR41_REG = 0x00;
            NR42_REG = 0xF2;
            NR43_REG = 0x43;
            NR44_REG = 0x80;
            for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
            NR52_REG = 0x80;
            NR51_REG = 0xFF;
            NR50_REG = 0x77;
            if (level_songs[idx]) {
                init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
                current_song_bank = song_bank[idx];
            }
            disable_interrupts();
            // Restore normal tileset on death
            load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);

            cam_px = 0;
            cam_py = 112;
            scroll_acc = 0;
            loaded_r = BKG_MT_W - 1;
            target_bg_idx = 0;
            player_init(&player, 0, 240);
            sp_cache_reset(&active_sp, &sp_stream_idx);
            sp_cache_col = 0xFFFF;
            previous_oam_index = MAX_HARDWARE_SPRITES;
            cached_collision_col = 0xFFFF;
            move_bkg(0, (uint8_t)cam_py);
            BGP_REG = bg_pals[0];
            fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
            TAC_REG = 0x04;
            music_ready = 1;
            enable_interrupts();
        }
    }

    HIDE_SPRITES;
    move_bkg(0, 0);
    waitpadup();
    disable_interrupts();
    setup_menu_font();
    enable_interrupts();
    redraw = 1;
}
