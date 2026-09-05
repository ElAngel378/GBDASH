#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include "sample_player.h"
#include "sfx_data.h"
#include "fade.h"
#include "hUGEDriver.h"
#include <gb/gb.h>

extern uint8_t selected;
extern uint8_t redraw;
extern uint8_t music_ready;
extern volatile uint8_t current_song_bank;
extern const hUGESong_t menuloop;

GameState update_level_select_state(void) {
    fade_set_black();
    DISPLAY_OFF;
    // Clear VRAM tiles and map to ensure no logo leftovers
    fill_bkg_rect(0, 0, 32, 32, 0);
    // Overwrite tile 0 with blank
    uint8_t blank_tile[16] = {0};
    set_bkg_data(0, 1, blank_tile);

    setup_menu_font();

    // Ensure scroll is reset for static background
    SCX_REG = 0;
    SCY_REG = 0;

    draw_levels();

    SHOW_BKG;
    fade_set_black();
    DISPLAY_ON;
    fade_from_black(2);

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
            music_ready = 0;
            TAC_REG = 0x00;
            play_sample(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
            fade_to_black(2);
            return STATE_PLAY_LEVEL;
        } else if (joy & J_B) {
            waitpadup();
            return STATE_MENU;
        }

        wait_vbl_done();
    }
}
