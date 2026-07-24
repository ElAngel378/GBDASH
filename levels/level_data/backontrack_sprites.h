#ifndef BACKONTRACK_SPRITES_H
#define BACKONTRACK_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} backontrack_sprites_placement_t;

#define BACKONTRACK_SPRITES_COUNT 182
extern const backontrack_sprites_placement_t backontrack_sprites_placements[];

#endif /* BACKONTRACK_SPRITES_H */
