#pragma bank 12

#include "player.h"
#include "collision.h"

static const uint8_t mod6_table[24] = {
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5,
    0, 1, 2, 3, 4, 5
};

void player_init(Player* p, uint16_t start_x, int16_t start_y) BANKED {
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
    p->mini = 0;
    p->sp_idx = 0;
}

static uint8_t hazard_kills(const Player* p, uint8_t col, uint8_t x_off) {
    uint8_t inner_x;
    uint8_t deadly_left;

    if (!IS_HAZARD(col)) return 0;

    if (col == COL_DEATH_LEFT || col == COL_DEATH_RIGHT) {
        inner_x = (uint8_t)(p->world_x + x_off) & 0x0F;
        deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
        if (deadly_left) {
            if (inner_x >= 8) return 0;
        } else {
            if (inner_x < 8) return 0;
        }
    }
    return 1;
}

// Quadrant collision types (ids COL_QUAD_BASE..): per 8x8 quadrant solid / deadly.
// Low nibble = solid quadrants, high nibble = deadly quadrants.
// Quadrant bits: 1 = top-left, 2 = top-right, 4 = bottom-left, 8 = bottom-right.
// Same order as QUAD_TYPES in tools/famidash2gbdk.py.
static const uint8_t col_quads[COL_QUAD_COUNT] = {
    0x05, 0x0A, 0x01, 0x02, 0x04, 0x08, 0x09, 0x06, 0x07, 0x0B, 0x0D, 0x0E, // solid
    0x14, 0x28, 0x1C, 0x2C, 0x3C, 0x3C, 0xC3, 0xC3,                         // solid + spikes
    0x40, 0x80, 0x10, 0x20, 0xC0, 0x30                                      // half spikes
};
static uint8_t quad_x_flip; // 1 in mirror mode (same convention as hazard_kills)

// Collision types that depend on where inside the metatile the probe is (half blocks,
// half spikes, quadrants). Kept out of inline_col_at so its 13 inlined copies in
// player_update stay small (SDCC compiles the big inlined version very slowly).
static uint8_t col_at_partial(uint8_t col, uint8_t inner_y, uint8_t xin) {
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
    } else if ((uint8_t)(col - COL_QUAD_BASE) < COL_QUAD_COUNT) {
        uint8_t m = col_quads[(uint8_t)(col - COL_QUAD_BASE)];
        uint8_t q = 1;
        if (inner_y >= 8) q = 4;
        if ((uint8_t)((xin >> 3) ^ quad_x_flip) & 1) q <<= 1;
        if (m & q) return COL_ALL;
        if (m & (uint8_t)(q << 4)) return COL_DEATH;
        return COL_NONE;
    }
    return col;
}

// xin: x inside the 16px metatile of the probe point, (world_x + offset) & 15
static inline uint8_t inline_col_at(const uint8_t* col_ptr, int16_t y, uint8_t xin) {
    if ((uint16_t)y & 0xFF00) {
        return (y < 0) ? COL_NONE : COL_ALL;
    }
    uint8_t py8 = (uint8_t)y;
    uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
    // Fast path for the common cases (air, plain spikes, solid blocks)
    if (col < COL_TOP || col == COL_ALL) return col;
    return col_at_partial(col, py8 & 0x0F, xin);
}

// off: x offset of the probe point inside the player box
#define COL_AT(off, y) inline_col_at(GET_COL_FAST(off), (int16_t)(y), (uint8_t)(wx + (off)) & 15u)

