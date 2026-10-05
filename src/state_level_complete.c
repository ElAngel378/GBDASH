#pragma bank 28

// STATE_LEVEL_COMPLETE: the end of a completed level. play_level() returns right after the end
// animation's shake with the level still on screen (gameplay.c fills in the lc_* result):
//   1. "LEVEL COMPLETE!" appears over the level as sprites, a column at a time
//   2. after about 2 seconds it moves up and a box like the settings menu's is drawn over the
//      level (background tiles, in the VRAM slots the visible level does not use), with the
//      run's stats and the RETRY / MENU choice.
//
// The text is 26 8x16 sprites (LEVEL: 10 columns; COMPLETE!: 16 columns). The hardware draws at
// most 10 sprites per scanline, so on COMPLETE!'s lines the OAM order alternates every frame
// between two sets of 10 columns (the middle columns stay solid, the outer ones shimmer).

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

extern const unsigned char FontPusab[];
extern const uint8_t extra_font_tiles[4 * 16];   // state_settings.c (same bank)
extern const hUGESong_t menuloop;
extern volatile uint8_t current_song_bank;
extern uint8_t music_ready;

// ---- text sprites
#define TEXT_SPRITE_TILE   0     // sprite tiles 0..51 (the player's: it has left the screen)
#define LEVEL_COLS         10
#define LEVEL_X_SHIFT      3     // LEVEL is centred over COMPLETE!
#define COMPLETE_COLS      16
#define OAM_FIRST          4     // slots 0..3: the % display
#define OAM_LEVEL          OAM_FIRST
#define OAM_COMPLETE       (OAM_LEVEL + LEVEL_COLS)
#define TEXT_X             16    // screen x of the first COMPLETE! column
#define TEXT_Y_CENTRE      56    // screen y of the top of the text block while it is centred
#define TEXT_Y_TOP         8     // ... and when the box is up
#define TEXT_SLIDE_FRAMES  24

// ---- box (cells on screen like the settings board: border x 2..17, text columns 3..16)
#define BOX_TOP            6
#define BOX_BOTTOM         14
#define BOX_ROW_ATTEMPTS   8
#define BOX_ROW_COINS      10
#define BOX_ROW_MODE       11
#define BOX_ROW_BUTTONS    13
#define PAL_BORDER         5     // CGB BG palettes 5..7 are unused in gameplay
#define PAL_BOARD          6
#define PAL_CORNER         7

static uint8_t skip;        // A pressed during the animation: the rest runs without waits
static uint8_t prev_joy;
static uint8_t rot;         // OAM order of the COMPLETE! columns
static uint8_t text_y;
static uint8_t level_shown, complete_shown;

static uint8_t map_x0, map_y0;          // BG map cell shown at the top left of the screen
static uint8_t border_slot[10];         // VRAM slots of the box border tiles
static uint8_t font_slot[44];           // VRAM slots of the font glyphs (0xFF: not loaded)

// settings_bg tiles of the box border, in border_slot order
static const uint8_t border_src[10] = { 2, 3, 4, 5, 6, 7, 8, 9, 0x18, 0x19 };
#define B_TOP    0
#define B_TL     1
#define B_TR     2
#define B_LEFT   3
#define B_RIGHT  4
#define B_BOTTOM 5
#define B_NOTCH0 6
#define B_NOTCH1 7
#define B_BL     8
#define B_BR     9
#define TILE_BLANK 12            // the gameplay sheet's transparent tile: the board interior

static void wait_frames(uint8_t n) {
    while (n--) {
        if (skip) return;
        wait_vbl_done();
        uint8_t joy = joypad();
        if ((joy & J_A) && !(prev_joy & J_A)) skip = 1;
        prev_joy = joy;
    }
}

// ---------------------------------------------------------------- text sprites

static void level_text_draw(void);

// n frames, redrawing the text each one (the OAM order alternates every frame)
static void wait_draw(uint8_t n) {
    while (n--) {
        wait_frames(1);
        level_text_draw();
    }
}

