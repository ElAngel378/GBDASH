#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include <gb/gb.h>

extern uint8_t selected;
extern uint8_t redraw;

GameState update_level_select_state(void) {
    DISPLAY_OFF;
    // Clear VRAM tiles and map to ensure no logo leftovers
    fill_bkg_rect(0, 0, 32, 32, 0);
    // Overwrite tiles 0-255 with 0 (blank)
    uint8_t blank_tile[16] = {0};
    set_bkg_data(0, 255, blank_tile);

    setup_menu_font();

    // Ensure scroll is reset for static background
    SCX_REG = 0;
    SCY_REG = 0;

    redraw = 1;

    SHOW_BKG;
    DISPLAY_ON;

    while (1) {
        if (redraw) draw_levels();

        uint8_t joy = joypad();
        if (joy & J_UP) {
            if (selected > 0) { selected--; redraw = 1; }
            waitpadup();
        } else if (joy & J_DOWN) {
            if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
            waitpadup();
        } else if (joy & J_A) {
            waitpadup();
            return STATE_PLAY_LEVEL;
        } else if (joy & J_B) {
            waitpadup();
            return STATE_MENU;
        }

        wait_vbl_done();
    }
}
