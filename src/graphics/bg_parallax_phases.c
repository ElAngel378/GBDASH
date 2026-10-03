#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdint.h>
#include "bg_parallax.h"
#include "famidash_bg.h"

volatile uint8_t bg_gdma_pending;
volatile uint8_t bg_gdma_phase;
volatile uint8_t bg_gdma_isr_on;
volatile uint8_t bg_vbl_on;
volatile uint8_t bg_vbl_seen;
volatile uint8_t bg_pal_request;
volatile uint8_t bg_cj_pending;
uint8_t bg_cj_x, bg_cj_y;
const uint8_t *bg_cj_tiles;
const uint8_t *bg_cj_attrs;
volatile uint8_t bg_rj_pending;
uint8_t bg_rj_x, bg_rj_y;
uint8_t bg_rj_tiles[2 * 2 * BG_RJ_SLOTS];
uint8_t bg_rj_attrs[2 * 2 * BG_RJ_SLOTS];
volatile uint8_t bg_saw_pending;
uint8_t bg_saw_bank, bg_saw_blocks;
const uint8_t *bg_saw_src;
uint16_t bg_saw_dst;
volatile uint8_t bg_saw_dmg_n;
uint8_t * const *bg_saw_dmg_dsts;
volatile uint8_t bg_scroll_pending;
volatile uint8_t bg_dmg_pal_pending;
uint8_t bg_dmg_bgp, bg_dmg_obp0, bg_dmg_obp1;
volatile uint8_t bg_scx;
volatile uint8_t bg_scy;

static void parallax_gdma(uint8_t phase);
static void saw_gdma(void);

void init_bg_parallax(void) {
    if (_cpu == CGB_TYPE) {
        bg_gdma_pending = 0;
        parallax_gdma(0);
    }
}

// Hand-written copy loops for the VBlank handler (C compiles to ~3x slower code
// and the whole upload has to fit in what is left of VBlank).
static const uint8_t *up_src;
static uint8_t *up_dst;

// 8 rows of 2 bytes from up_src (contiguous) to up_dst, up_dst advancing by 32 per row.
static void copy_rows2(void) __naked {
    __asm
        ld      hl, #_up_src
        ld      a, (hl+)
        ld      e, a
        ld      a, (hl)
        ld      d, a
        ld      hl, #_up_dst
        ld      a, (hl+)
        ld      c, a
        ld      a, (hl)
        ld      h, a
        ld      l, c
        ld      bc, #31
        .rept 8
        ld      a, (de)
        inc     de
        ld      (hl+), a
        ld      a, (de)
        inc     de
        ld      (hl), a
        add     hl, bc
        .endm
        ret
    __endasm;
}

// 8 contiguous bytes from up_src to up_dst.
static void copy8(void) __naked {
    __asm
        ld      hl, #_up_src
        ld      a, (hl+)
        ld      e, a
        ld      a, (hl)
        ld      d, a
        ld      hl, #_up_dst
        ld      a, (hl+)
        ld      c, a
        ld      a, (hl)
        ld      h, a
        ld      l, c
        .rept 8
        ld      a, (de)
        inc     de
        ld      (hl+), a
        .endm
        ret
    __endasm;
}

// Writes the 40 bytes of famidash_bg_palettes to CGB background palette RAM 0..
static void upload_palette(void) __naked {
    __asm
        ld      hl, #_famidash_bg_palettes
        ld      a, #0x80
        ldh     (0x68), a
        ld      c, #0x69
        .rept 40
        ld      a, (hl+)
        ldh     (c), a
        .endm
        ret
    __endasm;
}

