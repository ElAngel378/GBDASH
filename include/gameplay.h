#ifndef GAMEPLAY_H
#define GAMEPLAY_H

#include <gb/gb.h>
#include "assets.h"

extern uint8_t music_ready;
extern uint8_t redraw;
extern uint8_t selected;
extern volatile uint8_t current_song_bank;

void play_music_safe(void);
void setup_menu_font(void) BANKED;
void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count, uint8_t bank);

// Renders a single vertical slice of metatiles
void draw_mt_column(uint8_t ring_col, uint16_t map_col,
    const uint8_t* map, uint16_t map_w, uint16_t map_h,
    uint8_t map_bank);

// Fills the visible background area from the map data
void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint16_t map_h, uint8_t map_bank);

void draw_menu(void) BANKED;

void draw_level_sprites(uint16_t scroll_x, uint16_t scroll_y, const SpritePlacement *sprites, uint16_t count);

// Main gameplay loop for a specific level
void play_level(uint8_t idx) BANKED;

#endif
