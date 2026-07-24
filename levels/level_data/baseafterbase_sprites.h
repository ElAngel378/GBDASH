#ifndef BASEAFTERBASE_SPRITES_H
#define BASEAFTERBASE_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} baseafterbase_sprites_placement_t;

#define BASEAFTERBASE_SPRITES_COUNT 229
extern const baseafterbase_sprites_placement_t baseafterbase_sprites_placements[];

#endif /* BASEAFTERBASE_SPRITES_H */
