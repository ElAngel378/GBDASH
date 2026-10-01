#pragma bank 11

#include <stdint.h>
#include <gb/gb.h>
#include <gb/cgb.h>
#include "pause_buttons.h"
#include "death_effect.h"

extern const unsigned char FontPusab[];

static const uint8_t pause_glyph_indices[6] = {
    13 + ('P' - 'A'),
    13 + ('A' - 'A'),
    13 + ('U' - 'A'),
    13 + ('S' - 'A'),
    13 + ('E' - 'A'),
    13 + ('D' - 'A')
};

void apply_pause_box_attributes(uint8_t apply) BANKED {
    if (_cpu != CGB_TYPE) return;
    uint8_t scx_tile = (SCX_REG >> 3);
    uint8_t scy_tile = (SCY_REG >> 3);

    VBK_REG = 1;
    for (uint8_t sy = 2; sy < 17; sy++) {
        uint8_t my = (uint8_t)(scy_tile + sy) & 31;
        for (uint8_t sx = 1; sx < 19; sx++) {
            uint8_t mx = (uint8_t)(scx_tile + sx) & 31;
            uint8_t *addr = (uint8_t *)(0x9800 + ((uint16_t)my << 5) + mx);
            while (STAT_REG & 0x02);
            if (apply) {
                *addr |= 0x04;
            } else {
                *addr &= 0xFB;
            }
        }
    }
    VBK_REG = 0;
}

#include <gbdk/incbin.h>

INCBIN_EXTERN(sprite_tiles)

