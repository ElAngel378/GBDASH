#include <gb/gb.h>
#include <gb/cgb.h>
#include "assets.h"
#include "gameplay.h"
#include "collision.h"
#include "hUGEDriver.h"

extern const hUGESong_t menuloop;

uint8_t music_ready = 0;
uint8_t redraw = 1;
uint8_t selected = 0;
volatile uint8_t current_song_bank = 0;
static uint8_t cgb_music_tick = 0;

// Called by the timer interrupt to update music
void play_music_safe(void) {
  if (music_ready) {
    // CGB double-speed makes this timer fire twice as often. Advance hUGE on
    // alternate ticks so music retains the intended half-rate CGB cadence.
    if ((_cpu == CGB_TYPE) && (cgb_music_tick++ & 1u)) return;
    uint8_t prev_bank = _current_bank;
    SWITCH_ROM(current_song_bank);
    hUGE_dosound();
    SWITCH_ROM(prev_bank);
  }
}

void main(void) {
  music_ready = 0;

  // CGB double-speed affects CPU work only; timing-sensitive LCD hardware
  // continues at its normal rate. Leave all non-CGB hardware untouched.
  if (_cpu == CGB_TYPE) cpu_fast();

  // Enable sound hardware
  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  TAC_REG = 0x04;
  add_TIM(play_music_safe);
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
      music_ready = 0;
      TAC_REG = 0x00;
      NR52_REG = 0x00;
      NR52_REG = 0x80;
      NR51_REG = 0xFF;
      NR50_REG = 0x77;
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
