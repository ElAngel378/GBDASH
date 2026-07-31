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
#include "../levels/chr_data/chr_gb.h"
#include "famidash_metatiles.h"
#include "hUGEDriver.h"

#define BKG_MT_W 16
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9
// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 708

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

extern uint8_t music_ready;

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
    move_bkg(0, (uint8_t)cam_py);
    fill_scroll_bg(level_map, level_map_w, level_map_bank);
    BGP_REG = bg_pals[0];
    OBP0_REG = 0xE4;
    SPRITES_8x16;
    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;
    TAC_REG = 0x04;
    enable_interrupts();

    uint16_t scroll_acc = 0;
    uint8_t prev_joy = 0;
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
        process_sp_objects(l, &player, joy, &target_bg_idx);
        died = player_update(&player, joy, level_map, level_map_w, level_map_h, level_map_bank);

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
            draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank);
        }

        if (player.mode == MODE_SHIP) {
            if (player.gravity_flipped) {
                if (player.reversed) move_metasprite_hvflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 24);
                else move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 24);
            } else {
                if (player.reversed) move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 16);
                else move_metasprite(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 16);
            }
        } else {
            if (player.gravity_flipped) {
                if (player.reversed) move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 22, final_py + 16);
                else move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 22, final_py + 16);
            } else {
                if (player.reversed) move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 22, final_py + 16);
                else move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 8, final_py + 16);
            }
        }

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
            cam_px = 0;
            cam_py = 112;
            scroll_acc = 0;
            loaded_r = BKG_MT_W - 1;
            target_bg_idx = 0;
            player_init(&player, 0, 240);
            move_bkg(0, (uint8_t)cam_py);
            BGP_REG = bg_pals[0];
            fill_scroll_bg(level_map, level_map_w, level_map_bank);
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
