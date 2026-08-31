#pragma bank 10

#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <stdio.h>

#include "gameplay.h"
#include "player.h"
#include "assets.h"
#include "icon1.h"
#include "ship1.h"
#include "ball.h"
#include "famidash_sprites.h"
#include "gbc_palettes.h"
#include "../levels/chr_data/chr_gb.h"

#define DEBUG_MODE
#include "famidash_metatiles.h"
#include "hUGEDriver.h"

extern const uint8_t chr_gb_cgb_tiles[];
extern const uint8_t chr_gb_cgb_tiles_rev[];

extern const unsigned char FontPusab[];
#define FONT_PUSAB_START 0xD0

#define BKG_MT_W 16
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9

// ID Mappings for SP Layer Logic
#define OBJ_CUBE_PORTAL   0
#define OBJ_SHIP_PORTAL   1
#define OBJ_BALL_PORTAL   2
#define OBJ_ORB_BLUE      5
#define OBJ_ORB_PINK      6
#define OBJ_GRAVITY_DOWN  8
#define OBJ_GRAVITY_UP    9
#define OBJ_PAD_YELLOW    10
#define OBJ_ORB_YELLOW    11
#define OBJ_PAD_YELLOW_UP 12
#define OBJ_PAD_BLUE      13
#define OBJ_PAD_BLUE_UP   14
#define OBJ_PAD_PINK      37
#define OBJ_LEVEL_END     15
#define OBJ_MIRROR_PORTAL 126
#define OBJ_MIRROR_EXIT   121
#define OBJ_PORTAL_DN_HORIZ_DN  16
#define OBJ_PORTAL_DN_HORIZ_UP  17
#define OBJ_PORTAL_UP_HORIZ_DN  18
#define OBJ_PORTAL_UP_HORIZ_UP  19

// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
#define SCROLL_SPEED_FP 714

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

#define BG_TRIGGER_LEAD_TILES 11
#define BG_TRIGGER_LEAD_PX    ((BG_TRIGGER_LEAD_TILES) << 4)

// Index (0-3) of the default theme in bg_pals:
// bottom row (light), column 0 (gray). This is used at level start and after death.
extern uint8_t music_ready;

/**
 * NES Master Palette mapped to GBC 15-bit RGB.
 * 64 colors (4 rows of 16).
 */
static const uint16_t nes_master_palette[64] = {
    // Row 0 (0x00 - 0x0F): Dark
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(1, 2, 18), RGB(6, 0, 17),
    RGB(8, 0, 12), RGB(11, 0, 6), RGB(20, 0, 0), RGB(7, 3, 0),
    RGB(4, 5, 0), RGB(1, 7, 0), RGB(0, 8, 0), RGB(0, 7, 0),
    RGB(0, 6, 7), RGB(0, 0, 0), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 1 (0x10 - 0x1F): Medium/Dark
    RGB(22, 22, 22), RGB(0, 7, 19), RGB(6, 6, 29), RGB(11, 3, 28),
    RGB(27, 0, 25), RGB(20, 2, 12), RGB(27, 0, 0), RGB(15, 7, 0),
    RGB(10, 11, 0), RGB(5, 14, 0), RGB(1, 15, 0), RGB(0, 14, 5),
    RGB(0, 12, 15), RGB(0, 0, 0), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 2 (0x20 - 0x2F): Bright
    RGB(31, 31, 31), RGB(7, 23, 31), RGB(15, 15, 31), RGB(22, 12, 31),
    RGB(31, 7, 21), RGB(31, 11, 22), RGB(31, 13, 12), RGB(31, 15, 0),
    RGB(27, 20, 0), RGB(14, 24, 0), RGB(0, 28, 0), RGB(7, 25, 13),
    RGB(0, 29, 27), RGB(7, 7, 7), RGB(0, 0, 0), RGB(0, 0, 0),

    // Row 3 (0x30 - 0x3F): Pale
    RGB(31, 31, 31), RGB(21, 25, 31), RGB(23, 23, 31), RGB(26, 22, 31),
    RGB(31, 21, 31), RGB(31, 21, 26), RGB(31, 22, 22), RGB(31, 27, 15),
    RGB(25, 26, 15), RGB(22, 27, 15), RGB(21, 28, 18), RGB(19, 28, 22),
    RGB(20, 26, 28), RGB(20, 20, 20), RGB(0, 0, 0), RGB(0, 0, 0)
};

/**
 * Vibrant GBC Palettes moved local for maximum DMG performance
 */
static const uint16_t vibrant_palette_default[16] = {
    RGB(0, 7, 19), RGB(0, 0, 17), RGB(0, 0, 0), RGB(31, 31, 31), // palette 0
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(0, 7, 19), RGB(31, 31, 31), // palette 1
    RGB(10, 10, 10), RGB(0, 0, 17), RGB(0, 0, 0), RGB(0, 28, 0), // palette 2
    RGB(0, 7, 19), RGB(0, 0, 17), RGB(0, 0, 0), RGB(0, 0, 0)  // palette 3
};

static const uint8_t level_sprite_cost_table[38] = {
    9, 9, 0, 0, 0, 2, 2, 0, 9, 9, 2, 2, 2, 2, 2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    2
};

