#ifndef GBC_PALETTES_H
#define GBC_PALETTES_H

#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdint.h>

/**
 * GBC Palette data converted from FamiDash (NES)
 */

extern const uint16_t paletteDefault[16];
extern const uint16_t paletteDefaultSP[16];
extern const uint16_t paletteMenu[16];
extern const uint16_t splashMenu[16];
extern const uint16_t gameoverpalette[16];
extern const uint16_t oldsplashMenu[16];
extern const uint16_t splashMenu2[16];
extern const uint16_t paletteLVLSelectSP[16];

palette_color_t get_nes_color(uint8_t nes_id);

#endif
