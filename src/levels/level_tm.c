#pragma bank 50
#include <gbdk/incbin.h>

// Columns 0..511; the rest are in level_tm_1.c.. (next banks, same address)
INCBIN(timemachine_map, "levels/level_data/timemachine_16high_0.bin")
INCBIN_EXTERN(timemachine_map)
