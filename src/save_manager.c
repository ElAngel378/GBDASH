#pragma bank 23

#include "save_manager.h"
#include <gb/gb.h>

BANKREF(save_manager)

#define SRAM_BASE_ADDR ((volatile uint8_t *)0xA000)
#define SAVE_MAGIC_0 'P'
#define SAVE_MAGIC_1 'D'
#define SAVE_MAGIC_2 'S'
#define SAVE_MAGIC_3 'H'
#define SAVE_VERSION 3
#define NUM_SETTINGS_BYTES 6

#include "settings.h"

uint8_t level_progress_normal[NUM_SAVE_LEVELS] = {0};
uint8_t level_progress_practice[NUM_SAVE_LEVELS] = {0};

uint8_t setting_music_enabled   = 1;
uint8_t setting_sfx_enabled     = 1;
uint8_t setting_dmg_gradient    = 1;
uint8_t setting_show_bg_enabled = 1;
uint8_t setting_parallax_enabled = 1;
uint8_t setting_effects_enabled = 1;

static uint8_t calc_checksum(const uint8_t *data, uint8_t len) {
    uint8_t sum = 0x5A;
    for (uint8_t i = 0; i < len; i++) {
        sum = (uint8_t)(sum + data[i] + (uint8_t)(i * 7));
    }
    return sum;
}

void init_save_system(void) BANKED {
    ENABLE_RAM;
    volatile uint8_t *sram = SRAM_BASE_ADDR;

    // Check magic signature and version
    if (sram[0] == SAVE_MAGIC_0 && sram[1] == SAVE_MAGIC_1 &&
        sram[2] == SAVE_MAGIC_2 && sram[3] == SAVE_MAGIC_3) {

        if (sram[4] == 3) {
            uint8_t chk = calc_checksum((const uint8_t *)&sram[5], NUM_SAVE_LEVELS * 2 + NUM_SETTINGS_BYTES);
            if (sram[5 + NUM_SAVE_LEVELS * 2 + NUM_SETTINGS_BYTES] == chk) {
                for (uint8_t i = 0; i < NUM_SAVE_LEVELS; i++) {
                    level_progress_normal[i] = sram[5 + i];
                    level_progress_practice[i] = sram[5 + NUM_SAVE_LEVELS + i];
                    if (level_progress_normal[i] > 100) level_progress_normal[i] = 100;
                    if (level_progress_practice[i] > 100) level_progress_practice[i] = 100;
                }
                setting_music_enabled    = sram[5 + NUM_SAVE_LEVELS * 2 + 0] ? 1 : 0;
                setting_sfx_enabled      = sram[5 + NUM_SAVE_LEVELS * 2 + 1] ? 1 : 0;
                setting_dmg_gradient     = sram[5 + NUM_SAVE_LEVELS * 2 + 2] ? 1 : 0;
                setting_show_bg_enabled  = sram[5 + NUM_SAVE_LEVELS * 2 + 3] ? 1 : 0;
                setting_parallax_enabled = sram[5 + NUM_SAVE_LEVELS * 2 + 4] ? 1 : 0;
                setting_effects_enabled  = sram[5 + NUM_SAVE_LEVELS * 2 + 5] ? 1 : 0;
                // Enforce interlock: no parallax without BG
                if (!setting_show_bg_enabled) setting_parallax_enabled = 0;
                DISABLE_RAM;
                return;
            }
        } else if (sram[4] == 2) {
            // Upgrade from Version 2 (5 settings bytes, no SHOW BG)
            uint8_t chk = calc_checksum((const uint8_t *)&sram[5], NUM_SAVE_LEVELS * 2 + 5);
            if (sram[5 + NUM_SAVE_LEVELS * 2 + 5] == chk) {
                for (uint8_t i = 0; i < NUM_SAVE_LEVELS; i++) {
                    level_progress_normal[i] = sram[5 + i];
                    level_progress_practice[i] = sram[5 + NUM_SAVE_LEVELS + i];
                    if (level_progress_normal[i] > 100) level_progress_normal[i] = 100;
                    if (level_progress_practice[i] > 100) level_progress_practice[i] = 100;
                }
                setting_music_enabled    = sram[5 + NUM_SAVE_LEVELS * 2 + 0] ? 1 : 0;
                setting_sfx_enabled      = sram[5 + NUM_SAVE_LEVELS * 2 + 1] ? 1 : 0;
                setting_dmg_gradient     = sram[5 + NUM_SAVE_LEVELS * 2 + 2] ? 1 : 0;
                setting_parallax_enabled = sram[5 + NUM_SAVE_LEVELS * 2 + 3] ? 1 : 0;
                setting_effects_enabled  = sram[5 + NUM_SAVE_LEVELS * 2 + 4] ? 1 : 0;
                setting_show_bg_enabled  = 1;
                DISABLE_RAM;
                save_game_data();
                return;
            }
        } else if (sram[4] == 1) {
            // Upgrade from Version 1
            uint8_t chk = calc_checksum((const uint8_t *)&sram[5], NUM_SAVE_LEVELS * 2);
            if (sram[5 + NUM_SAVE_LEVELS * 2] == chk) {
                for (uint8_t i = 0; i < NUM_SAVE_LEVELS; i++) {
                    level_progress_normal[i] = sram[5 + i];
                    level_progress_practice[i] = sram[5 + NUM_SAVE_LEVELS + i];
                    if (level_progress_normal[i] > 100) level_progress_normal[i] = 100;
                    if (level_progress_practice[i] > 100) level_progress_practice[i] = 100;
                }
                DISABLE_RAM;
                save_game_data();
                return;
            }
        }
    }

    // Default to 0 on first boot or corrupt save
    for (uint8_t i = 0; i < NUM_SAVE_LEVELS; i++) {
        level_progress_normal[i] = 0;
        level_progress_practice[i] = 0;
    }
    setting_music_enabled   = 1;
    setting_sfx_enabled     = 1;
    setting_dmg_gradient    = 1;
    setting_show_bg_enabled = 1;
    setting_parallax_enabled = 1;
    setting_effects_enabled = 1;
    DISABLE_RAM;
    save_game_data();
}

