#pragma bank 1

#include <gb/gb.h>
#include <gbdk/incbin.h>
#include <gbdk/metasprites.h>

#include "famidash_sprites.h"

INCBIN(famidash_sprites_tiles, "levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin")
INCBIN_EXTERN(famidash_sprites_tiles)

#define P0 S_PAL(0)
#define P1 S_PAL(1)
#define PT_41 0
#define PT_43 2
#define PT_45 4
#define PT_47 6
#define PT_49 8
#define PT_4B 10
#define PT_6D 12
#define PT_6F 14
#define PT_73 16
#define PT_75 18
#define PT_79 20
#define PT_7B 22
#define MT_99 24
#define MT_9B 26
#define MT_B9 28
#define MT_BB 30
#define PT_59 32
#define PT_5B 34

const metasprite_t famidash_cube_portal[] = {
    METASPR_ITEM(0, 0, PT_41, P0), METASPR_ITEM(0, 8, PT_43, P0), METASPR_ITEM(0, 16, PT_45, P0),
    METASPR_ITEM(16, 0, PT_47, P0), METASPR_ITEM(16, 8, PT_49, P0), METASPR_ITEM(16, 16, PT_4B, P0),
    METASPR_ITEM(32, 0, PT_41, P0 | S_FLIPY), METASPR_ITEM(32, 8, PT_43, P0 | S_FLIPY),
    METASPR_ITEM(32, 16, PT_45, P0 | S_FLIPY), METASPR_TERM
};

const metasprite_t famidash_ship_portal[] = {
    METASPR_ITEM(0, 0, PT_41, P1), METASPR_ITEM(0, 8, PT_43, P1), METASPR_ITEM(0, 16, PT_45, P1),
    METASPR_ITEM(16, 0, PT_47, P1), METASPR_ITEM(16, 8, PT_49, P1), METASPR_ITEM(16, 16, PT_4B, P1),
    METASPR_ITEM(32, 0, PT_41, P1 | S_FLIPY), METASPR_ITEM(32, 8, PT_43, P1 | S_FLIPY),
    METASPR_ITEM(32, 16, PT_45, P1 | S_FLIPY), METASPR_TERM
};

#define VERTICAL_PORTAL(name, palette) \
const metasprite_t name[] = { \
    METASPR_ITEM(0, 0, PT_6D, palette), METASPR_ITEM(0, 8, PT_6F, palette), \
    METASPR_ITEM(16, 0, PT_73, palette), METASPR_ITEM(16, 8, PT_75, palette), \
    METASPR_ITEM(32, 0, PT_6D, palette | S_FLIPY), METASPR_ITEM(32, 8, PT_6F, palette | S_FLIPY), METASPR_TERM \
}

VERTICAL_PORTAL(famidash_gravity_down, P0);
VERTICAL_PORTAL(famidash_gravity_up, P1);

#define TWO_TILE(name, left, right, dy, palette, flip) \
const metasprite_t name[] = { \
    METASPR_ITEM(dy, 0, left, palette), METASPR_ITEM(dy, 8, right, palette | flip), METASPR_TERM \
}

TWO_TILE(famidash_yellow_pad, PT_79, PT_7B, 0, P1, S_FLIPX);
TWO_TILE(famidash_yellow_pad_up, PT_79, PT_7B, 0, P1, S_FLIPX | S_FLIPY);
TWO_TILE(famidash_blue_pad, PT_79, PT_7B, 0, P0, S_FLIPX);
TWO_TILE(famidash_blue_pad_up, PT_79, PT_7B, 0, P0, S_FLIPX | S_FLIPY);
TWO_TILE(famidash_yellow_orb, MT_99, MT_9B, 0, P1, S_FLIPX);
TWO_TILE(famidash_blue_orb, MT_99, MT_9B, 0, P0, S_FLIPX);
TWO_TILE(famidash_pink_orb, MT_B9, MT_BB, 0, P1, S_FLIPX);
TWO_TILE(famidash_pink_pad, PT_59, PT_5B, 0, P1, S_FLIPX);

const metasprite_t *famidash_sprite_for_object(uint8_t object_id) {
    switch (object_id) {
        case 0: return famidash_cube_portal;
        case 1: return famidash_ship_portal;
        case 5: return famidash_blue_orb;
        case 6: return famidash_pink_orb;
        case 8: return famidash_gravity_down;
        case 9: return famidash_gravity_up;
        case 10: return famidash_yellow_pad;
        case 11: return famidash_yellow_orb;
        case 12: return famidash_yellow_pad_up;
        case 13: return famidash_blue_pad;
        case 14: return famidash_blue_pad_up;
        case 37: return famidash_pink_pad;
        default: return 0;
    }
}