static void level_text_load(void) {
    uint8_t p;
    VBK_REG = 0;
    for (p = 0; p < LEVEL_COLS; p++) {            // LEVEL: tile rows 0 and 1
        set_sprite_data((uint8_t)(TEXT_SPRITE_TILE + (p << 1)), 1, level_complete_text_tiles + (uint16_t)p * 16u);
        set_sprite_data((uint8_t)(TEXT_SPRITE_TILE + (p << 1) + 1), 1,
                        level_complete_text_tiles + ((uint16_t)LEVEL_COMPLETE_TEXT_COLS + p) * 16u);
    }
    for (p = 0; p < COMPLETE_COLS; p++) {         // COMPLETE!: tile rows 2 and 3
        uint8_t t = (uint8_t)(TEXT_SPRITE_TILE + ((LEVEL_COLS + p) << 1));
        set_sprite_data(t, 1, level_complete_text_tiles + ((uint16_t)2 * LEVEL_COMPLETE_TEXT_COLS + p) * 16u);
        set_sprite_data((uint8_t)(t + 1), 1, level_complete_text_tiles + ((uint16_t)3 * LEVEL_COMPLETE_TEXT_COLS + p) * 16u);
    }
}

static void level_text_draw(void) {
    uint8_t i, c;
    for (i = OAM_FIRST; i < 40; i++) shadow_OAM[i].y = 0;
    for (c = 0; c < level_shown; c++) {
        uint8_t o = (uint8_t)(OAM_LEVEL + c);
        shadow_OAM[o].y = (uint8_t)(text_y + 16);
        shadow_OAM[o].x = (uint8_t)(TEXT_X + 8 + ((LEVEL_X_SHIFT + c) << 3));
        shadow_OAM[o].tile = (uint8_t)(TEXT_SPRITE_TILE + (c << 1));
        shadow_OAM[o].prop = 0;
    }
    // 16 columns, 10 sprites per line: the first 10 in OAM order win, rotate the order
    uint8_t start = (rot & 1) ? 6 : 0;
    for (c = 0; c < complete_shown; c++) {
        uint8_t o = (uint8_t)(OAM_COMPLETE + ((c + COMPLETE_COLS - start) & 15));
        shadow_OAM[o].y = (uint8_t)(text_y + 32);
        shadow_OAM[o].x = (uint8_t)(TEXT_X + 8 + (c << 3));
        shadow_OAM[o].tile = (uint8_t)(TEXT_SPRITE_TILE + ((LEVEL_COLS + c) << 1));
        shadow_OAM[o].prop = 0;
    }
    rot++;
}

// ---------------------------------------------------------------- box (background tiles)

static uint8_t font_tile(char c) {
    if (c == ' ') return 0;
    if (c == '%') return 1;
    if (c == '/') return 2;
    if (c >= '0' && c <= '9') return (uint8_t)((c - '0') + 3);
    if (c >= 'A' && c <= 'Z') return (uint8_t)((c - 'A') + 13);
    if (c == '>') return 40;
    return 0;
}

static void need_glyphs(const char *s) {
    for (; *s; s++) {
        uint8_t t = font_tile(*s);
        if (t) font_slot[t] = 0;
    }
}

static void put(uint8_t x, uint8_t y, uint8_t tile, uint8_t attr) {
    uint8_t mx = (uint8_t)((map_x0 + x) & 31), my = (uint8_t)((map_y0 + y) & 31);
    set_bkg_tile_xy(mx, my, tile);
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        set_bkg_tile_xy(mx, my, attr);
        VBK_REG = 0;
    }
}

