#ifndef FAMIDASH_SPRITES_H
#define FAMIDASH_SPRITES_H

#include <stdint.h>
#include <gbdk/metasprites.h>
#include "assets.h"

#define FAMIDASH_SPRITE_TILE_BASE 88
#define FAMIDASH_SPRITE_TILE_COUNT 72

extern const uint8_t famidash_sprites_tiles[1152];

extern const metasprite_t famidash_cube_portal[];
extern const metasprite_t famidash_ship_portal[];
extern const metasprite_t famidash_gravity_down[];
extern const metasprite_t famidash_gravity_up[];
extern const metasprite_t famidash_yellow_pad[];
extern const metasprite_t famidash_yellow_pad_up[];
extern const metasprite_t famidash_blue_pad[];
extern const metasprite_t famidash_blue_pad_up[];
extern const metasprite_t famidash_yellow_orb[];
extern const metasprite_t famidash_blue_orb[];
extern const metasprite_t famidash_pink_orb[];
extern const metasprite_t famidash_pink_pad[];
extern const metasprite_t * const famidash_sprite_table[38];

typedef struct {
    uint8_t count;
    uint8_t width;
    int8_t x[3];
    int8_t y[3];
    uint8_t tile[3];
    uint8_t props[3];
} FamidashDeco;

extern const FamidashDeco * const famidash_deco_table[64];

#endif
