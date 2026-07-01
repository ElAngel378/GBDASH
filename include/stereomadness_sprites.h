#ifndef STEREOMADNESS_SPRITES_H
#define STEREOMADNESS_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} stereomadness_sprites_placement_t;

#define STEREOMADNESS_SPRITES_COUNT 212
extern const stereomadness_sprites_placement_t stereomadness_sprites_placements[];

#endif /* STEREOMADNESS_SPRITES_H */
