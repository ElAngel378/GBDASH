#ifndef VIDEO_VBL_UPLOADER_H
#define VIDEO_VBL_UPLOADER_H

#include <stdint.h>

// Queue one complete 64-byte background column.
// The uploader writes it over multiple VBlanks.
void queue_bg_column(uint8_t bx, const uint8_t *data) NONBANKED;

// Queue a small tile-pattern chunk.
// Maximum is 4 tiles (64 bytes).
void queue_tile_chunk(uint16_t start_tile, uint8_t count,
                       const uint8_t *data) NONBANKED;

// TRUE while the background column is still being uploaded.
uint8_t bg_upload_busy(void) NONBANKED;

// TRUE while a tile-pattern chunk is waiting to be uploaded.
uint8_t tile_upload_busy(void) NONBANKED;

// Initialize the VBlank uploader.
void bg_upload_init(void) NONBANKED;

// Clear any queued/pending uploads.
// MUST be called at level start and after restarting from death.
void bg_upload_reset(void) NONBANKED;

#endif
