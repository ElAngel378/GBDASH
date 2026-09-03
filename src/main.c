#include <gb/gb.h>
#include <gb/cgb.h>
#include "assets.h"
#include "gameplay.h"
#include "hUGEDriver.h"
#include "states.h"

extern const hUGESong_t menuloop;

uint8_t music_ready = 0;
uint8_t redraw = 1;
uint8_t selected = 0;
volatile uint8_t current_song_bank = 0;
static uint8_t cgb_music_tick = 0;

GameState current_state = STATE_MENU;

// Called by the timer interrupt to update music
void play_music_safe(void) {
  if (music_ready) {
    if ((_cpu == CGB_TYPE) && (cgb_music_tick++ & 1u)) return;
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(current_song_bank);
    enable_interrupts();
    hUGE_dosound();
    disable_interrupts();
    SWITCH_ROM(prev_bank);
  }
}

void main(void) {
  music_ready = 0;

  if (_cpu == CGB_TYPE) cpu_fast();

  // Enable sound hardware
  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  TAC_REG = 0x04;
  add_TIM(play_music_safe);
  set_interrupts(VBL_IFLAG | TIM_IFLAG);
  enable_interrupts();

  init_music_banked(&menuloop, 1, 176);
  music_ready = 1; // Explicitly ensure music starts

  while (1) {
    switch (current_state) {
      case STATE_MENU:
        current_state = update_menu_state();
        break;
      case STATE_LEVEL_SELECT:
        current_state = update_level_select_state();
        break;
      case STATE_PLAY_LEVEL:
        current_state = update_play_level_state();
        break;
    }
  }
}
