#ifndef ASSETS_H
#define ASSETS_H

#include <gb/gb.h>
#include <stdint.h>
#include "hUGEDriver.h"

// Sprite placement structure for level objects
typedef struct {
    uint16_t x;
    uint16_t y;
    uint8_t tile;
} SpritePlacement;

// Structure defining a game level's data and metadata
typedef struct {
  const char *name;
  const uint8_t *tiles; // VRAM tile data
  const uint8_t *map;   // Metatile map data
  const SpritePlacement *sprites; // Sprite placement data
  uint16_t sprite_count; // Number of sprites in the placement data
  uint16_t tile_count;  // Total tiles in tileset
  uint16_t map_width;   // Width in metatiles
  uint16_t map_height;  // Height in metatiles
  uint8_t tiles_are_compressed;
  uint8_t map_is_compressed;
  uint8_t map_bank;     // ROM bank where the map resides
  uint8_t timer_divider; // The TMA_REG value for hUGEDriver
} Level;

// Per-level song pointers (same order as game_levels[]; NULL = silent)
extern const hUGESong_t * const level_songs[];

// Per-level song bank (matches level_songs[]; 0 = silent)
extern const uint8_t song_bank[];

extern const Level * const game_levels[];
BANKREF_EXTERN(game_levels)

extern const uint8_t MAX_LEVELS;

#endif
