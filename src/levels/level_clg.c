#pragma bank 45
#include <gbdk/incbin.h>

// Columns 0..511; the rest are in level_clg_1.c.. (next banks, same address)
INCBIN(cantletgo_map, "levels/level_data/cantletgo_16high_0.bin")
INCBIN_EXTERN(cantletgo_map)