// 12 tiles for Practice button (3 cols x 4 tiles tall in 8x16 mode) from 'better buttons.chr' (cols 10..12)
const uint8_t practice_button_tiles[192] = {
    // Col 0 Top
    0x00, 0x00, 0x01, 0x00, 0x06, 0x01, 0x08, 0x07, 0x10, 0x0F, 0x20, 0x1F, 0x20, 0x1F, 0x40, 0x3F,
    // Col 0 Mid
    0x40, 0x3F, 0x80, 0x7F, 0x81, 0x7E, 0x81, 0x7E, 0xFF, 0x7E, 0xFF, 0x7E, 0xFF, 0x7F, 0x7F, 0x3F,
    // Col 0 Bot
    0x7F, 0x3F, 0x3F, 0x1F, 0x3F, 0x1F, 0x1F, 0x0F, 0x0F, 0x07, 0x07, 0x01, 0x01, 0x00, 0x00, 0x00,
    // Col 0 Blank
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    // Col 1 Top
    0x7E, 0x00, 0x81, 0x7E, 0x00, 0xFF, 0x18, 0xE7, 0x24, 0xCB, 0x24, 0xCB, 0x42, 0x85, 0x42, 0x85,
    // Col 1 Mid
    0x81, 0x02, 0x81, 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x81, 0x02, 0x81, 0x02,
    // Col 1 Bot
    0xC3, 0x85, 0xC3, 0x85, 0xE7, 0xCB, 0xE7, 0xCB, 0xFF, 0xE7, 0xFF, 0xFF, 0xFF, 0x7E, 0x7E, 0x00,
    // Col 1 Blank
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    // Col 2 Top
    0x00, 0x00, 0x80, 0x00, 0x60, 0x80, 0x10, 0xE0, 0x08, 0xF0, 0x04, 0xF8, 0x04, 0xF8, 0x02, 0xFC,
    // Col 2 Mid
    0x02, 0xFC, 0x01, 0xFE, 0x81, 0x7E, 0x81, 0x7E, 0xFF, 0x7E, 0xFF, 0x7E, 0xFF, 0xFE, 0xFE, 0xFC,
    // Col 2 Bot
    0xFE, 0xFC, 0xFC, 0xF8, 0xFC, 0xF8, 0xF8, 0xF0, 0xF0, 0xE0, 0xE0, 0x80, 0x80, 0x00, 0x00, 0x00,
    // Col 2 Blank
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

// 4 tiles for Checkpoint Diamond from 'Practice mode stuff.chr' (Tiles 0, 16, 1, 17)
const uint8_t checkpoint_diamond_tiles[64] = {
    // Left sprite: Tile 0 (top-left)
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x03, 0x02, 0x03, 0x04, 0x07,
    // Left sprite: Tile 16 (bot-left)
    0x04, 0x07, 0x08, 0x0F, 0x08, 0x0F, 0x04, 0x07, 0x04, 0x07, 0x02, 0x03, 0x02, 0x03, 0x01, 0x01,
    // Right sprite: Tile 1 (top-right)
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x40, 0xC0,
    // Right sprite: Tile 17 (bot-right)
    0x40, 0xC0, 0x20, 0xE0, 0x20, 0xE0, 0x40, 0xC0, 0x40, 0xC0, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00,
};

// Pause menu only: "PAUSED" letters from the font over the death effect tiles (20..31) and the
// Practice button over the checkpoint tiles (76..87); restore_death_tiles/load_checkpoint_tiles
// put them back on resume
void init_pause_tiles(void) BANKED {
    static const uint8_t blank_tile[16] = {0};
    for (uint8_t i = 0; i < 6; i++) {
        uint8_t t = PAUSE_SPRITE_TILE_BASE + (i << 1);
        set_sprite_data(t, 1, &FontPusab[pause_glyph_indices[i] * 16]);
        set_sprite_data(t + 1, 1, blank_tile);
    }
    set_sprite_data(PAUSE_BTN_TILE_BASE + BTN_PRACTICE_TILE_OFFSET, 12, practice_button_tiles);
}

void load_checkpoint_tiles(void) BANKED {
    set_sprite_data(CHECKPOINT_TILE_BASE, 4, checkpoint_diamond_tiles);
}

void restore_death_tiles(void) BANKED {
    set_sprite_data(DEATH_TILE_BASE, DEATH_TILE_COUNT, sprite_tiles + (DEATH_TILE_BASE * 16u));
}

void draw_pause_menu_sprites(uint8_t selected_btn) BANKED {
    uint8_t prop_txt = (_cpu == CGB_TYPE) ? S_PAL(7) : S_PALETTE;
    uint8_t prop_play = (_cpu == CGB_TYPE) ? S_PAL(6) : 0;
    uint8_t prop_misc = (_cpu == CGB_TYPE) ? S_PAL(5) : 0;
    uint8_t prop_prac = (_cpu == CGB_TYPE) ? S_PAL(4) : 0;

    // "PAUSED" text banner moved 24px down (OAM Y = 48, screen Y = 32)
    for (uint8_t i = 0; i < 6; i++) {
        shadow_OAM[i].x = 64 + (i << 3);
        shadow_OAM[i].y = 48;
        shadow_OAM[i].tile = PAUSE_SPRITE_TILE_BASE + (i << 1);
        shadow_OAM[i].prop = prop_txt;
    }

    // Menu button on left (6 sprites: Slots 6..11, Screen X = 24, base Y = 58)
    uint8_t menu_y = (selected_btn == PAUSE_BTN_MENU) ? 72 : 74;
    for (uint8_t c = 0; c < 3; c++) {
        uint8_t spr_x = 32 + (c << 3);
        uint8_t t = PAUSE_BTN_TILE_BASE + BTN_MENU_TILE_OFFSET + (c << 2);
        shadow_OAM[6 + (c << 1)].x = spr_x;
        shadow_OAM[6 + (c << 1)].y = menu_y;
        shadow_OAM[6 + (c << 1)].tile = t;
        shadow_OAM[6 + (c << 1)].prop = prop_misc;

        shadow_OAM[7 + (c << 1)].x = spr_x;
        shadow_OAM[7 + (c << 1)].y = menu_y + 16;
        shadow_OAM[7 + (c << 1)].tile = t + 2;
        shadow_OAM[7 + (c << 1)].prop = prop_misc;
    }

    // Play button in center (8 sprites: Slots 12..19, Screen X = 64, base Y = 54)
    uint8_t play_y = (selected_btn == PAUSE_BTN_PLAY) ? 68 : 70;
    for (uint8_t c = 0; c < 4; c++) {
        uint8_t spr_x = 72 + (c << 3);
        uint8_t t = PAUSE_BTN_TILE_BASE + BTN_PLAY_TILE_OFFSET + (c << 2);
        shadow_OAM[12 + (c << 1)].x = spr_x;
        shadow_OAM[12 + (c << 1)].y = play_y;
        shadow_OAM[12 + (c << 1)].tile = t;
        shadow_OAM[12 + (c << 1)].prop = prop_play;

        shadow_OAM[13 + (c << 1)].x = spr_x;
        shadow_OAM[13 + (c << 1)].y = play_y + 16;
        shadow_OAM[13 + (c << 1)].tile = t + 2;
        shadow_OAM[13 + (c << 1)].prop = prop_play;
    }

    // Restart button on right (6 sprites: Slots 20..25, Screen X = 112, base Y = 58)
    uint8_t restart_y = (selected_btn == PAUSE_BTN_RESTART) ? 72 : 74;
    for (uint8_t c = 0; c < 3; c++) {
        uint8_t spr_x = 120 + (c << 3);
        uint8_t t = PAUSE_BTN_TILE_BASE + BTN_RESTART_TILE_OFFSET + (c << 2);
        shadow_OAM[20 + (c << 1)].x = spr_x;
        shadow_OAM[20 + (c << 1)].y = restart_y;
        shadow_OAM[20 + (c << 1)].tile = t;
        shadow_OAM[20 + (c << 1)].prop = prop_misc;

        shadow_OAM[21 + (c << 1)].x = spr_x;
        shadow_OAM[21 + (c << 1)].y = restart_y + 16;
        shadow_OAM[21 + (c << 1)].tile = t + 2;
        shadow_OAM[21 + (c << 1)].prop = prop_misc;
    }

    // Practice button centered below (6 sprites: Slots 27..32, Screen X = 68, base Y = 98)
    uint8_t practice_y = (selected_btn == PAUSE_BTN_PRACTICE) ? 112 : 114;
    for (uint8_t c = 0; c < 3; c++) {
        uint8_t spr_x = 76 + (c << 3);
        uint8_t t = PAUSE_BTN_TILE_BASE + BTN_PRACTICE_TILE_OFFSET + (c << 2);
        shadow_OAM[27 + (c << 1)].x = spr_x;
        shadow_OAM[27 + (c << 1)].y = practice_y;
        shadow_OAM[27 + (c << 1)].tile = t;
        shadow_OAM[27 + (c << 1)].prop = prop_prac;

        shadow_OAM[28 + (c << 1)].x = spr_x;
        shadow_OAM[28 + (c << 1)].y = practice_y + 16;
        shadow_OAM[28 + (c << 1)].tile = t + 2;
        shadow_OAM[28 + (c << 1)].prop = prop_prac;
    }

    // Cursor indicator sprite (Slot 26)
    // Points up at the selected button, from just below it
    uint8_t cur_x = 84;
    uint8_t cur_y = 101;
    if (selected_btn == PAUSE_BTN_MENU) {
        cur_x = 40;
        cur_y = 102;
    } else if (selected_btn == PAUSE_BTN_RESTART) {
        cur_x = 128;
        cur_y = 102;
    } else if (selected_btn == PAUSE_BTN_PRACTICE) {
        cur_y = practice_y + 28;
    }
    shadow_OAM[26].x = cur_x;
    shadow_OAM[26].y = cur_y;
    shadow_OAM[26].tile = PAUSE_CURSOR_TILE_BASE;
    shadow_OAM[26].prop = prop_txt;

    // Hide remaining sprites (33..39)
    for (uint8_t s = 33; s < 40; s++) {
        shadow_OAM[s].y = 0;
    }
}
