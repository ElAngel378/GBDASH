#ifndef DEATH_EFFECT_H
#define DEATH_EFFECT_H

#include <gb/gb.h>

#define DEATH_TILE_BASE 16

#define DEATH_TILE_CIRCLE_P1 16
#define DEATH_TILE_CIRCLE_P2 18
#define DEATH_TILE_CIRCLE_P3 20
#define DEATH_TILE_PART_CYAN 22
#define DEATH_TILE_PART_GREEN 24
#define DEATH_TILE_PART_SMALL_CYAN 26
#define DEATH_TILE_PART_SMALL_GREEN 28
#define DEATH_TILE_PART_TINY 30

extern const uint8_t death_effect_tiles[256];

void init_death_effect_tiles(void);
void play_death_animation(uint8_t screen_x, uint8_t screen_y, uint8_t scroll_px, uint8_t cam_py);

#endif
