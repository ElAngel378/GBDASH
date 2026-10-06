#pragma bank 29

#include "states.h"
#include "gameplay.h"
#include "assets.h"
#include "rainbow.h"
#include "logo.h"
#include "bg_parallax.h"
#include "settings.h"
#include <gb/gb.h>
#include <gb/cgb.h>

// The menu background is static: it is never scrolled and uses no scanline (LYC/HBlank)
// interrupt. Like in gameplay, the sky is the parallax block pattern, animated by the
// VBlank handler (CGB), and the ground strip scrolls by rewriting its map rows.

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
extern const uint8_t menu_ground_tiles[];
BANKREF_EXTERN(menu_bg)
extern const unsigned char playbutton[];
BANKREF_EXTERN(playbutton)

// Ground strip: menu_ground.png, 3 tile rows (screen y 120..143). Per row: a 64px period
// of start tile, 6 uniform tiles, end tile. See build_ground_variants().
#define GROUND_ROW            15
#define GROUND_ROWS           3
#define GROUND_PERIOD         64
#define GROUND_SPEED          3
#define GROUND_TILE_BASE      1    // VRAM tiles 1..48, 16 per row
#define GROUND_TILES_PER_ROW  16
#define GROUND_TILE_COUNT     9

static uint8_t ground_src[GROUND_TILE_COUNT * 16];   // menu_ground_tiles, copied out of its bank

static void menu_load_bg_gfx(void) __nonbanked {
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(menu_bg));
    for (uint8_t i = 0; i < GROUND_TILE_COUNT * 16; i++) ground_src[i] = menu_ground_tiles[i];

    // Load logo tiles from BANK(logo)
    SWITCH_ROM(BANK(logo));
    set_bkg_data(LOGO_TILE_START, LOGO_TILE_COUNT, logo_tiles);
    SWITCH_ROM(prev_bank);
}

// The ground is a flat strip with one 8px wide "pillar" every 64px. A pillar at any pixel
// position is a pair of tiles per row (the left one holds the pillar's first 8-o pixels,
// the right one the rest), so all 8 offsets o are loaded once and the strip scrolls by
// choosing tiles in the map. Per row: uniform, L(o) for o = 0..7, R(o) for o = 1..7.
#define GROUND_UNIFORM(k)  ((uint8_t)(GROUND_TILE_BASE + (k) * GROUND_TILES_PER_ROW))
#define GROUND_LEFT(k, o)  ((uint8_t)(GROUND_UNIFORM(k) + 1 + (o)))
#define GROUND_RIGHT(k, o) ((uint8_t)(GROUND_UNIFORM(k) + 8 + (o)))

static void build_ground_variants(void) {
    for (uint8_t k = 0; k < GROUND_ROWS; k++) {
        const uint8_t *st = &ground_src[k * 3 * 16];   // tile at the start of the period
        const uint8_t *un = st + 16;                   // uniform middle tile
        const uint8_t *en = st + 32;                   // tile at the end of the period
        set_bkg_data(GROUND_UNIFORM(k), 1, un);
        for (uint8_t o = 0; o < 8; o++) {
            uint8_t left[16], right[16];
            for (uint8_t i = 0; i < 16; i++) {         // bytes alternate between the 2 bit planes
                // the pillar: last 5 pixels of the end tile + first 3 of the start tile
                uint8_t pillar = (uint8_t)(((en[i] & 0x1F) << 3) | (st[i] >> 5));
                uint16_t w = ((uint16_t)un[i] << 8) | un[i];
                w = (w & ~(0xFF00u >> o)) | (((uint16_t)pillar << 8) >> o);
                left[i] = (uint8_t)(w >> 8);
                right[i] = (uint8_t)w;
            }
            set_bkg_data(GROUND_LEFT(k, o), 1, left);
            if (o) set_bkg_data(GROUND_RIGHT(k, o), 1, right);
        }
    }
}

