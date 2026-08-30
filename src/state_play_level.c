#include "states.h"
#include "gameplay.h"
#include <gb/gb.h>

extern uint8_t selected;
extern uint8_t music_ready;

GameState update_play_level_state(void) {
    // Reset sound hardware for gameplay
    disable_interrupts();
    music_ready = 0;
    TAC_REG = 0x00;
    NR52_REG = 0x00;
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    play_level(selected);

    // After play_level returns (win/death), return to level select
    return STATE_LEVEL_SELECT;
}
