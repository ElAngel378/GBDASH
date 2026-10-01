#pragma bank 35
#include <gbdk/incbin.h>

// Columns 512.. of polargeist (read through polargeist_map's address)
INCBIN(polargeist_map_1, "levels/level_data/polargeist_1.bin")
INCBIN_EXTERN(polargeist_map_1)
