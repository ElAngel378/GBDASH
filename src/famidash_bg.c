#pragma bank 14

#include <gb/gb.h>

#include "famidash_bg.h"
#include "fade.h"
#include "bg_parallax.h"

// Sky/ground colours per NES colour id live in famidash_bg_tables.h, generated
// by tools/gen_famidash_bg_tables.py from Famidash's own NES palette.

/**
 * Vibrant GBC Palettes moved local for maximum DMG performance
 */
#include <string.h>

static const uint16_t vibrant_palette_default[20] = {
    RGB( 1,  9, 24), RGB( 0,  4, 14), RGB( 0,  0,  0), RGB(31, 31, 31), // palette 0
    RGB( 1,  9, 24), RGB( 0,  4, 14), RGB( 1,  9, 24), RGB(31, 31, 31), // palette 1
    RGB( 1,  9, 24), RGB( 0,  4, 14), RGB( 0,  0,  0), RGB( 9, 25,  4), // palette 2: bg spikes accent (lime, matches cube)
    RGB( 1,  9, 24), RGB( 0,  4, 14), RGB( 0,  0,  0), RGB( 0,  0,  0), // palette 3
    RGB(31, 31, 31), RGB( 9, 25,  4), RGB( 5, 14,  0), RGB( 1,  7,  0)  // palette 4: ground (white line, ground, grid1, grid2)
};

// famidash_bg_palettes: what is on screen (the VBlank handler uploads it). The colour triggers
// set famidash_bg_target and the screen fades to it in BG_FADE_FRAMES frames (0.3 s): every
// colour channel moves by a fixed 8.8 step, computed once per trigger.
#define BG_FADE_FRAMES 18
palette_color_t famidash_bg_palettes[20];
palette_color_t famidash_bg_target[20];
static int16_t fade_acc[20][3];     // channel << 8
static int16_t fade_step[20][3];
static uint8_t fade_left;           // frames to go, 0: not fading

static void start_fade(void) {
    for (uint8_t i = 0; i < 20; i++) {
        uint16_t a = famidash_bg_palettes[i], b = famidash_bg_target[i];
        for (uint8_t c = 0; c < 3; c++, a >>= 5, b >>= 5) {
            int16_t from = (int16_t)(a & 31u);
            int16_t d = (int16_t)(b & 31u) - from;
            fade_acc[i][c] = from << 8;
            // d * 256 / 18 ~= d * 14.25 (the last frame lands on the target exactly)
            fade_step[i][c] = (int16_t)(((d << 6) - (d << 3) + d) >> 2);
        }
    }
    fade_left = BG_FADE_FRAMES;
}

// Once per frame (CGB): next step of a running fade
void famidash_bg_fade_step(void) BANKED {
    if (!fade_left) return;
    if (--fade_left == 0) {
        memcpy(famidash_bg_palettes, famidash_bg_target, sizeof(famidash_bg_target));
    } else {
        for (uint8_t i = 0; i < 20; i++) {
            int16_t *acc = fade_acc[i];
            const int16_t *st = fade_step[i];
            acc[0] += st[0]; acc[1] += st[1]; acc[2] += st[2];
            famidash_bg_palettes[i] = (palette_color_t)(((uint16_t)(acc[0] >> 8) & 31u)
                | (((uint16_t)(acc[1] >> 8) & 31u) << 5) | (((uint16_t)(acc[2] >> 8) & 31u) << 10));
        }
    }
    memcpy(shadow_bkg_palettes, famidash_bg_palettes, 20 * sizeof(palette_color_t));
    famidash_bkg_palettes_dirty = 1;
}

// Shows pal (20 colours) right away, no fade (practice checkpoint restore)
void famidash_bg_set_now(const palette_color_t *pal) BANKED {
    memcpy(famidash_bg_target, pal, sizeof(famidash_bg_target));
    memcpy(famidash_bg_palettes, pal, sizeof(famidash_bg_target));
    memcpy(shadow_bkg_palettes, pal, 20 * sizeof(palette_color_t));
    fade_left = 0;
}
static palette_color_t current_sky_color = RGB( 1,  9, 24);
static palette_color_t current_g_color = RGB( 9, 25,  4);

uint8_t famidash_bkg_palettes_dirty = 0;

#include "famidash_bg_tables.h"

