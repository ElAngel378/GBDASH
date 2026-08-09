#include <gb/gb.h>
#include "collision.h"
#include "famidash_metatiles.h"

#define BKG_MT_H 16

static uint8_t _prev_map_bank;

void col_at_begin(uint8_t map_bank) {
    if (_current_bank == map_bank) {
        _prev_map_bank = 0xFF;
        return;
    }
    _prev_map_bank = _current_bank;
    SWITCH_ROM(map_bank);
}

void col_at_end(void) {
    if (_prev_map_bank != 0xFF) {
        SWITCH_ROM(_prev_map_bank);
    }
}

uint8_t col_at_raw(
    uint16_t world_px,
    int16_t  world_py,
    const uint8_t *map,
    uint16_t map_w
) {
    if ((uint16_t)world_py >= 256u) {
        return (world_py < 0) ? COL_NONE : COL_ALL;
    }
    uint16_t mx = world_px >> 4;
    if (mx >= map_w) return COL_ALL;

    return col_at_raw_cached(&map[mx << 4], (uint16_t)world_py);
}

uint8_t col_at_raw_cached(const uint8_t *col_ptr, uint16_t world_py) {
    uint8_t py8 = (uint8_t)world_py;
    uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];

    if (col >= 0x10) {
        if (col == COL_DEATH_TOP_HALF) {
            if ((py8 & 0x0F) < 8) return COL_NONE;
            return COL_DEATH;
        }
        if (col == COL_DEATH_BOTTOM_HALF) {
            if ((py8 & 0x0F) >= 8) return COL_NONE;
            return COL_DEATH;
        }
    }


    return col;
}

// This function must be in BANK 0
uint8_t col_at(
    uint16_t world_px,
    int16_t  world_py,
    const uint8_t *map,
    uint16_t map_w,
    uint8_t  map_bank
) {
    uint8_t res;
    col_at_begin(map_bank);
    res = col_at_raw(world_px, world_py, map, map_w);
    col_at_end();
    return res;
}

// Loads tileset into VRAM. Handles splitting if tiles > 128.
// Also in Bank 0 because the 'tiles' pointer might be in another bank.
void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count, uint8_t bank) {
  uint8_t _prev = _current_bank;
  SWITCH_ROM(bank);
  if (tile_count == 256u) {
    set_bkg_data(0, 128, tiles);
    set_bkg_data(128, 128, tiles + (128u * 16u));
  } else {
    set_bkg_data(0, (uint8_t)tile_count, tiles);
  }
  SWITCH_ROM(_prev);
}

void draw_mt_column(uint8_t ring_col, uint16_t map_col,
  const uint8_t* map, uint16_t map_w, uint8_t map_bank, uint8_t reversed) {
  (void)map_w;
  uint8_t bx = ring_col << 1;

  uint8_t _prev = _current_bank;
  SWITCH_ROM(map_bank);

  const uint8_t *map_ptr = &map[(uint16_t)map_col << 4];

    if (reversed) {
        for (uint8_t r = 0; r < BKG_MT_H; r++) {
            uint8_t mt = *map_ptr++;
            uint8_t by = r << 1;

            // Point directly to the pre-swapped ROM data!
            // +0 gets the Top row, +2 gets the Bottom row
            set_bkg_tiles(bx, by, 2, 1, metatiles_rev[mt]);
            set_bkg_tiles(bx, by + 1, 2, 1, metatiles_rev[mt] + 2);
        }
    } else {
        for (uint8_t r = 0; r < BKG_MT_H; r++) {
            uint8_t mt = *map_ptr++;
            uint8_t by = r << 1;
            set_bkg_tiles(bx, by, 2, 1, metatiles[mt]);
            set_bkg_tiles(bx, by + 1, 2, 1, metatiles[mt] + 2);
        }
    }

  SWITCH_ROM(_prev);
}

void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint8_t map_bank, uint8_t reversed) {
  uint16_t cols = (map_w < 16) ? map_w : 16;
  for (uint16_t c = 0; c < cols; c++) {
    draw_mt_column((uint8_t)(c % 16), c, map, map_w, map_bank, reversed);
  }
}

#include "hUGEDriver.h"
extern uint8_t music_ready;
extern uint8_t current_song_bank;

void init_music_banked(const hUGESong_t * song, uint8_t bank, uint8_t divider) {
    uint8_t _prev = _current_bank;
    music_ready = 0;
    current_song_bank = bank;
    SWITCH_ROM(bank);
    disable_interrupts();
    hUGE_init(song);
    TMA_REG = divider;
    enable_interrupts();
    SWITCH_ROM(_prev);
    music_ready = 1;
}
