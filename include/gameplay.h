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

// SP stream loading is bank-safe and only reads new entries as the camera advances.
void sp_cache_reset(ActiveSp *cache, uint16_t *stream_idx);
void sp_cache_load(uint8_t sp_bank, const SpDef *sp_list, uint16_t cam_px,
                   ActiveSp *cache, uint16_t *stream_idx);
void sp_cache_update(const Level *l, uint16_t cam_px,
                     ActiveSp *cache, uint16_t *stream_idx);

// Collision and activation consume the same RAM cache used by rendering.
void process_sp_objects(uint16_t map_height, struct Player* p, uint8_t joy,
                        uint8_t* target_bg_idx, const ActiveSp *cache);

#endif
