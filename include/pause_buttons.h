#ifndef PAUSE_BUTTONS_H
#define PAUSE_BUTTONS_H

#include <stdint.h>
#include <gb/gb.h>

#define PAUSE_BTN_TILE_BASE 36
#define PAUSE_BTN_TILE_COUNT 52

// Tile offsets within pause_button_tiles (in 8x8 tile units, step by 4 for 8x16 columns)
// Play: 8 sprites (16 tiles: 0..15) -> 36..51
// Menu: 6 sprites (12 tiles: 16..27) -> 52..63
// Restart: 6 sprites (12 tiles: 28..39) -> 64..75
// Practice: 6 sprites (12 tiles: 40..51) -> 76..87

#define BTN_PLAY_TILE_OFFSET 0
#define BTN_MENU_TILE_OFFSET 16
#define BTN_RESTART_TILE_OFFSET 28
#define BTN_PRACTICE_TILE_OFFSET 40

#define PAUSE_BTN_MENU 0
#define PAUSE_BTN_PLAY 1
#define PAUSE_BTN_RESTART 2
#define PAUSE_BTN_PRACTICE 3

// "PAUSED" (pause menu only) borrows the death effect tiles 20..31 and the Practice button
// (76..87) the checkpoint diamond tiles 76..79: both are put back when the game resumes
#define PAUSE_SPRITE_TILE_BASE 20
#define PAUSE_CURSOR_TILE_BASE 88
#define CHECKPOINT_TILE_BASE 76

void init_pause_tiles(void) BANKED;
void load_checkpoint_tiles(void) BANKED;
void restore_death_tiles(void) BANKED;
void draw_pause_menu_sprites(uint8_t selected_btn) BANKED;
void apply_pause_box_attributes(uint8_t apply) BANKED;

#endif
