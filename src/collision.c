#include <gb/gb.h>
#include "collision.h"
#include "famidash_metatiles.h"

#define BKG_MT_H 16

// A level map is MAP_ROWS metatiles tall, stored column by column (MAP_ROWS bytes each), and
// split into MAP_BANK_COLS-column chunks (16 KB), one per ROM bank, in consecutive banks
// starting at map_bank. Every chunk is the only thing in its bank, so each one starts at the
// same address as the first: column c is in bank map_bank + (c >> 9), at
// map + ((c & 511) << 5).
#define MAP_BANK(map_bank, c) ((uint8_t)((map_bank) + (uint8_t)((c) >> MAP_BANK_COLS_SHIFT)))
#define MAP_COL(map, c) ((map) + (((uint16_t)(c) & (MAP_BANK_COLS - 1u)) << MAP_ROWS_SHIFT))

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

    return col_at_raw_cached(MAP_COL(map, mx), (uint16_t)world_py);
}

uint8_t col_at_raw_cached(const uint8_t *col_ptr, uint16_t world_py) {
    uint8_t py8 = (uint8_t)world_py;
    uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
    uint8_t inner_y = py8 & 0x0F;

    if (col == COL_TOP) {
        if (inner_y >= 8) return COL_NONE;
    } else if (col == COL_BOTTOM) {
        if (inner_y < 8) return COL_NONE;
    } else if (col == COL_DEATH_TOP_HALF) {
        if (inner_y < 8) return COL_NONE;
        return COL_DEATH;
    } else if (col == COL_DEATH_BOTTOM_HALF) {
        if (inner_y >= 8) return COL_NONE;
        return COL_DEATH;
    } else if (col >= COL_DEATH_LEFT_BOTTOMQ && col <= COL_DEATH_RIGHT_TOPQ) {
        if (col & 4) {
            if (inner_y >= 8) return COL_NONE;
        } else {
            if (inner_y < 8) return COL_NONE;
        }
        return (col & 1) ? COL_DEATH_RIGHT : COL_DEATH_LEFT;
    }

    return col;
}

// Bank-safe collision check wrapper
uint8_t col_at(
    uint16_t world_px,
    int16_t  world_py,
    const uint8_t *map,
    uint16_t map_w,
    uint8_t  map_bank
) {
    uint8_t res;
    col_at_begin(MAP_BANK(map_bank, world_px >> 4));
    res = col_at_raw(world_px, world_py, map, map_w);
    col_at_end();
    return res;
}

// Upload tileset graphics to VRAM
void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count, uint8_t bank) {
  uint8_t _prev = _current_bank;
  SWITCH_ROM(bank);
  VBK_REG = VBK_TILES;
  // BG tiles 0..127 and 128.. are separate VRAM blocks (0x9000 / 0x8800)
  if (tile_count > 128u) {
    set_bkg_data(0, 128, tiles);
    set_bkg_data(128, (uint8_t)(tile_count - 128u), tiles + (128u * 16u));
  } else {
    set_bkg_data(0, (uint8_t)tile_count, tiles);
  }
  SWITCH_ROM(_prev);
}

// Buffer current and adjacent map columns in WRAM to reduce bank switches
#include <string.h>

// The player's collision window: map rows row0 .. row0+15 of columns map_col and map_col+1
void load_collision_columns(uint16_t map_col, const uint8_t* map,
                            uint16_t map_w, uint8_t map_bank,
                            uint8_t* columns, uint8_t row0) {
  uint8_t _prev = _current_bank;
  uint16_t right_col = (map_col + 1u < map_w) ? map_col + 1u : map_col;

  SWITCH_ROM(MAP_BANK(map_bank, map_col));
  memcpy(columns, MAP_COL(map, map_col) + row0, 16);
  // the right column is in the next bank when map_col is the last column of a chunk
  SWITCH_ROM(MAP_BANK(map_bank, right_col));
  memcpy(columns + 16, MAP_COL(map, right_col) + row0, 16);
  SWITCH_ROM(_prev);
}

