#ifndef PERCENT_HUD_H
#define PERCENT_HUD_H

#include <gb/gb.h>
#include <stdint.h>

// Level progress "NN%" at the top centre of the screen (setting SHOW %).
// Uses OAM slots 0..3 (the first sprites of a scanline always get drawn);
// player and level sprites start at PERCENT_HUD_OAM.
#define PERCENT_HUD_OAM 4

void percent_hud_load_tiles(void) BANKED;
void percent_hud_reset(uint16_t max_scroll_px) BANKED;
void percent_hud_update(uint16_t cam_px) BANKED;
void percent_hud_hide(void) BANKED;
// Level end reached (end animation starts): show 100%
void percent_hud_complete(void) BANKED;

// "ATTEMPT N" text at the level start (percent_hud.c). Its glyph tiles are reloaded with the
// % digits (percent_hud_load_tiles) and by attempt_text_load_tiles after the pause menu.
extern uint16_t attempt_count;
void attempt_text_load_tiles(void) BANKED;
void attempt_text_start(uint8_t from_start, uint16_t cam_x, uint16_t cam_y) BANKED;
void attempt_text_hide(void) BANKED;
uint8_t attempt_text_draw(uint8_t oam, uint16_t cam_x, uint16_t cam_y) BANKED;

#endif
