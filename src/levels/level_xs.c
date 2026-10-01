#pragma bank 54
#include <gbdk/incbin.h>

// Columns 0..511; the rest are in level_xs_1.c.. (next banks, same address)
INCBIN(xstep_map, "levels/level_data/xstep_16high_0.bin")
INCBIN_EXTERN(xstep_map)