// VBlank interrupt handler: latches scroll, runs the requested parallax GDMA and
// the requested map uploads, in that order.
void bg_parallax_vbl_isr(void) {
    bg_vbl_seen = 1;
    // Latch this frame's scroll first thing, so it can never land in the
    // visible frame however late the main thread wakes up.
    if (bg_scroll_pending) {
        bg_scroll_pending = 0;
        SCX_REG = bg_scx;
        SCY_REG = bg_scy;
    }
    if (bg_dmg_pal_pending) {
        bg_dmg_pal_pending = 0;
        BGP_REG = bg_dmg_bgp;
        OBP0_REG = bg_dmg_obp0;
        OBP1_REG = bg_dmg_obp1;
    }
    uint8_t ly = LY_REG;
    // The interrupted code may be in the middle of a VRAM bank-1 write.
    uint8_t vbk = VBK_REG;
    if (bg_gdma_pending) {
        // Started outside the first lines of VBlank (interrupts were masked for
        // a long time): the transfer would run into the visible frame, so keep
        // the request and retry on the next VBlank.
        if (ly >= 144u && ly <= 149u) {
            bg_gdma_pending = 0;
            parallax_gdma(bg_gdma_phase);
            ly = LY_REG;
        }
    }
    if (bg_pal_request && ly >= 144u && ly <= 150u) {
        bg_pal_request = 0;
        upload_palette();
        famidash_bkg_palettes_dirty = 0;
        ly = LY_REG;
    }
    // Map uploads. Each one only starts if it is certain to finish inside VBlank
    // (column slice ~0.6k dots, top rows ~0.5k dots); otherwise it stays pending
    // and is retried on the next VBlank. LY is re-read before each item.
    {
        ly = LY_REG;
        if (bg_cj_pending && ly >= 144u && ly <= 150u) {
            up_dst = (uint8_t *)0x9800 + ((uint16_t)bg_cj_y << 5) + bg_cj_x;
            up_src = bg_cj_tiles;
            VBK_REG = 0;
            copy_rows2();
            if (bg_gdma_isr_on) {   // CGB attributes (DMG: no VRAM bank 1, it would overwrite the tiles)
                up_dst = (uint8_t *)0x9800 + ((uint16_t)bg_cj_y << 5) + bg_cj_x;
                up_src = bg_cj_attrs;
                VBK_REG = 1;
                copy_rows2();
            }
            bg_cj_pending = 0;
        }
        ly = LY_REG;
        if (bg_rj_pending && ly >= 144u && ly <= 151u) {
            uint8_t *row0 = (uint8_t *)0x9800 + ((uint16_t)bg_rj_y << 5) + bg_rj_x;
            VBK_REG = 0;
            up_dst = row0;      up_src = bg_rj_tiles;      copy8();
            up_dst = row0 + 8;  up_src = bg_rj_tiles + 8;  copy8();
            up_dst = row0 + 32; up_src = bg_rj_tiles + 16; copy8();
            up_dst = row0 + 40; up_src = bg_rj_tiles + 24; copy8();
            if (bg_gdma_isr_on) {
                VBK_REG = 1;
                up_dst = row0;      up_src = bg_rj_attrs;      copy8();
                up_dst = row0 + 8;  up_src = bg_rj_attrs + 8;  copy8();
                up_dst = row0 + 32; up_src = bg_rj_attrs + 16; copy8();
                up_dst = row0 + 40; up_src = bg_rj_attrs + 24; copy8();
            }
            bg_rj_pending = 0;
        }
    }
    // Saw animation chunk (~0.5k dots), last: the map streaming above matters more
    ly = LY_REG;
    if (bg_saw_pending && ly >= 144u && ly <= 151u) {
        bg_saw_pending = 0;
        saw_gdma();
    }
    // DMG saw tiles (~0.4k dots per tile); retried on the next VBlank when this one started late
    if (bg_saw_dmg_n && ly >= 144u && ly <= 150u) {
        uint8_t prev_b = _current_bank;
        SWITCH_ROM(bg_saw_bank);
        const uint8_t *src = bg_saw_src;
        for (uint8_t i = 0; i < bg_saw_dmg_n; i++, src += 32) {
            uint8_t *dst = bg_saw_dmg_dsts[i];
            if (!dst) continue;
            up_src = src;     up_dst = dst;     copy8();
            up_src = src + 8; up_dst = dst + 8; copy8();
        }
        SWITCH_ROM(prev_b);
        bg_saw_dmg_n = 0;
    }
    VBK_REG = vbk;
}

static void saw_gdma(void) {
    uint8_t prev_b = _current_bank;
    SWITCH_ROM(bg_saw_bank);
    VBK_REG = 1;
    HDMA1_REG = (uint8_t)((uint16_t)bg_saw_src >> 8);
    HDMA2_REG = (uint8_t)((uint16_t)bg_saw_src & 0xF0);
    HDMA3_REG = (uint8_t)((bg_saw_dst >> 8) & 0x1F);
    HDMA4_REG = (uint8_t)(bg_saw_dst & 0xF0);
    HDMA5_REG = (uint8_t)(bg_saw_blocks - 1u);
    VBK_REG = 0;
    SWITCH_ROM(prev_b);
}

static void parallax_gdma(uint8_t phase) {
    uint8_t bank = 41 + (phase >> 4);
    uint8_t p_in_bank = phase & 15u;
    const uint8_t *src;
    if (bank == 41) src = bg_parallax_phases_0[p_in_bank];
    else if (bank == 42) src = bg_parallax_phases_1[p_in_bank];
    else if (bank == 43) src = bg_parallax_phases_2[p_in_bank];
    else src = bg_parallax_phases_3[p_in_bank];

    uint8_t prev_b = _current_bank;
    SWITCH_ROM(bank);

    VBK_REG = 1;
    // Fast CGB GDMA transfer: 48 blocks of 16 bytes = 768 bytes
    // Destination: VRAM Bank 1, 0x9000 (tiles 0..47 in LCDC signed mode)
    HDMA1_REG = (uint8_t)((uint16_t)src >> 8);
    HDMA2_REG = (uint8_t)((uint16_t)src & 0xF0);
    HDMA3_REG = 0x90;
    HDMA4_REG = 0x00;
    HDMA5_REG = 47; // 48 blocks (768 bytes)
    VBK_REG = 0;

    SWITCH_ROM(prev_b);
}
