#include <gb/gb.h>
#include <stdint.h>
#include "video_vbl_uploader.h"
#include "profiling.h"

#define UPLOAD_SIZE (16 * 4) // BKG_MT_H * 4 (64)
#define TILE_BYTES 16
#define TILE_CHUNK_TILES 16 // conservative: 16 tiles per VBlank (256 bytes)
#define TILE_CHUNK_BYTES (TILE_CHUNK_TILES * TILE_BYTES)

// Single-slot uploader: conservative, simple, and safe.
// Map column upload buffer
static uint8_t bg_upload_data[UPLOAD_SIZE];
static uint8_t bg_upload_x;
static volatile uint8_t bg_upload_pending = 0;

// Tile chunk upload buffer
static uint8_t tile_upload_data[TILE_CHUNK_BYTES];
static uint16_t tile_upload_start = 0; // tile index
static uint8_t tile_upload_count = 0;  // tiles in this chunk
static volatile uint8_t tile_upload_pending = 0;

void queue_bg_column(uint8_t bx, const uint8_t *data) NONBANKED {
    // Copy data into the uploader's WRAM buffer.
    for (uint8_t i = 0; i < UPLOAD_SIZE; i++) {
        bg_upload_data[i] = data[i];
    }
    // Record destination X and mark pending last to avoid races.
    bg_upload_x = bx;
    bg_upload_pending = 1;
}

// Queue a chunk of tile pattern data (tiles must already be copied into 'data' in WRAM).
// start_tile: index in the 0..255 tile space where this chunk should be copied.
// count: number of tiles in this chunk (<= TILE_CHUNK_TILES)
void queue_tile_chunk(uint16_t start_tile, uint8_t count, const uint8_t *data) NONBANKED {
    // Limit safety: do not accept larger than our buffer
    if (count == 0 || count > TILE_CHUNK_TILES) return;
    // Copy into internal buffer
    uint16_t bytes = (uint16_t)count * TILE_BYTES;
    for (uint16_t i = 0; i < bytes; i++) {
        tile_upload_data[i] = data[i];
    }
    tile_upload_start = start_tile;
    tile_upload_count = count;
    tile_upload_pending = 1;
}

void bg_upload_vbl(void) NONBANKED {
    // Priority: perform tile uploads first so that subsequent map uploads can
    // reference newly-written tiles.
    if (tile_upload_pending) {
        // set_bkg_data takes (start_tile, count, data)
        set_bkg_data((uint8_t)tile_upload_start, tile_upload_count, tile_upload_data);
        tile_upload_pending = 0;
        prof_vbl_enter_count++; // simple marker that VBlank did work
    }

    if (bg_upload_pending) {
        // Perform the tilemap update during VBlank. Use set_bkg_tiles() which is
        // safe in VBlank when sourcing from WRAM.
        set_bkg_tiles(bg_upload_x, 0, 2, UPLOAD_SIZE >> 1, bg_upload_data);
        bg_upload_pending = 0;
        prof_vbl_enter_count++; // count map upload work also
    }
}

void bg_upload_init(void) NONBANKED {
    __critical {
        add_VBL(bg_upload_vbl);
    }
}
