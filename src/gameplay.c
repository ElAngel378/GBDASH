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
#include "video_vbl_uploader.h"

#define BKG_MT_W 16
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9
#define TILE_CHUNK_TILES 16

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

// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 714

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

extern uint8_t music_ready;

// Mirror mode state machine
#define MIRROR_IDLE 0
#define MIRROR_LOAD_TILES 1
#define MIRROR_REDRAW_MAP 2
static uint8_t mirror_state = MIRROR_IDLE;
static uint16_t mirror_map_next = 0;
static uint16_t mirror_map_target_end = 0;

#define MIRROR_TILE_CHUNK_TILES 4
#define MIRROR_TILE_CHUNK_BYTES (MIRROR_TILE_CHUNK_TILES * 16)
static uint8_t mirror_tile_chunk[MIRROR_TILE_CHUNK_BYTES];

// Mirror tiles load state
static const uint8_t *mirror_tiles_source = 0;
static uint8_t mirror_tiles_bank = 0;
static uint16_t mirror_tile_index = 0;
static uint16_t mirror_tile_total = 0;

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

// Fast Writer: 2x1 Objects (Pads, Orbs)
static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t i = oam_idx;
    if (!reversed) {
        shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
    } else {
        shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
    }
    return 2;
}

// Fast Writer: 2x3 Objects (Gravity Portals)
static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t i = oam_idx;
    if (!reversed) {
        shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
        shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
    } else {
        shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
        shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
    }
    return 6;
}

// Fast Writer: 3x3 Objects (Cube/Ship Portals)
static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t i = oam_idx;
    if (!reversed) {
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props;
    } else {
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
        shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX;
    }
    return 9;
}

static void process_sprite_logic(
        SpCache *cache, uint16_t cam_px,
        Player* p, uint8_t joy, uint8_t* target_bg_idx
) {
    uint8_t i;
    uint16_t px = p->world_x;
    uint16_t py = p->world_y.b.h;

    // PRE-CALCULATE CONSTANTS OUTSIDE THE LOOP
    uint16_t p_front = px + 15;
    uint16_t p_bottom = py + PLAYER_SIZE;
    uint16_t p_feet = py + PLAYER_SIZE;

    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) break;

        uint16_t obj_x = cache->px[i];
        if (obj_x > cam_px + 176u) break;

        uint8_t obj = cache->obj[i];
        uint16_t obj_y = cache->py[i];

        if (obj == OBJ_LEVEL_END) {
            if (px >= (obj_x - 180)) p->level_complete = 1;
            continue;
        }

        if (obj >= 16 && obj <= 19) {
            // 48-pixel (3 tile) wide horizontal gravity portal
            if (obj_x <= p_front && px <= obj_x + 48u) {
                if (py <= obj_y + 14u && p_bottom >= obj_y) {
                    if (!cache->activated[i]) {
                        uint8_t target_flipped = (obj >= 18);
                        if (p->gravity_flipped != target_flipped) {
                            p->gravity_flipped = target_flipped;
                            p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                        }
                        cache->activated[i] = 1;
                    }
                }
            }
        } else if (obj_x + 2 <= p_front && px <= obj_x + 13) {
            switch (obj) {
                case OBJ_CUBE_PORTAL:
                case OBJ_SHIP_PORTAL:
                case OBJ_BALL_PORTAL:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[i]) {
                            if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
                            else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
                            else p->mode = MODE_BALL;
                            cache->activated[i] = 1;
                        }
                    }
                    break;

                case OBJ_GRAVITY_DOWN:
                case OBJ_GRAVITY_UP:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[i]) {
                            uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                            if (p->gravity_flipped != target_flipped) {
                                p->gravity_flipped = target_flipped;
                                p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                            }
                            cache->activated[i] = 1;
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

                    if (py <= pad_bot && p_feet >= pad_top) {
                        if (!cache->activated[i]) {
                            cache->activated[i] = 1;
                            if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
                                p->gravity_flipped = !p->gravity_flipped;
                                p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
                            } else if (obj == OBJ_PAD_PINK) {
                                int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
                                p->vel_y.w = (p->gravity_flipped) ? -force : force;
                            } else {
                                int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
                                p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
                        if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
                            if (!cache->activated[i]) {
                                cache->activated[i] = 1;
                                p->orb_buffered = 0; // Clear buffer after hit
                                if (obj == OBJ_ORB_BLUE) {
                                    p->gravity_flipped = !p->gravity_flipped;
                                    int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                } else if (obj == OBJ_ORB_PINK) {
                                    int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                } else {
                                    int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                }
                                p->on_ground = 0;
                            }
                        }
                    }
                    break;
                }

                case 100: case 101: case 102: case 103:
                    if (!cache->activated[i]) {
                        *target_bg_idx = obj - 100;
                        cache->activated[i] = 1;
                    }
                    continue;

                case OBJ_MIRROR_PORTAL:
                case OBJ_MIRROR_EXIT:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[i]) {
                            p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
                            cache->activated[i] = 1;
                        }
                    }
                    break;
            }
        } else if (obj_x > p_front + 16) {
            break;
        }
    }
}

