#include <gb/gb.h>
#include "assets.h"
#include "gameplay.h"
#include "collision.h"
#include "hUGEDriver.h"
#include "video_vbl_uploader.h"
#include "profiling.h"

extern const hUGESong_t menuloop;

uint8_t music_ready = 0;
uint8_t redraw = 1;
uint8_t selected = 0;
volatile uint8_t current_song_bank = 0;

// profiling counters in WRAM
volatile uint16_t prof_vbl_enter_count = 0;
volatile uint16_t prof_tim_enter_count = 0;
volatile uint16_t prof_mirror_transitions = 0;
volatile uint16_t prof_column_changed_count = 0;

// Called by the timer interrupt to update music
void play_music_safe(void) {
  if (music_ready) {
    prof_tim_enter_count++;
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(current_song_bank);
    hUGE_dosound();
    SWITCH_ROM(prev_bank);
    prof_tim_enter_count++;
  }
}

void main(void) {
  music_ready = 0;

  // Enable sound hardware
  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  TAC_REG = 0x04;
  // Initialize the background VBlank uploader (registers small NONBANKED VBL handler)
  bg_upload_init();
#ifdef __GBDK_VERSION
#if __GBDK_VERSION >= 406
  add_low_priority_TIM(play_music_safe);
#else
  add_TIM(play_music_safe);
#endif
#else
  add_TIM(play_music_safe);
#endif
  set_interrupts(VBL_IFLAG | TIM_IFLAG);
  enable_interrupts();

  setup_menu_font();

  init_music_banked(&menuloop, 1, 176);

  while (1) {
    if (redraw) draw_menu();

    uint8_t joy = joypad();

    // Level selection handling
    if (joy & J_UP) {
      if (selected > 0) { selected--; redraw = 1; }
      waitpadup();
    } else if (joy & J_DOWN) {
      if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
      waitpadup();
    } else if (joy & J_A) {
      disable_interrupts();
      play_level(selected);

      // Stop level music and re-init sound hardware for menu
      music_ready = 0;
      TAC_REG = 0x00;
      NR52_REG = 0x00;
      NR52_REG = 0x80;
      NR51_REG = 0xFF;
      NR50_REG = 0x77;

      setup_menu_font(); // Re-setup font just in case
        init_music_banked(&menuloop, 1, 176);
      TAC_REG = 0x04;    // Start timer
      enable_interrupts();
      redraw = 1;
    }

    wait_vbl_done();
  }
}
