#pragma bank 36
#include <gbdk/incbin.h>

// Columns 0..511; the rest are in level_du_1.c.. (next banks, same address)
INCBIN(dryout_map, "levels/level_data/dryout_16high_0.bin")
INCBIN_EXTERN(dryout_map)
