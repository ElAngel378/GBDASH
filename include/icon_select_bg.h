#ifndef ICON_SELECT_BG_H
#define ICON_SELECT_BG_H

#include <stdint.h>
#include <gbdk/platform.h>

#define ICON_SELECT_BG_TILE_COUNT 148
#define ICON_SELECT_BG_MAP_WIDTH 20
#define ICON_SELECT_BG_MAP_HEIGHT 18
#define ICON_SELECT_SPR_TILE_COUNT 5

BANKREF_EXTERN(icon_select_bg)
extern const uint8_t icon_select_bg_tiles[];
extern const uint8_t icon_select_bg_map[];
extern const uint8_t icon_select_bg_attrmap[];
extern const uint8_t icon_select_spr_tiles[];

#endif // ICON_SELECT_BG_H