// Picks VRAM slots (BG tiles 0..127) that no visible cell outside the box shows, and loads the
// box's border and font tiles there. Returns 0 when there are not enough free slots.
static uint8_t box_tiles_load(void) {
    uint8_t used[128];
    uint8_t x, y, i, t, n = 0;
    for (i = 0; i < 128; i++) used[i] = 0;
    used[TILE_BLANK] = 1;
    for (y = 0; y < 18; y++) {
        for (x = 0; x < 20; x++) {
            if (y >= BOX_TOP && y <= BOX_BOTTOM && x >= 2 && x <= 17) continue;   // overwritten
            t = get_bkg_tile_xy((uint8_t)((map_x0 + x) & 31), (uint8_t)((map_y0 + y) & 31));
            if (t < 128) used[t] = 1;
        }
    }
    for (i = 0; i < 44; i++) font_slot[i] = 0xFF;
    need_glyphs("ATTEMPTS COINS RETRY MENU PRACTICE RUN 0123456789/>");
    uint8_t need = 10;
    for (i = 0; i < 44; i++) if (font_slot[i] == 0) need++;
    uint8_t free_n = 0;
    for (i = 0; i < 128; i++) if (!used[i]) free_n++;
    if (free_n < need) return 0;

    i = 0;
    for (n = 0; n < 10; n++) {
        while (used[i]) i++;
        border_slot[n] = i;
        used[i] = 1;
        set_bkg_data(i, 1, settings_bg_tiles + (uint16_t)border_src[n] * 16u);
    }
    for (n = 0; n < 44; n++) {
        if (font_slot[n] != 0) continue;
        while (used[i]) i++;
        font_slot[n] = i;
        used[i] = 1;
        set_bkg_data(i, 1, n >= 39 ? extra_font_tiles + (uint16_t)(n - 39) * 16u : FontPusab + (uint16_t)n * 16u);
    }
    return 1;
}

static void box_text(uint8_t x, uint8_t y, const char *s) {
    for (; *s; s++, x++) {
        uint8_t t = font_tile(*s);
        put(x, y, t ? font_slot[t] : TILE_BLANK, PAL_BOARD);
    }
}

static void box_number(uint8_t right_x, uint8_t y, uint16_t v) {
    char buf[6];
    uint8_t n = 0;
    do { buf[n++] = (char)('0' + v % 10u); v /= 10u; } while (v);
    uint8_t x = (uint8_t)(right_x + 1 - n);
    while (n) { n--; put(x, y, font_slot[3 + (buf[n] - '0')], PAL_BOARD); x++; }
}

static void box_row(uint8_t y) {
    uint8_t x;
    if (y == BOX_TOP) {
        put(2, y, border_slot[B_TL], PAL_CORNER);
        for (x = 3; x < 17; x++) put(x, y, border_slot[B_TOP], PAL_BORDER);
        put(17, y, border_slot[B_TR], PAL_CORNER);
    } else if (y == BOX_BOTTOM) {
        put(2, y, border_slot[B_BL], PAL_CORNER);
        for (x = 3; x < 17; x++) {
            if (x == 9 || x == 10) put(x, y, border_slot[x == 9 ? B_NOTCH0 : B_NOTCH1], PAL_CORNER);
            else put(x, y, border_slot[B_BOTTOM], PAL_BORDER);
        }
        put(17, y, border_slot[B_BR], PAL_CORNER);
    } else {
        put(2, y, border_slot[B_LEFT], PAL_BORDER);
        for (x = 3; x < 17; x++) put(x, y, TILE_BLANK, PAL_BOARD);
        put(17, y, border_slot[B_RIGHT], PAL_BORDER);
    }
}

static void draw_buttons(uint8_t sel) {
    box_text(4, BOX_ROW_BUTTONS, sel == 0 ? ">" : " ");
    box_text(5, BOX_ROW_BUTTONS, "RETRY");
    box_text(11, BOX_ROW_BUTTONS, sel == 1 ? ">" : " ");
    box_text(12, BOX_ROW_BUTTONS, "MENU");
}

