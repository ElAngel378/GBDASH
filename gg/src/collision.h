#ifndef COLLISION_H
#define COLLISION_H

#include <gbdk/platform.h>
#include <stdint.h>

// Collision types mapping to famidash metatiles (same values as the Game Boy build)
#define COL_NONE         0x00  // Air/No collision
#define COL_DEATH_RIGHT  0x01  // Right-facing spike
#define COL_DEATH_LEFT   0x02  // Left-facing spike
#define COL_DEATH_TOP    0x03  // Up-facing spike
#define COL_DEATH_BOTTOM 0x04  // Down-facing spike
#define COL_TOP          0x05  // Solid from top only (platform)
#define COL_BOTTOM       0x06  // Solid from bottom only
#define COL_ALL          0x07  // Full solid block
#define COL_DEATH        0x08  // Hazard (orb/saw)
#define COL_FLOOR_CEIL   0x09  // Solid top and bottom
#define COL_ORB          0x0A  // Yellow Orb
#define COL_PAD          0x0B  // Yellow Pad
#define COL_ORB_BLUE     0x0C  // Blue Orb (Gravity Flip)
#define COL_ORB_MAGENTA  0x0D  // Magenta Orb (Small Jump)
#define COL_PAD_BLUE     0x0E  // Blue Pad (Gravity Flip)
#define COL_PAD_MAGENTA  0x0F  // Magenta Pad (Small Jump)
#define COL_DEATH_TOP_HALF    0x10  // Deadly in bottom half (spike points up)
#define COL_DEATH_BOTTOM_HALF 0x11  // Deadly in top half (spike points down)

#define IS_SOLID(col)  ((col) == COL_ALL || (col) == COL_FLOOR_CEIL || \
                        (col) == COL_TOP || (col) == COL_BOTTOM)

#define IS_HAZARD(col) ((col) == COL_DEATH      || \
                        (col) == COL_DEATH_TOP   || \
                        (col) == COL_DEATH_BOTTOM|| \
                        (col) == COL_DEATH_LEFT  || \
                        (col) == COL_DEATH_RIGHT || \
                        (col) == COL_DEATH_TOP_HALF || \
                        (col) == COL_DEATH_BOTTOM_HALF)

#define IS_ORB(col)    ((col) == COL_ORB || (col) == COL_ORB_BLUE || (col) == COL_ORB_MAGENTA)
#define IS_PAD(col)    ((col) == COL_PAD || (col) == COL_PAD_BLUE || (col) == COL_PAD_MAGENTA)

#define IS_PASSTHROUGH(col) ((col) == COL_NONE)

extern const uint8_t famidash_metatile_collision[256];

#define col_of(tile_id) (famidash_metatile_collision[(tile_id)])

#endif
