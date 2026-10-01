#pragma bank 49
#include <gbdk/incbin.h>

// Columns 512.. of jumper (read through jumper_map's address)
INCBIN(jumper_map_1, "levels/level_data/jumper_16high_1.bin")
INCBIN_EXTERN(jumper_map_1)
