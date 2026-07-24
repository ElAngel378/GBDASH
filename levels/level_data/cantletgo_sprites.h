#ifndef CANTLETGO_SPRITES_H
#define CANTLETGO_SPRITES_H

#include <stdint.h>

typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} cantletgo_sprites_placement_t;

#define CANTLETGO_SPRITES_COUNT 171
extern const cantletgo_sprites_placement_t cantletgo_sprites_placements[];

#endif /* CANTLETGO_SPRITES_H */
