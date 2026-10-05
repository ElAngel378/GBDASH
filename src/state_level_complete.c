#pragma bank 28

// STATE_LEVEL_COMPLETE: shown after the end animation of a completed level (gameplay.c fills in
// the lc_* result). "LEVEL COMPLETE!" appears letter by letter, then a box like the settings
// menu's drops in with the run's stats and the RETRY / MENU choice.

#include <gb/gb.h>
#include <gb/cgb.h>
#include "states.h"
#include "settings_bg.h"
#include "level_complete.h"
#include "level_complete_gfx.h"
#include "sample_player.h"
#include "sfx_data.h"
#include "hUGEDriver.h"
#include "fade.h"
#include "collision.h"
#include "settings.h"

BANKREF(state_level_complete)

#define FONT_PUSAB_START 0xD0
extern const unsigned char FontPusab[];
extern const uint8_t extra_font_tiles[4 * 16];   // state_settings.c (same bank)
extern const hUGESong_t menuloop;
extern volatile uint8_t current_song_bank;
extern uint8_t music_ready;
extern uint8_t selected;

void setup_menu_font(void) BANKED;

#define TILE_COIN        26   // 2 tiles: ring (not collected), filled (collected)
#define TILE_TEXT        32   // the 64 "LEVEL COMPLETE!" tiles
#define PAL_BOX_COIN     3    // gold coin on the box interior
#define PAL_BOX_COIN_OFF 4    // dim coin
#define PAL_TEXT         6

// Text block: LEVEL (rows 0..1, centred over COMPLETE!) and COMPLETE! (rows 2..3)
#define TEXT_X           2
#define TEXT_Y           1
#define LEVEL_COLS       10
#define LEVEL_X_SHIFT    3

// Box (like the settings menu's board: border x 2..17, text columns 3..16)
#define BOX_TOP          6
#define BOX_BOTTOM       14
#define BOX_ROW_ATTEMPTS 8
#define BOX_ROW_COINS    10
#define BOX_ROW_MODE     11
#define BOX_ROW_BUTTONS  13

// The level's menu background colour (state_new_menu_select.c has the same list, in another bank)
static const palette_color_t level_sky[13] = {
    RGB8(  0,   0, 255), RGB8(248,   0, 248), RGB8(248,   0, 122), RGB8(248,   0,   0),
    RGB8(248, 120,   0), RGB8(248, 248,   0), RGB8(  0, 248,   0), RGB8(  0, 248, 248),
    RGB8(  0, 122, 248), RGB8(  0,   0, 255), RGB8(230,  50,  80), RGB8(248,   0, 248),
    RGB8(  0,   0, 255),
};

static const uint8_t coin_icon_tiles[32] = {
    0xC3, 0x3C, 0xBD, 0x42, 0x7E, 0x81, 0x7E, 0x81, 0x7E, 0x81, 0x7E, 0x81, 0xBD, 0x42, 0xC3, 0x3C,
    0xFF, 0x3C, 0xC3, 0x7E, 0x81, 0xFF, 0x99, 0xFF, 0x99, 0xFF, 0x81, 0xFF, 0xC3, 0x7E, 0xFF, 0x3C
};

static uint8_t skip;        // A pressed during the animation: the rest runs without waits
static uint8_t prev_joy;

static void put(uint8_t x, uint8_t y, uint8_t tile, uint8_t attr) {
    set_bkg_tile_xy(x, y, tile);
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        set_bkg_tile_xy(x, y, attr);
        VBK_REG = 0;
    }
}

static void wait_frames(uint8_t n) {
    while (n--) {
        if (skip) return;
        wait_vbl_done();
        uint8_t joy = joypad();
        if ((joy & J_A) && !(prev_joy & J_A)) skip = 1;
        prev_joy = joy;
    }
}

// ASCII to Pusab font tile (see state_settings.c)
static uint8_t font_tile(char c) {
    if (c == ' ') return 0;
    if (c == '%') return 1;
    if (c == '/') return 2;
    if (c >= '0' && c <= '9') return (uint8_t)((c - '0') + 3);
    if (c >= 'A' && c <= 'Z') return (uint8_t)((c - 'A') + 13);
    if (c == '>') return 40;
    if (c == '-') return 41;
    if (c == ':') return 42;
    return 0;
}

