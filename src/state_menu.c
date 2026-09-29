#pragma bank 29

#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include "rainbow.h"
#include "logo.h"
#include <gb/gb.h>
#include <gb/cgb.h>

static uint8_t bg_x = 0;
static uint8_t ground_x = 0;

void menu_stat_isr(void) __nonbanked {
    if (LYC_REG == 16) {
        SCX_REG = bg_x;
        LYC_REG = 120;
    } else {
        SCX_REG = ground_x;
        LYC_REG = 255;
    }
}

// Set to 1 to easily re-enable the version label in the bottom-right corner
#define SHOW_MENU_VERSION_LABEL 0

static void update_menu_sprites(uint8_t sel) {
    // Music button (16x16) on left of ground bar (Screen X = 56..72, OAM X = 64)
    uint8_t mx = 64;
    uint8_t my = (sel == 1) ? 138 : 140; // Screen Y = 122 (selected) / 124 (unselected)
    uint8_t prop_m = (_cpu == CGB_TYPE) ? 3 : 0;
    set_sprite_tile(0, 22); move_sprite(0, mx, my);      set_sprite_prop(0, prop_m);
    set_sprite_tile(1, 24); move_sprite(1, mx + 8, my);  set_sprite_prop(1, prop_m);

    // Settings cog button (16x16) on right of ground bar (Screen X = 88..104, OAM X = 96)
    uint8_t sx = 96;
    uint8_t sy = (sel == 2) ? 138 : 140;
    set_sprite_tile(2, 28); move_sprite(2, sx, sy);      set_sprite_prop(2, prop_m);
    set_sprite_tile(3, 30); move_sprite(3, sx + 8, sy);  set_sprite_prop(3, prop_m);

    // Play button sprites (OAM 4..11) - centered at Screen X = 64..96 (OAM X = 72)
    uint8_t bx = 72;
    uint8_t by = (sel == 0) ? 66 : 68; // Screen Y = 50 (selected) / 52 (unselected)
    set_sprite_tile(4, 0);   move_sprite(4, bx, by);           set_sprite_prop(4, 0);
    set_sprite_tile(5, 2);   move_sprite(5, bx, by + 16);      set_sprite_prop(5, 0);
    set_sprite_tile(6, 4);   move_sprite(6, bx + 8, by);       set_sprite_prop(6, 0);
    set_sprite_tile(7, 6);   move_sprite(7, bx + 8, by + 16);  set_sprite_prop(7, 0);
    set_sprite_tile(8, 8);   move_sprite(8, bx + 16, by);      set_sprite_prop(8, 0);
    set_sprite_tile(9, 10);  move_sprite(9, bx + 16, by + 16); set_sprite_prop(9, 0);
    set_sprite_tile(10, 12); move_sprite(10, bx + 24, by);     set_sprite_prop(10, 0);
    set_sprite_tile(11, 14); move_sprite(11, bx + 24, by + 16); set_sprite_prop(11, 0);

    if (_cpu == CGB_TYPE) {
        set_sprite_tile(12, 16); move_sprite(12, bx + 12, by + 8);  set_sprite_prop(12, 1);
        set_sprite_tile(13, 18); move_sprite(13, bx + 4, by + 4);   set_sprite_prop(13, 2);
        set_sprite_tile(14, 18); move_sprite(14, bx + 21, by + 4);  set_sprite_prop(14, 2);
        set_sprite_tile(15, 20); move_sprite(15, bx + 4, by + 16);  set_sprite_prop(15, 2);
        set_sprite_tile(16, 20); move_sprite(16, bx + 21, by + 16); set_sprite_prop(16, 2);
    } else {
        for (uint8_t s = 12; s < 17; s++) hide_sprite(s);
    }

    // Select arrow cursor (Slot 17, tile 26)
    // Positioned ON TOP of the selected button, pointing DOWN!
    uint8_t prop_c = (_cpu == CGB_TYPE) ? 4 : 0;
    if (sel == 0) {
        move_sprite(17, bx + 12, by - 9);
    } else if (sel == 1) {
        move_sprite(17, mx + 4, my - 9);
    } else {
        move_sprite(17, sx + 4, sy - 9);
    }
    set_sprite_tile(17, 26);
    set_sprite_prop(17, prop_c);

    for (uint8_t s = 18; s < 40; s++) hide_sprite(s);
}

