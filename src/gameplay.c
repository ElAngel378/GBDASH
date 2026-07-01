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
#include "fd_portal_sprites.h"
#include "stereomadness_sprites.h"
#include "hUGEDriver.h"

#define BKG_MT_W 16
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9
// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 860

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
  printf("GBDASH DEMO 01\n\n");
  for (uint8_t i = 0; i < MAX_LEVELS; i++) {
    gotoxy(1, 2 + i);
    if (i == selected) printf("0 %s", game_levels[i]->name);
    else printf(" %s", game_levels[i]->name);
  }
  SHOW_BKG;
  redraw = 0;
}

void draw_level_sprites(uint16_t scroll_x, uint16_t scroll_y, const SpritePlacement *sprites, uint16_t count) {
    // Starting OAM index (0 is reserved for the player)
    uint8_t oam_idx = 1;

    if (!sprites) {
        // Hide all sprites if no sprite data
        for (; oam_idx < 40; oam_idx++) hide_sprite(oam_idx);
        return;
    }

    // Simple visibility window: 160px wide + some padding
    uint16_t view_left = scroll_x;
    uint16_t view_right = scroll_x + 160;

    for (uint16_t i = 0; i < count; i++) {
        const SpritePlacement *sp = &sprites[i];

        // Horizontal visibility check
        if (sp->x >= view_left - 16 && sp->x <= view_right) {
            if (oam_idx >= 40) break; // OAM Full

            int16_t screen_x = (int16_t)sp->x - (int16_t)scroll_x + 8;
            int16_t screen_y = (int16_t)sp->y - (int16_t)scroll_y + 16;

            // Vertical visibility check (off-screen sprites are moved to 0 to hide)
            if (screen_y < 0 || screen_y > 160) {
                hide_sprite(oam_idx);
            } else {
                move_sprite(oam_idx, (uint8_t)screen_x, (uint8_t)screen_y);
                set_sprite_tile(oam_idx, 0x20 + sp->tile);
            }
            oam_idx++;
        }
    }

    // Hide remaining OAM slots
    for (; oam_idx < 40; oam_idx++) {
        hide_sprite(oam_idx);
    }
}

