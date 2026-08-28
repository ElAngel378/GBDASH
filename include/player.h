#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>
#include "collision.h"

#define PLAYER_SCREEN_X   32
#define PLAYER_SIZE       15    // Box size for wall/floor collision
#define PLAYER_HBOX       6     // Inset for spike/hazard collision

// Physics constants using 8.8 fixed-point (256 units = 1 pixel)
#define GRAVITY           107   // Famidash 0x006B (60fps)
#define JUMP_FORCE       -1424  // Famidash 0xFA70 (60fps)
#define MAGENTA_JUMP_FORCE -976  // Famidash 0xFC30 (Pink Orb 60fps)
#define PAD_JUMP_FORCE   -1984  // Famidash 0xF840 (Yellow Pad 60fps)
#define PINK_PAD_FORCE    -1296  // Famidash 0xFAF0 (60fps)
#define BLUE_PAD_FORCE     928   // Famidash 0x03A0 (60fps)
#define BLUE_ORB_FORCE     416   // Famidash 0x01A0 (60fps) - ONLY for Ball!
#define MAX_FALL_SPEED    1536  // Famidash 0x0600

// Ball specific orb/pad forces
#define BALL_YELLOW_ORB   -1040 // Famidash -243.75
#define BALL_PINK_ORB     -816  // Famidash -191.25
#define BALL_YELLOW_PAD   -1264 // Famidash -296.25
#define BALL_PINK_PAD     -864  // Famidash -202.5

#define MODE_CUBE         0
#define MODE_SHIP         1
#define MODE_BALL         2
#define MODE_UFO          3

#define SHIP_THRUST       -42   // Famidash 0x002A (60fps)
#define SHIP_GRAVITY       34   // Famidash 0x0022 (60fps)
#define SHIP_MAX_VEL_UP    873  // Famidash 0x0369
#define SHIP_MAX_VEL_DOWN  1091 // Famidash 0x0443

#define BALL_GRAVITY      71    // Famidash 0x0047 (60fps)
#define BALL_SWITCH_VEL   512   // Famidash 0x0200 (60fps)

#define MAX_ACTIVATIONS 8

typedef union {
    uint16_t w;
    struct {
        uint8_t l;
        uint8_t h;
    } b;
} fixed16_t;

typedef union {
    int16_t w;
    struct {
        uint8_t l;
        int8_t h;
    } b;
} sfixed16_t;

typedef struct {
    uint16_t mx;
    uint8_t my;
} ActivatedTile;

typedef struct Player {
    uint16_t world_x;
    fixed16_t world_y; // 8.8 fixed point
    sfixed16_t vel_y;   // 8.8 fixed point
    uint8_t  on_ground;
    uint8_t  dead;
    uint8_t  gravity_flipped;
    uint8_t  mode;
    uint8_t  reversed;
    uint8_t  anim_frame;
    uint16_t anim_timer;
    uint8_t  last_joy;
    uint8_t  ball_switched;
    uint8_t  orb_buffered;
    uint8_t  touching_orb;
    uint8_t  level_complete;
    uint16_t level_end_x;
    uint8_t  exit_timer;
    uint16_t sp_idx;
} Player;

extern uint8_t player_noclip;

// Reset player state to starting position
void player_init(Player* p, uint16_t start_x, int16_t start_y);

uint8_t player_update(
    Player* p,
    uint8_t joy,
    const uint8_t* collision_columns,
    uint16_t map_h
);

// Returns player's Y position relative to the camera
int16_t player_screen_y(const Player* p, uint16_t cam_py);

uint8_t player_tile_activated(const Player* p, uint16_t mx, uint8_t my);
void player_mark_activated(Player* p, uint16_t mx, uint8_t my);

#endif // PLAYER_H
