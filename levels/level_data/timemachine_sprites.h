#ifndef TIMEMACHINE_SPRITES_H
#define TIMEMACHINE_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} timemachine_sprites_placement_t;

#define TIMEMACHINE_SPRITES_COUNT 464
extern const timemachine_sprites_placement_t timemachine_sprites_placements[];

#endif /* TIMEMACHINE_SPRITES_H */