uint8_t player_update(
        Player* p,
        uint8_t joy,
        const uint8_t* collision_columns,
        uint16_t map_h
) BANKED {
    if (p->dead) return 1;
    if (p->level_complete) return 0;

    uint8_t mini = p->mini;
    quad_x_flip = p->reversed ? 1u : 0u;

    // Acceleration & gravity
    if (p->mode == MODE_SHIP) {
        // Famidash ship_movement() 4-state model (60fps, non-mini):
        //   holding + falling  -> SHIP_GRAVITY_HOLD_FALL (52)
        //   holding + rising   -> SHIP_GRAVITY_BASE (42)
        //   release + rising   -> SHIP_GRAVITY_AFTER_HOLD (50)
        //   release + falling  -> SHIP_GRAVITY (34)
        // "falling" is motion toward the rest surface (vel_y > 0 normally,
        // vel_y < 0 when gravity_flipped). Holding always steers away from
        // the rest surface in the local gravity frame.
        uint8_t ship_falling = (p->gravity_flipped) ? (p->vel_y.w < 0) : (p->vel_y.w > 0);
        int16_t accel;
        if (joy & (J_A | J_UP)) {
            if (mini) accel = ship_falling ? -MINI_SHIP_GRAVITY_HOLD_FALL : MINI_SHIP_THRUST;
            else      accel = ship_falling ? -SHIP_GRAVITY_HOLD_FALL : SHIP_THRUST;
        } else {
            if (mini) accel = ship_falling ? MINI_SHIP_GRAVITY : MINI_SHIP_GRAVITY_AFTER_HOLD;
            else      accel = ship_falling ? SHIP_GRAVITY : SHIP_GRAVITY_AFTER_HOLD;
        }
        if (p->gravity_flipped) accel = (int16_t)-accel;
        p->vel_y.w += accel;
    } else {
        uint16_t gravity_val;
        int16_t max_fall = MAX_FALL_SPEED;
        if (p->mode == MODE_BALL) {
            gravity_val = mini ? MINI_BALL_GRAVITY : BALL_GRAVITY;
            if (mini) max_fall = MINI_BALL_MAX_FALL;
        } else {
            gravity_val = mini ? MINI_GRAVITY : GRAVITY;
        }
        if (p->gravity_flipped) {
            p->vel_y.w -= gravity_val;
            if (p->vel_y.w < -max_fall) p->vel_y.w = -max_fall;
        } else {
            p->vel_y.w += gravity_val;
            if (p->vel_y.w > max_fall) p->vel_y.w = max_fall;
        }
    }

    // Buffer jump input while airborne
    if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
        p->orb_buffered = 1;
    }

    // Movement & collision resolution
    uint16_t prev_y = p->world_y.w;
    p->world_y.w += p->vel_y.w;

    // Famidash clamps ship velocity AFTER position integration
    // (common_gravity_routine then clamp in ship_movement)
    if (p->mode == MODE_SHIP) {
        int16_t vup = mini ? MINI_SHIP_MAX_VEL_UP : SHIP_MAX_VEL_UP;
        int16_t vdown = mini ? MINI_SHIP_MAX_VEL_DOWN : SHIP_MAX_VEL_DOWN;
        if (p->gravity_flipped) {
            if (p->vel_y.w < -vup) p->vel_y.w = -vup;
            if (p->vel_y.w > vdown) p->vel_y.w = vdown;
        } else {
            if (p->vel_y.w > vup) p->vel_y.w = vup;
            if (p->vel_y.w < -vdown) p->vel_y.w = -vdown;
        }
    }

    // Out of bounds check: ceiling underflow (going above top of screen/map)
    if (p->vel_y.w < 0 && p->world_y.w > prev_y) {
        p->world_y.w = 0;
        p->dead = 1;
        return 1;
    }

    // Out of bounds check: floor overflow
    if (p->vel_y.w > 0 && p->world_y.w < prev_y) {
        p->world_y.w = 0xFF00;
        p->dead = 1;
        return 1;
    }

    uint8_t py = p->world_y.b.h;
    const uint8_t* c0 = collision_columns;
    const uint8_t* c1 = collision_columns + 16;
    uint8_t wx = (uint8_t)p->world_x;
    uint8_t x_mod_16 = wx & 0x0F;
    uint8_t threshold = 16 - x_mod_16;
    // Box: x .. x+box_r (inclusive), y+box_top .. y+box_bot-1
    uint8_t box_r   = mini ? MINI_BOX_RIGHT : PLAYER_SIZE;
    uint8_t box_top = mini ? MINI_BOX_TOP : 0;
    uint8_t box_bot = mini ? MINI_BOX_BOTTOM : 16;
    uint8_t pen_max = mini ? 3 : 6;   // max penetration still treated as landing on a front edge

