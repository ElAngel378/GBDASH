#pragma bank 1
#include <gbdk/incbin.h>
#include "assets.h"
#include "../levels/chr_data/chr_gb.h"

BANKREF(game_levels)
BANKREF(chr_gb)

// Main tileset for the game levels
INCBIN(chr_gb_tiles, "levels/chr_data/chr_gb_tiles.bin")
INCBIN_EXTERN(chr_gb_tiles)

// Flipped tileset for mirror mode
INCBIN(chr_gb_tiles_rev, "levels/chr_data/chr_gb_tiles.bin")
INCBIN_EXTERN(chr_gb_tiles_rev)

// External map data definitions from level files
BANKREF_EXTERN(stereomadness_map)
extern const uint8_t stereomadness_map[];

BANKREF_EXTERN(backontrack_map)
extern const uint8_t backontrack_map[];

BANKREF_EXTERN(polargeist_map)
extern const uint8_t polargeist_map[];

BANKREF_EXTERN(dryout_map)
extern const uint8_t dryout_map[];

BANKREF_EXTERN(baseafterbase_map)
extern const uint8_t baseafterbase_map[];

BANKREF_EXTERN(cantletgo_map)
extern const uint8_t cantletgo_map[];

BANKREF_EXTERN(jumper_map)
extern const uint8_t jumper_map[];

BANKREF_EXTERN(timemachine_map)
extern const uint8_t timemachine_map[];

extern const SpDef stereomadness_sp[];
BANKREF_EXTERN(stereomadness_sp)
extern const SpDef backontrack_sp[];
BANKREF_EXTERN(backontrack_sp)
extern const SpDef polargeist_sp[];
BANKREF_EXTERN(polargeist_sp)
extern const SpDef dryout_sp[];
BANKREF_EXTERN(dryout_sp)
extern const SpDef baseafterbase_sp[];
BANKREF_EXTERN(baseafterbase_sp)
extern const SpDef cantletgo_sp[];
BANKREF_EXTERN(cantletgo_sp)
extern const SpDef jumper_sp[];
BANKREF_EXTERN(jumper_sp)
extern const SpDef timemachine_sp[];
BANKREF_EXTERN(timemachine_sp)

// Music songs
extern const hUGESong_t stereomadness;
extern const hUGESong_t dryout;
extern const hUGESong_t polargeist;
extern const hUGESong_t backontrack;
extern const hUGESong_t baseafterbase;
extern const hUGESong_t cantletgo;
extern const hUGESong_t jumper;
extern const hUGESong_t timemachine;

// level songs
const hUGESong_t * const level_songs[] = {
  &stereomadness, // level_sm
  &backontrack,  // level_bot
  &polargeist,   // level_pg
  &dryout,       // level_du
  &baseafterbase,// level_bab
  &cantletgo,    // level_clg
  &jumper,       // level_ju
  &timemachine // level_tm
};

// Per-level song banks: matches level_songs[]; 0 = silent
// Values must match the #pragma bank N in each song's .c file.
const uint8_t song_bank[] = {
  255u, // level_sm — stereomadness.c
  254u, // level_bot — backontrack.c
  253u, // level_pg — polargeist.c
  252u, // level_du — dryout.c
  251u, // level_bab — baseafterbase.c
  250u, // level_clg — cantletgo.c
  249u, // level_ju — jumper.c
  248u, // level_tm — timemachine.c
};

// Level definitions with dimensions and bank info
// .timer_divider (last number) should be the same number as the song's timer_divider
const Level level_sm = {
  "STEREO MADNESS",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  stereomadness_map,
  chr_gb_TILE_COUNT, 894, 16, 0, 0,
  BANK(stereomadness_map),
  191,
  stereomadness_sp,
  BANK(stereomadness_sp)
};

const Level level_bot = {
  "BACK ON TRACK",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  backontrack_map,
  chr_gb_TILE_COUNT, 846, 16, 0, 0,
  BANK(backontrack_map),
  183,
  backontrack_sp,
  BANK(backontrack_sp)
};

const Level level_pg = {
  "POLARGEIST",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  polargeist_map,
  chr_gb_TILE_COUNT, 934, 16, 0, 0,
  BANK(polargeist_map),
  193,
  polargeist_sp,
  BANK(polargeist_sp)
};

const Level level_du = {
  "DRY OUT",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  dryout_map,
  chr_gb_TILE_COUNT, 842, 16, 0, 0,
  BANK(dryout_map),
  185,
  dryout_sp,
  BANK(dryout_sp)
};

const Level level_bab = {
  "BASE AFTER BASE",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  baseafterbase_map,
  chr_gb_TILE_COUNT, 869, 16, 0, 0,
  BANK(baseafterbase_map),
  183,
  baseafterbase_sp,
  BANK(baseafterbase_sp)
};

const Level level_clg = {
  "CANT LET GO",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  cantletgo_map,
  chr_gb_TILE_COUNT, 837, 16, 0, 0,
  BANK(cantletgo_map),
  196,
  cantletgo_sp,
  BANK(cantletgo_sp)
};

const Level level_ju = {
  "JUMPER",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  jumper_map,
  chr_gb_TILE_COUNT, 897, 16, 0, 0,
  BANK(jumper_map),
  141,
  jumper_sp,
  BANK(jumper_sp)
};

const Level level_tm = {
  "BROKE MACHINE",
  chr_gb_tiles,
  chr_gb_tiles_rev,
  timemachine_map,
  chr_gb_TILE_COUNT, 997, 16, 0, 0,
  BANK(timemachine_map),
  41,
  timemachine_sp,
  BANK(timemachine_sp)
};

// Global level list used by the menu and gameplay systems
const Level* const game_levels[] = {
  &level_sm,
  &level_bot,
  &level_pg,
  &level_du,
  &level_bab,
  &level_clg,
  &level_ju,
  &level_tm
};
const uint8_t MAX_LEVELS = sizeof(game_levels) / sizeof(game_levels[0]);