// This file lives in a switchable ROM bank, so everything that switches ROM
// banks (to read tile data from other banks) must run from bank 0: __nonbanked.
extern const uint8_t menu_bg_tiles[];
extern const uint8_t menu_bg_map[];
extern const uint8_t menu_ground_tiles[];
extern const uint8_t menu_ground_map[];
BANKREF_EXTERN(menu_bg)
extern const unsigned char playbutton[];
BANKREF_EXTERN(playbutton)

static void menu_load_bg_gfx(void) __nonbanked {
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(chr_gb));
    set_bkg_data(0, 128, chr_gb_tiles);
    SWITCH_ROM(BANK(menu_bg));
    set_bkg_data(28, 87, menu_bg_tiles);    // BG tiles at index 28-114
    set_bkg_data(115, 9, menu_ground_tiles); // Ground tiles at 115-123

    // Clear the whole map first (so top 16px is empty sky/color 0)
    fill_bkg_rect(0, 0, 32, 32, 0);

    // Draw background map starting at row 2 (16px down), drawing only 28 rows to not wrap
    set_bkg_tiles(0, 2, 32, 28, menu_bg_map);
    // Draw ground map at row 15 (120px) - 3 rows tall
    set_bkg_tiles(0, 15, 32, 3, menu_ground_map);

    // Load logo tiles from BANK(logo)
    SWITCH_ROM(BANK(logo));
    set_bkg_data(LOGO_TILE_START, LOGO_TILE_COUNT, logo_tiles);
    SWITCH_ROM(prev_bank);
}

static void menu_load_playbutton_gfx(void) __nonbanked {
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(playbutton));
    set_sprite_data(0, 16, &playbutton[16]);
    SWITCH_ROM(prev_bank);
}

