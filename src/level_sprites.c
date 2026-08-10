#pragma bank 0

#include <gb/gb.h>

#include "assets.h"

#define LEVEL_SPRITE_LIMIT 12

uint8_t collect_level_sprites(const SpDef *sp_list, uint8_t sp_bank,
                              uint8_t start_idx, uint16_t cam_px,
                              SpDef *visible) {
    uint8_t visible_count = 0;
    uint8_t save_bank = _current_bank;

    if (sp_bank == 0) return 0;

    SWITCH_ROM(sp_bank);
    sp_list += start_idx;
    while (sp_list->c != 0xFFFF && visible_count < LEVEL_SPRITE_LIMIT) {
        uint16_t object_x = sp_list->c << 4;
        if (object_x > cam_px + 176u) break;
        if (object_x + 32u >= cam_px &&
            (sp_list->obj == 0 || sp_list->obj == 1 ||
             sp_list->obj == 5 || sp_list->obj == 6 ||
             sp_list->obj == 8 || sp_list->obj == 9 ||
             sp_list->obj == 10 || sp_list->obj == 11 ||
             sp_list->obj == 12 || sp_list->obj == 13 ||
             sp_list->obj == 14 || sp_list->obj == 37)) {
            visible[visible_count].c = sp_list->c;
            visible[visible_count].r = sp_list->r;
            visible[visible_count].obj = sp_list->obj;
            visible_count++;
        }
        sp_list++;
    }
    SWITCH_ROM(save_bank);
    return visible_count;
}
