#ifndef ASSETS_H
#define ASSETS_H

#include <gb/gb.h>
#include <stdint.h>
#include "hUGEDriver.h"

#ifndef SPDEF_TYPE
#define SPDEF_TYPE
typedef struct {
    uint16_t c;   // Column (X coordinate >> 4)
    uint8_t  r;   // Row (Y coordinate >> 4)
    uint8_t  obj; // Object ID (0=Cube, 1=Ship, 10=Yellow Pad, etc.)
} SpDef;
#endif

// Structure defining a game level's data and metadata
typedef struct {
  const char *name;
  const uint8_t *tiles;     // VRAM tile data
  const uint8_t *tiles_rev; // Flipped tileset for mirror mode
  const uint8_t *map;       // Metatile map data
  uint16_t tile_count;      // Total tiles in tileset
  uint16_t map_width;   // Width in metatiles
  uint16_t map_height;  // Height in metatiles
  uint8_t tiles_are_compressed;
  uint8_t map_is_compressed;
  uint8_t map_bank;     // ROM bank where the map resides
  uint8_t timer_divider; // The TMA_REG value for hUGEDriver
  const SpDef *sp_list;
  uint8_t sp_bank;
} Level;

// Per-level song pointers (same order as game_levels[]; NULL = silent)
extern const hUGESong_t * const level_songs[];

// Per-level song bank (matches level_songs[]; 0 = silent)
extern const uint8_t song_bank[];

extern const Level * const game_levels[];
BANKREF_EXTERN(game_levels)

extern const uint8_t MAX_LEVELS;

#endif
