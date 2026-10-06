#ifndef SAVE_MANAGER_H
#define SAVE_MANAGER_H

#include <stdint.h>
#include <gbdk/platform.h>

// Room for more levels than exist yet: changing this changes the save layout (see SAVE_VERSION)
#define NUM_SAVE_LEVELS 16

extern uint8_t level_progress_normal[NUM_SAVE_LEVELS];
extern uint8_t level_progress_practice[NUM_SAVE_LEVELS];
// Famidash secret coins: bit 0/1/2 = coin 1/2/3 collected in a completed run
extern uint8_t level_coins[NUM_SAVE_LEVELS];

extern uint8_t selected_icon;
extern uint8_t selected_color_primary;
extern uint8_t selected_color_secondary;

void init_save_system(void) BANKED;
void save_game_data(void) BANKED;
void record_level_progress(uint8_t level_idx, uint8_t pct, uint8_t is_practice) BANKED;
void record_level_coins(uint8_t level_idx, uint8_t coins) BANKED;
void record_level_progress_from_cam(uint8_t level_idx, uint16_t cam_x, uint16_t max_x, uint8_t is_practice) BANKED;

#endif // SAVE_MANAGER_H