GameState update_menu_state(void) BANKED {
    DISPLAY_OFF;

    // Restore standard palettes
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    OBP1_REG = 0xD2;

    if (_cpu == CGB_TYPE) {
        apply_rainbow_palette(0);
    }

    menu_load_bg_gfx();

#if SHOW_MENU_VERSION_LABEL
    // Load Pusab font tiles for version label
    setup_menu_font();

    // Version label "Demo v03" on window layer
    static const uint8_t ver_tiles[] = { 16, 17, 25, 27, 0, 34, 3, 6 };
    for (uint8_t i = 0; i < 8; i++) {
        set_win_tile_xy(i, 0, (uint8_t)(0xD0u + ver_tiles[i]));
    }
#endif

    // Title logo
    for (uint8_t x = 0; x < 20; x++) {
        set_bkg_tile_xy(x, 0, (uint8_t)(LOGO_TILE_START + x));
        set_bkg_tile_xy(x, 1, (uint8_t)(LOGO_TILE_START + 20 + x));
    }

    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        fill_bkg_rect(0, 0, 32, 32, 0);
        fill_bkg_rect(0, 0, 20, 2, 1);
        VBK_REG = 0;
    }

    // Play button
    menu_load_playbutton_gfx();

    if (_cpu == CGB_TYPE) {
        static const uint8_t yellow_fill_tile[32] = {
            0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00,
            0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00,
            0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00,
            0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00
        };
        static const uint8_t top_blue_tile[32] = {
            0x00, 0x00, 0x7C, 0x00, 0x7C, 0x00, 0x7C, 0x00,
            0x7C, 0x00, 0x7C, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        };
        static const uint8_t bot_blue_tile[32] = {
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x7C, 0x00, 0x7C, 0x00,
            0x7C, 0x00, 0x7C, 0x00, 0x7C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        };

        set_sprite_data(16, 2, yellow_fill_tile);
        set_sprite_data(18, 2, top_blue_tile);
        set_sprite_data(20, 2, bot_blue_tile);

        static const uint16_t play_button_palette[] = {
            RGB8(255, 255, 255),
            RGB8(138, 245, 30),
            RGB8(30, 140, 20),
            RGB8(0, 0, 0)
        };
        static const uint16_t play_button_yellow_palette[] = {
            RGB8(255, 255, 255),
            RGB8(255, 240, 0),
            RGB8(255, 210, 0),
            RGB8(220, 160, 0)
        };
        static const uint16_t play_button_blue_palette[] = {
            RGB8(255, 255, 255),
            RGB8(0, 240, 255),
            RGB8(0, 160, 255),
            RGB8(0, 80, 220)
        };
        static const uint16_t music_btn_palette[] = {
            RGB8(255, 255, 255),
            RGB8(255, 235, 20),
            RGB8(80, 210, 20),
            RGB8(0, 0, 0)
        };
        static const uint16_t cursor_palette[] = {
            RGB8(255, 255, 255),
            RGB8(255, 255, 255),
            RGB8(255, 255, 255),
            RGB8(0, 0, 0)
        };
        set_sprite_palette(0, 1, play_button_palette);
        set_sprite_palette(1, 1, play_button_yellow_palette);
        set_sprite_palette(2, 1, play_button_blue_palette);
        set_sprite_palette(3, 1, music_btn_palette);
        set_sprite_palette(4, 1, cursor_palette);
    }

    // Music button tiles (16x16 icon -> 4 8x8 tiles = 2 8x16 sprites)
    // Colors: 0 transparent, 1 yellow (note), 2 lime (bg), 3 black (outline)
    // Eighth-note drawn from scratch: oval head, stem, slim flag.
    static const uint8_t music_button_tiles[64] = {
        // Tile 0 (left top)
        0x00, 0x00, 0x0F, 0x0F, 0x18, 0x1F, 0x21, 0x3F, 0x63, 0x7E, 0x43, 0x7E, 0x43, 0x7E, 0x43, 0x7E,
        // Tile 1 (left bottom)
        0x43, 0x7E, 0x5F, 0x7E, 0x7F, 0x60, 0x7F, 0x60, 0x3F, 0x31, 0x1E, 0x1F, 0x0F, 0x0F, 0x00, 0x00,
        // Tile 2 (right top)
        0x00, 0x00, 0xF0, 0xF0, 0x18, 0xF8, 0x84, 0xFC, 0xC6, 0x7E, 0xE2, 0x3E, 0xF2, 0x9E, 0xF2, 0xDE,
        // Tile 3 (right bottom)
        0xA2, 0xFE, 0x82, 0xFE, 0x82, 0xFE, 0x86, 0xFE, 0x04, 0xFC, 0x18, 0xF8, 0xF0, 0xF0, 0x00, 0x00
    };
    set_sprite_data(22, 4, music_button_tiles);

    // Settings button tiles (16x16 icon -> 4 8x8 tiles = 2 8x16 sprites)
    // Colors: 0 transparent, 1 yellow (gear), 2 lime (bg), 3 black (outline)
    // 8-tooth gear drawn from scratch: yellow ring + teeth, lime hub hole.
    static const uint8_t settings_button_tiles[64] = {
        0x00, 0x00, 0x0F, 0x0F, 0x1B, 0x1E, 0x2F, 0x3E, 0x7F, 0x70, 0x5F, 0x71, 0x7E, 0x73, 0x7C, 0x47,
        0x7C, 0x47, 0x7E, 0x73, 0x5F, 0x71, 0x7F, 0x70, 0x2F, 0x3E, 0x1B, 0x1E, 0x0F, 0x0F, 0x00, 0x00,
        0x00, 0x00, 0xF0, 0xF0, 0xD8, 0x78, 0xF4, 0x7C, 0xFE, 0x0E, 0xFA, 0x8E, 0x7E, 0xCE, 0x3E, 0xE2,
        0x3E, 0xE2, 0x7E, 0xCE, 0xFA, 0x8E, 0xFE, 0x0E, 0xF4, 0x7C, 0xD8, 0x78, 0xF0, 0xF0, 0x00, 0x00,
    };
    set_sprite_data(28, 4, settings_button_tiles);

    // Cursor indicator tiles (downward-pointing chevron, 8x16 mode: white body, black border)
    static const uint8_t pause_cursor_tiles[32] = {
        0x7E, 0x7E, 0x7E, 0x42, 0x7E, 0x42, 0x3C, 0x24,
        0x3C, 0x24, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    };
    set_sprite_data(26, 2, pause_cursor_tiles);

    SPRITES_8x16;
    uint8_t menu_sel = 0; // 0 = Play, 1 = Music, 2 = Settings
    uint8_t last_ground_sel = 1;

    update_menu_sprites(menu_sel);

    bg_x = 0;
    ground_x = 0;
    SCX_REG = 0;
    SCY_REG = 0;

    disable_interrupts();
    add_LCD(menu_stat_isr);
    STAT_REG |= STATF_LYC;
    LYC_REG = 16;
    set_interrupts(VBL_IFLAG | LCD_IFLAG | TIM_IFLAG);
    enable_interrupts();

    SHOW_BKG;
    SHOW_SPRITES;
