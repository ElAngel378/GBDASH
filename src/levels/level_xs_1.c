#pragma bank 55
#include <gbdk/incbin.h>

// Columns 512.. of xstep (read through xstep_map's address)
INCBIN(xstep_map_1, "levels/level_data/xstep_16high_1.bin")
INCBIN_EXTERN(xstep_map_1)