void save_game_data(void) BANKED {
    ENABLE_RAM;
    volatile uint8_t *sram = SRAM_BASE_ADDR;

    sram[0] = SAVE_MAGIC_0;
    sram[1] = SAVE_MAGIC_1;
    sram[2] = SAVE_MAGIC_2;
    sram[3] = SAVE_MAGIC_3;
    sram[4] = SAVE_VERSION;

    for (uint8_t i = 0; i < NUM_SAVE_LEVELS; i++) {
        sram[5 + i] = level_progress_normal[i];
        sram[5 + NUM_SAVE_LEVELS + i] = level_progress_practice[i];
    }

    sram[5 + NUM_SAVE_LEVELS * 2 + 0] = setting_music_enabled;
    sram[5 + NUM_SAVE_LEVELS * 2 + 1] = setting_sfx_enabled;
    sram[5 + NUM_SAVE_LEVELS * 2 + 2] = setting_dmg_gradient;
    sram[5 + NUM_SAVE_LEVELS * 2 + 3] = setting_show_bg_enabled;
    sram[5 + NUM_SAVE_LEVELS * 2 + 4] = setting_parallax_enabled;
    sram[5 + NUM_SAVE_LEVELS * 2 + 5] = setting_effects_enabled;

    sram[5 + NUM_SAVE_LEVELS * 2 + NUM_SETTINGS_BYTES] = 
        calc_checksum((const uint8_t *)&sram[5], NUM_SAVE_LEVELS * 2 + NUM_SETTINGS_BYTES);
    DISABLE_RAM;
}

void record_level_progress(uint8_t level_idx, uint8_t pct, uint8_t is_practice) BANKED {
    if (level_idx >= NUM_SAVE_LEVELS) return;
    if (pct > 100) pct = 100;

    if (is_practice) {
        if (pct > level_progress_practice[level_idx]) {
            level_progress_practice[level_idx] = pct;
            save_game_data();
        }
    } else {
        if (pct > level_progress_normal[level_idx]) {
            level_progress_normal[level_idx] = pct;
            save_game_data();
        }
    }
}

void record_level_progress_from_cam(uint8_t level_idx, uint16_t cam_x, uint16_t max_x) BANKED {
    if (level_idx >= NUM_SAVE_LEVELS) return;
    uint8_t pct;
    if (max_x == 0) pct = 0;
    else if (cam_x >= max_x) pct = 100;
    else {
        uint32_t p = ((uint32_t)cam_x * 100u) / max_x;
        pct = (p > 100u) ? 100u : (uint8_t)p;
    }
    record_level_progress(level_idx, pct, 0);
}
