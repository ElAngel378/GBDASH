#include <gb/gb.h>
#include <stdint.h>
#include "video_vbl_uploader.h"

#define BG_UPLOAD_BYTES            64u
#define BG_UPLOAD_ROWS_PER_VBL     16u
#define BG_UPLOAD_ROW_BYTES        2u

#define TILE_UPLOAD_MAX_TILES      4u
#define TILE_UPLOAD_MAX_BYTES      (TILE_UPLOAD_MAX_TILES * 16u)

// -----------------------------------------------------------------------------
// Background map upload
//
// The 64 bytes represent a 2-column x 32-row tilemap rectangle.
//
// IMPORTANT:
// The Game Boy tilemap is not laid out as one contiguous 2x32 rectangle,
// so the VBlank handler uploads 16 rows (32 bytes) at a time using
// set_bkg_tiles(), then finishes the second half next VBlank.
//
// This keeps each VBlank bounded.
// -----------------------------------------------------------------------------

static uint8_t bg_upload_data[BG_UPLOAD_BYTES];
static uint8_t bg_upload_x;
static uint8_t bg_upload_row;
static volatile uint8_t bg_upload_pending;

// -----------------------------------------------------------------------------
// Tile pattern upload
//
// Tile uploads have priority over background-map uploads, because mirror mode
// needs the new patterns to exist before the reversed map is displayed.
//
// Maximum transfer in one VBlank:
//     4 tiles = 64 bytes
// -----------------------------------------------------------------------------

static uint8_t tile_upload_data[TILE_UPLOAD_MAX_BYTES];
static uint8_t tile_upload_start;
static uint8_t tile_upload_count;
static volatile uint8_t tile_upload_pending;


void queue_bg_column(uint8_t bx, const uint8_t *data) NONBANKED {
    // Never overwrite a transfer that is still in progress.
    if (bg_upload_pending) return;

    for (uint8_t i = 0; i < BG_UPLOAD_BYTES; i++) {
        bg_upload_data[i] = data[i];
    }

    bg_upload_x = bx;
    bg_upload_row = 0;
    bg_upload_pending = 1;
}


void queue_tile_chunk(uint16_t start_tile, uint8_t count,
                       const uint8_t *data) NONBANKED {
    if (tile_upload_pending) return;

    if (count == 0 || count > TILE_UPLOAD_MAX_TILES) return;

    // start_tile is allowed to be 0..255.
    // For this project tile_count is 256, so the valid ranges include
    // 252..255 as the final four tiles.
    tile_upload_start = (uint8_t)start_tile;
    tile_upload_count = count;

    for (uint8_t i = 0; i < (uint8_t)(count * 16u); i++) {
        tile_upload_data[i] = data[i];
    }

    tile_upload_pending = 1;
}


void bg_upload_vbl(void) NONBANKED {
    // NEVER perform both upload types during one VBlank.
    //
    // A mirror tile upload gets the whole VBlank slot.
    // The map column waits until the next VBlank.
    if (tile_upload_pending) {
        set_bkg_data(
            tile_upload_start,
            tile_upload_count,
            tile_upload_data
        );

        tile_upload_pending = 0;
        return;
    }

    if (bg_upload_pending) {
        // Upload only HALF the 64-byte column this VBlank.
        //
        // 16 tile rows x 2 columns = 32 bytes.
        set_bkg_tiles(
            bg_upload_x,
            bg_upload_row,
            2,
            BG_UPLOAD_ROWS_PER_VBL,
            bg_upload_data + ((uint8_t)bg_upload_row * BG_UPLOAD_ROW_BYTES)
        );

        bg_upload_row += BG_UPLOAD_ROWS_PER_VBL;

        if (bg_upload_row >= 32u) {
            bg_upload_pending = 0;
            bg_upload_row = 0;
        }
    }
}


uint8_t bg_upload_busy(void) NONBANKED {
    return bg_upload_pending;
}


uint8_t tile_upload_busy(void) NONBANKED {
    return tile_upload_pending;
}


void bg_upload_reset(void) NONBANKED {
    __critical {
        bg_upload_pending = 0;
        bg_upload_row = 0;
        tile_upload_pending = 0;
        tile_upload_start = 0;
        tile_upload_count = 0;
    }
}


void bg_upload_init(void) NONBANKED {
    __critical {
        add_VBL(bg_upload_vbl);
    }
}
