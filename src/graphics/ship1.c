#pragma bank 10
#include <gb/gb.h>
#include <gbdk/metasprites.h>

// Ship metasprite: tail at left, nose at right
const metasprite_t ship_metasprite0[] = {
    { -1, -1, 8, 0 },
    { 0, 8, 10, 0 },
    METASPR_TERM
};

const metasprite_t* const ship_metasprites[1] = {
    ship_metasprite0
};
