#include "states.h"
#include "logo.h"
#include "gameplay.h"
#include <gb/gb.h>

static uint8_t bg_x = 0;
static uint8_t ground_x = 0;

void menu_stat_isr(void) {
    if (LYC_REG == 24) {
        SCX_REG = bg_x;
        LYC_REG = 120;
    } else {
        SCX_REG = ground_x;
        LYC_REG = 24;
    }
}

GameState update_menu_state(void) {
    DISPLAY_OFF;

    // Clear VRAM tiles and map
    fill_bkg_rect(0, 0, 32, 32, 0);

    // Load logo tiles (limiting to 256 for DMG compatibility in one go)
    // If the logo needs more, we'd need CGB or different mapping.
    // For now, let's load the first 256 tiles.
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(logo_tiles));
    set_bkg_data(0, 255, logo_tiles);
    SWITCH_ROM(prev_bank);

    // Draw logo grid (centeralized 20x12 or similar if 256 tiles)
    // 256 tiles = 16x16 grid.
    uint16_t tile_idx = 0;
    for (uint8_t y = 3; y < 15; y++) {
        for (uint8_t x = 2; x < 18; x++) {
            set_bkg_tile_xy(x, y, (uint8_t)tile_idx++);
        }
    }

    bg_x = 0;
    ground_x = 0;

    disable_interrupts();
    add_LCD(menu_stat_isr);
    STAT_REG |= STATF_LYC;
    LYC_REG = 24;
    set_interrupts(VBL_IFLAG | LCD_IFLAG | TIM_IFLAG);
    enable_interrupts();

    SHOW_BKG;
    DISPLAY_ON;

    while (1) {
        SCX_REG = 0; // Header stays at 0

        if (joypad() & J_A) {
            waitpadup();
            // Teardown parallax
            disable_interrupts();
            remove_LCD(menu_stat_isr);
            set_interrupts(VBL_IFLAG | TIM_IFLAG);
            enable_interrupts();
            return STATE_LEVEL_SELECT;
        }

        wait_vbl_done();
        bg_x += 1;
        ground_x += 2;
    }
}
