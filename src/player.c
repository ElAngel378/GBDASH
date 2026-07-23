#include "player.h"

uint8_t player_noclip = 0;

void player_init(Player *p, uint16_t start_x, int16_t start_y) {
    p->world_x = start_x;
    p->world_y = start_y;
    p->vel_y = 0;
    p->on_ground = 0;
    p->dead = 0;
    p->anim_timer = 0;
    p->anim_frame = 0;
    p->gravity_flipped = 0;
    p->mode = MODE_CUBE;
    p->last_joy = 0;
    p->touching_orb = 0;
    p->activated_count = 0;
    p->next_activated_slot = 0;
}

uint8_t player_tile_activated(const Player *p, uint16_t mx, uint16_t my) {
    for (uint8_t i = 0; i < p->activated_count; i++) {
        if (p->activated[i].mx == mx && p->activated[i].my == my) return 1;
    }
    return 0;
}

void player_mark_activated(Player *p, uint16_t mx, uint16_t my) {
    p->activated[p->next_activated_slot].mx = mx;
    p->activated[p->next_activated_slot].my = my;
    p->next_activated_slot++;
    if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
    if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
}

int16_t player_screen_y(const Player *p, uint16_t cam_y) {
    return (int16_t)p->world_y - (int16_t)cam_y;
}

uint8_t player_update(
    Player *p,
    uint8_t joy,
    const uint8_t *map,
    uint16_t map_w,
    uint16_t map_h,
    uint8_t  map_bank
) {
    if (p->dead) return 1;

    col_at_begin(map_bank);

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
        col_at_end();
        return 0;
    }

    // Jump input for cube only
    if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
        p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->on_ground = 0;
    }

    // Check frontal collision for death before vertical snap to fix 1-tile wall bug.
    uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);

    if (IS_SOLID(front_mid)) {
        p->dead = 1;
        col_at_end();
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
    uint8_t cl = col_at_raw(p->world_x + 2, check_y_foot, map, map_w, map_h);
    uint8_t cr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_foot, map, map_w, map_h);

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
        uint8_t hl = col_at_raw(p->world_x + 2, check_y_head, map, map_w, map_h);
        uint8_t hr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_head, map, map_w, map_h);
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
            uint8_t gl = col_at_raw(p->world_x + 2, sticky_y, map, map_w, map_h);
            uint8_t gr = col_at_raw(p->world_x + PLAYER_SIZE - 2, sticky_y, map, map_w, map_h);
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
    uint8_t front_head = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_HBOX, map, map_w, map_h);
    uint8_t front_foot = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);

    // Hazard Collision box
    uint8_t hz_tl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
    uint8_t hz_tr = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
    uint8_t hz_bl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
    uint8_t hz_br = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);

    // --- Orbs and Pads: full 16x16 hitbox corners ---
// Full 16x16 outer corner checks (no inset)
    uint8_t tl = col_at_raw(p->world_x,                     p->world_y,                     map, map_w, map_h);
    uint8_t tr = col_at_raw(p->world_x + PLAYER_SIZE - 1, p->world_y,                     map, map_w, map_h);
    uint8_t bl = col_at_raw(p->world_x,                     p->world_y + PLAYER_SIZE - 1, map, map_w, map_h);
    uint8_t br = col_at_raw(p->world_x + PLAYER_SIZE - 1, p->world_y + PLAYER_SIZE - 1, map, map_w, map_h);

    uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
    uint8_t pad_r = (p->gravity_flipped) ? tr : br;

    // --- Pads ---
    if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
        uint8_t hit;
        uint16_t hx;
        int16_t hy = (p->gravity_flipped) ? p->world_y : (p->world_y + PLAYER_SIZE - 1);
        if (IS_PAD(pad_l)) { hit = pad_l; hx = p->world_x; }
        else               { hit = pad_r; hx = p->world_x + PLAYER_SIZE - 1; }

        uint16_t pmx = (hx >> 4);
        uint16_t pmy = ((uint16_t)hy >> 4);

        if (!player_tile_activated(p, pmx, pmy)) {
            player_mark_activated(p, pmx, pmy);
            if (hit == COL_PAD_BLUE) {
                p->gravity_flipped = !p->gravity_flipped;
                p->vel_y = (p->gravity_flipped) ? -64 : 64;
            } else {
                p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
            }
            p->on_ground = 0;
        }
    }
    // --- Orbs: check every corner independently, mark every orb tile touched ---
    else if (joy & J_A) {
        struct { uint8_t col; uint16_t x; int16_t y; } corners[4] = {
            { tl, p->world_x,                  p->world_y },
            { tr, p->world_x + PLAYER_SIZE-1, p->world_y },
            { bl, p->world_x,                  p->world_y + PLAYER_SIZE-1},
            { br, p->world_x + PLAYER_SIZE-1, p->world_y + PLAYER_SIZE-1},
        };

        for (uint8_t i = 0; i < 4; i++) {
            if (!IS_ORB(corners[i].col)) continue;

            uint16_t omx = (corners[i].x >> 4);
            uint16_t omy = ((uint16_t)corners[i].y >> 4);

            if (player_tile_activated(p, omx, omy)) continue; // already used, skip entirely

            player_mark_activated(p, omx, omy);

            uint8_t hit = corners[i].col;
            if (hit == COL_ORB_MAGENTA) {
                p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
            } else if (hit == COL_ORB_BLUE) {
                p->gravity_flipped = !p->gravity_flipped;
                p->vel_y = (p->gravity_flipped) ? -64 : 64;
            } else {
                p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE+9 : JUMP_FORCE-9;
            }
            p->on_ground = 0;
            break; // only fire once per frame even if multiple corners overlap different orbs
        }
    }

    // Death logic
    if (IS_SOLID(front_head) || IS_SOLID(front_foot) ||
        IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
        p->dead = 1;
        col_at_end();
        return 1;
    }

    col_at_end();

    // Cube animation (1.7 frames per step)
    if (p->on_ground) {
        p->anim_timer = 0;
        p->anim_frame = 0;
    } else {
        p->anim_timer += 10;
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

    p->last_joy = joy;
    return 0;
}
