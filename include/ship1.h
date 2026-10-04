#ifndef SHIP1_H
#define SHIP1_H

#include <stdint.h>
#include <gbdk/metasprites.h>

#define SHIP_FRAME_COUNT 7
#define SHIP_FRAME_NEUTRAL 3
#define SHIP_TILE_BASE 36
#define SHIP_TILE_COUNT 28

// 7 rotation frames: 0 = steep down ... 3 = neutral ... 6 = steep up
extern const metasprite_t* const ship_metasprites[SHIP_FRAME_COUNT];

#endif
