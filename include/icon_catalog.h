#ifndef ICON_CATALOG_H
#define ICON_CATALOG_H

#include <stdint.h>
#include <gbdk/platform.h>
#include <gb/cgb.h>

#define NUM_CUBE_ICONS 7
#define NUM_GAMEMODE_TABS 7
#define NUM_PALETTE_COLORS 12
#define PREVIEW_TILE_BASE 1
#define PREVIEW_TILE_COUNT 19

// Available colors in RGB555 for CGB
extern const palette_color_t icon_palette_colors[NUM_PALETTE_COLORS];
// Available colors in DMG shade index (0..3)
extern const uint8_t icon_dmg_shades[NUM_PALETTE_COLORS];

// Pre-rendered 19 preview tiles for each of the 7 icons
BANKREF_EXTERN(icon_catalog)
extern const uint8_t icon_preview_tiles[NUM_CUBE_ICONS][PREVIEW_TILE_COUNT * 16];

#endif // ICON_CATALOG_H
