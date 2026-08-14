#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>
#include "collision.h"

#define PLAYER_SCREEN_X   32
#define PLAYER_SIZE       15    // Box size for wall/floor collision
#define PLAYER_HBOX       6     // Inset for spike/hazard collision

// Physics constants using 8.8 fixed-point (256 units = 1 pixel)
#define GRAVITY           103   // Famidash 0x006B
#define JUMP_FORCE       -1276  // Famidash 0xFA70
#define MAGENTA_JUMP_FORCE -976  // Famidash 0xFC30 (Pink Orb)
#define PAD_JUMP_FORCE   -1890  // Famidash 0xF840 (Yellow Pad)
#define PINK_PAD_FORCE    -1256  // Famidash 0xFAF0
#define BLUE_PAD_FORCE     928   // Famidash 0x03A0
#define BLUE_ORB_FORCE     416   // Famidash 0x01A0 (ORB_BALL_HEIGHT_BLUE)
#define MAX_FALL_SPEED    1536  // Famidash 0x0600

#define MODE_CUBE         0
#define MODE_SHIP         1

#define SHIP_THRUST       -52   // Famidash SHIP_GRAVITY_BASE
#define SHIP_GRAVITY       34   // Famidash SHIP_GRAVITY
#define SHIP_MAX_VEL_UP    873  // Famidash 0x0369
#define SHIP_MAX_VEL_DOWN  1091 // Famidash 0x0443

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
    uint8_t  touching_orb;
    uint8_t  level_complete;
    uint16_t level_end_x;
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
