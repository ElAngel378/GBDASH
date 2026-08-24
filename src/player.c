#include "player.h"
#include "collision.h"

uint8_t player_noclip = 0;

void player_init(Player* p, uint16_t start_x, int16_t start_y) {
    p->world_x = start_x;
    p->world_y.w = (uint16_t)start_y << 8;
    p->vel_y.w = 0;
    p->on_ground = 0;
    p->dead = 0;
    p->anim_timer = 0;
    p->anim_frame = 0;
    p->gravity_flipped = 0;
    p->mode = MODE_CUBE;
    p->reversed = 0;
    p->last_joy = 0;
    p->ball_switched = 0;
    p->touching_orb = 0;
    p->level_complete = 0;
    p->sp_idx = 0;
}

int16_t player_screen_y(const Player* p, uint16_t cam_y) {
    return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
}

#define COL_AT_PTR(col, y) ( \
    (((uint16_t)(y)) & 0xFF00) ? ((((int16_t)(y)) < 0) ? COL_NONE : COL_ALL) : \
    col_at_raw_cached(col, (uint16_t)(y)) \
)

uint8_t player_update(
        Player* p,
        uint8_t joy,
        const uint8_t* collision_columns,
        uint16_t map_h
) {
    if (p->dead) return 1;
    if (p->level_complete) return 0;

    // --------------------------------------------------------
    // 1. PHASE 1: ACCELERATE (FamiDash Style)
    // --------------------------------------------------------
    if (p->mode == MODE_SHIP) {
        int16_t accel;
        if (joy & J_A) {
            accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
        } else {
            accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
        }
        p->vel_y.w += accel;

        // Ship Terminal Velocity
        if (p->gravity_flipped) {
            if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
            if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
        } else {
            if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
            if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
        }
    } else {
        uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
        if (p->gravity_flipped) {
            p->vel_y.w -= gravity_val;
            if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
        } else {
            p->vel_y.w += gravity_val;
            if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
        }
    }

    // Orb Buffering Logic: Only allow buffering if pressed while mid-air
    if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
        p->orb_buffered = 1;
    }

    if (player_noclip) {
        if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->world_y.w += p->vel_y.w;
        return 0;
    }

    // --------------------------------------------------------
    // 2. PHASE 2: MOVE
    // --------------------------------------------------------
    p->world_y.w += p->vel_y.w;

    // --------------------------------------------------------
    // 3. PHASE 3: EJECT (Collision Response)
    // --------------------------------------------------------
    uint8_t py = p->world_y.b.h;
    const uint8_t* c0 = collision_columns;
    const uint8_t* c1 = collision_columns + 16;
    uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
    uint8_t threshold = 16 - x_mod_16;

#define GET_COL_FAST(off) ((off) < threshold ? c0 : c1)

    p->on_ground = 0;

    // --- Vertical Ejection ---
    // Check Floor
    int16_t foot_y = py + PLAYER_SIZE;
    uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(4), foot_y);
    uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 4), foot_y);
    if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
        if (!p->gravity_flipped || p->mode == MODE_SHIP) {
            uint8_t hit_col = IS_SOLID(cl_f) ? cl_f : cr_f;
            if (hit_col == COL_BOTTOM) {
                p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
            } else {
                p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
            }
            p->world_y.b.l = 0;
            p->vel_y.w = 0;
            if (!p->gravity_flipped) {
                p->on_ground = 1;
                p->orb_buffered = 0;
            }
        }
    }

    // Check Ceiling
    int16_t head_y = py;
    uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(4), head_y);
    uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 4), head_y);
    if (IS_SOLID(cl_h) || IS_SOLID(cr_h)) {
        if (p->gravity_flipped || p->mode == MODE_SHIP) {
            uint8_t hit_col = IS_SOLID(cl_h) ? cl_h : cr_h;
            if (hit_col == COL_TOP) {
                p->world_y.b.h = (head_y & ~15) + 8;
            } else {
                p->world_y.b.h = (head_y & ~15) + 16;
            }
            p->world_y.b.l = 0;
            p->vel_y.w = 0;
            if (p->gravity_flipped) {
                p->on_ground = 1;
                p->orb_buffered = 0;
            }
        }
    }

    // --- 1-Pixel Sticky Ground Check (FamiDash Hack) ---
    if (!p->on_ground) {
        int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
        uint8_t gl = COL_AT_PTR(GET_COL_FAST(4), sticky_y);
        uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 4), sticky_y);
        if (IS_SOLID(gl) || IS_SOLID(gr)) {
            p->on_ground = 1;
            p->vel_y.w = 0;
            p->orb_buffered = 0;
        }
    }

    // --- Wall / Front Collision (Death) ---
    py = p->world_y.b.h;
    const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
    uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
    uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
    if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
        p->dead = 1;
        return 1;
    }

    // --- Hazard Collision (Spikes) ---
    uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX + 1), py + PLAYER_HBOX);
    uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX + 1), py + PLAYER_HBOX);
    uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX + 1), py + PLAYER_SIZE - PLAYER_HBOX);
    uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX + 1), py + PLAYER_SIZE - PLAYER_HBOX);
    if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
        p->dead = 1;
        return 1;
    }

    // --------------------------------------------------------
    // 4. PHASE 4: INPUT (After Eject)
    // --------------------------------------------------------
    if (p->on_ground) {
        if (joy & J_A) {
            if (p->mode == MODE_CUBE) {
                p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
                p->on_ground = 0;
            } else if (p->mode == MODE_BALL && !p->ball_switched) {
                p->gravity_flipped = !p->gravity_flipped;
                p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
                p->on_ground = 0;
                p->ball_switched = 1;
            }
        }
    }
    if (!(joy & J_A)) p->ball_switched = 0;

    // Animation Update
    if (p->on_ground && p->mode != MODE_BALL) {
        p->anim_timer = 0;
        p->anim_frame = 0;
    } else {
        p->anim_timer += 10;
        if (p->anim_timer >= 21) {
            p->anim_timer -= 21;
            p->anim_frame++;
            if (p->anim_frame >= 24) p->anim_frame = 0;
        }
    }

    // Bounds check
    if (p->world_y.b.h > (map_h << 4)) {
        p->dead = 1;
        return 1;
    }

    p->last_joy = joy;
    return 0;
}

#undef GET_COL_FAST
