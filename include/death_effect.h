#ifndef DEATH_EFFECT_H
#define DEATH_EFFECT_H

#include <gb/gb.h>

#define DEATH_TILE_BASE 20
#define DEATH_TILE_COUNT 16   // sprite tiles 20..35

#define DEATH_TILE_CIRCLE_P1 (DEATH_TILE_BASE + 0)
#define DEATH_TILE_CIRCLE_P2 (DEATH_TILE_BASE + 2)
#define DEATH_TILE_CIRCLE_P3 (DEATH_TILE_BASE + 4)
#define DEATH_TILE_PART_CYAN (DEATH_TILE_BASE + 6)
#define DEATH_TILE_PART_GREEN (DEATH_TILE_BASE + 8)
#define DEATH_TILE_PART_SMALL_CYAN (DEATH_TILE_BASE + 10)
#define DEATH_TILE_PART_SMALL_GREEN (DEATH_TILE_BASE + 12)
#define DEATH_TILE_PART_TINY (DEATH_TILE_BASE + 14)

// keep_music: practice mode, the music keeps playing through the death
void play_death_animation(uint8_t screen_x, uint8_t screen_y, uint8_t scroll_px, uint8_t cam_py, uint8_t keep_music) BANKED;

#endif
