#pragma bank 10
#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

// Converted from GDP Ball.chr (2 animated frames, 8x16 metasprite format)
// Total 4 tiles (64 bytes): 2 tiles per frame. The ball is symmetric under a 180 degree rotation, so
// the right half is the left half drawn with S_FLIPX | S_FLIPY (gameplay.c draws it at tile base 8).

// Metasprites for 8x16 mode
const metasprite_t ball_metasprite0[] = {
    METASPR_ITEM(0, 0, 0, 0),
    METASPR_ITEM(0, 8, 0, S_FLIPX | S_FLIPY),
    METASPR_TERM
};

const metasprite_t ball_metasprite1[] = {
    METASPR_ITEM(0, 0, 2, 0),
    METASPR_ITEM(0, 8, 2, S_FLIPX | S_FLIPY),
    METASPR_TERM
};

const metasprite_t* const ball_metasprites[2] = {
    ball_metasprite0,
    ball_metasprite1
};
