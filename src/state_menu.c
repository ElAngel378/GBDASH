#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include <gb/gb.h>
#include <gb/cgb.h>

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

    // Restore standard palettes
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    OBP1_REG = 0xD2;

    if (_cpu == CGB_TYPE) {
        // Initialize menu palette for CGB
        static const uint16_t menu_pal[] = {
            RGB8(20, 20, 40), RGB8(100, 100, 150), RGB8(200, 200, 255), RGB8(255, 255, 255)
        };
        for (uint8_t i = 0; i < 8; i++) {
            set_bkg_palette(i, 1, menu_pal);
        }
    }

    // Clear VRAM
    fill_bkg_rect(0, 0, 32, 32, 0);

    // Load font and level tiles
    setup_menu_font();

    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(chr_gb));
    set_bkg_data(0, 128, chr_gb_tiles); // Load first 128 tiles of the level set
    SWITCH_ROM(prev_bank);

    // Draw stationary title
    draw_text(0, 1, "GEOMETRY DASH POCKET");

    // Draw ground pattern at the bottom
    // We'll use tiles 10, 11 for the top of the ground and 26, 27 for the bottom
    // Repeating across the whole 32-tile wide buffer
    for (uint8_t x = 0; x < 32; x++) {
        uint8_t t_top = (x & 1) ? 11 : 10;
        uint8_t t_bot = (x & 1) ? 27 : 26;
        set_bkg_tile_xy(x, 15, t_top);
        set_bkg_tile_xy(x, 16, t_bot);
        set_bkg_tile_xy(x, 17, t_bot); // Repeat bot for height
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