//static const uint16_t gbc_bg_palettes[] = {
//    // --- ROW 0: DARK GRADIENTS (Triggers 100-115) ---
//    RGB8(0,0,0), RGB8(20,20,20), RGB8(40,40,40), RGB8(80,80,80),        // 0: Gray
//    RGB8(0,0,20), RGB8(0,10,40), RGB8(0,20,80), RGB8(0,40,120),        // 1: Deep Blue
//    RGB8(0,10,20), RGB8(0,30,60), RGB8(0,50,100), RGB8(20,80,150),      // 2: Blue
//    RGB8(10,0,30), RGB8(20,10,60), RGB8(40,20,100), RGB8(60,40,150),    // 3: Indigo
//    RGB8(20,0,40), RGB8(40,10,80), RGB8(60,20,120), RGB8(80,40,160),    // 4: Purple
//    RGB8(30,0,30), RGB8(60,10,60), RGB8(100,20,100), RGB8(150,40,150),  // 5: Magenta
//    RGB8(40,0,20), RGB8(80,10,40), RGB8(120,20,60), RGB8(180,40,80),    // 6: Pink
//    RGB8(40,0,0), RGB8(80,10,10), RGB8(120,20,20), RGB8(180,40,40),     // 7: Red
//    RGB8(40,20,0), RGB8(80,40,10), RGB8(120,60,20), RGB8(180,90,40),    // 8: Orange
//    RGB8(40,40,0), RGB8(80,80,10), RGB8(120,120,20), RGB8(180,180,40),  // 9: Yellow
//    RGB8(20,40,0), RGB8(40,80,10), RGB8(60,120,20), RGB8(80,180,40),    // 10: Lime
//    RGB8(0,40,0), RGB8(10,80,10), RGB8(20,120,20), RGB8(40,180,40),     // 11: Green
//    RGB8(0,40,30), RGB8(10,80,60), RGB8(20,120,100), RGB8(40,180,150),  // 12: Teal
//    RGB8(0,20,40), RGB8(10,40,80), RGB8(20,60,120), RGB8(40,80,180),    // 13: Navy
//    RGB8(80,80,80), RGB8(120,120,120), RGB8(180,180,180), RGB8(255,255,255), // 14: White
//    RGB8(0,0,0), RGB8(0,0,0), RGB8(0,0,0), RGB8(0,0,0),                 // 15: Black
//
//    // --- ROW 1: MEDIUM GRADIENTS (Triggers 116-131) ---
//    RGB8(20,20,20), RGB8(80,80,80), RGB8(150,150,150), RGB8(200,200,200), // 0: Gray
//    RGB8(0,20,60), RGB8(0,60,150), RGB8(20,100,220), RGB8(80,160,255),    // 1: Blue
//    RGB8(0,40,80), RGB8(20,100,180), RGB8(60,150,230), RGB8(120,200,255),  // 2: Sky
//    RGB8(30,10,80), RGB8(60,40,180), RGB8(100,80,255), RGB8(160,150,255),  // 3: Indigo
//    RGB8(50,10,100), RGB8(90,40,180), RGB8(140,80,255), RGB8(190,140,255), // 4: Purple
//    RGB8(80,10,80), RGB8(150,40,150), RGB8(220,80,220), RGB8(255,140,255), // 5: Magenta
//    RGB8(100,10,50), RGB8(180,40,100), RGB8(255,80,150), RGB8(255,150,200),// 6: Pink
//    RGB8(100,10,10), RGB8(180,40,40), RGB8(255,80,80), RGB8(255,150,150),  // 7: Red
//    RGB8(100,50,10), RGB8(180,100,40), RGB8(255,150,80), RGB8(255,200,150),// 8: Orange
//    RGB8(100,100,10), RGB8(180,180,40), RGB8(255,255,80), RGB8(255,255,180),// 9: Yellow
//    RGB8(50,100,10), RGB8(100,180,40), RGB8(150,255,80), RGB8(200,255,150),// 10: Lime
//    RGB8(10,100,10), RGB8(40,180,40), RGB8(80,255,80), RGB8(150,255,150),  // 11: Green
//    RGB8(10,100,80), RGB8(40,180,150), RGB8(80,255,220), RGB8(150,255,255),// 12: Teal
//    RGB8(10,40,100), RGB8(40,80,180), RGB8(80,120,255), RGB8(150,180,255), // 13: Navy
//    RGB8(150,150,150), RGB8(200,200,200), RGB8(255,255,255), RGB8(255,255,255), // 14: White
//    RGB8(20,20,20), RGB8(10,10,10), RGB8(5,5,5), RGB8(0,0,0),              // 15: Black
//
//    // --- ROW 2: LIGHT GRADIENTS (Triggers 132-147) ---
//    RGB8(100,100,100), RGB8(180,180,180), RGB8(230,230,230), RGB8(255,255,255), // 0: Gray
//    RGB8(40,80,180), RGB8(100,140,255), RGB8(160,200,255), RGB8(220,240,255),   // 1: Blue
//    RGB8(60,120,200), RGB8(120,180,255), RGB8(180,220,255), RGB8(230,250,255),  // 2: Sky
//    RGB8(100,80,200), RGB8(160,140,255), RGB8(200,180,255), RGB8(240,220,255),  // 3: Indigo
//    RGB8(140,80,220), RGB8(180,140,255), RGB8(220,180,255), RGB8(255,220,255),  // 4: Purple
//    RGB8(180,80,180), RGB8(220,140,220), RGB8(255,180,255), RGB8(255,230,255),  // 5: Magenta
//    RGB8(200,80,140), RGB8(255,140,180), RGB8(255,190,220), RGB8(255,240,250),  // 6: Pink
//    RGB8(200,80,80), RGB8(255,140,140), RGB8(255,190,190), RGB8(255,240,240),   // 7: Red
//    RGB8(200,120,80), RGB8(255,180,140), RGB8(255,220,190), RGB8(255,250,240),  // 8: Orange
//    RGB8(200,200,80), RGB8(255,255,140), RGB8(255,255,190), RGB8(255,255,240),  // 9: Yellow
//    RGB8(140,200,80), RGB8(190,255,140), RGB8(220,255,190), RGB8(250,255,240),  // 10: Lime
//    RGB8(80,200,80), RGB8(140,255,140), RGB8(190,255,190), RGB8(240,255,240),   // 11: Green
//    RGB8(80,200,180), RGB8(140,255,230), RGB8(190,255,245), RGB8(240,255,250),  // 12: Teal
//    RGB8(80,120,200), RGB8(140,180,255), RGB8(190,220,255), RGB8(240,240,255),  // 13: Navy
//    RGB8(255,255,255), RGB8(255,255,255), RGB8(255,255,255), RGB8(255,255,255), // 14: White
//    RGB8(50,50,50), RGB8(30,30,30), RGB8(10,10,10), RGB8(0,0,0)                 // 15: Black
//};

