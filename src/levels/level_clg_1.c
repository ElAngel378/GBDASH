#pragma bank 46
#include <gbdk/incbin.h>

// Columns 512.. of cantletgo (read through cantletgo_map's address)
INCBIN(cantletgo_map_1, "levels/level_data/cantletgo_16high_1.bin")
INCBIN_EXTERN(cantletgo_map_1)
