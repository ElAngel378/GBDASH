#ifndef GAMEPLAY_H
#define GAMEPLAY_H

#include <gb/gb.h>
#include "assets.h"

// Forward declaration of Player to avoid circular includes
struct Player;

extern uint8_t music_ready;
extern uint8_t redraw;
extern uint8_t selected;
extern volatile uint8_t current_song_bank;

void setup_menu_font(void) BANKED;
void draw_menu(void) BANKED;
void play_level(uint8_t idx) BANKED;

// Bank-safe portal checking (resides in Bank 0)
void check_portals_banked(const Level* l, uint16_t col, struct Player* p, uint8_t* target_bg_idx);

#endif
