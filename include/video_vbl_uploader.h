#ifndef VIDEO_VBL_UPLOADER_H
#define VIDEO_VBL_UPLOADER_H

#include <stdint.h>

// Queue a 64-byte background map column for upload during VBlank.
// bx is the destination X in tiles (usually ring_col << 1).
void queue_bg_column(uint8_t bx, const uint8_t *data) NONBANKED;

// Queue a chunk of tile pattern data (tiles must be copied into WRAM 'data').
// start_tile is the destination tile index (0..255), count is number of tiles.
void queue_tile_chunk(uint16_t start_tile, uint8_t count, const uint8_t *data) NONBANKED;

// Query whether a background map or tile-pattern upload is already pending.
uint8_t bg_upload_busy(void) NONBANKED;
uint8_t tile_upload_busy(void) NONBANKED;

// Initialize the VBlank uploader (register VBlank handler). Call from init code.
void bg_upload_init(void) NONBANKED;

#endif // VIDEO_VBL_UPLOADER_H
