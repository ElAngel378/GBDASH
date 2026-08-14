#include <gb/gb.h>
#include "assets.h"
#include "player.h"
#include "gameplay.h"

// ID Mappings from SP Layer
#define OBJ_CUBE_PORTAL   0
#define OBJ_SHIP_PORTAL   1
#define OBJ_ORB_BLUE      5
#define OBJ_ORB_PINK      6
#define OBJ_GRAVITY_DOWN  8
#define OBJ_GRAVITY_UP    9
#define OBJ_PAD_YELLOW    10
#define OBJ_ORB_YELLOW    11
#define OBJ_PAD_YELLOW_UP 12
#define OBJ_PAD_BLUE      13
#define OBJ_PAD_BLUE_UP   14
#define OBJ_PAD_PINK      37
#define OBJ_LEVEL_END     15
#define OBJ_MIRROR_PORTAL 126
#define OBJ_MIRROR_EXIT   121

void sp_cache_load(uint8_t sp_bank, const SpDef *sp_list, uint16_t cam_px,
                   SpCache *cache, uint16_t *stream_idx, uint16_t map_h) {
    uint8_t count = 0;
    uint8_t save_bank = _current_bank;

    if (sp_bank == 0 || sp_list == 0) return;
    SWITCH_ROM(sp_bank);
    while (count < MAX_ACTIVE_SP_OBJECTS && cache->active[count]) count++;
    while (count < MAX_ACTIVE_SP_OBJECTS && sp_list[*stream_idx].c != 0xFFFF) {
        uint16_t object_x = (uint16_t)sp_list[*stream_idx].c << 4;
        if (object_x > cam_px + 176u) break;

        cache->obj[count] = sp_list[*stream_idx].obj;
        cache->px[count] = object_x;
        cache->py[count] = (uint16_t)(map_h - 1u - sp_list[*stream_idx].r) << 4;
        cache->active[count] = 1;
        cache->activated[count] = 0;

        count++;
        (*stream_idx)++;
    }
    SWITCH_ROM(save_bank);
}