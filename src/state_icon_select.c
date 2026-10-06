#pragma bank 24

#include <gb/gb.h>
#include <gb/cgb.h>
#include "states.h"
#include "icon_select_bg.h"
#include "icon_catalog.h"
#include "save_manager.h"
#include "settings.h"
#include "sample_player.h"
#include "sfx_data.h"

BANKREF(state_icon_select)

#define SECTION_GAMEMODE        0
#define SECTION_ICON            1
#define SECTION_COLOR_PRIMARY   2
#define SECTION_COLOR_SECONDARY 3

static const uint8_t tab_x[NUM_GAMEMODE_TABS] = { 16, 37, 58, 79, 100, 121, 141 };
static const uint8_t icon_x[NUM_CUBE_ICONS] = { 18, 35, 52, 69, 86, 103, 120 };

static uint8_t active_section = SECTION_ICON;
static uint8_t selected_tab = 0; // 0 = Cube

static void refresh_preview_tiles(void) {
    uint8_t prev_b = _current_bank;
    SWITCH_ROM(BANK(icon_catalog));
    set_bkg_data(PREVIEW_TILE_BASE, PREVIEW_TILE_COUNT, icon_preview_tiles[selected_icon]);
    SWITCH_ROM(prev_b);
}

static void refresh_palettes(void) {
    if (_cpu == CGB_TYPE) {
        // Pal 0: General UI
        palette_color_t ui_pal[4] = {
            RGB8(255, 255, 255), RGB8(160, 160, 160), RGB8(70, 70, 70), RGB8(0, 0, 0)
        };
        set_bkg_palette(0, 1, ui_pal);

        // Pal 1: Preview box
        palette_color_t prev_pal[4] = {
            RGB8(255, 255, 255),
            icon_palette_colors[selected_color_primary],
            icon_palette_colors[selected_color_secondary],
            RGB8(0, 0, 0)
        };
        set_bkg_palette(1, 1, prev_pal);

        // Pal 2: Gamemode badges
        palette_color_t gm_pal[4] = {
            RGB8(255, 255, 255), RGB8(0, 220, 255), RGB8(160, 160, 160), RGB8(0, 0, 0)
        };
        set_bkg_palette(2, 1, gm_pal);

        // Pal 3: Carousel
        set_bkg_palette(3, 1, ui_pal);

        // Pal 4: Primary swatches
        palette_color_t sw1_pal[4] = {
            RGB8(255, 255, 255),
            icon_palette_colors[selected_color_primary],
            RGB8(70, 70, 70),
            RGB8(0, 0, 0)
        };
        set_bkg_palette(4, 1, sw1_pal);

        // Pal 5: Secondary swatches
        palette_color_t sw2_pal[4] = {
            RGB8(255, 255, 255),
            icon_palette_colors[selected_color_secondary],
            RGB8(70, 70, 70),
            RGB8(0, 0, 0)
        };
        set_bkg_palette(5, 1, sw2_pal);

        // Sprite Pal 0: Active cursor (White / Bright Yellow)
        palette_color_t spr_act[4] = {
            RGB8(255, 255, 255), RGB8(255, 255, 255), RGB8(255, 240, 0), RGB8(0, 0, 0)
        };
        set_sprite_palette(0, 1, spr_act);

        // Sprite Pal 1: Inactive cursor (Gray)
        palette_color_t spr_inact[4] = {
            RGB8(255, 255, 255), RGB8(180, 180, 180), RGB8(100, 100, 100), RGB8(0, 0, 0)
        };
        set_sprite_palette(1, 1, spr_inact);
    } else {
        BGP_REG = 0xE4;
        OBP0_REG = 0xE4;
        OBP1_REG = 0xD0;
    }
}

static void update_cursor_sprites(void) {
    uint8_t prop_icon = (_cpu == CGB_TYPE && active_section == SECTION_ICON) ? 0 : 1;
    uint8_t prop_col1 = (_cpu == CGB_TYPE && active_section == SECTION_COLOR_PRIMARY) ? 0 : 1;
    uint8_t prop_col2 = (_cpu == CGB_TYPE && active_section == SECTION_COLOR_SECONDARY) ? 0 : 1;

    // 1. Icon Carousel bracket cursor (Sprites 0..3)
    uint8_t ix = icon_x[selected_icon];
    uint8_t iy = 86;
    set_sprite_tile(0, 0); move_sprite(0, ix + 6, iy + 14); set_sprite_prop(0, prop_icon);
    set_sprite_tile(1, 1); move_sprite(1, ix + 15, iy + 14); set_sprite_prop(1, prop_icon);
    set_sprite_tile(2, 2); move_sprite(2, ix + 6, iy + 23); set_sprite_prop(2, prop_icon);
    set_sprite_tile(3, 3); move_sprite(3, ix + 15, iy + 23); set_sprite_prop(3, prop_icon);

    // 2. Primary Color Swatch bracket cursor (Sprites 4..7)
    uint8_t c1x = (uint8_t)(10 + selected_color_primary * 12);
    uint8_t c1y = 114;
    set_sprite_tile(4, 0); move_sprite(4, c1x + 6, c1y + 14); set_sprite_prop(4, prop_col1);
    set_sprite_tile(5, 1); move_sprite(5, c1x + 11, c1y + 14); set_sprite_prop(5, prop_col1);
    set_sprite_tile(6, 2); move_sprite(6, c1x + 6, c1y + 19); set_sprite_prop(6, prop_col1);
    set_sprite_tile(7, 3); move_sprite(7, c1x + 11, c1y + 19); set_sprite_prop(7, prop_col1);

    // 3. Secondary Color Swatch bracket cursor (Sprites 8..11)
    uint8_t c2x = (uint8_t)(10 + selected_color_secondary * 12);
    uint8_t c2y = 126;
    set_sprite_tile(8, 0); move_sprite(8, c2x + 6, c2y + 14); set_sprite_prop(8, prop_col2);
    set_sprite_tile(9, 1); move_sprite(9, c2x + 11, c2y + 14); set_sprite_prop(9, prop_col2);
    set_sprite_tile(10, 2); move_sprite(10, c2x + 6, c2y + 19); set_sprite_prop(10, prop_col2);
    set_sprite_tile(11, 3); move_sprite(11, c2x + 11, c2y + 19); set_sprite_prop(11, prop_col2);

    // 4. Gamemode Tab down-arrow (Sprite 12)
    uint8_t gx = tab_x[selected_tab];
    uint8_t gy = 60;
    set_sprite_tile(12, 4);
    move_sprite(12, gx + 4, gy + 11);
    set_sprite_prop(12, (_cpu == CGB_TYPE && active_section == SECTION_GAMEMODE) ? 0 : 1);

    // Hide remaining sprites
    for (uint8_t s = 13; s < 40; s++) hide_sprite(s);
}

