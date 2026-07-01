#pragma bank 1
#include <gbdk/incbin.h>
#include "assets.h"
#include "stereomadness_sprites.h"
#include "../levels/chr_data/chr_gb.h"

BANKREF(game_levels)
BANKREF(chr_gb)

// Main tileset for the game levels
INCBIN(chr_gb_tiles, "levels/chr_data/chr_gb_tiles.bin")
INCBIN_EXTERN(chr_gb_tiles)

// External map data definitions from level files
BANKREF_EXTERN(stereomadness_map)
extern const uint8_t stereomadness_map[];

BANKREF_EXTERN(backontrack_map)
extern const uint8_t backontrack_map[];

BANKREF_EXTERN(polargeist_map)
extern const uint8_t polargeist_map[];

BANKREF_EXTERN(dryout_map)
extern const uint8_t dryout_map[];

// Music songs
extern const hUGESong_t stereomadness;
extern const hUGESong_t dryout;
extern const hUGESong_t polargeist;
extern const hUGESong_t backontrack;

// level songs
const hUGESong_t * const level_songs[] = {
  &stereomadness, // level_sm
  &backontrack,  // level_bot
  &polargeist,   // level_pg
  &dryout        // level_du
};

// Per-level song banks: matches level_songs[]; 0 = silent
// Values must match the #pragma bank N in each song's .c file.
const uint8_t song_bank[] = {
  6u, // level_sm — stereomadness.c
  9u, // level_bot — backontrack.c
  8u, // level_pg — polargeist.c
  7u, // level_du — dryout.c
};

// Level definitions with dimensions and bank info
// .timer_divider (last number) should be the same number as the song's timer_divider
const Level level_sm = {
  "STEREO MADNESS",
  chr_gb_tiles,
  stereomadness_map,
  (const SpritePlacement *)stereomadness_sprites_placements,
  STEREOMADNESS_SPRITES_COUNT,
  chr_gb_TILE_COUNT, 894, 16, 0, 0,
  BANK(stereomadness_map),
  192
};

const Level level_bot = {
  "BACK ON TRACK",
  chr_gb_tiles,
  backontrack_map,
  NULL, 0,
  chr_gb_TILE_COUNT, 846, 16, 0, 0,
  BANK(backontrack_map),
  184
};

const Level level_pg = {
  "POLARGEIST",
  chr_gb_tiles,
  polargeist_map,
  NULL, 0,
  chr_gb_TILE_COUNT, 934, 16, 0, 0,
  BANK(polargeist_map),
  193
};

const Level level_du = {
  "DRY OUT",
  chr_gb_tiles,
  dryout_map,
  NULL, 0,
  chr_gb_TILE_COUNT, 842, 16, 0, 0,
  BANK(dryout_map),
  185
};

// Global level list used by the menu and gameplay systems
const Level* const game_levels[] = { &level_sm, &level_bot, &level_pg, &level_du };
const uint8_t MAX_LEVELS = sizeof(game_levels) / sizeof(game_levels[0]);