#if SHOW_MENU_VERSION_LABEL
    WY_REG = 136;
    WX_REG = 103;
    SHOW_WIN;
#else
    HIDE_WIN;
#endif
    DISPLAY_ON;

    static uint16_t frame_counter = 0;
    uint8_t prev_joy = joypad();

    while (1) {
        wait_vbl_done();
        SCX_REG = 0;
        SCY_REG = 0;
        LYC_REG = 16;

        uint8_t joy = joypad();
        uint8_t pressed = joy & ~prev_joy;
        prev_joy = joy;

        if (pressed & (J_LEFT | J_RIGHT)) {
            if (menu_sel == 0) {
                menu_sel = (pressed & J_LEFT) ? 1 : 2;
                last_ground_sel = menu_sel;
            } else if (menu_sel == 1 && (pressed & J_RIGHT)) {
                menu_sel = 2;
                last_ground_sel = 2;
            } else if (menu_sel == 2 && (pressed & J_LEFT)) {
                menu_sel = 1;
                last_ground_sel = 1;
            }
            update_menu_sprites(menu_sel);
        }

        if (pressed & (J_UP | J_DOWN)) {
            if (menu_sel == 0 && (pressed & J_DOWN)) {
                menu_sel = last_ground_sel;
            } else if (menu_sel != 0 && (pressed & J_UP)) {
                last_ground_sel = menu_sel;
                menu_sel = 0;
            }
            update_menu_sprites(menu_sel);
        }

        if (pressed & J_SELECT) {
            menu_sel = (uint8_t)((menu_sel + 1) % 3);
            if (menu_sel != 0) last_ground_sel = menu_sel;
            update_menu_sprites(menu_sel);
        }

        if (pressed & (J_A | J_START)) {
            disable_interrupts();
            remove_LCD(menu_stat_isr);
            STAT_REG &= ~STATF_LYC;
            SCX_REG = 0;
            SCY_REG = 0;
            set_interrupts(VBL_IFLAG | TIM_IFLAG);
            enable_interrupts();
            HIDE_SPRITES;
            HIDE_WIN;
            for (uint8_t s = 0; s < 40; s++) hide_sprite(s);
            if (menu_sel == 0) {
                return STATE_NEW_MENU_SELECT;
            } else if (menu_sel == 1) {
                return STATE_MUSIC_TEST;
            } else {
                return STATE_SETTINGS;
            }
        }

        frame_counter++;
        if ((frame_counter & 1) == 0) {
            bg_x += 1;
        }
        ground_x += 3;

        if (_cpu == CGB_TYPE && (frame_counter & 15) == 0) {
            uint8_t color_index = (frame_counter >> 4) & 127;
            apply_rainbow_palette(color_index);
        }
    }
}
