#pragma bank 10

#include <gb/gb.h>
#include <gb/cgb.h>
#include "percent_hud.h"
#include "settings.h"
#include "debug_mode.h"

extern const unsigned char FontPusab[];

// Sprite tiles: sprites are 8x16, and there is no free tile space left in gameplay.
// The debug HUD's glyph pairs (sprite tiles 90..115) only use their upper tile, so
// the % digits live in the lower (odd) tiles: pair 90 + 2k, lower tile = digit k,
// k = 10 is '%'. The % sprites sit at the top edge (OAM y 8) so only their lower
// tile is on screen (rows 0..7); the debug HUD sits at the bottom edge and shows
// only its upper tiles.
#define HUD_PAIR_BASE   90
#define GLYPH_PERCENT   10
#define FONT_DIGIT0     3
#define FONT_PERCENT    1
#define HUD_Y           8
#define GLYPH_W         8

static uint8_t pct;
static uint8_t shown = 0xFF;     // value currently in OAM (0xFF: redraw)
// Next percent threshold = ceil(p * max / 100), kept exactly with integer steps:
// q + rem/100 = p * max / 100
static uint16_t thr, q, step_q;
static uint8_t rem, step_r;

void percent_hud_load_tiles(void) BANKED {
    uint8_t k;
    for (k = 0; k < 10; k++) {
        set_sprite_data((uint8_t)(HUD_PAIR_BASE + (k << 1) + 1), 1, &FontPusab[(FONT_DIGIT0 + k) * 16]);
    }
    set_sprite_data((uint8_t)(HUD_PAIR_BASE + (GLYPH_PERCENT << 1) + 1), 1, &FontPusab[FONT_PERCENT * 16]);
    shown = 0xFF;
}

static void next_threshold(void) {
    q += step_q;
    rem += step_r;
    if (rem >= 100) { rem -= 100; q++; }
    thr = rem ? (uint16_t)(q + 1) : q;
}

void percent_hud_reset(uint16_t max_scroll_px) BANKED {
    pct = 0;
    q = 0; rem = 0;
    step_q = max_scroll_px / 100u;
    step_r = (uint8_t)(max_scroll_px % 100u);
    next_threshold();
    shown = 0xFF;
}

void percent_hud_complete(void) BANKED {
    pct = 100;
}

void percent_hud_hide(void) BANKED {
    shadow_OAM[0].y = shadow_OAM[1].y = shadow_OAM[2].y = shadow_OAM[3].y = 0;
    shown = 0xFF;
}

static void put(uint8_t slot, uint8_t x, uint8_t glyph) {
    shadow_OAM[slot].y = HUD_Y;
    shadow_OAM[slot].x = x;
    shadow_OAM[slot].tile = (uint8_t)(HUD_PAIR_BASE + (glyph << 1));
    // CGB: sprite palette 7 = the colours of the pause menu's "PAUSED" text
    // (black outline, light blue shading, white). DMG: OBP0
    shadow_OAM[slot].prop = (_cpu == CGB_TYPE) ? 7 : 0;
}

// Same value as the saved progress: floor(cam_px * 100 / max_scroll_px)
void percent_hud_update(uint16_t cam_px) BANKED {
    while (pct < 100 && cam_px >= thr) {
        pct++;
        if (pct < 100) next_threshold();
    }
    if (!setting_show_percent || DEBUG_ON()) {
        if (shown != 0xFE) { percent_hud_hide(); shown = 0xFE; }
        return;
    }
    if (pct == shown) return;
    shown = pct;

    uint8_t tens = pct / 10u, ones = pct % 10u;   // once per percent, not per frame
    uint8_t n = (pct == 100) ? 4 : (pct >= 10) ? 3 : 2;
    uint8_t x = (uint8_t)(80 + 8 - ((n * GLYPH_W) >> 1));
    uint8_t s = 0;
    if (pct == 100) {
        put(s++, x, 1); x += GLYPH_W;
        put(s++, x, 0); x += GLYPH_W;
        put(s++, x, 0); x += GLYPH_W;
    } else {
        if (pct >= 10) { put(s++, x, tens); x += GLYPH_W; }
        put(s++, x, ones); x += GLYPH_W;
    }
    put(s++, x, GLYPH_PERCENT);
    while (s < 4) shadow_OAM[s++].y = 0;
}
