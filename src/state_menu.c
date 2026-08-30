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
        static const uint16_t menu_pal[] = {
            RGB8(20, 20, 40), RGB8(100, 100, 150), RGB8(200, 200, 255), RGB8(255, 255, 255)
        };
        for (uint8_t i = 0; i < 8; i++) {
            set_bkg_palette(i, 1, menu_pal);
        }
    }

    extern const uint8_t menu_bg_tiles[];
    extern const uint8_t menu_bg_map[];
    BANKREF_EXTERN(menu_bg)

    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(chr_gb));
    set_bkg_data(0, 128, chr_gb_tiles);
    SWITCH_ROM(BANK(menu_bg));
    set_bkg_data(28, 87, menu_bg_tiles); // Load bg_tiles at index 28-114
    
    // Draw background map
    set_bkg_tiles(0, 0, 32, 32, menu_bg_map);
    SWITCH_ROM(prev_bank);

    setup_menu_font();

    // Title (20 chars fits exactly)
    // Clear a small box for the text so it's readable over the background
    fill_bkg_rect(0, 1, 20, 1, 0); 
    draw_text(0, 1, "GEOMETRY DASH POCKET");

    // Ground Parallax (16 lines + gap pattern)
    for (uint8_t x = 0; x < 32; x++) {
        uint8_t body_tile = ((x & 3) == 0) ? 25 : 26;
        
        set_bkg_tile_xy(x, 15, 0); // Empty sky for the top 8 pixels
        set_bkg_tile_xy(x, 16, body_tile);
        set_bkg_tile_xy(x, 17, body_tile);
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
        SCX_REG = 0; // Header

        if (joypad() & J_A) {
            waitpadup();
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