#define GET_COL_FAST(off) ((off) < threshold ? c0 : c1)

    p->on_ground = 0;

    // Floor collision
    if (p->vel_y.w >= 0) {
        int16_t foot_y = py + box_bot;
        uint8_t hit_off = 0;
        uint8_t hit_col = COL_AT(0, foot_y);
        uint8_t hit_front_only = 0;
        if (!IS_SOLID(hit_col)) {
            hit_off = box_r >> 1;
            hit_col = COL_AT(box_r >> 1, foot_y);
            if (!IS_SOLID(hit_col)) {
                hit_off = box_r;
                hit_col = COL_AT(box_r, foot_y);
                if (IS_SOLID(hit_col)) hit_front_only = 1;
            }
        }
        if (IS_SOLID(hit_col)) {
            uint8_t block_top_y = (uint8_t)(foot_y & ~15);
            // A quadrant solid hit in its lower half has its top 8px lower
            if ((foot_y & 15) >= 8 && hit_col == COL_ALL && !IS_SOLID(COL_AT(hit_off, foot_y - 8))) {
                block_top_y += 8;
            }
            if (hit_front_only && ((uint8_t)(py + box_top + ((box_bot - box_top) >> 1)) >= block_top_y || (uint8_t)(foot_y - block_top_y) > pen_max)) {
                // Front edge struck wall side
            } else if (!p->gravity_flipped || p->mode == MODE_SHIP) {
                if (hit_col == COL_BOTTOM) {
                    p->world_y.b.h = block_top_y + 8 - box_bot;
                } else {
                    p->world_y.b.h = block_top_y - box_bot;
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

    // Ceiling collision
    if (p->vel_y.w < 0) {
        int16_t head_y = py + box_top;
        uint8_t hit_off = 0;
        uint8_t hit_col = COL_AT(0, head_y);
        uint8_t hit_front_only = 0;
        if (!IS_SOLID(hit_col)) {
            hit_off = box_r >> 1;
            hit_col = COL_AT(box_r >> 1, head_y);
            if (!IS_SOLID(hit_col)) {
                hit_off = box_r;
                hit_col = COL_AT(box_r, head_y);
                if (IS_SOLID(hit_col)) hit_front_only = 1;
            }
        }
        if (IS_SOLID(hit_col)) {
            uint8_t block_bottom_y = (uint8_t)((head_y & ~15) + 16);
            // A quadrant solid hit in its upper half has its bottom 8px higher
            if ((head_y & 15) < 8 && hit_col == COL_ALL && !IS_SOLID(COL_AT(hit_off, head_y + 8))) {
                block_bottom_y -= 8;
            }
            if (hit_front_only && ((uint8_t)(py + box_top + ((box_bot - box_top) >> 1)) <= block_bottom_y || (uint8_t)(block_bottom_y - head_y) > pen_max)) {
                // Front edge struck ceiling side
            } else if (p->gravity_flipped || p->mode == MODE_SHIP) {
                if (hit_col == COL_TOP) {
                    p->world_y.b.h = (head_y & ~15) + 8 - box_top;
                } else {
                    p->world_y.b.h = block_bottom_y - box_top;
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

    // Front wall collision
    py = p->world_y.b.h;
    // Famidash: mini cube probes the wall 2px above / 3px below its centre
    uint8_t front_y = mini ? ((p->mode == MODE_CUBE) ? (p->gravity_flipped ? 10 : 5) : 7) : (PLAYER_SIZE >> 1);
    uint8_t front_center = COL_AT(box_r - 1, py + front_y);
    if (IS_SOLID(front_center)) {
        p->dead = 1;
        return 1;
    }

    // Hazard collision: 4 points around the box centre
    {
        uint8_t hx0 = mini ? 3 : PLAYER_HBOX;
        uint8_t hx1 = mini ? 5 : (PLAYER_SIZE - PLAYER_HBOX);
        uint8_t hy0 = mini ? 7 : PLAYER_HBOX;
        uint8_t hy1 = mini ? 8 : (PLAYER_SIZE - PLAYER_HBOX);
        uint8_t hz = COL_AT(hx0, py + hy0);
        if (IS_HAZARD(hz) && hazard_kills(p, hz, hx0)) { p->dead = 1; return 1; }
        hz = COL_AT(hx1, py + hy0);
        if (IS_HAZARD(hz) && hazard_kills(p, hz, hx1)) { p->dead = 1; return 1; }
        hz = COL_AT(hx0, py + hy1);
        if (IS_HAZARD(hz) && hazard_kills(p, hz, hx0)) { p->dead = 1; return 1; }
        hz = COL_AT(hx1, py + hy1);
        if (IS_HAZARD(hz) && hazard_kills(p, hz, hx1)) { p->dead = 1; return 1; }
    }

    // Ground jump handling
    if (p->on_ground) {
        if (joy & J_A) {
            if (p->mode == MODE_CUBE) {
                int16_t jf = mini ? MINI_JUMP_FORCE : JUMP_FORCE;
                p->vel_y.w = (p->gravity_flipped) ? -jf : jf;
                p->on_ground = 0;
            } else if (p->mode == MODE_BALL && !p->ball_switched) {
                p->gravity_flipped = !p->gravity_flipped;
                int16_t sv = mini ? MINI_BALL_SWITCH_VEL : BALL_SWITCH_VEL;
                p->vel_y.w = (p->gravity_flipped) ? -sv : sv;
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
        uint8_t q = mod6_table[p->anim_frame];
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

    // Bottom bounds check (falling below playable map)
    if (p->world_y.b.h >= (uint8_t)((map_h << 4) - 8)) {
        p->dead = 1;
        return 1;
    }

    p->last_joy = joy;
    return 0;
}

#undef GET_COL_FAST
