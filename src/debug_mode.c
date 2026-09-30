#pragma bank 10

#include <gb/gb.h>
#include <gb/cgb.h>
#include "debug_mode.h"

#if ENABLE_DEBUG_MODE

extern const unsigned char FontPusab[];

uint8_t debug_mode = 0;

// Sprite tile numbers 90.. are unused during gameplay (pause menu uses 36..89, the
// Famidash sprites start at 160). Sprites are 8x16, so every glyph takes a tile pair.
#define DBG_TILE_BASE 90
// glyph order: D B G 0 1 2 ... 9
#define DBG_GLYPH_D 0
#define DBG_GLYPH_B 1
#define DBG_GLYPH_G 2
#define DBG_GLYPH_DIGIT0 3
#define DBG_GLYPHS 13

#define DBG_FIRST_SLOT 31

void debug_load_hud_tiles(void) {
    static const uint8_t blank_tile[16] = {0};
    // FontPusab: digits start at glyph 3, letters at glyph 13 ('A')
    static const uint8_t font_index[DBG_GLYPHS] = {
        13 + 3, 13 + 1, 13 + 6,          // D B G
        3, 4, 5, 6, 7, 8, 9, 10, 11, 12  // 0-9
    };
    for (uint8_t i = 0; i < DBG_GLYPHS; i++) {
        uint8_t t = DBG_TILE_BASE + (uint8_t)(i << 1);
        set_sprite_data(t, 1, &FontPusab[font_index[i] * 16]);
        set_sprite_data(t + 1, 1, blank_tile);
    }
}

static void put(uint8_t slot, uint8_t x, uint8_t glyph) {
    // Player palette (bright outline/body colours); OBP0 on DMG
    shadow_OAM[slot].y = 16;
    shadow_OAM[slot].x = (uint8_t)(x + 8);
    shadow_OAM[slot].tile = DBG_TILE_BASE + (uint8_t)(glyph << 1);
    shadow_OAM[slot].prop = 0;
}

static void put_number(uint8_t slot, uint8_t x, uint8_t value) {
    put(slot,     x,      (uint8_t)(DBG_GLYPH_DIGIT0 + value / 100));
    put(slot + 1, x + 8,  (uint8_t)(DBG_GLYPH_DIGIT0 + (value / 10) % 10));
    put(slot + 2, x + 16, (uint8_t)(DBG_GLYPH_DIGIT0 + value % 10));
}

void debug_draw_hud(uint8_t show_ly, uint8_t ly, uint8_t max_ly) {
    put(DBG_FIRST_SLOT,     68, DBG_GLYPH_D);
    put(DBG_FIRST_SLOT + 1, 76, DBG_GLYPH_B);
    put(DBG_FIRST_SLOT + 2, 84, DBG_GLYPH_G);
    if (show_ly) {
        put_number(DBG_FIRST_SLOT + 3, 100, ly);
        put_number(DBG_FIRST_SLOT + 6, 132, max_ly);
    } else {
        for (uint8_t i = DBG_FIRST_SLOT + 3; i < 40; i++) shadow_OAM[i].y = 0;
    }
}

void debug_hide_hud(void) {
    for (uint8_t i = DBG_FIRST_SLOT; i < 40; i++) shadow_OAM[i].y = 0;
}

#endif