static palette_color_t famidash_bg_palettes[16];

static palette_color_t famidash_darker(palette_color_t color) {
    return RGB((color & 0x1Fu) * 3u / 4u,
               ((color >> 5) & 0x1Fu) * 3u / 4u,
               ((color >> 10) & 0x1Fu) * 3u / 4u);
}

static void famidash_reset_bg_palettes(void) {
    uint8_t i;
    for (i = 0; i != 16; i++) famidash_bg_palettes[i] = vibrant_palette_default[i];
    set_bkg_palette(0, 4, famidash_bg_palettes);
}

static void famidash_apply_bg_trigger(uint8_t color_id) {
    palette_color_t color;

    if (color_id == 31u) color = RGB(0, 29, 27); /* FamiDash $9F: Use Aqua as default player color */
    else if (color_id == 46u) {                       /* FamiDash $AE: Ground Color 2 Trigger */
        color = RGB(0, 28, 0); /* Neon Green */
        famidash_bg_palettes[6] = color;
        famidash_bg_palettes[5] = famidash_darker(color);
        set_bkg_palette(0, 4, famidash_bg_palettes);
        return;
    } else {
        // Fast local lookup
        color = nes_master_palette[color_id & 0x3Fu];
    }

    famidash_bg_palettes[0] = color;
    color = famidash_darker(color);
    famidash_bg_palettes[1] = color;
    famidash_bg_palettes[9] = color;
    famidash_bg_palettes[13] = color;
    set_bkg_palette(0, 4, famidash_bg_palettes);
}

static const uint16_t gbc_sprite_palettes[] = {
    // 0: Player (Outline: Black, Primary: Blue, Secondary: Green)
    RGB8(255, 255, 255), RGB8(0, 255, 255), RGB8(0, 255, 0), RGB8(0, 0, 0),
    // 1: Cube (Outline: Black, Primary: Green, Secondary: Green)
    RGB8(255, 255, 255), RGB8(0, 0, 0), RGB8(0, 255, 0), RGB8(0, 255, 0),
    // 2: Normal Gravity (Outline: Black, Primary: Teal, Secondary: Teal)
    RGB8(255, 255, 255), RGB8(0, 0, 0), RGB8(0, 255, 255), RGB8(0, 255, 255),
    // 3: Inverted Gravity (Outline: Black, Primary: Yellow, Secondary: Yellow)
    RGB8(255, 255, 255), RGB8(0, 0, 0), RGB8(255, 255, 0), RGB8(255, 255, 0),
    // 4: Ship (Outline: Black, Primary: Pink, Secondary: Pink)
    RGB8(255, 255, 255), RGB8(0, 0, 0), RGB8(255, 100, 255), RGB8(255, 100, 255),
    // 5: Ball (Outline: Black, Primary: Red, Secondary: Red)
    RGB8(255, 255, 255), RGB8(0, 0, 0), RGB8(255, 0, 0), RGB8(255, 0, 0)
};

void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
    uint8_t i;
    *stream_idx = 0;
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
}

void sp_cache_update(const Level *l, uint16_t cam_px,
                     SpCache *cache, uint16_t *stream_idx) {
    uint8_t i;
    uint8_t count = 0;
    uint8_t sp_bank = l->sp_bank;
    const SpDef *sp_list = l->sp_list;

    /* Retire old entries */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) continue;
        if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
    }

    /* Compact arrays */
    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (cache->active[i]) {
            if (count != i) {
                cache->obj[count] = cache->obj[i];
                cache->px[count] = cache->px[i];
                cache->py[count] = cache->py[i];
                cache->active[count] = cache->active[i];
                cache->activated[count] = cache->activated[i];
            }
            count++;
        }
    }
    while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;

    sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
}

// ==============================================================================
// ULTIMATE FAST OAM WRITERS (Zero Array Overhead, Raw Pointer Math)
// ==============================================================================

