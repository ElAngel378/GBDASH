#ifndef DRYOUT_SPRITES_H
#define DRYOUT_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} dryout_sprites_placement_t;

#define DRYOUT_SPRITES_COUNT 212
extern const dryout_sprites_placement_t dryout_sprites_placements[];

#endif /* DRYOUT_SPRITES_H */
