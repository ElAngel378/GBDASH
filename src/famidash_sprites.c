#pragma bank 10

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

// 3 columns wide (24px) x 3 rows tall.
// Carriage return goes down 16 (dy=16) and back left 16 (dx=-16) to hit column 1.
        const metasprite_t famidash_cube_portal[] = {
                METASPR_ITEM(0, 0, PT_41, P0),   METASPR_ITEM(0, 8, PT_43, P0),   METASPR_ITEM(0, 8, PT_45, P0),
                METASPR_ITEM(16, -16, PT_47, P0), METASPR_ITEM(0, 8, PT_49, P0),   METASPR_ITEM(0, 8, PT_4B, P0),
                METASPR_ITEM(16, -16, PT_41, P0 | S_FLIPY), METASPR_ITEM(0, 8, PT_43, P0 | S_FLIPY), METASPR_ITEM(0, 8, PT_45, P0 | S_FLIPY),
                METASPR_TERM
        };

        const metasprite_t famidash_ship_portal[] = {
                METASPR_ITEM(0, 0, PT_41, P1),   METASPR_ITEM(0, 8, PT_43, P1),   METASPR_ITEM(0, 8, PT_45, P1),
                METASPR_ITEM(16, -16, PT_47, P1), METASPR_ITEM(0, 8, PT_49, P1),   METASPR_ITEM(0, 8, PT_4B, P1),
                METASPR_ITEM(16, -16, PT_41, P1 | S_FLIPY), METASPR_ITEM(0, 8, PT_43, P1 | S_FLIPY), METASPR_ITEM(0, 8, PT_45, P1 | S_FLIPY),
                METASPR_TERM
        };

// 2 columns wide (16px) x 3 rows tall.
// Carriage return goes down 16 (dy=16) and back left 8 (dx=-8) to hit column 1.
#define VERTICAL_PORTAL(name, palette) \
const metasprite_t name[] = { \
    METASPR_ITEM(0, 0, PT_6D, palette),             METASPR_ITEM(0, 8, PT_6F, palette), \
    METASPR_ITEM(16, -8, PT_73, palette),           METASPR_ITEM(0, 8, PT_75, palette), \
    METASPR_ITEM(16, -8, PT_6D, palette | S_FLIPY), METASPR_ITEM(0, 8, PT_6F, palette | S_FLIPY), \
    METASPR_TERM \
}

        VERTICAL_PORTAL(famidash_gravity_down, P0);
        VERTICAL_PORTAL(famidash_gravity_up, P1);

// Redefined to apply props to BOTH tiles uniformly, and not force S_FLIPX.
// Redefined to allow independent properties for the left and right tiles
#define TWO_TILE(name, left, right, props_left, props_right) \
const metasprite_t name[] = { \
    METASPR_ITEM(0, 0, left, props_left), \
    METASPR_ITEM(0, 8, right, props_right), \
    METASPR_TERM \
}

// Pads
        TWO_TILE(famidash_yellow_pad,    PT_79, PT_7B, P1,           P1 | S_FLIPX);
        TWO_TILE(famidash_yellow_pad_up, PT_79, PT_7B, P1 | S_FLIPY, P1 | S_FLIPX | S_FLIPY);
        TWO_TILE(famidash_blue_pad,      PT_79, PT_7B, P0,           P0 | S_FLIPX);
        TWO_TILE(famidash_blue_pad_up,   PT_79, PT_7B, P0 | S_FLIPY, P0 | S_FLIPX | S_FLIPY);
        TWO_TILE(famidash_pink_pad,      PT_59, PT_5B, P1,           P1 | S_FLIPX);

// Orbs (Restored the S_FLIPX on the right tile so the circle completes)
        TWO_TILE(famidash_yellow_orb,    MT_99, MT_9B, P1,           P1 | S_FLIPX);
        TWO_TILE(famidash_blue_orb,      MT_99, MT_9B, P0,           P0 | S_FLIPX);
        TWO_TILE(famidash_pink_orb,      MT_B9, MT_BB, P1,           P1 | S_FLIPX);

const metasprite_t * const famidash_sprite_table[38] = {
    famidash_cube_portal, famidash_ship_portal, 0, 0, 0,
    famidash_blue_orb, famidash_pink_orb, 0,
    famidash_gravity_down, famidash_gravity_up,
    famidash_yellow_pad, famidash_yellow_orb,
    famidash_yellow_pad_up, famidash_blue_pad, famidash_blue_pad_up,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    famidash_pink_pad
};
