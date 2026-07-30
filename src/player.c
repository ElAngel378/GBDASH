#include "player.h"

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
    p->last_joy = 0;
    p->touching_orb = 0;
    p->portal_idx = 0;
    p->activated_count = 0;
    p->next_activated_slot = 0;
}

uint8_t player_tile_activated(const Player* p, uint16_t mx, uint8_t my) {
    for (uint8_t i = 0; i < p->activated_count; i++) {
        if (p->activated[i].mx == mx && p->activated[i].my == my) return 1;
    }
    return 0;
}

void player_mark_activated(Player* p, uint16_t mx, uint8_t my) {
    p->activated[p->next_activated_slot].mx = mx;
    p->activated[p->next_activated_slot].my = my;
    p->next_activated_slot++;
    if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
    if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
}

int16_t player_screen_y(const Player* p, uint16_t cam_y) {
    return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
}

uint8_t player_update(
        Player* p,
        uint8_t joy,
        const uint8_t* map,
        uint16_t map_w,
        uint16_t map_h,
        uint8_t  map_bank
) {
    if (p->dead) return 1;

    col_at_begin(map_bank);

    if (p->mode == MODE_SHIP) {
        if (joy & J_A) {
            p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
        } else {
            p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
        }
        if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
            p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
        if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
            p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
    } else {
        if (!p->on_ground) {
            if (p->gravity_flipped) {
                p->vel_y.w -= GRAVITY;
                if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
            } else {
                p->vel_y.w += GRAVITY;
                if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
            }
        }
    }

    if (player_noclip) {
        if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->world_y.w += p->vel_y.w;
        col_at_end();
        return 0;
    }

    if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
        p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
        p->on_ground = 0;
    }

    uint16_t px = p->world_x;
    uint8_t py = p->world_y.b.h;
    uint16_t mx0 = px >> 4;
    const uint8_t* c0 = &map[mx0 << 4];
    const uint8_t* c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;

    uint8_t x_mod_16 = (uint8_t)px & 0x0F;
    uint8_t threshold = 16 - x_mod_16;

#define GET_COL_FAST(off) ((off) < threshold ? c0 : c1)
#define GET_MX_FAST(off)  ((off) < threshold ? mx0 : mx0 + 1)