// The 16 map rows the VRAM ring holds for band `band`: dest[k] = map row band + ((k - band) & 15),
// the row shown in VRAM metatile row k. Rows below the map (the ground row) read as 0.
void get_map_column(uint16_t map_col, const uint8_t *map, uint8_t map_bank, uint8_t *dest, uint8_t band) {
  uint8_t _prev = _current_bank;
  SWITCH_ROM(MAP_BANK(map_bank, map_col));
  // VRAM rows b..15 show map rows base+b..base+15, VRAM rows 0..b-1 rows base+16..base+16+b-1
  const uint8_t *src = MAP_COL(map, map_col) + (band & ~15u);
  uint8_t b = band & 15u;
  memcpy(dest + b, src + b, 16u - b);
  if (b) {
    if ((band & ~15u) + 16u < MAP_ROWS) memcpy(dest, src + 16, b);
    else memset(dest, 0, b);   // below the map: the ground row
  }
  SWITCH_ROM(_prev);
}

// Metatiles of map row `row` at ring positions first .. first+n-1 (the columns loaded_r maps them
// to), with as few bank switches as possible. Rows below the map read as 0.
void get_map_row_slots(uint8_t first, uint8_t n, uint8_t row, uint16_t loaded_r, uint8_t reversed,
                       const uint8_t *map, uint16_t map_w, uint8_t map_bank, uint8_t *out) {
  uint8_t _prev = _current_bank;
  uint8_t cur = _prev;
  for (uint8_t i = 0; i < n; i++) {
    uint8_t slot = (uint8_t)(first + i);
    if (reversed) slot = (uint8_t)(-(int8_t)slot & 15u);
    uint16_t c = loaded_r - ((loaded_r - slot) & 15u);
    uint8_t id = 0;
    if (c < map_w && row < MAP_ROWS) {
      uint8_t b = MAP_BANK(map_bank, c);
      if (b != cur) { SWITCH_ROM(b); cur = b; }
      id = MAP_COL(map, c)[row];
    }
    out[i] = id;
  }
  if (cur != _prev) SWITCH_ROM(_prev);
}

uint8_t get_map_tile(uint16_t col, uint8_t row, const uint8_t *map, uint8_t map_bank) {
  if (row >= MAP_ROWS) return 0;
  uint8_t _prev = _current_bank;
  SWITCH_ROM(MAP_BANK(map_bank, col));
  uint8_t id = MAP_COL(map, col)[row];
  SWITCH_ROM(_prev);
  return id;
}


#include "hUGEDriver.h"

extern uint8_t music_ready;
extern uint8_t current_song_bank;
extern volatile uint8_t current_music_divider;
extern volatile uint8_t sample_playing;
extern volatile uint8_t sample_keeps_music;

#include "settings.h"

void init_music_banked(const hUGESong_t * song, uint8_t bank, uint8_t divider) {
    uint8_t _prev = _current_bank;
    disable_interrupts();
    music_ready = 0;
    sample_playing = 0;
    sample_keeps_music = 0;
    current_song_bank = bank;
    current_music_divider = divider;
    SWITCH_ROM(bank);
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
    hUGE_init(song);
    if (setting_music_enabled) {
        hUGE_mute_channel(HT_CH1, HT_CH_PLAY);
        hUGE_mute_channel(HT_CH2, HT_CH_PLAY);
        hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
        hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
    } else {
        hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
        hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
        hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
        hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
        NR12_REG = 0; NR14_REG = 0x80;
        NR22_REG = 0; NR24_REG = 0x80;
        NR30_REG = 0;
        NR42_REG = 0; NR44_REG = 0x80;
    }
    hUGE_reset_wave();
    TMA_REG = divider;
    TIMA_REG = divider;
    IF_REG &= ~TIM_IFLAG;
    TAC_REG = 0x04;
    enable_interrupts();
    SWITCH_ROM(_prev);
    music_ready = setting_music_enabled ? 1 : 0;
}
