#include <gb/gb.h>
#include <stdint.h>
#include "video_vbl_uploader.h"

#define UPLOAD_SIZE (16 * 4) // BKG_MT_H * 4 (64)
#define TILE_BYTES 16
#define TILE_CHUNK_TILES 4
#define TILE_CHUNK_BYTES (TILE_CHUNK_TILES * TILE_BYTES)

// Single-slot uploader: conservative and safe.
// Map-column upload buffer.
static uint8_t bg_upload_data[UPLOAD_SIZE];
static uint8_t bg_upload_x;
static volatile uint8_t bg_upload_pending = 0;

// Tile chunk upload buffer.
static uint8_t tile_upload_data[TILE_CHUNK_BYTES];
static uint16_t tile_upload_start = 0;
static uint8_t tile_upload_count = 0;
static volatile uint8_t tile_upload_pending = 0;

void queue_bg_column(uint8_t bx, const uint8_t *data) NONBANKED {
    if (bg_upload_pending) return;
    for (uint8_t i = 0; i < UPLOAD_SIZE; i++) {
        bg_upload_data[i] = data[i];
    }
    bg_upload_x = bx;
    bg_upload_pending = 1;
}

void queue_tile_chunk(uint16_t start_tile, uint8_t count, const uint8_t *data) NONBANKED {
    if (tile_upload_pending) return;
    if (count == 0 || count > TILE_CHUNK_TILES) return;
    uint16_t bytes = (uint16_t)count * TILE_BYTES;
    for (uint16_t i = 0; i < bytes; i++) {
        tile_upload_data[i] = data[i];
    }
    tile_upload_start = start_tile;
    tile_upload_count = count;
    tile_upload_pending = 1;
}

void bg_upload_vbl(void) NONBANKED {
    if (tile_upload_pending) {
        set_bkg_data((uint8_t)tile_upload_start, tile_upload_count, tile_upload_data);
        tile_upload_pending = 0;
        return;
    }

    if (bg_upload_pending) {
        set_bkg_tiles(bg_upload_x, 0, 2, UPLOAD_SIZE >> 1, bg_upload_data);
        bg_upload_pending = 0;
    }
}

uint8_t bg_upload_busy(void) NONBANKED {
    return bg_upload_pending;
}

uint8_t tile_upload_busy(void) NONBANKED {
    return tile_upload_pending;
}

void bg_upload_init(void) NONBANKED {
    __critical {
        add_VBL(bg_upload_vbl);
    }
}
