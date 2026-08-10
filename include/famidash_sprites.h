#ifndef FAMIDASH_SPRITES_H
#define FAMIDASH_SPRITES_H

#include <stdint.h>
#include <gbdk/metasprites.h>
#include "assets.h"

#define FAMIDASH_SPRITE_TILE_BASE 88
#define FAMIDASH_SPRITE_TILE_COUNT 36

extern const uint8_t famidash_sprites_tiles[576];

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

const metasprite_t *famidash_sprite_for_object(uint8_t object_id);
uint8_t collect_level_sprites(const SpDef *sp_list, uint8_t sp_bank,
                              uint8_t start_idx, uint16_t cam_px,
                              SpDef *visible);

#endif