// phase = screen x of the first pillar's left edge (pillars are GROUND_PERIOD apart)
static void draw_ground(uint8_t phase) {
    uint8_t rows[GROUND_ROWS][20];
    for (uint8_t k = 0; k < GROUND_ROWS; k++) {
        for (uint8_t x = 0; x < 20; x++) rows[k][x] = GROUND_UNIFORM(k);
    }
    for (uint8_t j = 0; j < 3; j++) {
        int16_t xl = (int16_t)phase + (int16_t)(j * GROUND_PERIOD) - 8;
        int8_t tx = (int8_t)(xl >> 3);
        uint8_t o = (uint8_t)xl & 7;
        for (uint8_t k = 0; k < GROUND_ROWS; k++) {
            if (tx >= 0 && tx < 20) rows[k][tx] = GROUND_LEFT(k, o);
            if (o && tx + 1 >= 0 && tx + 1 < 20) rows[k][tx + 1] = GROUND_RIGHT(k, o);
        }
    }
    for (uint8_t k = 0; k < GROUND_ROWS; k++) {
        set_bkg_tiles(0, (uint8_t)(GROUND_ROW + k), 20, 1, rows[k]);
    }
}

// DMG sky: the gameplay parallax block pattern (phase 0, 48 tiles, 8 tiles = 64px period),
// loaded into bank 0 VRAM and scrolled with SCX by a scanline (LYC) interrupt, the same
// look as the CGB menu. Rows 0..1 (logo) and the ground strip are drawn at SCX 0.
#define DMG_SKY_TILE   53
#define DMG_SKY_PERIOD 64
static volatile uint8_t menu_sky_scx;

// The interrupt comes one line early and waits for the line itself: an interrupt in the way
// (the music tick) can no longer make the split land a line late.
static void menu_stat_isr(void) __nonbanked {
    if (LYC_REG == 15) {
        while (LY_REG < 16u);
        SCX_REG = menu_sky_scx;
        LYC_REG = 119;
    } else {
        while (LY_REG < 120u);
        SCX_REG = 0;
        LYC_REG = 255;
    }
}

// Start of every frame: logo at SCX 0, the STAT handler scrolls the sky from line 16. Done in
// the VBlank interrupt: the main loop's ground update can run well into the next frame.
static void menu_vbl_isr(void) __nonbanked {
    SCX_REG = 0;
    LYC_REG = 15;
}

static void menu_load_dmg_sky_tiles(void) __nonbanked {
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(BANK(bg_parallax_data_0));
    set_bkg_data(DMG_SKY_TILE, BG_PARALLAX_NUM_TILES, bg_parallax_phases_0[0]);
    SWITCH_ROM(prev_bank);
}