void play_level(uint8_t idx) BANKED {
  const Level *l;
  const uint8_t *level_tiles;
  const uint8_t *level_map;
  uint16_t level_tile_count;
  uint16_t level_map_w;
  uint16_t level_map_h;
  uint8_t level_tiles_bank;
  uint8_t level_map_bank;
  const SpritePlacement *level_sprites;
  uint16_t level_sprite_count;

  // game_levels is in Bank 1
  l = game_levels[idx];
  level_tiles = l->tiles;
  level_map = l->map;
  level_tile_count = l->tile_count;
  level_map_w = l->map_width;
  level_map_h = l->map_height;
  level_tiles_bank = BANK(chr_gb);
  level_map_bank = l->map_bank;
  level_sprites = l->sprites;
  level_sprite_count = l->sprite_count;

  // Power on sound
  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  // Start level music if the level has a song
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

  Player player;
  player_init(&player, 0, 240);

  // Setup GBDK graphics state
  disable_interrupts();
  DISPLAY_OFF;
  load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);

  set_sprite_data(0, 8, icon1_tiles);
  set_sprite_data(8, 4, ship_tiles);

  // Load FamiDash portal/object sprites starting at index 32
  set_sprite_data(0x20, PORTAL_SPRITE_TILES_COUNT, (uint8_t *)portal_sprite_tiles);


  move_bkg(0, (uint8_t)cam_py);
  fill_scroll_bg(level_map, level_map_w, level_map_h, level_map_bank);

  BGP_REG = 0xE4;
  OBP0_REG = 0xE4;
  SPRITES_8x16;

  SHOW_BKG;
  SHOW_SPRITES;
  DISPLAY_ON;

  TAC_REG = 0x04; // Start the timer metronome
  enable_interrupts();

  //waitpadup();

  uint16_t scroll_acc = 0;
  uint8_t prev_joy = 0;
  while (1) {
    uint8_t joy = joypad();
    if (joy & J_START) break;

    // Toggle noclip on B press
    if ((joy & J_B) && !(prev_joy & J_B)) {
      player_noclip = !player_noclip;
    }
    prev_joy = joy;

    //  Physics and Scroll calculation
    uint16_t px_prev = cam_px >> 4;
    uint8_t needs_render = 0;
    uint16_t need_col = 0;

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
    // Player Mode logic (hardcoded for now lol)
    // Mode Portals for Stereo Madness
    if (idx == 0) {
        uint16_t col = (player.world_x + 8) >> 4;
        if (col == 266) player.mode = MODE_SHIP; // 266
        else if (col == 418) player.mode = MODE_CUBE;
        else if (col == 763) player.mode = MODE_SHIP;
    }
    // Mode Portals for Back on Track
    if (idx == 1) {
        uint16_t col = (player.world_x + 8) >> 4;
        if (col == 421) player.mode = MODE_SHIP;
        else if (col == 559) player.mode = MODE_CUBE;
    }
    // Mode Portals for Polargeist
    if (idx == 2) {
        uint16_t col = (player.world_x + 8) >> 4;
        if (col == 321) player.mode = MODE_SHIP;
        else if (col == 443) player.mode = MODE_CUBE;
    }
    // Mode Portals for Dry Out
    if (idx == 3) {
        uint16_t col = (player.world_x + 8) >> 4;
        if (col == 292) player.gravity_flipped = 1;
        else if (col == 429) player.gravity_flipped = 0;
        else if (col == 566) player.mode = MODE_SHIP;
        else if (col == 707) player.mode = MODE_CUBE;
    }


    died = player_update(&player, joy, level_map, level_map_w, level_map_h, level_map_bank);

    // Simple camera Y following math
    py = player_screen_y(&player, cam_py);
    if (py < CAM_Y_TOP_ZONE) {
      int16_t target_cam_py = player.world_y - CAM_Y_TOP_ZONE;
      if (target_cam_py < 0) target_cam_py = 0;
      if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
      cam_py = (uint16_t)target_cam_py;
    } else if (py > CAM_Y_BOTTOM_ZONE) {
      int16_t target_cam_py = player.world_y - CAM_Y_BOTTOM_ZONE;
      if (target_cam_py < 0) target_cam_py = 0;
      if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
      cam_py = (uint16_t)target_cam_py;
    }

    // Calculate final positions
    uint16_t scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
    uint8_t sprite_x = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
    int16_t final_py = player_screen_y(&player, cam_py);

    // WAIT FOR VBLANK
    wait_vbl_done();

    // UPDATE
    move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);

    if (needs_render) {
      loaded_r = need_col;
      draw_mt_column((uint8_t)(need_col % BKG_MT_W), need_col, level_map, level_map_w, level_map_h, level_map_bank);
    }

    // Draw the objects/portals from the TMX SP layer
    draw_level_sprites(scroll_px, cam_py, level_sprites, level_sprite_count);

    if (player.mode == MODE_SHIP) {
        if (player.gravity_flipped) {
            move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
        } else {
            move_metasprite(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
        }
    } else {
        if (player.gravity_flipped) {
            move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 22, final_py + 16);
        } else {
            move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 8, final_py + 16);
        }
    }

    if (died) {
      TAC_REG = 0x00;   // Stop music timer immediately

      NR52_REG = 0x00; // Silence

      NR52_REG = 0x80; // Turn sound back ON
      NR51_REG = 0xFF; // Route all channels to left and right
      NR50_REG = 0x77; // Set master volume to max

      NR41_REG = 0x00; // Length
      NR42_REG = 0xF2; // Volume
      NR43_REG = 0x43; // Note
      NR44_REG = 0x80; // Trigger

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
      player_init(&player, 0, 240);
      move_bkg(0, (uint8_t)cam_py);
      fill_scroll_bg(level_map, level_map_w, level_map_h, level_map_bank);

      TAC_REG = 0x04;
      music_ready = 1;
      enable_interrupts();
      //waitpadup();
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
