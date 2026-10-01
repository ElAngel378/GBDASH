#pragma bank 39
#include <gbdk/incbin.h>

// Columns 512.. of baseafterbase (read through baseafterbase_map's address)
INCBIN(baseafterbase_map_1, "levels/level_data/baseafterbase_16high_1.bin")
INCBIN_EXTERN(baseafterbase_map_1)
