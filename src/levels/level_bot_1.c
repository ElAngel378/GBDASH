#pragma bank 33
#include <gbdk/incbin.h>

// Columns 512.. of backontrack (read through backontrack_map's address)
INCBIN(backontrack_map_1, "levels/level_data/backontrack_16high_1.bin")
INCBIN_EXTERN(backontrack_map_1)
