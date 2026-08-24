#ifndef FAMIDASH_SPRITES_H
#define FAMIDASH_SPRITES_H

#include <stdint.h>
#include <gbdk/metasprites.h>
#include "assets.h"

#define FAMIDASH_SPRITE_TILE_BASE 104
#define FAMIDASH_SPRITE_TILE_COUNT 84

extern const uint8_t famidash_sprites_tiles[1152];

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
#define D_CF 36
#define D_C9 38
#define D_CB 40
#define D_CD 42
#define D_D5 44
#define D_D7 46
#define D_D9 48
#define D_DB 50
#define D_DD 52
#define D_DF 54
#define D_E1 56
#define D_E3 58
#define D_E5 60
#define D_E7 62
#define D_ED 64
#define D_F5 66
#define D_F1 68
#define D_F7 70

#endif
