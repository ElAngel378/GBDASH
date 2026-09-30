#ifndef DEBUG_MODE_H
#define DEBUG_MODE_H

#include <stdint.h>
#include "debug_config.h"

#if ENABLE_DEBUG_MODE

extern uint8_t debug_mode;      // 1 = noclip + scanline readout

// Loads the HUD glyphs (D, B, G, 0-9) into free sprite tiles. Call after the other
// gameplay sprite tiles were loaded.
void debug_load_hud_tiles(void);
// Draws the HUD into OAM slots 31..39. ly/max_ly are only shown when show_ly is set.
void debug_draw_hud(uint8_t show_ly, uint8_t ly, uint8_t max_ly);
void debug_hide_hud(void);

#define DEBUG_ON()  (debug_mode)

#else

#define debug_mode 0
#define DEBUG_ON()  0
#define debug_load_hud_tiles()             ((void)0)
#define debug_draw_hud(show, ly, max_ly)   ((void)0)
#define debug_hide_hud()                   ((void)0)

#endif

#endif /* DEBUG_MODE_H */
