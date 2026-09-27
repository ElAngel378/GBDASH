#pragma bank 14

#include <gb/gb.h>
#include <stdint.h>
#include <string.h>
#include "collision.h"
#include "famidash_metatiles.h"

#define BKG_MT_H 16

uint8_t vram_row0_is_ground = 1;
static const uint8_t ground_top[8] = { 48, 49, 49, 49, 49, 49, 49, 50 };
static const uint8_t ground_bot[8] = { 51, 52, 52, 52, 52, 52, 52, 53 };

static uint8_t metatile_column_tiles[BKG_MT_H * 4];
static uint8_t metatile_column_attributes[BKG_MT_H * 4];
static uint8_t col_buf[16];

void prepare_mt_column(uint16_t map_col, const uint8_t* map, uint8_t map_bank, uint8_t reversed) BANKED {
    uint8_t tl_x = 0;
    uint8_t tr_x = 1;
    if (_cpu == CGB_TYPE) {
        uint8_t vram_slot = (uint8_t)(map_col & 15u);
        if (reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15u);
        tl_x = (uint8_t)((vram_slot & 3u) << 1);
        tr_x = tl_x + 1u;
    }

    get_map_column(map_col, map, map_bank, col_buf);

    const uint8_t *map_ptr = col_buf;
    const uint8_t (*mt_table)[4] = reversed ? metatiles_rev : metatiles;
    uint8_t *dst = metatile_column_tiles;

    if (_cpu == CGB_TYPE) {
        static const uint8_t row_to_ty0[16] = { 0, 16, 32, 0, 16, 32, 0, 16, 32, 0, 16, 32, 0, 16, 32, 0 };
        uint8_t *dst_attr = metatile_column_attributes;
        for (uint8_t r = 0; r < BKG_MT_H; r++) {
            uint8_t metatile_id = *map_ptr++;
            if (r == 0 && vram_row0_is_ground) {
                *dst++ = ground_top[tl_x];
                *dst++ = ground_top[tr_x];
                *dst++ = ground_bot[tl_x];
                *dst++ = ground_bot[tr_x];
                *dst_attr++ = 0x0C; // Bank 1 + Palette 4
                *dst_attr++ = 0x0C;
                *dst_attr++ = 0x0C;
                *dst_attr++ = 0x0C;
                continue;
            }
            const uint8_t *tiles = mt_table[metatile_id];
            uint8_t palette = famidash_metatile_palettes[metatile_id];
            uint8_t r0 = row_to_ty0[r];
            uint8_t r1 = r0 + 8u;
            for (uint8_t i = 0; i < 4; i++) {
                uint8_t t = tiles[i];
                if (t == 12) {
                    *dst++ = (i < 2 ? r0 : r1) + ((i & 1) ? tr_x : tl_x);
                    *dst_attr++ = 0x0B;
                } else {
                    *dst++ = t;
                    *dst_attr++ = palette;
                }
            }
        }
    } else {
        for (uint8_t r = 0; r < BKG_MT_H; r++) {
            uint8_t metatile_id = *map_ptr++;
            const uint8_t *tiles = mt_table[metatile_id];

            *dst++ = tiles[0];
            *dst++ = tiles[1];
            *dst++ = tiles[2];
            *dst++ = tiles[3];
        }
    }
}

static uint8_t row0_tiles_cache[64];
static uint8_t row0_attrs_cache[64];

