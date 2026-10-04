#pragma bank 10
#include <gb/gb.h>
#include <gbdk/metasprites.h>

// Ship metasprites: tail at left, nose at right; frames 0..6 = steep down .. neutral (3) .. steep up
const metasprite_t ship_metasprite0[] = {
    { -1, -1, 36, 0 },
    { 0, 8, 38, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite1[] = {
    { -1, -1, 40, 0 },
    { 0, 8, 42, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite2[] = {
    { -1, -1, 44, 0 },
    { 0, 8, 46, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite3[] = {
    { -1, -1, 48, 0 },
    { 0, 8, 50, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite4[] = {
    { -1, -1, 52, 0 },
    { 0, 8, 54, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite5[] = {
    { -1, -1, 56, 0 },
    { 0, 8, 58, 0 },
    METASPR_TERM
};

const metasprite_t ship_metasprite6[] = {
    { -1, -1, 60, 0 },
    { 0, 8, 62, 0 },
    METASPR_TERM
};

const metasprite_t* const ship_metasprites[7] = {
    ship_metasprite0,
    ship_metasprite1,
    ship_metasprite2,
    ship_metasprite3,
    ship_metasprite4,
    ship_metasprite5,
    ship_metasprite6
};
