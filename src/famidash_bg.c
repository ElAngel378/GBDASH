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

palette_color_t famidash_bg_palettes[20];
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
    famidash_bg_palettes[0] = shades->color;
    famidash_bg_palettes[1] = shades->darker;
    famidash_bg_palettes[2] = RGB(0, 0, 0);
    famidash_bg_palettes[3] = RGB(31, 31, 31);

    // Palette 1: Accent / Ground (preserve ground color in 5 and 6)
    famidash_bg_palettes[4] = shades->color;
    famidash_bg_palettes[7] = RGB(31, 31, 31);

    // Palette 2: BG Spikes / Hazards
    famidash_bg_palettes[8] = shades->color;
    famidash_bg_palettes[9] = shades->darker;
    famidash_bg_palettes[10] = RGB(0, 0, 0);
    famidash_bg_palettes[11] = RGB(15, 31, 0);

    // Palette 3: Parallax BG
    famidash_bg_palettes[12] = shades->color;
    famidash_bg_palettes[13] = shades->border;
    famidash_bg_palettes[14] = shades->body;
    famidash_bg_palettes[15] = shades->shadow;

    // Palette 4: Ground Grid (Color 0 is the top white line, always pure white)
    famidash_bg_palettes[16] = RGB(31, 31, 31);

    memcpy(shadow_bkg_palettes, famidash_bg_palettes, 20 * sizeof(palette_color_t));
    famidash_bkg_palettes_dirty = 1;
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
    famidash_bg_palettes[5] = shades->darker;
    famidash_bg_palettes[6] = color;

    // Palette 4: Ground Grid
    famidash_bg_palettes[16] = RGB(31, 31, 31);
    famidash_bg_palettes[17] = color;
    famidash_bg_palettes[18] = shades->grid_18;
    famidash_bg_palettes[19] = shades->grid_9;

    memcpy(shadow_bkg_palettes, famidash_bg_palettes, 20 * sizeof(palette_color_t));
    famidash_bkg_palettes_dirty = 1;
}

static const uint8_t level_initial_bg_color[11] = {
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
    17  // Ultimate Destruction: Blue
};

static const uint8_t level_initial_g_color[11] = {
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
    17  // Ultimate Destruction: Blue
};

void famidash_reset_bg_palettes(uint8_t idx) BANKED {
    uint8_t i;
    if (idx >= 11) idx = 0;
    for (i = 0; i < 20; i++) famidash_bg_palettes[i] = vibrant_palette_default[i];
    current_sky_color = 0xFFFF;
    current_g_color = 0xFFFF;
    famidash_apply_bg_trigger(level_initial_bg_color[idx]);
    famidash_apply_g_trigger(level_initial_g_color[idx]);
    memcpy(shadow_bkg_palettes, famidash_bg_palettes, 20 * sizeof(palette_color_t));
    if (_cpu == CGB_TYPE) {
        set_bkg_palette(0, 5, famidash_bg_palettes);
    }
    famidash_bkg_palettes_dirty = 0;
}