GameState update_icon_select_state(void) BANKED {
    DISPLAY_OFF;

    // Reset scrolling & window
    SCX_REG = 0;
    SCY_REG = 0;
    HIDE_WIN;

    // Load background tiles
    uint8_t prev_b = _current_bank;
    SWITCH_ROM(BANK(icon_select_bg));
    set_bkg_data(0, ICON_SELECT_BG_TILE_COUNT, icon_select_bg_tiles);
    set_sprite_data(0, ICON_SELECT_SPR_TILE_COUNT, icon_select_spr_tiles);

    // Load background tile map
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        set_bkg_tiles(0, 0, 20, 18, icon_select_bg_attrmap);
        VBK_REG = 0;
    }
    set_bkg_tiles(0, 0, 20, 18, icon_select_bg_map);
    SWITCH_ROM(prev_b);

    // Ensure valid selections
    if (selected_icon >= NUM_CUBE_ICONS) selected_icon = 0;
    if (selected_color_primary >= NUM_PALETTE_COLORS) selected_color_primary = 0;
    if (selected_color_secondary >= NUM_PALETTE_COLORS) selected_color_secondary = 1;

    // Update live preview & palettes
    refresh_preview_tiles();
    refresh_palettes();
    update_cursor_sprites();

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    uint8_t prev_joy = joypad();
    uint8_t frame = 0;

    while (1) {
        wait_vbl_done();
        frame++;

        uint8_t joy = joypad();
        uint8_t pressed = joy & ~prev_joy;
        prev_joy = joy;

        // Navigation UP/DOWN between sections
        if (pressed & J_UP) {
            if (active_section > 0) {
                active_section--;
                if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                update_cursor_sprites();
            }
        }
        if (pressed & J_DOWN) {
            if (active_section < SECTION_COLOR_SECONDARY) {
                active_section++;
                if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                update_cursor_sprites();
            }
        }

        // Navigation LEFT/RIGHT within the active section
        if (pressed & J_LEFT) {
            if (active_section == SECTION_GAMEMODE) {
                if (selected_tab > 0) {
                    selected_tab--;
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_ICON) {
                if (selected_icon > 0) {
                    selected_icon--;
                    refresh_preview_tiles();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_COLOR_PRIMARY) {
                if (selected_color_primary > 0) {
                    selected_color_primary--;
                    refresh_palettes();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_COLOR_SECONDARY) {
                if (selected_color_secondary > 0) {
                    selected_color_secondary--;
                    refresh_palettes();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            }
            update_cursor_sprites();
        }

        if (pressed & J_RIGHT) {
            if (active_section == SECTION_GAMEMODE) {
                if (selected_tab < NUM_GAMEMODE_TABS - 1) {
                    selected_tab++;
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_ICON) {
                if (selected_icon < NUM_CUBE_ICONS - 1) {
                    selected_icon++;
                    refresh_preview_tiles();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_COLOR_PRIMARY) {
                if (selected_color_primary < NUM_PALETTE_COLORS - 1) {
                    selected_color_primary++;
                    refresh_palettes();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            } else if (active_section == SECTION_COLOR_SECONDARY) {
                if (selected_color_secondary < NUM_PALETTE_COLORS - 1) {
                    selected_color_secondary++;
                    refresh_palettes();
                    if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
                }
            }
            update_cursor_sprites();
        }

        // B or START: Save customization and return to Main Menu
        if (pressed & (J_B | J_START)) {
            if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, quit_sound_data, QUIT_SOUND_LEN);
            save_game_data();
            HIDE_SPRITES;
            for (uint8_t s = 0; s < 40; s++) hide_sprite(s);
            return STATE_MENU;
        }

        // A button: Select / confirm
        if (pressed & J_A) {
            if (setting_sfx_enabled) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
            save_game_data();
        }
    }
}
