#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>
#include "collision.h"

#define PLAYER_SCREEN_X   32
#define PLAYER_SIZE       15    // Box size for wall/floor collision
#define PLAYER_HBOX       6     // Inset for spike/hazard collision

// Physics constants using 4.4 fixed-point (16 units = 1 pixel)
#define GRAVITY           10
#define JUMP_FORCE       -93
#define MAGENTA_JUMP_FORCE -60
#define PAD_JUMP_FORCE   -140
#define MAX_FALL_SPEED    112

#define MODE_CUBE         0
#define MODE_SHIP         1

#define SHIP_THRUST       -8
#define SHIP_GRAVITY       5
#define SHIP_MAX_VEL       64

typedef struct {
    uint16_t world_x;
    int16_t  world_y;
    int16_t  vel_y;
    uint8_t  on_ground;
    uint8_t  dead;
    uint8_t  gravity_flipped;
    uint8_t  mode;
    uint8_t  anim_frame;
    uint16_t anim_timer;
    uint8_t  last_joy;
    uint8_t  touching_orb;
} Player;

extern uint8_t player_noclip;

// Reset player state to starting position
void player_init(Player *p, uint16_t start_x, int16_t start_y);

uint8_t player_update(
    Player *p,
    uint8_t joy,
    const uint8_t *map,
    uint16_t map_w,
    uint16_t map_h,
    uint8_t map_bank
);

// Returns player's Y position relative to the camera
int16_t player_screen_y(const Player *p, uint16_t cam_py);

#endif // PLAYER_H
