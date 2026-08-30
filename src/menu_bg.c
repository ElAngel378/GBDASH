#pragma bank 21
#include <gb/gb.h>
#include <gbdk/incbin.h>

BANKREF(menu_bg)

INCBIN(menu_bg_tiles, "levels/chr_data/bg_contrasted_tiles.bin")
INCBIN(menu_bg_map, "levels/chr_data/bg_contrasted_map.bin")
INCBIN(menu_ground_tiles, "levels/chr_data/menu_ground_tiles.bin")
INCBIN(menu_ground_map, "levels/chr_data/menu_ground_map.bin")
