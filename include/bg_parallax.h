#ifndef BG_PARALLAX_H
#define BG_PARALLAX_H

#include <gb/gb.h>
#include <stdint.h>

#define BG_PARALLAX_TILE_BASE 0  // In VRAM Bank 1 (tiles 0..47)
#define BG_PARALLAX_NUM_TILES 48

BANKREF_EXTERN(bg_parallax_data_0)
BANKREF_EXTERN(bg_parallax_data_1)
BANKREF_EXTERN(bg_parallax_data_2)
BANKREF_EXTERN(bg_parallax_data_3)

extern const uint8_t bg_parallax_phases_0[16][768];
extern const uint8_t bg_parallax_phases_1[16][768];
extern const uint8_t bg_parallax_phases_2[16][768];
extern const uint8_t bg_parallax_phases_3[16][768];

// Parallax is uploaded by a VBlank interrupt handler so that the 768-byte GDMA
// starts at the very beginning of VBlank regardless of what the main thread or
// the music interrupt is doing. Call bg_parallax_isr_start() when gameplay
// starts, request_bg_parallax() once per frame *before* wait_vbl_done(), and
// bg_parallax_isr_stop() when gameplay ends.
extern volatile uint8_t bg_gdma_pending;
extern volatile uint8_t bg_gdma_phase;
extern volatile uint8_t bg_gdma_isr_on;
extern volatile uint8_t bg_vbl_on;
extern volatile uint8_t bg_vbl_seen;
extern volatile uint8_t bg_pal_request; // apply famidash_bg_palettes in the VBlank handler (CGB palette RAM is VBlank-only)

// VRAM uploads done by the VBlank handler right after the parallax GDMA (fast,
// no STAT polling). The main thread fills the request and sets *_pending; the
// handler clears it once the data is written (it skips it if too little VBlank
// is left, and the request stays pending for the next one).
extern volatile uint8_t bg_cj_pending;     // 8 tile rows x 2 columns of a streamed map column
extern uint8_t bg_cj_x, bg_cj_y;
extern const uint8_t *bg_cj_tiles;         // 16 bytes: (x, x+1) for each of 8 rows
extern const uint8_t *bg_cj_attrs;
extern volatile uint8_t bg_rj_pending;     // top two tile rows, 8 tiles wide (four ring positions)
extern uint8_t bg_rj_x;
extern uint8_t bg_rj_tiles[16];            // row 0 (8 tiles) then row 1 (8 tiles)
extern uint8_t bg_rj_attrs[16];
extern volatile uint8_t bg_scroll_pending;
extern volatile uint8_t bg_scx;
extern volatile uint8_t bg_scy;
// Ask the VBlank handler to set SCX/SCY at the start of the next VBlank.
#define request_bg_scroll(x, y) do { bg_scx = (x); bg_scy = (y); bg_scroll_pending = 1; } while (0)
#define request_bg_parallax(p) do { bg_gdma_phase = (p); bg_gdma_pending = 1; } while (0)
void bg_parallax_vbl_isr(void);
// Register/unregister the VBlank handler (CGB only). Not in bank 0 to save space there.
#define bg_parallax_isr_start() do {     bg_gdma_pending = 0; bg_scroll_pending = 0; bg_vbl_seen = 0;     add_VBL(bg_parallax_vbl_isr); bg_vbl_on = 1;     bg_gdma_isr_on = (_cpu == CGB_TYPE); } while (0)
#define bg_parallax_isr_stop() do {     if (bg_vbl_on) { bg_vbl_on = 0; bg_gdma_isr_on = 0; remove_VBL(bg_parallax_vbl_isr); bg_gdma_pending = 0; } } while (0)

// Waits for the next VBlank. GBDK's wait_vbl_done() can sleep through a whole
// extra frame when a timer interrupt returns right at the start of VBlank (the
// VBlank interrupt lands between its flag check and its HALT), so poll a flag
// set by the VBlank handler instead. Only valid between isr_start/isr_stop.
#define bg_wait_vbl() do { bg_vbl_seen = 0; while (!bg_vbl_seen) { } } while (0)

#endif /* BG_PARALLAX_H */