// Fast Writer: 2x1 Objects (Pads, Orbs)
static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    // Cast shadow_OAM to a raw 8-bit pointer. This forces the compiler to use LD (HL+), A.
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }
    return 2;
}

// Fast Writer: 2x2 8x16 objects (the 16x32 chain block).
// SDCC passes tile_base in A and oam_idx in E; sy, sx and reversed are the
// three stack bytes after the return address.  This routine also performs
// SDCC's required three-byte stack cleanup before returning.
static uint8_t draw_oam_2x2(uint8_t tile_base, uint8_t oam_idx,
                            uint8_t sx, uint8_t sy, uint8_t reversed) __naked {
__asm
    ; Build &shadow_OAM[oam_idx] while preserving tile_base in A.
    push    af
    xor     a
    ld      l, e
    ld      h, a
    add     hl, hl
    add     hl, hl
    ld      de, #_shadow_OAM
    add     hl, de
    pop     af
    ld      e, a                   ; E = tile_base

    ; Save the OAM pointer while reading the stack arguments.
    ; Stack after PUSH HL: saved OAM pointer, return address, sx, sy, reversed.
    push    hl
    ldhl    sp, #4
    ld      b, (hl)                ; B = sx
    inc     hl
    ld      c, (hl)                ; C = sy
    inc     hl
    ld      a, (hl)
    pop     hl                     ; Restore the OAM pointer.
    or      a
    jr      NZ, 00102$

    ; Normal order: top-left, top-right, bottom-left, bottom-right.
    ld      (hl), c
    inc     hl
    ld      (hl), b
    inc     hl
    ld      a, e
    ld      (hl), a
    inc     hl
    ld      (hl), #3
    inc     hl

    ld      (hl), c
    inc     hl
    ld      a, b
    add     #8
    ld      (hl), a
    inc     hl
    ld      a, e
    add     #2
    ld      (hl), a
    inc     hl
    ld      (hl), #3
    inc     hl

    ld      a, c
    add     #16
    ld      (hl), a
    inc     hl
    ld      (hl), b
    inc     hl
    ld      a, e
    add     #4
    ld      (hl), a
    inc     hl
    ld      (hl), #3
    inc     hl

    ld      a, c
    add     #16
    ld      (hl), a
    inc     hl
    ld      a, b
    add     #8
    ld      (hl), a
    inc     hl
    ld      a, e
    add     #6
    ld      (hl), a
    inc     hl
    ld      (hl), #3
    jr      00103$

00102$:
    ; Mirror order: reverse columns and set horizontal flip.
    ld      (hl), c
    inc     hl
    ld      a, b
    add     #8
    ld      (hl), a
    inc     hl
    ld      a, e
    ld      (hl), a
    inc     hl
    ld      (hl), #0x23
    inc     hl

    ld      (hl), c
    inc     hl
    ld      (hl), b
    inc     hl
    ld      a, e
    add     #2
    ld      (hl), a
    inc     hl
    ld      (hl), #0x23
    inc     hl

    ld      a, c
    add     #16
    ld      (hl), a
    inc     hl
    ld      a, b
    add     #8
    ld      (hl), a
    inc     hl
    ld      a, e
    add     #4
    ld      (hl), a
    inc     hl
    ld      (hl), #0x23
    inc     hl

    ld      a, c
    add     #16
    ld      (hl), a
    inc     hl
    ld      (hl), b
    inc     hl
    ld      a, e
    add     #6
    ld      (hl), a
    inc     hl
    ld      (hl), #0x23

00103$:
    ld      a, #4
    pop     hl                     ; Return address
    add     sp, #3                 ; sy, sx, reversed
    jp      (hl)
__endasm;
}

// Fast Writer: 2x3 Objects (Gravity Portals)
static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }
    return 6;
}

// Fast Writer: 3x3 Objects (Cube/Ship Portals)
static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];

    if (!reversed) {
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;

        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;

        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
        *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
    } else {
        *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;

        *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;

        *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
        *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
    }

    return 9;
}

inline static uint8_t draw_oam_deco(const FamidashDeco *deco, uint8_t tile_base,
                             uint8_t oam_idx, uint8_t sx, uint8_t sy,
                             uint8_t reversed) {
    uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
    uint8_t count = deco->count;
    const int8_t *dx = deco->x;
    const int8_t *dy = deco->y;
    const uint8_t *dt = deco->tile;
    const uint8_t *dp = deco->props;

    if (!reversed) {
        *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
        if (count > 1) {
            *oam++ = sy + dy[1]; *oam++ = sx + dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1];
            if (count > 2) {
                *oam++ = sy + dy[2]; *oam++ = sx + dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2];
            }
        }
    } else {
        uint8_t rx = sx + deco->width - 8;
        *oam++ = sy + dy[0]; *oam++ = rx - dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0] ^ S_FLIPX;
        if (count > 1) {
            *oam++ = sy + dy[1]; *oam++ = rx - dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1] ^ S_FLIPX;
            if (count > 2) {
                *oam++ = sy + dy[2]; *oam++ = rx - dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2] ^ S_FLIPX;
            }
        }
    }
    return count;
}