void famidash_apply_bg_trigger(uint8_t color_id) BANKED {
    if (color_id == 46u) {
        famidash_apply_g_trigger(46u);
        return;
    }
    uint8_t idx = (color_id == 31u) ? 0x2Cu : (color_id & 0x3Fu);
    const famidash_sky_shades_t *shades = &famidash_sky_table[idx];
    if (shades->color == current_sky_color) return;

    current_sky_color = shades->color;

    // Palette 0: Normal level tiles
    famidash_bg_target[0] = shades->color;
    famidash_bg_target[1] = shades->darker;
    famidash_bg_target[2] = RGB(0, 0, 0);
    famidash_bg_target[3] = RGB(31, 31, 31);

    // Palette 1: Accent / Ground (preserve ground color in 5 and 6)
    famidash_bg_target[4] = shades->color;
    famidash_bg_target[7] = RGB(31, 31, 31);

    // Palette 2: BG Spikes / Hazards
    famidash_bg_target[8] = shades->color;
    famidash_bg_target[9] = shades->darker;
    famidash_bg_target[10] = RGB(0, 0, 0);
    famidash_bg_target[11] = RGB(15, 31, 0);

    // Palette 3: Parallax BG
    famidash_bg_target[12] = shades->color;
    famidash_bg_target[13] = shades->border;
    famidash_bg_target[14] = shades->body;
    famidash_bg_target[15] = shades->shadow;

    // Palette 4: Ground Grid (Color 0 is the top white line, always pure white)
    famidash_bg_target[16] = RGB(31, 31, 31);

    start_fade();
}

void famidash_apply_g_trigger(uint8_t color_id) BANKED {
    uint8_t idx;
    if (color_id == 31u) idx = 0x2Cu;
    else if (color_id == 46u) idx = 0x2Au;
    else idx = color_id & 0x3Fu;

    const famidash_sky_shades_t *sky_entry = &famidash_sky_table[idx];
    palette_color_t color = sky_entry->color;
    if (color == current_g_color) return;

    current_g_color = color;
    const famidash_ground_shades_t *shades = &famidash_ground_table[idx];

    // Palette 1: Ground color
    famidash_bg_target[5] = shades->darker;
    famidash_bg_target[6] = color;

    // Palette 4: Ground Grid
    famidash_bg_target[16] = RGB(31, 31, 31);
    famidash_bg_target[17] = color;
    famidash_bg_target[18] = shades->grid_18;
    famidash_bg_target[19] = shades->grid_9;

    start_fade();
}

#define NUM_LEVEL_COLORS 13
static const uint8_t level_initial_bg_color[NUM_LEVEL_COLORS] = {
    17, // Stereo Madness: Blue
    20, // Back On Track: Magenta
    42, // Polargeist: Green
    22, // Dry Out: Red
    17, // Base After Base: Blue
    20, // Cant Let Go: Magenta
    19, // Jumper: Purple
    42, // Time Machine: Green
    4,  // Cycles: Dark Violet
    28, // xStep: Cyan
    17, // Ultimate Destruction: Blue
    22, // Clutterfunk: Red
    17  // Test
};

static const uint8_t level_initial_g_color[NUM_LEVEL_COLORS] = {
    46, // Stereo Madness: Neon Green
    20, // Back On Track: Magenta
    26, // Polargeist: Medium Green
    22, // Dry Out: Red
    17, // Base After Base: Blue
    4,  // Cant Let Go: Dark Violet
    19, // Jumper: Purple
    26, // Time Machine: Medium Green
    20, // Cycles: Magenta
    12, // xStep: Dark Cyan
    17, // Ultimate Destruction: Blue
    6,  // Clutterfunk: Dark Red
    46  // Test
};

void famidash_reset_bg_palettes(uint8_t idx) BANKED {
    uint8_t i;
    if (idx >= NUM_LEVEL_COLORS) idx = 0;
    for (i = 0; i < 20; i++) famidash_bg_target[i] = vibrant_palette_default[i];
    current_sky_color = 0xFFFF;
    current_g_color = 0xFFFF;
    famidash_apply_bg_trigger(level_initial_bg_color[idx]);
    famidash_apply_g_trigger(level_initial_g_color[idx]);
    famidash_bg_set_now(famidash_bg_target);   // the level's colours from the start, no fade
    if (_cpu == CGB_TYPE) {
        set_bkg_palette(0, 5, famidash_bg_palettes);
    }
    famidash_bkg_palettes_dirty = 0;
}
