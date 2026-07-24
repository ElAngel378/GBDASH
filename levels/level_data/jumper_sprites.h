#ifndef JUMPER_SPRITES_H
#define JUMPER_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} jumper_sprites_placement_t;

#define JUMPER_SPRITES_COUNT 249
extern const jumper_sprites_placement_t jumper_sprites_placements[];

#endif /* JUMPER_SPRITES_H */