static void draw_stats(void) {
    uint8_t coins = (uint8_t)((lc_coins & 1) + ((lc_coins >> 1) & 1) + ((lc_coins >> 2) & 1));
    box_text(4, BOX_ROW_ATTEMPTS, "ATTEMPTS");
    box_number(15, BOX_ROW_ATTEMPTS, lc_attempts);
    box_text(4, BOX_ROW_COINS, "COINS");
    put(13, BOX_ROW_COINS, font_slot[3 + coins], PAL_BOARD);
    put(14, BOX_ROW_COINS, font_slot[2], PAL_BOARD);
    put(15, BOX_ROW_COINS, font_slot[3 + 3], PAL_BOARD);
    if (lc_practice) box_text(4, BOX_ROW_MODE, "PRACTICE RUN");
}

// ---------------------------------------------------------------- leaving

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
    music_ready = 0;
    skip = 0;
    rot = 0;
    level_shown = complete_shown = 0;
    text_y = TEXT_Y_CENTRE;
    prev_joy = joypad();

    // the text: tiles over the player's (it has left the screen), a green palette
    level_text_load();
    if (_cpu == CGB_TYPE) {
        static const palette_color_t text_pal[4] = {
            RGB8(0, 0, 0), RGB8(196, 255, 72), RGB8(72, 200, 28), RGB8(8, 40, 4)
        };
        fade_set_sprite_palette(0, 1, text_pal);
    }
    level_text_draw();              // hides the level's object sprites (their OAM slots)

    wait_frames(6);
    for (c = 1; c <= LEVEL_COLS; c++) {
        level_shown = c;
        level_text_draw();
        wait_frames(2);
    }
    wait_frames(4);
    for (c = 1; c <= COMPLETE_COLS; c++) {
        complete_shown = c;
        level_text_draw();
        wait_frames(2);
    }
    // 2 seconds with the text on the level (A skips the wait)
    for (y = 0; y < 120 && !skip; y++) wait_draw(1);
    skip = 0;

    // the box: grid-lock the scroll like the pause menu does, then pick the tile slots
    uint8_t scx = (uint8_t)(SCX_REG & 0xF8u), scy = (uint8_t)(SCY_REG & 0xF8u);
    move_bkg(scx, scy);
    map_x0 = (uint8_t)(scx >> 3);
    map_y0 = (uint8_t)(scy >> 3);
    uint8_t have_box = box_tiles_load();
    if (_cpu == CGB_TYPE) {
        // the settings board's palettes 1, 2 and 7 (border, board + text, corners)
        set_bkg_palette(PAL_BORDER, 1, settings_bg_palettes + 1 * 4);
        set_bkg_palette(PAL_BOARD, 1, settings_bg_palettes + 2 * 4);
        set_bkg_palette(PAL_CORNER, 1, settings_bg_palettes + 7 * 4);
    }

    // the text moves up while the box drops in
    for (c = 1; c <= TEXT_SLIDE_FRAMES; c++) {
        text_y = (uint8_t)(TEXT_Y_CENTRE - (uint8_t)((uint16_t)c * (2u * TEXT_SLIDE_FRAMES - c) / 12u));
        wait_draw(1);
    }
    text_y = TEXT_Y_TOP;
    level_text_draw();

    uint8_t sel = 0;
    if (have_box) {
        for (y = BOX_TOP; y <= BOX_BOTTOM; y++) {
            box_row(y);
            wait_draw(2);
        }
        draw_stats();
        draw_buttons(sel);
    }
    // the A that may still be held from the level must not choose RETRY right away
    prev_joy = joypad();
    while (joypad() & (J_A | J_START | J_B)) { wait_vbl_done(); level_text_draw(); }
    prev_joy = joypad();

    while (1) {
        wait_vbl_done();
        level_text_draw();
        uint8_t joy = joypad();
        uint8_t pressed = joy & ~prev_joy;
        prev_joy = joy;
        if (have_box && (pressed & (J_LEFT | J_RIGHT))) {
            sel ^= 1;
            draw_buttons(sel);
        }
        if (pressed & (J_A | J_START)) return leave(sel ? STATE_NEW_MENU_SELECT : STATE_PLAY_LEVEL);
        if (pressed & J_B) return leave(STATE_NEW_MENU_SELECT);
    }
}
