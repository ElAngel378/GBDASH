#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include <gb/gb.h>
#include <gb/cgb.h>

static uint8_t bg_x = 0;
static uint8_t ground_x = 0;

void menu_stat_isr(void) {
    if (LYC_REG == 16) {
        SCX_REG = bg_x;
        LYC_REG = 120;
    } else {
        SCX_REG = ground_x;
        LYC_REG = 16;
    }
}

GameState update_menu_state(void) {
    DISPLAY_OFF;

    // Restore standard palettes
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    OBP1_REG = 0xD2;

    if (_cpu == CGB_TYPE) {
        extern const uint16_t rainbow_palettes[64][4];
        set_bkg_palette(0, 1, rainbow_palettes[0]);
    }

    extern const uint8_t menu_bg_tiles[];
    extern const uint8_t menu_bg_map[];
    extern const uint8_t menu_ground_tiles[];
    extern const uint8_t menu_ground_map[];
    BANKREF_EXTERN(menu_bg)

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
    SWITCH_ROM(prev_bank);

    setup_menu_font();

    // Title 
    draw_text(0, 1, "GEOMETRY DASH POCKET");

    // Load Play Button (4x4 tiles / 8 8x16 sprites)
    extern const unsigned char playbutton[];
    // Tiles 1-16 (skip tile 0 which is empty)
    set_sprite_data(0, 16, &playbutton[16]);

    if (_cpu == CGB_TYPE) {
        static const uint16_t play_button_palette[] = {
            RGB8(255, 255, 255), // Trans
            RGB8(138, 245, 30),  // Light Green
            RGB8(30, 140, 20),   // Dark Green
            RGB8(0, 0, 0)        // Black Outline
        };
        set_sprite_palette(0, 1, play_button_palette);
    }

    SPRITES_8x16;
    uint8_t bx = 72; // Centered X (64 + 8)
    uint8_t by = 68; // Centered Y (52 + 16)

    // Set 8 8x16 hardware sprites for the 32x32 button
    set_sprite_tile(0, 0);  move_sprite(0, bx, by);           set_sprite_prop(0, 0);
    set_sprite_tile(1, 2);  move_sprite(1, bx, by + 16);      set_sprite_prop(1, 0);
    set_sprite_tile(2, 4);  move_sprite(2, bx + 8, by);       set_sprite_prop(2, 0);
    set_sprite_tile(3, 6);  move_sprite(3, bx + 8, by + 16);  set_sprite_prop(3, 0);
    set_sprite_tile(4, 8);  move_sprite(4, bx + 16, by);      set_sprite_prop(4, 0);
    set_sprite_tile(5, 10); move_sprite(5, bx + 16, by + 16); set_sprite_prop(5, 0);
    set_sprite_tile(6, 12); move_sprite(6, bx + 24, by);      set_sprite_prop(6, 0);
    set_sprite_tile(7, 14); move_sprite(7, bx + 24, by + 16); set_sprite_prop(7, 0);

    bg_x = 0;
    ground_x = 0;

    disable_interrupts();
    add_LCD(menu_stat_isr);
    STAT_REG |= STATF_LYC;
    LYC_REG = 16;
    set_interrupts(VBL_IFLAG | LCD_IFLAG | TIM_IFLAG);
    enable_interrupts();

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    while (1) {
        SCX_REG = 0; // Header

        uint8_t joy = joypad();
        if (joy & (J_A | J_START)) {
            waitpadup();
            disable_interrupts();
            remove_LCD(menu_stat_isr);
            set_interrupts(VBL_IFLAG | TIM_IFLAG);
            HIDE_SPRITES;
            for (uint8_t s = 0; s < 8; s++) hide_sprite(s);
            enable_interrupts();
            return STATE_LEVEL_SELECT;
        }

        wait_vbl_done();
        
        static uint16_t frame_counter = 0;
        frame_counter++;
        
        if ((frame_counter & 1) == 0) {
            bg_x += 1;
        }
        ground_x += 3;

        if (_cpu == CGB_TYPE && (frame_counter & 15) == 0) {
            extern const uint16_t rainbow_palettes[128][4];
            uint8_t color_index = (frame_counter >> 4) & 127;
            // Update palette 0 (used by background and ground)
            set_bkg_palette(0, 1, rainbow_palettes[color_index]);
        }
    }
}