static void process_sprite_logic(
        SpCache *cache, uint16_t cam_px,
        Player* p, uint8_t joy, uint8_t* target_bg_idx
) {
    uint8_t i;
    uint16_t px = p->world_x;
    uint16_t py = p->world_y.b.h;

    uint8_t player_col = (uint8_t)(px >> 4);

    uint16_t p_front = px + 15u;
    uint16_t p_bottom = py + PLAYER_SIZE;
    uint16_t p_feet = py + PLAYER_SIZE;

    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
        if (!cache->active[i]) break;

        uint16_t obj_x = cache->px[i];
        if (obj_x > cam_px + 176u) break;

        uint8_t obj = cache->obj[i];

        if (obj == OBJ_LEVEL_END) {
            if (px >= (obj_x - 180u)) {
                p->level_complete = 1;
            }
            continue;
        }

        // Bypass collision entirely for all decorations to save CPU cycles
        if (obj >= 38 && obj < 64) continue;

        // Background trigger objects do not need Y coordinates.
        if (obj >= 100 && obj <= 147 &&
            obj != OBJ_MIRROR_EXIT && obj != OBJ_MIRROR_PORTAL) {

            if (!cache->activated[i]) {
                uint8_t obj_col = (uint8_t)(obj_x >> 4);

                uint8_t trigger_col;
                if (obj_col > BG_TRIGGER_LEAD_TILES) {
                    trigger_col = obj_col - BG_TRIGGER_LEAD_TILES;
                } else {
                    trigger_col = 0;
                }

                if (player_col >= trigger_col) {
                    uint8_t pal_idx = (uint8_t)(obj - 100);

                    if (_cpu == CGB_TYPE) {
                        famidash_apply_bg_trigger(pal_idx);
                    }

                    if (pal_idx < 16) {
                        *target_bg_idx = (pal_idx == 15) ? 3 : 2;
                    } else if (pal_idx < 32) {
                        *target_bg_idx = 1;
                    } else {
                        *target_bg_idx = 0;
                    }

                    cache->activated[i] = 1;
                }
            }

            if (obj_x > p_front + 16u) break;
            continue;
        }

        uint16_t obj_y = cache->py[i];

        if (obj >= 16 && obj <= 19) {
            // 48-pixel (3 tile) wide horizontal gravity portal
            if (obj_x <= p_front && px <= obj_x + 48u) {
                if (py <= obj_y + 14u && p_bottom >= obj_y) {
                    if (!cache->activated[i]) {
                        uint8_t target_flipped = (obj >= 18);
                        if (p->gravity_flipped != target_flipped) {
                            p->gravity_flipped = target_flipped;
                            p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity
                        }
                        cache->activated[i] = 1;
                    }
                }
            }
        } else if (obj_x + 2 <= p_front && px <= obj_x + 15) {
            switch (obj) {
                case OBJ_CUBE_PORTAL:
                case OBJ_SHIP_PORTAL:
                case OBJ_BALL_PORTAL:
                    // Expanded hitbox: 3px above, 3px below (total 38px height)
                    if (py <= obj_y + 35 && p_bottom >= (obj_y - 3)) {
                        if (!cache->activated[i]) {
                            if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
                            else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
                            else p->mode = MODE_BALL;
                            cache->activated[i] = 1;
                        }
                    }
                    break;

                case OBJ_GRAVITY_DOWN:
                case OBJ_GRAVITY_UP:
                    // Expanded hitbox: 3px above, 3px below (total 38px height)
                    if (py <= obj_y + 35 && p_bottom >= (obj_y - 3)) {
                        if (!cache->activated[i]) {
                            uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                            if (p->gravity_flipped != target_flipped) {
                                p->gravity_flipped = target_flipped;
                                p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                            }
                            cache->activated[i] = 1;
                        }
                    }
                    break;

                case OBJ_PAD_YELLOW:
                case OBJ_PAD_PINK:
                case OBJ_PAD_BLUE:
                case OBJ_PAD_YELLOW_UP:
                case OBJ_PAD_BLUE_UP:
                {
                    uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
                    uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
                    uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);

                    if (py <= pad_bot && p_bottom >= pad_top) {
                        if (!cache->activated[i]) {
                            cache->activated[i] = 1;
                            if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
                                p->gravity_flipped = !p->gravity_flipped;
                                p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
                            } else if (obj == OBJ_PAD_PINK) {
                                int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
                                p->vel_y.w = (p->gravity_flipped) ? -force : force;
                            } else {
                                int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
                                p->vel_y.w = (p->gravity_flipped) ? -force : force;
                            }
                            p->on_ground = 0;
                        }
                    }
                    break;
                }

                case OBJ_ORB_YELLOW:
                case OBJ_ORB_PINK:
                case OBJ_ORB_BLUE:
                {
                    if (joy & J_A) {
                        if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
                            if (!cache->activated[i]) {
                                cache->activated[i] = 1;
                                p->orb_buffered = 0; // Clear buffer after hit
                                if (obj == OBJ_ORB_BLUE) {
                                    p->gravity_flipped = !p->gravity_flipped;
                                    int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                } else if (obj == OBJ_ORB_PINK) {
                                    int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                } else {
                                    int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
                                    p->vel_y.w = (p->gravity_flipped) ? -force : force;
                                }
                                p->on_ground = 0;
                            }
                        }
                    }
                    break;
                }


                case OBJ_MIRROR_PORTAL:
                case OBJ_MIRROR_EXIT:
                    if (py <= obj_y + 32 && p_bottom >= obj_y) {
                        if (!cache->activated[i]) {
                            p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
                            cache->activated[i] = 1;
                        }
                    }
                    break;
            }
        } else if (obj_x > p_front + 16) {
            break;
        }
    }
}

