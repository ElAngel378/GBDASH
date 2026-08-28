#include <gb/cgb.h>
#include "gbc_palettes.h"

/**
 * NES Master Palette mapped to GBC 15-bit RGB.
 * 64 colors (4 rows of 16).
 */
const uint16_t nes_master_palette[64] = {
    // Row 0 (0x00 - 0x0F): Dark
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(1, 2, 18), RGB(6, 0, 17),
    RGB(8, 0, 12), RGB(11, 0, 6), RGB(20, 0, 0), RGB(7, 3, 0),
    RGB(4, 5, 0), RGB(1, 7, 0), RGB(0, 8, 0), RGB(0, 7, 0),
    RGB(0, 6, 7), RGB(0, 0, 0), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 1 (0x10 - 0x1F): Medium/Dark
    RGB(22, 22, 22), RGB(0, 7, 19), RGB(6, 6, 29), RGB(11, 3, 28),
    RGB(27, 0, 25), RGB(20, 2, 12), RGB(27, 0, 0), RGB(15, 7, 0),
    RGB(10, 11, 0), RGB(5, 14, 0), RGB(1, 15, 0), RGB(0, 14, 5),
    RGB(0, 12, 15), RGB(0, 0, 0), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 2 (0x20 - 0x2F): Bright
    RGB(31, 31, 31), RGB(7, 23, 31), RGB(15, 15, 31), RGB(22, 12, 31),
    RGB(31, 7, 21), RGB(31, 11, 22), RGB(31, 13, 12), RGB(31, 15, 0),
    RGB(27, 20, 0), RGB(14, 24, 0), RGB(0, 28, 0), RGB(7, 25, 13),
    RGB(0, 29, 27), RGB(7, 7, 7), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 3 (0x30 - 0x3F): Pale
    RGB(31, 31, 31), RGB(21, 25, 31), RGB(23, 23, 31), RGB(26, 22, 31),
    RGB(31, 21, 31), RGB(31, 21, 26), RGB(31, 22, 22), RGB(31, 27, 15),
    RGB(25, 26, 15), RGB(22, 27, 15), RGB(21, 28, 18), RGB(19, 28, 22),
    RGB(20, 26, 28), RGB(20, 20, 20), RGB(0, 0, 0), RGB(0, 0, 0)
};

palette_color_t get_nes_color(uint8_t nes_id) {
    return nes_master_palette[nes_id & 0x3Fu];
}

/**
 * GBC Palette data converted from FamiDash (NES)
 * 16-bit integers defining a 15-bit RGB color space (0-31 per channel).
 */

const uint16_t paletteDefault[16] = {
    RGB(0, 7, 19), RGB(0, 0, 17), RGB(0, 0, 0), RGB(31, 31, 31), // palette 0
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(0, 7, 19), RGB(31, 31, 31), // palette 1
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(0, 0, 0), RGB(0, 28, 0), // palette 2
    RGB(0, 7, 19), RGB(0, 0, 17), RGB(0, 0, 0), RGB(0, 0, 0)  // palette 3
};

const uint16_t paletteDefaultSP[16] = {
    RGB(10, 10, 10), RGB(0, 0, 0), RGB(0, 28, 0), RGB(7, 23, 31),
    RGB(10, 10, 10), RGB(0, 0, 0), RGB(31, 7, 21), RGB(27, 20, 0),
    RGB(10, 10, 10), RGB(0, 0, 0), RGB(27, 0, 0), RGB(31, 31, 31),
    RGB(10, 10, 10), RGB(0, 0, 0), RGB(0, 28, 0), RGB(0, 29, 27)
};

const uint16_t paletteMenu[16] = {
    RGB(22, 8, 0), RGB(0, 0, 0), RGB(22, 22, 22), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 28, 0), RGB(21, 28, 18),
    RGB(22, 8, 0), RGB(0, 0, 0), RGB(22, 8, 0), RGB(31, 15, 0),
    RGB(22, 8, 0), RGB(0, 0, 0), RGB(0, 7, 19), RGB(7, 23, 31)
};

const uint16_t splashMenu[16] = {
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 15, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 28, 0), RGB(21, 28, 18),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 15, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31)
};

const uint16_t gameoverpalette[16] = {
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 7, 21), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(20, 0, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 15, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31)
};

const uint16_t oldsplashMenu[16] = {
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 28, 0), RGB(21, 28, 18),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 15, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31)
};

const uint16_t splashMenu2[16] = {
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(27, 0, 25), RGB(31, 27, 15),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 28, 0), RGB(21, 28, 18),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 15, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31)
};

const uint16_t paletteLVLSelectSP[16] = {
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 28, 0), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(0, 7, 19), RGB(31, 31, 31),
    RGB(0, 7, 19), RGB(0, 0, 0), RGB(31, 31, 31), RGB(31, 31, 31)
};
