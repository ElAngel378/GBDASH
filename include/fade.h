#ifndef FADE_H
#define FADE_H

#include <gb/gb.h>
#include <gb/cgb.h>

void fade_init(void) BANKED;
void fade_set_bkg_palette(uint8_t first, uint8_t count, const palette_color_t *data) BANKED;
void fade_set_sprite_palette(uint8_t first, uint8_t count, const palette_color_t *data) BANKED;
void fade_set_dmg_palettes(uint8_t bgp, uint8_t obp0, uint8_t obp1) BANKED;
void fade_set_black(void) BANKED;
void fade_to_black(uint8_t delay_frames) BANKED;
void fade_from_black(uint8_t delay_frames) BANKED;

#endif