static uint8_t draw_sprites(
        SpCache *cache, uint16_t cam_px, uint16_t cam_py,
        uint8_t reversed, uint8_t oam_start
) {
    uint8_t i;
    uint8_t dist_x, screen_x, screen_y;
    uint8_t deco_drawn = 0;
    // Cap decorations to maintain 60 FPS: 4 on DMG, 12 on CGB
    uint8_t deco_max = (_cpu == CGB_TYPE) ? 12 : 4;

    for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
        if (!cache->active[i]) break;

        uint16_t obj_x = cache->px[i];
        if (obj_x > cam_px + 176u) break;

        uint8_t obj = cache->obj[i];
        if (obj == OBJ_LEVEL_END || obj >= 100) continue;

        // --- PURE 8-BIT DISTANCE MATH ---
        // This eliminates the 16-bit rel_x calculation.
        // It uses native integer underflow to safely wrap off-screen objects.
        dist_x = (uint8_t)obj_x - (uint8_t)cam_px;

        // Skip objects far left of camera (values between 177 and 224 roughly)
        if (dist_x > 176 && dist_x < 224) continue;

        if (reversed) {
            screen_x = 128 - dist_x + 8;
        } else {
            screen_x = dist_x + PLAYER_SCREEN_X + 8;
        }

        screen_y = ((uint8_t)cache->py[i] - (uint8_t)cam_py) + 16;

        if (screen_x > 160 && screen_x < 232) continue;
        if (screen_y > 160 && screen_y < 208) continue;

        if (obj >= 38) {
            if (deco_drawn >= deco_max) continue;
            
            if (_cpu == CGB_TYPE && obj < 64) {
                const FamidashDeco *deco = famidash_deco_table[obj];
                if (deco) {
                    if (oam_start > MAX_HARDWARE_SPRITES - deco->count) break;
                    deco_drawn++;
                    oam_start += draw_oam_deco(deco, FAMIDASH_SPRITE_TILE_BASE,
                                               oam_start, screen_x, screen_y, reversed);
                }
            }
            continue;
        }

        if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
        const metasprite_t *sprite = famidash_sprite_table[obj];
        if (sprite == 0) continue;

        // Temporary: Disable orb and pad graphics
        if (_cpu != CGB_TYPE && (
            obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
            obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
            obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK)) {
            continue;
        }

        if (obj >= 16 && obj <= 19) {
            if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
            else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
        } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
            oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
            oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        } else {
            oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
        }
    }
    return oam_start;
}

void setup_menu_font(void) BANKED {
    set_bkg_data(FONT_PUSAB_START, 39, FontPusab);
}

void draw_text(uint8_t x, uint8_t y, const char *str) BANKED {
    uint8_t tile;
    while (*str) {
        char c = *str;
        if (c == ' ') tile = 0;
        else if (c == '%') tile = 1;
        else if (c == '/') tile = 2;
        else if (c >= '0' && c <= '9') tile = (c - '0') + 3;
        else if (c >= 'A' && c <= 'Z') tile = (c - 'A') + 13;
        else if (c >= 'a' && c <= 'z') tile = (c - 'a') + 13;
        else tile = 0;
        set_bkg_tile_xy(x++, y, FONT_PUSAB_START + tile);
        str++;
    }
}

void draw_levels(void) BANKED {
    if (_cpu == CGB_TYPE) {
        // Simple dark blue/gray palette for menu
        static const uint16_t menu_pal[] = {
            RGB8(20, 20, 40), RGB8(100, 100, 150), RGB8(200, 200, 255), RGB8(255, 255, 255)
        };
        set_bkg_palette(0, 1, menu_pal);

        // RESET ATTRIBUTES: Clear level attributes (Palettes 1-7, VRAM Bank 1, flips)
        // so the menu text uses Palette 0 and VRAM Bank 0.
        VBK_REG = 1;
        fill_bkg_rect(0, 0, 32, 32, 0x00);
        VBK_REG = 0;
    }
    BGP_REG = 0x2F; // Inverted Palette: White=00, Light Gray=Dark Gray(10), Dark Gray=Black(11), Black=Black(11)
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    draw_text(0, 0, "LEVEL SELECT");
    for (uint8_t i = 0; i < MAX_LEVELS; i++) {
        if (i == selected) {
            draw_text(1, 2 + i, "0"); // cursor icon
            draw_text(3, 2 + i, game_levels[i]->name);
        } else {
            draw_text(3, 2 + i, game_levels[i]->name);
        }
    }
    draw_text(0, 16, "PRESS START TO PLAY");
    SHOW_BKG;
    redraw = 0;
}

// Globals for play_level to avoid slow stack-relative addressing
SpCache active_sp;
uint8_t collision_columns[32];

