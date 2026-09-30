#ifndef ICON1_H
#define ICON1_H

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

#define icon1_TILE_ORIGIN 0
#define icon1_TILE_W 8
#define icon1_TILE_H 16
#define icon1_WIDTH 16
#define icon1_HEIGHT 16
#define icon1_TILE_COUNT 8
#define icon1_PALETTE_COUNT 1
#define icon1_COLORS_PER_PALETTE 4
#define icon1_TOTAL_COLORS 4
#define icon1_PIVOT_X 1
#define icon1_PIVOT_Y 1
#define icon1_PIVOT_W 14
#define icon1_PIVOT_H 14

extern const metasprite_t* const icon1_metasprites[25];
extern const palette_color_t icon1_palettes[4];

#endif