void flush_mt_column(uint8_t ring_col) BANKED {
    // FAST VBLANK PATH: this is only ever called right after wait_vbl_done()
    // (or with DISPLAY_OFF during init/mirror-switch), so VRAM is freely
    // accessible. Write directly instead of set_bkg_tiles(), which polls
    // STAT per byte and costs 2-3x the VBlank budget for 64+64 writes.
    // Region is 2 wide x 32 tall at (ring_col*2, 0); buffers are row-major.
    uint8_t bx = ring_col << 1;
    volatile uint8_t *vram = (volatile uint8_t *)0x9800;
    uint8_t y;
    VBK_REG = VBK_TILES;
    for (y = 0; y < 32; y++) {
        uint16_t row = (uint16_t)y << 5;
        uint8_t src = y << 1;
        vram[row + bx] = metatile_column_tiles[src];
        vram[row + bx + 1u] = metatile_column_tiles[src + 1u];
    }
    if (_cpu == CGB_TYPE) {
        VBK_REG = VBK_ATTRIBUTES;
        for (y = 0; y < 32; y++) {
            uint16_t row = (uint16_t)y << 5;
            uint8_t src = y << 1;
            vram[row + bx] = metatile_column_attributes[src];
            vram[row + bx + 1u] = metatile_column_attributes[src + 1u];
        }
        VBK_REG = VBK_TILES;
    }
}

void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint8_t map_bank, uint8_t reversed) BANKED {
    uint16_t cols = (map_w < 16) ? map_w : 16;
    for (uint16_t c = 0; c < cols; c++) {
        prepare_mt_column(c, map, map_bank, reversed);
        flush_mt_column((uint8_t)(c % 16));
    }
}

void prepare_row0_level_tiles(uint16_t loaded_r, const uint8_t* map, uint16_t map_w, uint8_t map_bank, uint8_t reversed) BANKED {
    const uint8_t (*mt_table)[4] = reversed ? metatiles_rev : metatiles;

    // PERF: old code called get_map_column() 16x (16x ROM bank switch +
    // 16-byte memcpy each) right before VBlank. Batch into a single bank
    // switch; only the first byte of each 16-byte map column (row 0) is
    // needed, so this is 16 ROM reads instead of 16 switches + 256 bytes.
    uint8_t save_bank = _current_bank;
    SWITCH_ROM(map_bank);
    for (uint8_t s = 0; s < 16; s++) {
        uint8_t slot = s;
        if (reversed) slot = (uint8_t)(-(int8_t)slot & 15u);
        uint8_t tl_x = (uint8_t)((slot & 3u) << 1);
        uint8_t tr_x = tl_x + 1u;
        uint16_t col = loaded_r - ((loaded_r - slot) & 15u);
        if (col < map_w) {
            uint8_t mt_id = map[(uint16_t)col << 4];
            const uint8_t *tiles = mt_table[mt_id];
            uint8_t pal = famidash_metatile_palettes[mt_id];
            for (uint8_t i = 0; i < 4; i++) {
                uint8_t t = tiles[i];
                uint8_t dst_idx = (i < 2 ? 0 : 32) + (s << 1) + (i & 1);
                if (t == 12) {
                    row0_tiles_cache[dst_idx] = (i < 2 ? 0 : 8) + ((i & 1) ? tr_x : tl_x);
                    row0_attrs_cache[dst_idx] = 0x0B;
                } else {
                    row0_tiles_cache[dst_idx] = t;
                    row0_attrs_cache[dst_idx] = pal;
                }
            }
        }
    }
    SWITCH_ROM(save_bank);
}

void flush_vram_row0(uint8_t is_ground) BANKED {
    if (_cpu != CGB_TYPE) return;

    // FAST VBLANK PATH: direct VRAM writes, no STAT polling (see above).
    // Rows 0-1 of the 32x32 map; row0_*_cache buffers are row-major 32x2.
    volatile uint8_t *vram = (volatile uint8_t *)0x9800;
    uint8_t x;
    if (is_ground) {
        VBK_REG = 0;
        for (x = 0; x < 32; x++) {
            vram[x] = ground_top[x & 7u];
            vram[32u + x] = ground_bot[x & 7u];
        }
        VBK_REG = 1;
        for (x = 0; x < 64; x++) vram[x] = 0x0C;
        VBK_REG = 0;
    } else {
        VBK_REG = 0;
        for (x = 0; x < 64; x++) vram[x] = row0_tiles_cache[x];
        VBK_REG = 1;
        for (x = 0; x < 64; x++) vram[x] = row0_attrs_cache[x];
        VBK_REG = 0;
    }
}

