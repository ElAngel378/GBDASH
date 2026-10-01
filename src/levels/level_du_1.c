#pragma bank 37
#include <gbdk/incbin.h>

// Columns 512.. of dryout (read through dryout_map's address)
INCBIN(dryout_map_1, "levels/level_data/dryout_16high_1.bin")
INCBIN_EXTERN(dryout_map_1)
