#ifndef POLARGEIST_SPRITES_H
#define POLARGEIST_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} polargeist_sprites_placement_t;

#define POLARGEIST_SPRITES_COUNT 242
extern const polargeist_sprites_placement_t polargeist_sprites_placements[];

#endif /* POLARGEIST_SPRITES_H */
