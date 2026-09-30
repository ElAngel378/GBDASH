#pragma bank 11

#include <stdint.h>
#include <gb/gb.h>
#include <gb/cgb.h>
#include "pause_buttons.h"

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
    for (uint8_t sy = 2; sy < 16; sy++) {
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

// "PAUSED" letters from the font (the buttons and cursor are in sprite_tiles.png)
void init_pause_tiles(void) BANKED {
    static const uint8_t blank_tile[16] = {0};
    for (uint8_t i = 0; i < 6; i++) {
        uint8_t t = PAUSE_SPRITE_TILE_BASE + (i << 1);
        set_sprite_data(t, 1, &FontPusab[pause_glyph_indices[i] * 16]);
        set_sprite_data(t + 1, 1, blank_tile);
    }
}

void draw_pause_menu_sprites(uint8_t selected_btn) BANKED {
    uint8_t prop_txt = (_cpu == CGB_TYPE) ? S_PAL(7) : S_PALETTE;
    uint8_t prop_play = (_cpu == CGB_TYPE) ? S_PAL(6) : 0;
    uint8_t prop_misc = (_cpu == CGB_TYPE) ? S_PAL(5) : 0;

    // "PAUSED" text banner moved 24px down (OAM Y = 48, screen Y = 32)
    for (uint8_t i = 0; i < 6; i++) {
        shadow_OAM[i].x = 64 + (i << 3);
        shadow_OAM[i].y = 48;
        shadow_OAM[i].tile = PAUSE_SPRITE_TILE_BASE + (i << 1);
        shadow_OAM[i].prop = prop_txt;
    }

    // Menu button on left (6 sprites: Slots 6..11, Screen X = 24, base Y = 68)
    uint8_t menu_y = (selected_btn == PAUSE_BTN_MENU) ? 82 : 84;
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

    // Play button in center (8 sprites: Slots 12..19, Screen X = 64, base Y = 64)
    uint8_t play_y = (selected_btn == PAUSE_BTN_PLAY) ? 78 : 80;
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

    // Restart button on right (6 sprites: Slots 20..25, Screen X = 112, base Y = 68)
    uint8_t restart_y = (selected_btn == PAUSE_BTN_RESTART) ? 82 : 84;
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

    // Cursor indicator sprite (Slot 26)
    uint8_t cur_x = 84;
    uint8_t cur_y = 116;
    if (selected_btn == PAUSE_BTN_MENU) {
        cur_x = 40;
        cur_y = 112;
    } else if (selected_btn == PAUSE_BTN_PLAY) {
        cur_x = 84;
        cur_y = 116;
    } else if (selected_btn == PAUSE_BTN_RESTART) {
        cur_x = 128;
        cur_y = 112;
    }
    shadow_OAM[26].x = cur_x;
    shadow_OAM[26].y = cur_y;
    shadow_OAM[26].tile = PAUSE_CURSOR_TILE_BASE;
    shadow_OAM[26].prop = prop_txt;

    // Hide remaining sprites (27..39)
    for (uint8_t s = 27; s < 40; s++) {
        shadow_OAM[s].y = 0;
    }
}
