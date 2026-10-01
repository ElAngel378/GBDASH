#pragma bank 53
#include <gbdk/incbin.h>

// Columns 512.. of cycles (read through cycles_map's address)
INCBIN(cycles_map_1, "levels/level_data/cycles_16high_1.bin")
INCBIN_EXTERN(cycles_map_1)
