#include <gb/gb.h>
#include <gb/cgb.h>
#include "assets.h"
#include "gameplay.h"
#include "hUGEDriver.h"
#include "states.h"
#include "sample_player.h"
#include "bg_parallax.h"

extern const hUGESong_t menuloop;

uint8_t music_ready = 0;
uint8_t redraw = 1;
uint8_t selected = 0;
volatile uint8_t current_song_bank = 0;
volatile uint8_t current_music_divider = 176;
volatile uint8_t cgb_music_tick = 0;
static uint16_t music_time_acc = 0;

#ifdef DEBUG_PROFILE
GameState current_state = STATE_PLAY_LEVEL;
volatile uint8_t gplevel;
#else
GameState current_state = STATE_MENU;
#endif

volatile uint8_t level_banner_scx = 0;
static volatile uint8_t active_banner_scx = 0;

void level_select_stat_isr(void) {
  if (LYC_REG == 31) {
    SCX_REG = active_banner_scx;
    LYC_REG = 120;
  } else {
    SCX_REG = 0;
    LYC_REG = 255;
  }
}

void level_select_vbl_isr(void) {
  SCX_REG = 0;
  LYC_REG = 31;
  active_banner_scx = level_banner_scx;
}

#define HUGE_ORDER_CNT     (*((volatile uint8_t *)(&hUGE_mute_mask - 0x1D)))
#define HUGE_CURRENT_ORDER (*((volatile uint8_t *)(&hUGE_mute_mask + 6)))

static inline void step_music(void) {
  uint8_t order_before = HUGE_CURRENT_ORDER;
  uint8_t prev_bank = _current_bank;
  uint8_t prev_ie = IE_REG;
  // A music tick takes up to ~3k dots. If VBlank starts meanwhile, the VBlank
  // handler (which starts the parallax GDMA) must be able to preempt it, or the
  // GDMA would start too late to finish inside VBlank. Only VBlank may nest.
  if (bg_gdma_isr_on) {
    IE_REG = VBL_IFLAG;
    enable_interrupts();
  }
  SWITCH_ROM(current_song_bank);
  hUGE_dosound();
  SWITCH_ROM(prev_bank);
  if (bg_gdma_isr_on) {
    disable_interrupts();
    IE_REG = prev_ie;
  }

  if (current_song_bank != 1) {
    if (order_before == (uint8_t)(HUGE_ORDER_CNT - 2) && HUGE_CURRENT_ORDER == 0) {
      music_ready = 0;
      NR12_REG = 0; NR14_REG = 0x80;
      NR22_REG = 0; NR24_REG = 0x80;
      NR30_REG = 0;
      NR42_REG = 0; NR44_REG = 0x80;
    }
  }
}

#include "save_manager.h"
#include "settings.h"

// Called by the timer interrupt to update music or stream samples
void play_music_safe(void) {
  if (sample_playing) {
    sample_play_isr();
    if (!sample_playing) {
      if (music_ready && setting_music_enabled) {
        hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
        hUGE_reset_wave();
        TMA_REG = current_music_divider;
        TIMA_REG = current_music_divider;
        IF_REG &= ~TIM_IFLAG;
        TAC_REG = 0x04;
        cgb_music_tick = 0;
        music_time_acc = 0;
      }
      sample_keeps_music = 0;
      return;
    }
    if (music_ready && sample_keeps_music && setting_music_enabled) {
      music_time_acc += 16;
      uint16_t period = 256 - current_music_divider;
      while (music_ready && music_time_acc >= period) {
        music_time_acc -= period;
        step_music();
      }
    }
    return;
  }
  if (music_ready && setting_music_enabled) {
    if ((_cpu == CGB_TYPE) && (cgb_music_tick++ & 1u)) return;
    step_music();
  }
}

void main(void) {
  music_ready = 0;
  sample_playing = 0;

  if (_cpu == CGB_TYPE) cpu_fast();

#ifdef DEBUG_PROFILE
  // Profiling build: tools/mesen_profile.lua writes level + 1 to gplevel; then straight in
  while (gplevel == 0) wait_vbl_done();
  selected = (uint8_t)(gplevel - 1u);
#endif

  init_save_system();

  // Enable sound hardware
  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  TAC_REG = 0x04;
  add_TIM(play_music_safe);
  set_interrupts(VBL_IFLAG | TIM_IFLAG);

  if (setting_music_enabled) {
    init_music_banked(&menuloop, 1, 176);
    current_song_bank = 1;
    music_ready = 1;
  }
  enable_interrupts();

  while (1) {
    switch (current_state) {
      case STATE_MENU:
        current_state = update_menu_state();
        break;
      case STATE_LEVEL_SELECT:
        current_state = update_level_select_state();
        break;
      case STATE_NEW_MENU_SELECT:
        current_state = update_new_menu_select_state();
        break;
      case STATE_PLAY_LEVEL:
        current_state = update_play_level_state();
        break;
      case STATE_MUSIC_TEST:
        current_state = update_music_test_state();
        break;
      case STATE_SETTINGS:
        current_state = update_settings_state();
        break;
    }
  }
}
