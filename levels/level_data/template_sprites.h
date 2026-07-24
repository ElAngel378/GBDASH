#ifndef TEMPLATE_SPRITES_H
#define TEMPLATE_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} template_sprites_placement_t;

#define TEMPLATE_SPRITES_COUNT 0
extern const template_sprites_placement_t template_sprites_placements[1];

#endif /* TEMPLATE_SPRITES_H */