static uint8_t draw_sprites(
        SpCache *cache, uint16_t cam_px, uint16_t cam_py,
        uint8_t reversed, uint8_t oam_start
) {
    uint8_t i;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
        if (!cache->active[i]) break;

        uint16_t obj_x = cache->px[i];
        if (obj_x > cam_px + 176u) break;

        uint8_t obj = cache->obj[i];
        uint16_t obj_y = cache->py[i];

        if (obj == OBJ_LEVEL_END || obj >= 100) continue;

        int16_t rel_x = (int16_t)obj_x - (int16_t)cam_px;
        if (rel_x < -64 || rel_x > 176) continue;

        uint8_t screen_x;
        if (reversed) {
            screen_x = 128 - (uint8_t)rel_x + 8;
        } else {
            screen_x = (uint8_t)rel_x + PLAYER_SCREEN_X + 8;
        }

        uint8_t screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;

        if (screen_x > 160 && screen_x < 232) continue;
        if (screen_y > 160 && screen_y < 208) continue;

        if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
        if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;

        // Temporary: Disable orb and pad graphics
        if (obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
            obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
            obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK) {
            continue;
        }

        const metasprite_t *sprite = famidash_sprite_table[obj];

        if (obj >= 16 && obj <= 19) {
            if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
            else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
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
    font_init();
    font_set(font_load(font_min));
}

void draw_menu(void) BANKED {
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    gotoxy(0, 0);
    printf("GD POCKET DEMO 01\n");
    for (uint8_t i = 0; i < MAX_LEVELS; i++) {
        gotoxy(1, 2 + i);
        if (i == selected) printf("0 %s", game_levels[i]->name);
        else printf("  %s", game_levels[i]->name);
    }
    printf("\n\n\n\n\n\n\nSotospro24");
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
            const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
            mirror_tiles_source = target_tiles;
            mirror_tiles_bank = level_tiles_bank;
            mirror_tile_index = 0;
            mirror_tile_total = level_tile_count;
            mirror_state = MIRROR_LOAD_TILES;
            uint16_t start_col = cam_px >> 4;
            mirror_map_next = start_col;
            mirror_map_target_end = start_col + 15;
            prev_reversed = player.reversed;
        }

        uint16_t collision_col = cam_px >> 4;
        if (collision_col != cached_collision_col) {
            load_collision_columns(collision_col, level_map, level_map_w,
                                   level_map_bank, collision_columns);
            cached_collision_col = collision_col;
        }

        // Mirror-mode incremental state machine: a tiny tile chunk per VBlank,
        // then at most one map column per frame.
        if (mirror_state == MIRROR_LOAD_TILES) {
            if (!tile_upload_busy()) {
                uint8_t chunk_tiles = (uint8_t)((mirror_tile_total - mirror_tile_index) >= MIRROR_TILE_CHUNK_TILES ? MIRROR_TILE_CHUNK_TILES : (mirror_tile_total - mirror_tile_index));
                if (chunk_tiles > 0) {
                    uint16_t chunk_bytes = (uint16_t)chunk_tiles * 16u;
                    uint8_t prev = _current_bank;
                    SWITCH_ROM(mirror_tiles_bank);
                    for (uint16_t i = 0; i < chunk_bytes; i++) {
                        mirror_tile_chunk[i] = mirror_tiles_source[(uint32_t)mirror_tile_index * 16u + i];
                    }
                    SWITCH_ROM(prev);
                    queue_tile_chunk(mirror_tile_index, chunk_tiles, mirror_tile_chunk);
                    mirror_tile_index += chunk_tiles;
                }
            }
            if (mirror_tile_index >= mirror_tile_total) {
                mirror_state = MIRROR_REDRAW_MAP;
            }
        } else if (mirror_state == MIRROR_REDRAW_MAP) {
            if (!bg_upload_busy() && mirror_map_next <= mirror_map_target_end) {
                uint16_t curr_col = mirror_map_next;
                mirror_map_next++;
                if (curr_col < level_map_w) {
                    uint8_t vram_slot = (uint8_t)(curr_col & 15);
                    if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
                    prepare_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
                }
            } else if (mirror_map_next > mirror_map_target_end) {
                mirror_state = MIRROR_IDLE;
            }
        }

        // Logic (Pads, Orbs, Portals) BEFORE player movement
        process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);

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

        // Runtime map rendering is allowed only when not already in a mirror redraw and
        // when no upload is pending. The mirror redraw has priority and should be the only
        // map-column request in a frame.
        if (mirror_state == MIRROR_IDLE && !bg_upload_busy() && needs_render) {
            loaded_r = need_col;
            uint8_t vram_slot = (uint8_t)(need_col & 15);
            if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
            prepare_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
        }

        wait_vbl_done();
        BGP_REG = bg_pals[target_bg_idx];
        move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);

        uint8_t oam_index = draw_sprites(
            &active_sp, cam_px, cam_py,
            player.reversed, 0
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

            /* // [SPRITE RELOAD DISABLED]
            set_sprite_data(0, 8, icon1_tiles);
            set_sprite_data(8, 4, ship_tiles);
            set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
            */

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
