#include "player.h"
#include "collision.h"

uint8_t player_noclip = 0;

static const uint8_t mod6_table[24] = {
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5
};

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

// Returns 1 if the sampled tile actually kills the player.
// Side-facing half spikes (COL_DEATH_LEFT / COL_DEATH_RIGHT) only cover
// their own half of the tile, giving them the same reduced hitbox as the
// top/bottom half spikes. On mirrored levels (reversed) the sprites are
// flipped, so the deadly half swaps sides too.
static uint8_t hazard_kills(const Player* p, uint8_t col, uint8_t x_off) {
    uint8_t inner_x;
    uint8_t deadly_left;

    if (!IS_HAZARD(col)) return 0;

    if (col == COL_DEATH_LEFT || col == COL_DEATH_RIGHT) {
        inner_x = (uint8_t)(p->world_x + x_off) & 0x0F;
        deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
        if (deadly_left) {
            if (inner_x >= 8) return 0; // deadly zone: left half only
        } else {
            if (inner_x < 8) return 0;  // deadly zone: right half only
        }
    }
    return 1;
}

static inline uint8_t inline_col_at(const uint8_t* col_ptr, int16_t y) {
    if ((uint16_t)y & 0xFF00) {
        return (y < 0) ? COL_NONE : COL_ALL;
    }
    uint8_t py8 = (uint8_t)y;
    uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
    uint8_t inner_y = py8 & 0x0F;

    if (col == COL_TOP) {
        if (inner_y >= 8) return COL_NONE;
    } else if (col == COL_BOTTOM) {
        if (inner_y < 8) return COL_NONE;
    } else if (col == COL_DEATH_TOP_HALF) {
        if (inner_y < 8) return COL_NONE;
        return COL_DEATH;
    } else if (col == COL_DEATH_BOTTOM_HALF) {
        if (inner_y >= 8) return COL_NONE;
        return COL_DEATH;
    }
    return col;
}

#define COL_AT_PTR(col, y) inline_col_at((col), (int16_t)(y))

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
    // Check Floor (only when falling or stationary, matching FamiDash)
    if (p->vel_y.w >= 0) {
        int16_t foot_y = py + PLAYER_SIZE;
        uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), foot_y);
        if (!IS_SOLID(hit_col)) {
            hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), foot_y);
            if (!IS_SOLID(hit_col)) {
                hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), foot_y);
            }
        }
        if (IS_SOLID(hit_col)) {
            if (!p->gravity_flipped || p->mode == MODE_SHIP) {
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
    }

    // Check Ceiling (only when rising, matching FamiDash)
    if (p->vel_y.w < 0) {
        int16_t head_y = py;
        uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), head_y);
        if (!IS_SOLID(hit_col)) {
            hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), head_y);
            if (!IS_SOLID(hit_col)) {
                hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), head_y);
            }
        }
        if (IS_SOLID(hit_col)) {
            if (p->gravity_flipped || p->mode == MODE_SHIP) {
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
    }

    // --- 1-Pixel Sticky Ground Check (FamiDash Hack) - Cube & Ball only ---
    if (!p->on_ground && p->mode != MODE_SHIP) {
        int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
        uint8_t stick_col = COL_AT_PTR(GET_COL_FAST(0), sticky_y);
        if (!IS_SOLID(stick_col)) {
            stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), sticky_y);
            if (!IS_SOLID(stick_col)) {
                stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), sticky_y);
            }
        }
        if (IS_SOLID(stick_col)) {
            p->on_ground = 1;
            p->vel_y.w = 0;
            p->orb_buffered = 0;
        }
    }

    // --- Wall / Front Collision (Death) — single center probe like FamiDash ---
    py = p->world_y.b.h;
    const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
    uint8_t front_center = COL_AT_PTR(c_front, py + (PLAYER_SIZE >> 1));
    if (IS_SOLID(front_center)) {
        p->dead = 1;
        return 1;
    }

    // --- Hazard Collision (Spikes) ---
    uint8_t hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
    if (hazard_kills(p, hz, PLAYER_HBOX)) {
        p->dead = 1;
        return 1;
    }
    hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
    if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
        p->dead = 1;
        return 1;
    }
    hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
    if (hazard_kills(p, hz, PLAYER_HBOX)) {
        p->dead = 1;
        return 1;
    }
    hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
    if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
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
        // Landed mid-spin: settle onto the NEAREST square side.
        // A quarter turn is 6 frames (90 deg), so the midpoint of the
        // quarter is 45 deg. Past the midpoint -> finish the spin
        // forwards; before the midpoint -> roll backwards instead.
        uint8_t q = (p->anim_frame < 24) ? mod6_table[p->anim_frame] : (p->anim_frame % 6);
        if (q != 0) {
            p->anim_timer += 20; // double speed while settling
            if (p->anim_timer >= 21) {
                p->anim_timer -= 21;
                if (q >= 3) {
                    // Forward: complete the rotation to the next square
                    p->anim_frame++;
                    if (p->anim_frame >= 24) {
                        p->anim_frame = 0;
                        p->anim_timer = 0;
                    }
                } else {
                    // Backward: un-roll to the previous square
                    p->anim_frame--;
                }
            }
        } else {
            p->anim_timer = 0;
        }
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
