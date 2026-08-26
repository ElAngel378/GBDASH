#ifndef FAMIDASH_SPRITES_H
#define FAMIDASH_SPRITES_H

#include <stdint.h>
#include <gbdk/metasprites.h>
#include "assets.h"

#define FAMIDASH_SPRITE_TILE_BASE 112
#define FAMIDASH_SPRITE_TILE_COUNT 92
#define CHAIN_BLOCK_TILE 84

extern const uint8_t famidash_sprites_tiles[FAMIDASH_SPRITE_TILE_COUNT * 16];

extern const metasprite_t famidash_cube_portal[];
extern const metasprite_t famidash_ship_portal[];
extern const metasprite_t famidash_ball_portal[];
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

#define DP S_PAL(3)
/* Decoration tile pairs follow the 18 gameplay pairs in VRAM. */
// 24 gameplay pairs occupy tiles 0..47; decoration pairs start at 48.
#define D_CF 48
#define D_C9 50
#define D_CB 52
#define D_CD 54
#define D_D5 56
#define D_D7 58
#define D_D9 60
#define D_DB 62
#define D_DD 64
#define D_DF 66
#define D_E1 68
#define D_E3 70
#define D_E5 72
#define D_E7 74
#define D_ED 76
#define D_F5 78
#define D_F1 80
#define D_F7 82

extern const metasprite_t famidash_deco_45[];

#endif