#define COL_AT_PTR(col, y) ( \
    (((uint16_t)(y)) & 0xFF00) ? ((((int16_t)(y)) < 0) ? COL_NONE : COL_ALL) : \
    col_at_raw_cached(col, (uint16_t)(y)) \
)

    uint8_t front_mid = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), py + 8);

    if (IS_SOLID(front_mid)) {
        p->dead = 1;
        col_at_end();
        return 1;
    }

    p->world_y.w += p->vel_y.w;
    uint8_t ny = p->world_y.b.h;
    p->on_ground = 0;

    int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
    int16_t check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);

    uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
    uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);

    uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);

    if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
        if (p->gravity_flipped) {
            py = ((ny >> 4) + 1) << 4;
        } else {
            py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
        }
        p->world_y.b.h = py;
        p->world_y.b.l = 0;
        p->vel_y.w = 0;
        p->on_ground = 1;
    }else {
        // Head / Ceiling check
        uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
        uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);

        if (IS_SOLID(hl) || IS_SOLID(hr)) {
            if (p->mode == MODE_CUBE) {
                // Cube mode: Hitting head kills player
                p->dead = 1;
                col_at_end();
                return 1;
            } else {
                // Ship mode: Solid ceiling behavior (snap position & stop vertical momentum)
                if (p->gravity_flipped) {
                    py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
                } else {
                    py = ((ny >> 4) + 1) << 4;
                }
                p->world_y.b.h = py;
                p->world_y.b.l = 0;
                p->vel_y.w = 0;
            }
        } else {
            py = ny;

            // Sticky ground check
            int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
            uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
            uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);

            if (IS_SOLID(gl) || IS_SOLID(gr)) {
                p->on_ground = 1;
                if (p->mode == MODE_CUBE) p->vel_y.w = 0;
                else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
                else { if (p->vel_y.w > 0) p->vel_y.w = 0; }
            }
        }
    }

    const uint8_t* c_front = GET_COL_FAST(PLAYER_SIZE);
    uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
    uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);

    uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
    uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
    uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
    uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);

    if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
        p->dead = 1;
        col_at_end();
        return 1;
    }

    if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
        p->dead = 1;
        col_at_end();
        return 1;
    }

    uint8_t tl = COL_AT_PTR(c0, py);
    const uint8_t* c_right = GET_COL_FAST(PLAYER_SIZE - 1);
    uint8_t tr = COL_AT_PTR(c_right, py);
    uint8_t bl = COL_AT_PTR(c0, py + PLAYER_SIZE - 1);
    uint8_t br = COL_AT_PTR(c_right, py + PLAYER_SIZE - 1);

    uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
    uint8_t pad_r = (p->gravity_flipped) ? tr : br;

    if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
        uint8_t hit;
        uint16_t hx;
        int16_t hy = (p->gravity_flipped) ? (int16_t)(p->world_y.b.h) : (int16_t)(p->world_y.b.h) + PLAYER_SIZE - 1;

        if (IS_PAD(pad_l)) { hit = pad_l; hx = px; }
        else { hit = pad_r; hx = px + PLAYER_SIZE - 1; }

        uint8_t pmx = (hx >> 4);
        uint8_t pmy = ((uint16_t)hy >> 4);

        if (!player_tile_activated(p, pmx, pmy)) {
            player_mark_activated(p, pmx, pmy);
            if (hit == COL_PAD_BLUE) {
                p->gravity_flipped = !p->gravity_flipped;
                p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
            } else if (hit == COL_PAD_MAGENTA) {
                p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
            } else {
                p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
            }
            p->on_ground = 0;
        }
    } else if (joy & J_A) {
        uint8_t omx, omy;
        uint8_t hit;

        if (IS_ORB(tl)) {
            omx = mx0; omy = py >> 4;
            if (!player_tile_activated(p, omx, omy)) {
                player_mark_activated(p, omx, omy);
                hit = tl; goto orb_hit;
            }
        }
        if (IS_ORB(tr)) {
            omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = py >> 4;
            if (!player_tile_activated(p, omx, omy)) {
                player_mark_activated(p, omx, omy);
                hit = tr; goto orb_hit;
            }
        }
        if (IS_ORB(bl)) {
            omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
            if (!player_tile_activated(p, omx, omy)) {
                player_mark_activated(p, omx, omy);
                hit = bl; goto orb_hit;
            }
        }
        if (IS_ORB(br)) {
            omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = (py + PLAYER_SIZE - 1) >> 4;
            if (!player_tile_activated(p, omx, omy)) {
                player_mark_activated(p, omx, omy);
                hit = br; goto orb_hit;
            }
        }
        goto orb_done;

        orb_hit:
        if (hit == COL_ORB_MAGENTA) {
            p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
        } else if (hit == COL_ORB_BLUE) {
            p->gravity_flipped = !p->gravity_flipped;
            p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
        } else {
            p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 144 : JUMP_FORCE - 144;
        }
        p->on_ground = 0;

        orb_done:;
    }
    col_at_end();

    if (p->on_ground) {
        p->anim_timer = 0;
        p->anim_frame = 0;
    } else {
        p->anim_timer += 10;
        if (p->anim_timer >= 20) {
            p->anim_timer -= 20;
            p->anim_frame++;
            if (p->anim_frame >= 24) p->anim_frame = 0;
        }
    }

    if (p->world_y.b.h > (map_h << 4)) {
        p->dead = 1;
        return 1;
    }

    p->last_joy = joy;
    return 0;
}