// Box interior text (brown board, palette 2); spaces are the board tile
static void box_text(uint8_t x, uint8_t y, const char *s) {
    for (; *s; s++, x++) {
        uint8_t t = font_tile(*s);
        put(x, y, t ? (uint8_t)(FONT_PUSAB_START + t) : 0, 2);
    }
}

static void box_number(uint8_t right_x, uint8_t y, uint16_t v) {
    char buf[6];
    uint8_t n = 0;
    do { buf[n++] = (char)('0' + v % 10u); v /= 10u; } while (v);
    uint8_t x = (uint8_t)(right_x + 1 - n);
    while (n) { n--; put(x++, y, (uint8_t)(FONT_PUSAB_START + 3 + (buf[n] - '0')), 2); }
}

// One row of the box frame (the tiles and attributes of settings_bg.c's board)
static void box_row(uint8_t y) {
    uint8_t x;
    if (y == BOX_TOP) {
        put(2, y, 3, 7);
        for (x = 3; x < 17; x++) put(x, y, 2, 1);
        put(17, y, 4, 7);
    } else if (y == BOX_BOTTOM) {
        put(2, y, 0x18, 7);
        for (x = 3; x < 17; x++) put(x, y, (x == 9) ? 8 : (x == 10) ? 9 : 7, (x == 9 || x == 10) ? 7 : 1);
        put(17, y, 0x19, 7);
    } else {
        put(2, y, 5, 1);
        for (x = 3; x < 17; x++) put(x, y, 0, 2);
        put(17, y, 6, 1);
    }
}

// The corner studs under the box: rows 15..17 of the settings background
static void box_studs(void) {
    set_bkg_tiles(0, 15, SETTINGS_BG_WIDTH, 3, settings_bg_map + 15 * SETTINGS_BG_WIDTH);
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        set_bkg_tiles(0, 15, SETTINGS_BG_WIDTH, 3, settings_bg_attributes + 15 * SETTINGS_BG_WIDTH);
        VBK_REG = 0;
    }
}

static void text_column(uint8_t row0, uint8_t x_shift, uint8_t c) {
    for (uint8_t r = row0; r < (uint8_t)(row0 + 2); r++) {
        uint8_t i = (uint8_t)(r * LEVEL_COMPLETE_TEXT_COLS + c);
        put((uint8_t)(TEXT_X + x_shift + c), (uint8_t)(TEXT_Y + r), (uint8_t)(TILE_TEXT + i), PAL_TEXT);
    }
}

static void draw_buttons(uint8_t sel) {
    box_text(4, BOX_ROW_BUTTONS, sel == 0 ? ">" : " ");
    box_text(5, BOX_ROW_BUTTONS, "RETRY");
    box_text(11, BOX_ROW_BUTTONS, sel == 1 ? ">" : " ");
    box_text(12, BOX_ROW_BUTTONS, "MENU");
}

static void draw_stats(void) {
    box_text(4, BOX_ROW_ATTEMPTS, "ATTEMPTS");
    box_number(15, BOX_ROW_ATTEMPTS, lc_attempts);
    box_text(4, BOX_ROW_COINS, "COINS");
    for (uint8_t i = 0; i < 3; i++) {
        uint8_t x = (uint8_t)(11 + (i << 1));   // a gap between the coins
        if ((lc_coins >> i) & 1) put(x, BOX_ROW_COINS, TILE_COIN + 1, PAL_BOX_COIN);
        else put(x, BOX_ROW_COINS, TILE_COIN, PAL_BOX_COIN_OFF);
    }
    if (lc_practice) box_text(4, BOX_ROW_MODE, "PRACTICE RUN");
}

static void restore_menu_music(void) {
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
    if (setting_music_enabled) {
        init_music_banked(&menuloop, 1, 176);
        current_song_bank = 1;
        TAC_REG = 0x04;
        music_ready = 1;
    } else {
        music_ready = 0;
    }
}

static GameState leave(GameState next) {
    if (setting_sfx_enabled) {
        // the end jingle may still be playing: let it finish, then the menu sound
        while (is_sample_playing()) wait_vbl_done();
        if (next == STATE_PLAY_LEVEL) play_sample_with_music(BANK_SFX_DATA, play_sound_data, PLAY_SOUND_LEN);
        else play_sample_with_music(BANK_SFX_DATA, quit_sound_data, QUIT_SOUND_LEN);
    }
    fade_to_black(2);
    while (is_sample_playing()) wait_vbl_done();
    stop_sample();
    HIDE_SPRITES;
    SCX_REG = 0;
    SCY_REG = 0;
    if (next != STATE_PLAY_LEVEL) restore_menu_music();
    return next;
}

