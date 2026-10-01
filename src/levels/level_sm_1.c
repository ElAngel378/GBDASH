#pragma bank 31
#include <gbdk/incbin.h>

// Columns 512.. of stereomadness (read through stereomadness_map's address)
INCBIN(stereomadness_map_1, "levels/level_data/stereomadness_16high_1.bin")
INCBIN_EXTERN(stereomadness_map_1)
