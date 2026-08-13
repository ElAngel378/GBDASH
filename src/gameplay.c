#pragma bank 1

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

// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 714

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

extern uint8_t music_ready;

static const uint8_t level_sprite_cost_table[38] = {
    9, 9, 0, 0, 0, 2, 2, 0, 9, 9, 2, 2, 2, 2, 2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    2
};

void sp_cache_reset(ActiveSp *cache, uint16_t *stream_idx) {
    uint8_t i;
    *stream_idx = 0;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache[i].active = 0;
}

void sp_cache_update(const Level *l, uint16_t cam_px,
                     ActiveSp *cache, uint16_t *stream_idx) {
    uint8_t i;
    uint8_t count = 0;
    uint8_t sp_bank = l->sp_bank;
    const SpDef *sp_list = l->sp_list;

    /* Retire entries that are behind the player's collision window. */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        uint16_t object_x;
        if (!cache[i].active) continue;
        object_x = (uint16_t)cache[i].def.c << 4;
        if (object_x + 32u < cam_px) cache[i].active = 0;
    }

    /* Compact in stream order so newly loaded entries remain ordered. */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (cache[i].active) {
            if (count != i) cache[count] = cache[i];
            count++;
        }
    }
    while (count < MAX_ACTIVE_SP_OBJECTS) cache[count++].active = 0;

    sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx);
}

static uint8_t render_level_sprites(const ActiveSp *cache, uint8_t draw_offset,
                                    uint16_t map_height, uint16_t cam_px, uint16_t cam_py,
    uint8_t reversed, uint8_t oam_start) {
    uint8_t i;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
        uint8_t slot = (draw_offset + i) & (MAX_ACTIVE_SP_OBJECTS - 1);
        uint8_t obj;
        uint16_t object_x;
        uint16_t object_y;
        if (!cache[slot].active) continue;
        obj = cache[slot].def.obj;
        if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;
        object_x = (uint16_t)cache[slot].def.c << 4;
        object_y = (uint16_t)(map_height - 1u - cache[slot].def.r) << 4;

        // 1. Calculate the object's relative distance from the player
        int16_t screen_x = (int16_t)(object_x - cam_px);

        // 2. Anchor to the player's screen position + Game Boy hardware offset (8)
        if (reversed) {
            // In mirror mode, the player anchors at 128 on the screen
            screen_x = 128 - screen_x + 8;
        } else {
            // Normal mode anchors at PLAYER_SCREEN_X (32)
            screen_x = screen_x + PLAYER_SCREEN_X + 8;
        }

        int16_t screen_y = (int16_t)(object_y - cam_py) + 16;
        uint8_t used;

        // Culling bounds check
        if (screen_x < -24 || screen_x > 160 || screen_y < -48 || screen_y > 144) continue;

        uint8_t cost = level_sprite_cost_table[obj];
        if (oam_start + cost > MAX_HARDWARE_SPRITES - 2) break;

        const metasprite_t *sprite = famidash_sprite_table[obj];

        if (reversed) {
            used = move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE,
                                         oam_start, (uint8_t)screen_x,
                                         (uint8_t)screen_y);
        } else {
            used = move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE,
                                   oam_start, (uint8_t)screen_x,
                                   (uint8_t)screen_y);
        }
        oam_start += used;
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
    ActiveSp active_sp[MAX_ACTIVE_SP_OBJECTS];
    uint16_t sp_stream_idx = 0;
    uint8_t sp_draw_offset = 0;
    uint16_t sp_cache_col = 0xFFFF;
    uint8_t collision_columns[32];
    uint16_t cached_collision_col = 0xFFFF;
    sp_cache_reset(active_sp, &sp_stream_idx);
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
        uint8_t prev_reversed = player.reversed;

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
            sp_cache_update(l, cam_px, active_sp, &sp_stream_idx);
            sp_cache_col = cam_px >> 4;
        }
        process_sp_objects(level_map_h, &player, joy, &target_bg_idx, active_sp);

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

        sp_draw_offset = (sp_draw_offset + 9u) & (MAX_ACTIVE_SP_OBJECTS - 1u);
        uint8_t oam_index = render_level_sprites(active_sp, sp_draw_offset,
                                                  l->map_height, cam_px, cam_py,
                                                  player.reversed, 0);

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
            sp_cache_reset(active_sp, &sp_stream_idx);
            sp_draw_offset = 0;
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