GameState update_level_complete_state(void) BANKED {
    uint8_t c, y;
    DISPLAY_OFF;
    HIDE_SPRITES;
    for (c = 0; c < 40; c++) hide_sprite(c);
    HIDE_WIN;
    SCX_REG = 0;
    SCY_REG = 0;
    music_ready = 0;

    fill_bkg_rect(0, 0, 32, 32, 0);
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        fill_bkg_rect(0, 0, 32, 32, 0);
        VBK_REG = 0;
    }

    set_bkg_data(0, SETTINGS_BG_TILE_COUNT, settings_bg_tiles);
    set_bkg_data(TILE_COIN, 2, coin_icon_tiles);
    set_bkg_data(TILE_TEXT, LEVEL_COMPLETE_TEXT_TILES, level_complete_text_tiles);
    setup_menu_font();
    set_bkg_data((uint8_t)(FONT_PUSAB_START + 39), 4, extra_font_tiles);

    if (_cpu == CGB_TYPE) {
        palette_color_t pal[32];
        palette_color_t sky = level_sky[lc_level % 13];
        for (c = 0; c < 32; c++) pal[c] = settings_bg_palettes[c];
        pal[0] = sky;                                                    // background
        pal[PAL_BOX_COIN * 4 + 0] = RGB8(153, 78, 0);                    // coins on the board
        pal[PAL_BOX_COIN * 4 + 1] = RGB8(255, 214, 40);
        pal[PAL_BOX_COIN * 4 + 2] = RGB8(160, 100, 0);
        pal[PAL_BOX_COIN * 4 + 3] = RGB8(255, 255, 255);
        pal[PAL_BOX_COIN_OFF * 4 + 0] = RGB8(153, 78, 0);
        pal[PAL_BOX_COIN_OFF * 4 + 1] = RGB8(128, 66, 0);
        pal[PAL_BOX_COIN_OFF * 4 + 2] = RGB8(72, 36, 0);
        pal[PAL_BOX_COIN_OFF * 4 + 3] = RGB8(100, 52, 0);
        pal[PAL_TEXT * 4 + 0] = sky;                                     // LEVEL COMPLETE!
        pal[PAL_TEXT * 4 + 1] = RGB8(196, 255, 72);
        pal[PAL_TEXT * 4 + 2] = RGB8(72, 200, 28);
        pal[PAL_TEXT * 4 + 3] = RGB8(8, 40, 4);
        fade_set_bkg_palette(0, 8, pal);
    }
    fade_set_dmg_palettes(0xE4, 0xE4, 0xE4);
    fade_set_black();
    SHOW_BKG;
    DISPLAY_ON;
    fade_from_black(2);

    prev_joy = joypad();
    skip = 0;

    wait_frames(10);
    // LEVEL, then COMPLETE!, a column at a time
    for (c = 0; c < LEVEL_COLS; c++) {
        text_column(0, LEVEL_X_SHIFT, c);
        wait_frames(2);
    }
    wait_frames(4);
    for (c = 0; c < LEVEL_COMPLETE_TEXT_COLS; c++) {
        text_column(2, 0, c);
        wait_frames(2);
    }
    wait_frames(24);

    // the box drops in row by row, then its contents
    for (y = BOX_TOP; y <= BOX_BOTTOM; y++) {
        box_row(y);
        wait_frames(2);
    }
    box_studs();
    wait_frames(6);
    draw_stats();
    wait_frames(6);

    uint8_t sel = 0;
    draw_buttons(sel);
    // the A that may still be held from the level must not choose RETRY right away
    waitpadup();
    prev_joy = joypad();

    while (1) {
        wait_vbl_done();
        uint8_t joy = joypad();
        uint8_t pressed = joy & ~prev_joy;
        prev_joy = joy;
        if (pressed & (J_LEFT | J_RIGHT)) {
            sel ^= 1;
            draw_buttons(sel);
        }
        if (pressed & (J_A | J_START)) return leave(sel ? STATE_NEW_MENU_SELECT : STATE_PLAY_LEVEL);
        if (pressed & J_B) return leave(STATE_NEW_MENU_SELECT);
    }
}