void play_level(uint8_t idx) BANKED {
    const Level* l;
    const uint8_t* level_tiles;
    const uint8_t* level_map;
    uint16_t level_tile_count;
    uint16_t level_map_w;
    uint16_t level_map_h;
    uint8_t level_tiles_bank;
    uint8_t level_map_bank;

    l = game_levels[idx];
    level_tiles = l->tiles;
    level_map = l->map;
    level_tile_count = l->tile_count;
    level_map_w = l->map_width;
    level_map_h = l->map_height;
    level_tiles_bank = BANK(chr_gb);
    level_map_bank = l->map_bank;
    if (_cpu == CGB_TYPE) level_tiles = chr_gb_cgb_tiles;

    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    if (level_songs[idx]) {
        init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
        current_song_bank = song_bank[idx];
        music_ready = 1;
    }

    uint16_t cam_px = 0;
    uint16_t cam_py = 112;
    uint16_t cam_py_max = (level_map_h << 4);
    if (cam_py_max > 144u) cam_py_max -= 144u;
    else cam_py_max = 0;
    uint16_t loaded_r = BKG_MT_W - 1;

    uint8_t died;
    int16_t py;

    uint8_t target_bg_idx = 0;
    const uint8_t bg_pals[] = {
            0xE4, // 0: Normal (W:W, LG:LG, DG:DG, B:B)
            0x39, // 1: Inverse (W:LG, LG:DG, DG:B, B:W)
            0x3E, // 2: Inverse (W:DG, LG:B, DG:B, B:W)
            0x3F  // 3: Inverse (W:B, LG:B, DG:B, B:W)
    };

    Player player;
    player_init(&player, 0, 240);

    disable_interrupts();
    DISPLAY_OFF;
    load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
    set_sprite_data(0, 8, icon1_tiles);
    set_sprite_data(8, 4, ship_tiles);
    set_sprite_data(12, 4, ball_tiles);
    set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
    move_bkg(0, (uint8_t)cam_py);
    fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);

    if (_cpu == CGB_TYPE) {
        // Boot on the default FamiDash theme so GBC matches the DMG boot
        // state (bg_pals[0] = 0xE4).
        famidash_reset_bg_palettes();
        set_sprite_palette(0, 6, gbc_sprite_palettes);
    }

    BGP_REG = bg_pals[0];
    OBP0_REG = bg_pals[0];
    SPRITES_8x16;
    OBP1_REG = bg_pals[0];
    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;
    TAC_REG = 0x04;
    enable_interrupts();

    uint16_t scroll_acc = 0;
    uint8_t prev_joy = 0;
    uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
    uint16_t sp_stream_idx = 0;
    uint16_t sp_cache_col = 0xFFFF;
    uint16_t cached_collision_col = 0xFFFF;
    uint8_t prev_reversed = player.reversed;
    uint8_t reduce_flash = 0;
    sp_cache_reset(&active_sp, &sp_stream_idx);
    while (1) {
        uint8_t joy = joypad();
        if (joy & J_START) break;

        if ((joy & J_UP) || player.level_complete) {
            HIDE_SPRITES;
            move_bkg(0, 0);
            disable_interrupts();
            setup_menu_font();
            enable_interrupts();
            VBK_REG = 1;
            fill_bkg_rect(0, 0, 32, 32, 0x00);
            VBK_REG = 0;
            fill_bkg_rect(0, 0, 20, 18, 0x00);
            draw_text(3, 6, "LEVEL COMPLETE");
            draw_text(3, 12, "PRESS A TO EXIT");
            waitpadup();
            while (!(joypad() & J_A)) wait_vbl_done();
            break;
        }


        if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
        if ((joy & J_SELECT) && !(prev_joy & J_SELECT)) {
            reduce_flash = !reduce_flash;
        }
        prev_joy = joy;

        uint16_t px_prev = cam_px >> 4;
        uint8_t needs_render = 0;
        uint16_t need_col = 0;

        // PROGRESS FORWARD through the level map
        if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
            scroll_acc += SCROLL_SPEED_FP;
            cam_px += scroll_acc >> 8;
            scroll_acc &= 0xFF;
            uint16_t px_curr = cam_px >> 4;
            if (px_curr != px_prev) {
                uint16_t need = px_curr + VIEW_MT_W;
                if (need > loaded_r && need < level_map_w) {
                    needs_render = 1;
                    need_col = need;
                }
            }
        }

        player.world_x = cam_px;
        /* SP entries are aligned to 16-pixel columns, so the cache only
         * needs banked stream work when entering a new column. */
        if ((cam_px >> 4) != sp_cache_col) {
            sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
            sp_cache_col = cam_px >> 4;
        }

        // Apply object logic before testing the mirror state so the tile-map
        // and camera switch on the same frame as the mirror portal.
        process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);

        if (player.reversed != prev_reversed) {
            disable_interrupts();

            // Swap tileset in VRAM to match mirror mode orientation
            const uint8_t* target_tiles = player.reversed
                ? ((_cpu == CGB_TYPE) ? chr_gb_cgb_tiles_rev : l->tiles_rev)
                : level_tiles;
            load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);

            // Instant redraw of the entire 16-column buffer
            uint16_t start_col = cam_px >> 4;
            for (uint8_t i = 0; i < 16; i++) {
                uint16_t curr_col = start_col + i;
                if (curr_col < level_map_w) {
                    uint8_t vram_slot = (uint8_t)(curr_col & 15);
                    if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
                    prepare_mt_column(curr_col, level_map, level_map_bank, player.reversed);
                    flush_mt_column(vram_slot);
                }
            }
            // Reinit sprites
            set_sprite_data(0, 8, icon1_tiles);
            set_sprite_data(8, 4, ship_tiles);
            set_sprite_data(12, 4, ball_tiles);
            set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
            enable_interrupts();
            // Reset loaded_r to match the last column we just drew
            loaded_r = start_col + 15;
            prev_reversed = player.reversed;
        }

        uint16_t collision_col = cam_px >> 4;
        if (collision_col != cached_collision_col) {
            load_collision_columns(collision_col, level_map, level_map_w,
                                   level_map_bank, collision_columns);
            cached_collision_col = collision_col;
        }

        died = player_update(&player, joy, collision_columns, level_map_h);

        py = player_screen_y(&player, cam_py);
        if (py < CAM_Y_TOP_ZONE) {
            int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
            if (target_cam_py < 0) target_cam_py = 0;
            if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
            cam_py = (uint16_t)target_cam_py;
        }
        else if (py > CAM_Y_BOTTOM_ZONE) {
            int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
            if (target_cam_py < 0) target_cam_py = 0;
            if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
            cam_py = (uint16_t)target_cam_py;
        }

        uint16_t scroll_px;
        uint8_t sprite_x_final;
        if (player.reversed) {
            // Mirror Mode: SCX decreases as we progress forward
            scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
            sprite_x_final = 128; // Mirrored player position
        } else {
            scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
            sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
        }
        int16_t final_py = player_screen_y(&player, cam_py);

        uint8_t vram_slot = 0;
        if (needs_render) {
            loaded_r = need_col;
            vram_slot = (uint8_t)(need_col & 15);
            if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
            
            // Do the heavy 16-bit math and array formatting BEFORE VBlank starts
            prepare_mt_column(need_col, level_map, level_map_bank, player.reversed);
        }

        wait_vbl_done();
        uint8_t apply_idx = target_bg_idx;
        if (reduce_flash && (apply_idx == 1 || apply_idx == 2)) {
            apply_idx = 0;
        }
        BGP_REG = bg_pals[apply_idx];
        OBP0_REG = bg_pals[apply_idx];
        OBP1_REG = bg_pals[apply_idx];
        move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);

        if (needs_render) {
            // Only execute the actual VRAM writes inside VBlank
            flush_mt_column(vram_slot);
        }

        uint8_t oam_index = draw_sprites(
            &active_sp, cam_px, cam_py,
            player.reversed, 0
        );

        if (player.mode == MODE_SHIP) {
            if (player.gravity_flipped) {
                if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
                else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
            } else {
                if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
                else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
            }
        } else if (player.mode == MODE_BALL) {
            if (player.gravity_flipped) {
                if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
                else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
            } else {
                if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
                else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
            }
        } else {
            if (player.gravity_flipped) {
                if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
                else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
            } else {
                if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
                else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
            }
        }
        // Only clear entries that were used by the previous frame but not by
        // this one. Newly needed entries are overwritten below/above.
        if (oam_index < previous_oam_index) {
            hide_sprites_range(oam_index, previous_oam_index);
        }
        previous_oam_index = oam_index;

        if (died) {
            TAC_REG = 0x00;
            NR52_REG = 0x00;
            NR52_REG = 0x80;
            NR51_REG = 0xFF;
            NR50_REG = 0x77;
            NR41_REG = 0x00;
            NR42_REG = 0xF2;
            NR43_REG = 0x43;
            NR44_REG = 0x80;
            for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
            NR52_REG = 0x80;
            NR51_REG = 0xFF;
            NR50_REG = 0x77;
            if (level_songs[idx]) {
                init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
                current_song_bank = song_bank[idx];
            }
            disable_interrupts();
            DISPLAY_OFF;

            // Restore normal tileset on death.
            // NOTE: BG tiles share VRAM 8000h-8FFFh with sprite tiles, and the
            // chr_gb tileset is a full 256 tiles, so this upload wipes the
            // famidash portal/orb/pad graphics (tiles 112-195) AND the
            // player/ship/ball tiles (0-15).
            load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);

            // Re-upload ALL sprite tiles afterwards or portals render corrupted on the next attempt.
            set_sprite_data(0, 8, icon1_tiles);
            set_sprite_data(8, 4, ship_tiles);
            set_sprite_data(12, 4, ball_tiles);
            set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);

            cam_px = 0;
            cam_py = 112;
            scroll_acc = 0;
            loaded_r = BKG_MT_W - 1;
            target_bg_idx = 0;
            player_init(&player, 0, 240);
            sp_cache_reset(&active_sp, &sp_stream_idx);
            sp_cache_col = 0xFFFF;
            previous_oam_index = MAX_HARDWARE_SPRITES;
            cached_collision_col = 0xFFFF;
            move_bkg(0, (uint8_t)cam_py);
            BGP_REG = bg_pals[0];
            if (_cpu == CGB_TYPE) {
                // Reset to the default light theme on respawn, matching
                // target_bg_idx = 0. Without this the palette from the
                // death spot would persist until the first trigger.
                famidash_reset_bg_palettes();
            }
            fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
            DISPLAY_ON;
            TAC_REG = 0x04;
            music_ready = 1;
            enable_interrupts();
        }
    }

    HIDE_SPRITES;
    move_bkg(0, 0);
    waitpadup();
    disable_interrupts();
    setup_menu_font();
    enable_interrupts();
    redraw = 1;
}
