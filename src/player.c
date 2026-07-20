#pragma bank 1

#include "player.h"

BANKREF(player_update)

uint8_t player_noclip = 0;

void player_init(Player *p, uint16_t start_x, int16_t start_y) __banked {
    p->world_x = start_x;
    p->world_y = start_y;
    p->vel_y = 0;
    p->on_ground = 0;
    p->dead = 0;
    p->anim_timer = 0;
    p->anim_frame = 0;
    p->gravity_flipped = 0;
    p->mode = MODE_CUBE;
}

int16_t player_screen_y(const Player *p, uint16_t cam_y) __banked {
    return (int16_t)p->world_y - (int16_t)cam_y;
}

uint8_t player_update(
    Player *p,
    uint8_t joy,
    const uint8_t *map,
    uint16_t map_w,
    uint16_t map_h,
    uint8_t  map_bank
) __banked {
    if (p->dead) return 1;

    // Ship Physics
    if (p->mode == MODE_SHIP) {
        if (joy & J_A) {
            p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
        } else {
            p->vel_y += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
        }
        if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
        if (p->vel_y < -SHIP_MAX_VEL) p->vel_y = -SHIP_MAX_VEL;
    } else {
        // Cube Physics
        if (!p->on_ground) {
            if (p->gravity_flipped) {
                p->vel_y -= GRAVITY;
                if (p->vel_y < -MAX_FALL_SPEED) p->vel_y = -MAX_FALL_SPEED;
            } else {
                p->vel_y += GRAVITY;
                if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
            }
        }
    }

    // Noclip handling
    if (player_noclip) {
        if (joy & J_A) p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->world_y += (int8_t)(p->vel_y >> 4);
        return 0;
    }

    // Jump input for cube only
    if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
        p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->on_ground = 0;
    }

    // Check frontal collision for death before vertical snap to fix 1-tile wall bug.
    // Using col_at (Bank 0) is required here because player_update is in Bank 1.
    uint8_t front_mid = col_at(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h, map_bank);

    if (IS_SOLID(front_mid)) {
        p->dead = 1;
        return 1;
    }

    // Calculate vertical movement
    int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
    int8_t pixels = (int8_t)(effective_vel >> 4);
    if (p->gravity_flipped) pixels = -pixels;
    int16_t ny = p->world_y + pixels;
    p->on_ground = 0;

    // Vertical Collision logic
    int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
    int16_t check_y_head = (p->gravity_flipped) ? ny + PLAYER_SIZE : ny;

    // Check for "Ground" (Foot direction)
    uint8_t cl = col_at(p->world_x + 2, check_y_foot, map, map_w, map_h, map_bank);
    uint8_t cr = col_at(p->world_x + PLAYER_SIZE - 2, check_y_foot, map, map_w, map_h, map_bank);

    uint8_t falling = (p->gravity_flipped) ? (pixels <= 0) : (pixels >= 0);

    if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
        if (p->gravity_flipped) {
            p->world_y = ((ny >> 4) + 1) << 4;
        } else {
            p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
        }
        p->vel_y = 0;
        p->on_ground = 1;
    } else {
        // Ceiling check
        uint8_t hl = col_at(p->world_x + 2, check_y_head, map, map_w, map_h, map_bank);
        uint8_t hr = col_at(p->world_x + PLAYER_SIZE - 2, check_y_head, map, map_w, map_h, map_bank);
        if (IS_SOLID(hl) || IS_SOLID(hr)) {
            if (p->gravity_flipped) {
                p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
            } else {
                p->world_y = ((ny >> 4) + 1) << 4;
            }
            p->vel_y = 0;
        } else {
            p->world_y = ny;

            // Sticky ground check
            int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
            uint8_t gl = col_at(p->world_x + 2, sticky_y, map, map_w, map_h, map_bank);
            uint8_t gr = col_at(p->world_x + PLAYER_SIZE - 2, sticky_y, map, map_w, map_h, map_bank);
            if (IS_SOLID(gl) || IS_SOLID(gr)) {
                p->on_ground = 1;
                // Don't zero velocity in ship
                if (p->mode == MODE_CUBE) p->vel_y = 0;
                else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
                else { if (p->vel_y > 0) p->vel_y = 0; }
            }
        }
    }

    // Recalculate frontal points at NEW position for Orbs, Pads, and Hazards
    uint8_t front_head = col_at(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_HBOX, map, map_w, map_h, map_bank);
    uint8_t front_foot = col_at(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h, map_bank);

    // Hazard Collision box
    uint8_t hz_tl = col_at(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h, map_bank);
    uint8_t hz_tr = col_at(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h, map_bank);
    uint8_t hz_bl = col_at(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h, map_bank);
    uint8_t hz_br = col_at(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h, map_bank);

    // Orbs and Pads logic
    uint8_t mid = col_at(p->world_x + 8, p->world_y + 8, map, map_w, map_h, map_bank);

    if (IS_PAD(mid) || IS_PAD(front_head) || IS_PAD(front_foot)) {
        uint8_t hit = (IS_PAD(mid)) ? mid : (IS_PAD(front_head) ? front_head : front_foot);
        if (hit == COL_PAD_BLUE) {
            p->gravity_flipped = !p->gravity_flipped;
            p->vel_y = (p->gravity_flipped) ? -20 : 20;
        } else {
            p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
        }
        p->on_ground = 0;
    } else if ((joy & J_A) && (IS_ORB(mid) || IS_ORB(front_head) || IS_ORB(front_foot))) {
        uint8_t hit = (IS_ORB(mid)) ? mid : (IS_ORB(front_head) ? front_head : front_foot);
        if (hit == COL_ORB_MAGENTA) {
            p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
        } else if (hit == COL_ORB_BLUE) {
            p->gravity_flipped = !p->gravity_flipped;
            p->vel_y = (p->gravity_flipped) ? -20 : 20;
        } else {
            p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        }
        p->on_ground = 0;
    }

    // Death logic
    if (IS_SOLID(front_head) || IS_SOLID(front_foot) ||
        IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
        p->dead = 1;
        return 1;
    }

    // Cube animation (1.7 frames per step)
    if (p->on_ground) {
        p->anim_timer = 0;
        p->anim_frame = 0;
    } else {
        p->anim_timer += 17;
        if (p->anim_timer >= 17) {
            p->anim_timer -= 17;
            p->anim_frame++;
            if (p->anim_frame >= 24) p->anim_frame = 0;
        }
    }

    // Out of bounds
    if (p->world_y > (int16_t)((uint16_t)map_h << 4) || p->world_y < -32) {
        p->dead = 1;
        return 1;
    }

    return 0;
}
