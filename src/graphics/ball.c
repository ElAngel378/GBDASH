#pragma bank 10
#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

// Converted from GDP Ball.chr (2 animated frames, 8x16 metasprite format)
// Total 8 tiles (128 bytes): 4 tiles per 16x16 frame

// Metasprites for 8x16 mode
const metasprite_t ball_metasprite0[] = {
    METASPR_ITEM(0, 0, 0, 0),
    METASPR_ITEM(0, 8, 2, 0),
    METASPR_TERM
};

const metasprite_t ball_metasprite1[] = {
    METASPR_ITEM(0, 0, 4, 0),
    METASPR_ITEM(0, 8, 6, 0),
    METASPR_TERM
};

const metasprite_t* const ball_metasprites[2] = {
    ball_metasprite0,
    ball_metasprite1
};