// Sky rows 2..14: the gameplay parallax pattern (48 tiles, tile row offsets 0/16/32,
// 8 tiles wide): VRAM bank 1 on CGB, bank 0 at DMG_SKY_TILE on DMG.
static void draw_sky(void) {
    uint8_t tiles[32];
    if (_cpu == CGB_TYPE && setting_show_bg_enabled) {
        static const uint8_t row_to_ty0[3] = { 0, 16, 32 };
        for (uint8_t ty = 2; ty < GROUND_ROW; ty++) {
            uint8_t ty0 = (uint8_t)(row_to_ty0[(ty >> 1) % 3] + ((ty & 1) << 3));
            for (uint8_t x = 0; x < 20; x++) tiles[x] = (uint8_t)(ty0 + (x & 7));
            VBK_REG = 0;
            set_bkg_tiles(0, ty, 20, 1, tiles);
        }
        VBK_REG = 1;
        fill_bkg_rect(0, 2, 20, GROUND_ROW - 2, 0x0B);   // bank 1, palette 3
        VBK_REG = 0;
    } else if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        fill_bkg_rect(0, 2, 20, GROUND_ROW - 2, 3);      // plain sky colour (palette 3)
        VBK_REG = 0;
    } else if (setting_show_bg_enabled) {
        static const uint8_t row_to_ty0[3] = { 0, 16, 32 };
        menu_load_dmg_sky_tiles();
        for (uint8_t ty = 2; ty < GROUND_ROW; ty++) {
            uint8_t ty0 = (uint8_t)(DMG_SKY_TILE + row_to_ty0[(ty >> 1) % 3] + ((ty & 1) << 3));
            for (uint8_t x = 0; x < 32; x++) tiles[x] = (uint8_t)(ty0 + (x & 7));   // all 32 columns: SCX scrolls
            set_bkg_tiles(0, ty, 32, 1, tiles);
        }
    }
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

    static uint16_t frame_counter = 0;

    menu_load_bg_gfx();
    static const uint8_t blank_tile[16] = { 0 };
    set_bkg_data(0, 1, blank_tile);
    fill_bkg_rect(0, 0, 32, 32, 0);
    build_ground_variants();

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

    draw_sky();
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        fill_bkg_rect(0, 0, 20, 2, 1);                    // logo: palette 1
        fill_bkg_rect(0, GROUND_ROW, 20, GROUND_ROWS, 4); // ground: palette 4
        VBK_REG = 0;
        // Continue the rainbow where it was (entering with colour 0 flashed red)
        apply_rainbow_palette((uint8_t)(frame_counter >> 4));
    }
    uint8_t ground_x = 0;
    draw_ground(ground_x);

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

    SCX_REG = 0;
    SCY_REG = 0;

    if (_cpu == CGB_TYPE && setting_show_bg_enabled) init_bg_parallax();

    uint8_t dmg_sky_irq = (_cpu != CGB_TYPE && setting_show_bg_enabled);
    if (dmg_sky_irq) {
        menu_sky_scx = 0;
        disable_interrupts();
        add_LCD(menu_stat_isr);
        add_VBL(menu_vbl_isr);
        STAT_REG |= STATF_LYC;
        LYC_REG = 15;
        set_interrupts(VBL_IFLAG | LCD_IFLAG | TIM_IFLAG);
        enable_interrupts();
    }

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

    // VBlank handler: runs the parallax GDMA at the start of VBlank (CGB)
    bg_parallax_isr_start();
    uint8_t sky_phase = 0;
    uint8_t prev_joy = joypad();

    while (1) {
        if (_cpu == CGB_TYPE && setting_show_bg_enabled && setting_parallax_enabled) {
            // the sky drifts left half a pixel per frame
            uint8_t phase = (uint8_t)(-(int8_t)(frame_counter >> 1)) & 63u;
            if (phase != sky_phase) {
                sky_phase = phase;
                request_bg_parallax(phase);
            }
        }
        bg_wait_vbl();
        draw_ground(ground_x);
        if (dmg_sky_irq) {
            if (setting_parallax_enabled) {
                menu_sky_scx = (uint8_t)(frame_counter >> 1) & (DMG_SKY_PERIOD - 1);
            }
        }
        if (_cpu == CGB_TYPE && (frame_counter & 15) == 0) {
            apply_rainbow_palette((uint8_t)(frame_counter >> 4));
        }

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
            if (dmg_sky_irq) {
                disable_interrupts();
                remove_LCD(menu_stat_isr);
                remove_VBL(menu_vbl_isr);
                STAT_REG &= ~STATF_LYC;
                SCX_REG = 0;
                set_interrupts(VBL_IFLAG | TIM_IFLAG);
                enable_interrupts();
            }
            bg_parallax_isr_stop();
            HIDE_SPRITES;
            HIDE_WIN;
            for (uint8_t s = 0; s < 40; s++) hide_sprite(s);
            return STATE_ICON_SELECT;
        }

        if (pressed & (J_A | J_START)) {
            if (dmg_sky_irq) {
                disable_interrupts();
                remove_LCD(menu_stat_isr);
                remove_VBL(menu_vbl_isr);
                STAT_REG &= ~STATF_LYC;
                SCX_REG = 0;
                set_interrupts(VBL_IFLAG | TIM_IFLAG);
                enable_interrupts();
            }
            bg_parallax_isr_stop();
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
        ground_x = (uint8_t)(ground_x - GROUND_SPEED) & (GROUND_PERIOD - 1);
    }
}
