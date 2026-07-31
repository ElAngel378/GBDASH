#include <gb/gb.h>
#include "assets.h"
#include "player.h"

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
#define OBJ_MIRROR_PORTAL 16
#define OBJ_MIRROR_EXIT   17

void process_sp_objects(const Level* l, Player* p, uint8_t joy, uint8_t* target_bg_idx) {
    // CRITICAL: Capture pointers FROM BANK 1 before we switch banks!
    // If we switch to sp_bank first, the 'l' pointer (in Bank 1) becomes garbage.
    uint8_t sp_bank = l->sp_bank;
    if (sp_bank == 0) return;
    uint16_t map_h = l->map_height;

    const SpDef* sp_list = l->sp_list;

    uint8_t save_bank = _current_bank;
    SWITCH_ROM(sp_bank);

    const SpDef* sp_ptr = sp_list + p->sp_idx;

    uint16_t px = p->world_x;
    uint16_t py = p->world_y.b.h;

    // 1. SLIDING WINDOW OPTIMIZATION
    while (sp_ptr->c != 0xFFFF) {
        uint16_t obj_x = sp_ptr->c << 4;
        if (obj_x + 16 < px) {
            p->sp_idx++;
            sp_ptr++;
        } else {
            break;
        }
    }


// 2. PROCESS OVERLAPPING OBJECTS
    const SpDef* check_ptr = sp_ptr;
    while (check_ptr->c != 0xFFFF) {
        uint16_t obj_x = check_ptr->c << 4;
        if (obj_x > px + 160) break;

        uint8_t obj = check_ptr->obj;

        // For all other objects, only process if they are within 1 block of the player
        if (obj_x > px + 15) {
            check_ptr++;
            continue;
        }

        // Base Y coordinate
        uint16_t obj_y = (uint16_t)(map_h - 1 - check_ptr->r) << 4;

        switch (obj) {
            case OBJ_CUBE_PORTAL:
            case OBJ_SHIP_PORTAL:
                // Algebra fix: added 16 to the left side to prevent obj_y underflow
                if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
                    if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                        p->mode = (obj == OBJ_CUBE_PORTAL) ? MODE_CUBE : MODE_SHIP;
                        player_mark_activated(p, check_ptr->c, check_ptr->r);
                    }
                }
                break;

            case OBJ_GRAVITY_DOWN:
            case OBJ_GRAVITY_UP:
                if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
                    if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                        uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
                        if (p->gravity_flipped != target_flipped) {
                            p->gravity_flipped = target_flipped;
                            // Replaced 32-bit math with fast 16-bit bitwise approximation (~0.625 dampening)
                            p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
                        }
                        player_mark_activated(p, check_ptr->c, check_ptr->r);
                    }
                }
                break;

            case OBJ_PAD_YELLOW:
            case OBJ_PAD_PINK:
            case OBJ_PAD_BLUE:
            case OBJ_PAD_YELLOW_UP:
            case OBJ_PAD_BLUE_UP:
            {
                uint8_t is_ceiling_pad = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
                uint16_t pad_top = is_ceiling_pad ? obj_y : (obj_y + 8);
                uint16_t pad_bot = is_ceiling_pad ? (obj_y + 8) : (obj_y + 16);

                if (py <= pad_bot && (py + PLAYER_SIZE) >= pad_top) {
                    if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                        player_mark_activated(p, check_ptr->c, check_ptr->r);

                        if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
                            p->gravity_flipped = !p->gravity_flipped;
                            p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
                        } else if (obj == OBJ_PAD_PINK) {
                            p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
                        } else {
                            p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
                        }
                        p->on_ground = 0;
                    }
                }
                break;
            }

            case OBJ_ORB_YELLOW:
            case OBJ_ORB_PINK:
            case OBJ_ORB_BLUE:
            {
                if (joy & J_A) {
                    if (py <= obj_y + 16 && (py + PLAYER_SIZE) >= obj_y) {
                        if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                            player_mark_activated(p, check_ptr->c, check_ptr->r);

                            if (obj == OBJ_ORB_BLUE) {
                                p->gravity_flipped = !p->gravity_flipped;
                                p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
                            } else if (obj == OBJ_ORB_PINK) {
                                p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
                            } else {
                                p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 144 : JUMP_FORCE - 144;
                            }
                            p->on_ground = 0;
                        }
                    }
                }
                break;
            }

            case 100: case 101: case 102: case 103:
                // Background triggers cover the whole column, so no Y check needed.
                if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                    *target_bg_idx = obj - 100;
                    player_mark_activated(p, check_ptr->c, check_ptr->r);
                }
                break;

            case OBJ_LEVEL_END:
                // Trigger 10 blocks early (160 pixels)
                if (px >= (obj_x - 165)) {
                    p->level_complete = 1;
                }
                break;

            case OBJ_MIRROR_PORTAL:
                if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
                    if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                        p->reversed = 1;
                        player_mark_activated(p, check_ptr->c, check_ptr->r);
                    }
                }
                break;

            case OBJ_MIRROR_EXIT:
                if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
                    if (!player_tile_activated(p, check_ptr->c, check_ptr->r)) {
                        p->reversed = 0;
                        player_mark_activated(p, check_ptr->c, check_ptr->r);
                    }
                }
                break;
        }

        check_ptr++;
    }

    SWITCH_ROM(save_bank);
}
