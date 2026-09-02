;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_noclip
	.globl _player_init
	.globl _player_screen_y
	.globl _player_update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_player_noclip::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/player.c:13: void player_init(Player* p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init::
	dec	sp
	dec	sp
;src/player.c:14: p->world_x = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:15: p->world_y.w = (uint16_t)start_y << 8;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/player.c:16: p->vel_y.w = 0;
	ld	hl, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:17: p->on_ground = 0;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;src/player.c:18: p->dead = 0;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->anim_timer = 0;
	ld	hl, #0x000c
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:20: p->anim_frame = 0;
	ld	hl, #0x000b
	add	hl, de
	ld	(hl), #0x00
;src/player.c:21: p->gravity_flipped = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x00
;src/player.c:22: p->mode = MODE_CUBE;
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/player.c:23: p->reversed = 0;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/player.c:24: p->last_joy = 0;
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x00
;src/player.c:25: p->ball_switched = 0;
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x00
;src/player.c:26: p->touching_orb = 0;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;src/player.c:27: p->level_complete = 0;
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x00
;src/player.c:28: p->sp_idx = 0;
	ld	hl, #0x0015
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:29: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
_mod6_table:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
;src/player.c:31: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:32: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:33: }
	ret
;src/player.c:40: static uint8_t hazard_kills(const Player* p, uint8_t col, uint8_t x_off) {
;	---------------------------------
; Function hazard_kills
; ---------------------------------
_hazard_kills:
;src/player.c:44: if (!IS_HAZARD(col)) return 0;
	ld	c, a
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00199$
	xor	a, a
00199$:
	ld	b, a
	ld	a,c
	cp	a,#0x08
	jr	Z, 00102$
	cp	a,#0x03
	jr	Z, 00102$
	sub	a, #0x04
	jr	Z, 00102$
	ld	a, b
	or	a, a
	jr	NZ, 00102$
	ld	a, c
	dec	a
	jr	Z, 00102$
	ld	a,c
	cp	a,#0x10
	jr	Z, 00102$
	sub	a, #0x11
	jr	Z, 00102$
	xor	a, a
	jr	00119$
00102$:
;src/player.c:46: if (col == COL_DEATH_LEFT || col == COL_DEATH_RIGHT) {
	ld	a, b
	or	a, a
	jr	NZ, 00116$
	dec	c
	jr	NZ, 00117$
00116$:
;src/player.c:47: inner_x = (uint8_t)(p->world_x + x_off) & 0x0F;
	ld	a, (de)
	ldhl	sp,	#2
	add	a, (hl)
	and	a, #0x0f
	ld	c, a
;src/player.c:48: deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
	ld	hl, #0x000a
	add	hl, de
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	e, a
;src/player.c:50: if (inner_x >= 8) return 0; // deadly zone: left half only
	ld	a, c
	sub	a, #0x08
	ld	a, #0x00
	rla
	ld	c, a
;src/player.c:48: deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
	ld	a, b
;src/player.c:49: if (deadly_left) {
	xor	a,e
	jr	Z, 00114$
;src/player.c:50: if (inner_x >= 8) return 0; // deadly zone: left half only
	bit	0, c
	jr	NZ, 00117$
	xor	a, a
	jr	00119$
00114$:
;src/player.c:52: if (inner_x < 8) return 0;  // deadly zone: right half only
	ld	a, c
	or	a, a
	jr	Z, 00117$
	xor	a, a
	jr	00119$
00117$:
;src/player.c:55: return 1;
	ld	a, #0x01
00119$:
;src/player.c:56: }
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:58: static inline uint8_t inline_col_at(const uint8_t* col_ptr, int16_t y) {
;	---------------------------------
; Function inline_col_at
; ---------------------------------
_inline_col_at:
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	or	a, a
	jr	Z, 00102$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	bit	7, b
	jr	Z, 00124$
	xor	a, a
	ret
00124$:
	ld	a, #0x07
	ret
00102$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00120$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00121$
	xor	a, a
	ret
00120$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00117$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00121$
	xor	a, a
	ret
00117$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00114$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00108$
	xor	a, a
	ret
00108$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	ret
00114$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00121$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00110$
	xor	a, a
	ret
00110$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	ret
00121$:
;src/player.c:77: return col;
	ld	a, b
;src/player.c:78: }
	ret
;src/player.c:82: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-31
	ldhl	sp,	#29
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:88: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00558$
00102$:
;src/player.c:89: if (p->level_complete) return 0;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00104$
	xor	a, a
	jp	00558$
00104$:
;src/player.c:94: if (p->mode == MODE_SHIP) {
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:96: if (joy & J_A) {
	ldhl	sp,	#28
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:97: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/player.c:101: p->vel_y.w += accel;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:164: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src/player.c:94: if (p->mode == MODE_SHIP) {
	ld	a, c
;src/player.c:96: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:97: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, b
	or	a, a
	ld	a, #0x2a
	jr	NZ, 00561$
	ld	a, #0xd6
00561$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:99: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, b
	or	a, a
	ld	a, #0xde
	jr	NZ, 00563$
	ld	a, #0x22
00563$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:101: p->vel_y.w += accel;
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:104: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
;src/player.c:101: p->vel_y.w += accel;
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
;src/player.c:105: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	ld	h, a
;src/player.c:104: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:105: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	ld	a, b
	sub	a, #0x97
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x7c
	jr	NC, 00109$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x97
	ld	(hl+), a
	ld	(hl), #0xfc
00109$:
;src/player.c:106: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	e, h
	ld	d, #0x04
	ld	a, #0x43
	cp	a, l
	ld	a, #0x04
	sbc	a, h
	bit	7, e
	jr	Z, 02266$
	bit	7, d
	jr	NZ, 02267$
	cp	a, a
	jr	02267$
02266$:
	bit	7, d
	jr	Z, 02267$
	scf
02267$:
	jp	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x43
	ld	(hl+), a
	ld	(hl), #0x04
	jp	00128$
00117$:
;src/player.c:108: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ld	e, h
	ld	d, #0x03
	ld	a, #0x69
	cp	a, b
	ld	a, #0x03
	sbc	a, h
	bit	7, e
	jr	Z, 02268$
	bit	7, d
	jr	NZ, 02269$
	cp	a, a
	jr	02269$
02268$:
	bit	7, d
	jr	Z, 02269$
	scf
02269$:
	jr	NC, 00113$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:109: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0xbd
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7b
	jp	NC, 00128$
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, #0xbd
	ld	(hl+), a
	ld	(hl), #0xfb
	jp	00128$
00127$:
;src/player.c:112: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ld	a, c
	sub	a, #0x02
	ld	a, #0x47
	jr	Z, 00565$
	ld	a, #0x6b
00565$:
	ldhl	sp,	#26
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:114: p->vel_y.w -= gravity_val;
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, (hl)
;src/player.c:113: if (p->gravity_flipped) {
	inc	b
	dec	b
	jr	Z, 00124$
;src/player.c:114: p->vel_y.w -= gravity_val;
	inc	hl
	ld	e, a
	ld	d, c
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, a
	ld	b, e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/player.c:115: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00128$
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00128$
00124$:
;src/player.c:117: p->vel_y.w += gravity_val;
	ld	e, a
	ld	d, c
	ldhl	sp,	#26
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	b, l
	ld	c, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/player.c:118: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	e, b
	ld	d, #0x06
	xor	a, a
	cp	a, c
	ld	a, #0x06
	sbc	a, b
	bit	7, e
	jr	Z, 02272$
	bit	7, d
	jr	NZ, 02273$
	cp	a, a
	jr	02273$
02272$:
	bit	7, d
	jr	Z, 02273$
	scf
02273$:
	jr	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:123: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00130$
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	bit	4, a
	jr	NZ, 00130$
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00130$
;src/player.c:124: p->orb_buffered = 1;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x01
00130$:
;src/player.c:129: p->world_y.w += p->vel_y.w;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:127: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00136$
;src/player.c:128: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00134$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00566$
	ld	bc, #0x0590
	jr	00567$
00566$:
	ld	bc, #0xfa70
00567$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00134$:
;src/player.c:129: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:130: return 0;
	xor	a, a
	jp	00558$
00136$:
;src/player.c:136: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:141: uint8_t py = p->world_y.b.h;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#23
	ld	(hl), a
;src/player.c:142: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#15
;src/player.c:143: const uint8_t* c1 = collision_columns + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src/player.c:144: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:145: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#18
	ld	(hl), a
;src/player.c:123: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
;src/player.c:150: p->on_ground = 0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:154: if (p->vel_y.w >= 0) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	NZ, 00161$
;src/player.c:155: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	b, #0x00
	add	a, #0x0f
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ld	(hl), c
	inc	hl
;src/player.c:156: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), foot_y);
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, b
	or	a, a
	jr	Z, 00251$
	ld	a, #0x07
	jr	00271$
00251$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:156: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), foot_y);
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00269$
	ld	a, c
	sub	a, #0x08
	jr	C, 00270$
	xor	a, a
	jr	00271$
00269$:
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00267$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00270$
	xor	a, a
	jr	00271$
00267$:
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00265$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00259$
	xor	a, a
	jr	00271$
00259$:
	ld	a, #0x08
	jr	00271$
00265$:
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00270$
	ld	a, c
	sub	a, #0x08
	jr	C, 00262$
	xor	a, a
	jr	00271$
00262$:
	ld	a, #0x08
	jr	00271$
00270$:
	ld	a, b
00271$:
	ld	b, a
;src/player.c:157: if (!IS_SOLID(hit_col)) {
	cp	a, #0x07
	jp	Z, 00143$
	cp	a, #0x09
	jp	Z, 00143$
	cp	a, #0x05
	jp	Z, 00143$
	sub	a, #0x06
	jp	Z, 00143$
;src/player.c:158: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), foot_y);
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x07
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00572$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00573$
00572$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00573$:
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	or	a, a
	jr	Z, 00273$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ld	a, #0x07
	jr	00293$
00273$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00291$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00292$
	xor	a, a
	jr	00293$
00291$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00289$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00292$
	xor	a, a
	jr	00293$
00289$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00287$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00281$
	xor	a, a
	jr	00293$
00281$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00293$
00287$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00292$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00284$
	xor	a, a
	jr	00293$
00284$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00293$
00292$:
;src/player.c:77: return col;
	ld	a, b
;src/player.c:158: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), foot_y);
00293$:
	ld	b, a
;src/player.c:159: if (!IS_SOLID(hit_col)) {
	cp	a, #0x07
	jp	Z, 00143$
	cp	a, #0x09
	jp	Z, 00143$
	cp	a, #0x05
	jp	Z, 00143$
	sub	a, #0x06
	jp	Z, 00143$
;src/player.c:160: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), foot_y);
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x0f
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00576$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00577$
00576$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00577$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	or	a, a
	jr	Z, 00295$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ld	a, #0x07
	jr	00315$
00295$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00313$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00314$
	xor	a, a
	jr	00315$
00313$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00311$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00314$
	xor	a, a
	jr	00315$
00311$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00309$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00303$
	xor	a, a
	jr	00315$
00303$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00315$
00309$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00314$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00306$
	xor	a, a
	jr	00315$
00306$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00315$
00314$:
;src/player.c:77: return col;
	ld	a, b
;src/player.c:160: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), foot_y);
00315$:
	ld	b, a
00143$:
;src/player.c:163: if (IS_SOLID(hit_col)) {
	ld	a,b
	cp	a,#0x07
	jr	Z, 00155$
	cp	a,#0x09
	jr	Z, 00155$
	cp	a,#0x05
	jr	Z, 00155$
	sub	a, #0x06
	jr	NZ, 00161$
00155$:
;src/player.c:164: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00152$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00161$
00152$:
;src/player.c:166: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ldhl	sp,	#24
	ld	a, (hl)
	and	a, #0xf0
	ld	c, a
;src/player.c:165: if (hit_col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00148$
;src/player.c:166: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf8
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00149$
00148$:
;src/player.c:168: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf0
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00149$:
;src/player.c:170: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:171: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:172: if (!p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00161$
;src/player.c:173: p->on_ground = 1;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:174: p->orb_buffered = 0;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00161$:
;src/player.c:181: if (p->vel_y.w < 0) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	Z, 00186$
;src/player.c:182: int16_t head_y = py;
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:183: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), head_y);
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ld	c, b
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:183: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), head_y);
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00335$
	ld	a, c
	sub	a, #0x08
	jr	C, 00336$
	xor	a, a
	jr	00337$
00335$:
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00333$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00336$
	xor	a, a
	jr	00337$
00333$:
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00331$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00325$
	xor	a, a
	jr	00337$
00325$:
	ld	a, #0x08
	jr	00337$
00331$:
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00336$
	ld	a, c
	sub	a, #0x08
	jr	C, 00328$
	xor	a, a
	jr	00337$
00328$:
	ld	a, #0x08
	jr	00337$
00336$:
	ld	a, e
00337$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:184: if (!IS_SOLID(hit_col)) {
	cp	a, #0x07
	jp	Z, 00168$
	cp	a, #0x09
	jp	Z, 00168$
	cp	a, #0x05
	jp	Z, 00168$
	sub	a, #0x06
	jp	Z, 00168$
;src/player.c:185: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), head_y);
	ld	a, #0x07
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00584$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00585$
00584$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00585$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ld	c, b
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00357$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00358$
	xor	a, a
	jr	00359$
00357$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00355$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00358$
	xor	a, a
	jr	00359$
00355$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00353$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00347$
	xor	a, a
	jr	00359$
00347$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00359$
00353$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00358$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00350$
	xor	a, a
	jr	00359$
00350$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00359$
00358$:
;src/player.c:77: return col;
	ld	a, e
;src/player.c:185: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), head_y);
00359$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:186: if (!IS_SOLID(hit_col)) {
	cp	a, #0x07
	jr	Z, 00168$
	cp	a, #0x09
	jr	Z, 00168$
	cp	a, #0x05
	jr	Z, 00168$
	sub	a, #0x06
	jr	Z, 00168$
;src/player.c:187: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), head_y);
	ld	a, #0x0f
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00588$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00589$
00588$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00589$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, b
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, b
	and	a, #0x0f
	ld	b, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00379$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00380$
	xor	a, a
	jr	00381$
00379$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00377$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00380$
	xor	a, a
	jr	00381$
00377$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, c
	sub	a, #0x10
	jr	NZ, 00375$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00369$
	xor	a, a
	jr	00381$
00369$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00381$
00375$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, c
	sub	a, #0x11
	jr	NZ, 00380$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00372$
	xor	a, a
	jr	00381$
00372$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00381$
00380$:
;src/player.c:77: return col;
	ld	a, c
;src/player.c:187: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), head_y);
00381$:
	ldhl	sp,	#26
	ld	(hl), a
00168$:
;src/player.c:190: if (IS_SOLID(hit_col)) {
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00180$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00180$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00180$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00186$
00180$:
;src/player.c:191: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00177$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00186$
00177$:
;src/player.c:193: p->world_y.b.h = (head_y & ~15) + 8;
	ldhl	sp,	#27
;src/player.c:192: if (hit_col == COL_TOP) {
	ld	a, (hl-)
	and	a, #0xf0
	ld	c, a
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00173$
;src/player.c:193: p->world_y.b.h = (head_y & ~15) + 8;
	ld	a, c
	add	a, #0x08
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00174$
00173$:
;src/player.c:195: p->world_y.b.h = (head_y & ~15) + 16;
	ld	a, c
	add	a, #0x10
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00174$:
;src/player.c:197: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:198: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:199: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00186$
;src/player.c:200: p->on_ground = 1;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:201: p->orb_buffered = 0;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00186$:
;src/player.c:208: if (!p->on_ground && p->mode != MODE_SHIP) {
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00203$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jp	Z, 00203$
;src/player.c:209: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:141: uint8_t py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;src/player.c:209: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	e, a
	ld	d, #0x00
	ld	a, c
	or	a, a
	jr	Z, 00592$
	dec	de
	jr	00593$
00592$:
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00593$:
	ldhl	sp,	#21
	ld	a, e
	ld	(hl+), a
;src/player.c:210: uint8_t stick_col = COL_AT_PTR(GET_COL_FAST(0), sticky_y);
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, b
	or	a, a
	jr	Z, 00383$
	bit	7, b
	jr	Z, 00596$
	xor	a, a
	jr	00597$
00596$:
	ld	a, #0x07
00597$:
	ldhl	sp,	#26
	ld	(hl), a
	jr	00403$
00383$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:210: uint8_t stick_col = COL_AT_PTR(GET_COL_FAST(0), sticky_y);
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00401$
	ld	a, c
	sub	a, #0x08
	jr	C, 00402$
	ldhl	sp,	#26
	ld	(hl), #0x00
	jr	00403$
00401$:
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00399$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00402$
	ldhl	sp,	#26
	ld	(hl), #0x00
	jr	00403$
00399$:
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00397$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00391$
	ldhl	sp,	#26
	ld	(hl), #0x00
	jr	00403$
00391$:
	ldhl	sp,	#26
	ld	(hl), #0x08
	jr	00403$
00397$:
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00402$
	ld	a, c
	sub	a, #0x08
	jr	C, 00394$
	ldhl	sp,	#26
	ld	(hl), #0x00
	jr	00403$
00394$:
	ldhl	sp,	#26
	ld	(hl), #0x08
	jr	00403$
00402$:
	ldhl	sp,	#26
	ld	(hl), b
00403$:
	ldhl	sp,	#26
	ld	a, (hl+)
;src/player.c:211: if (!IS_SOLID(stick_col)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x07
	jp	Z, 00193$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00193$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00193$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00193$
;src/player.c:212: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), sticky_y);
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, #0x07
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00598$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jr	00599$
00598$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00599$:
	ldhl	sp,	#23
	ld	a, c
	ld	(hl+), a
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	a, (hl)
	or	a, a
	jr	Z, 00405$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ldhl	sp,	#26
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00600$
	xor	a, a
	jp	00425$
00600$:
	ld	a, #0x07
	jr	00425$
00405$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ldhl	sp,	#26
	ld	a, (hl-)
	ld	(hl), a
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl+)
	inc	hl
	swap	a
	and	a, #0x0f
	ld	(hl), a
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#23
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_famidash_metatile_collision
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl)
	and	a, #0x0f
	ld	b, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00423$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00424$
	xor	a, a
	jr	00425$
00423$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00421$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00424$
	xor	a, a
	jr	00425$
00421$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, c
	sub	a, #0x10
	jr	NZ, 00419$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00413$
	xor	a, a
	jr	00425$
00413$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00425$
00419$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, c
	sub	a, #0x11
	jr	NZ, 00424$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00416$
	xor	a, a
	jr	00425$
00416$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00425$
00424$:
;src/player.c:77: return col;
	ld	a, c
;src/player.c:212: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), sticky_y);
00425$:
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:213: if (!IS_SOLID(stick_col)) {
	cp	a, #0x07
	jp	Z, 00193$
	cp	a, #0x09
	jp	Z, 00193$
	cp	a, #0x05
	jp	Z, 00193$
	sub	a, #0x06
	jp	Z, 00193$
;src/player.c:214: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), sticky_y);
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x0f
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00602$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00603$
00602$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00603$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	or	a, a
	jr	Z, 00427$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	bit	7, b
	jr	Z, 00604$
	xor	a, a
	jr	00447$
00604$:
	ld	a, #0x07
	jr	00447$
00427$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00445$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00446$
	xor	a, a
	jr	00447$
00445$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00443$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00446$
	xor	a, a
	jr	00447$
00443$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, b
	sub	a, #0x10
	jr	NZ, 00441$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	NC, 00435$
	xor	a, a
	jr	00447$
00435$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00447$
00441$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00446$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, c
	sub	a, #0x08
	jr	C, 00438$
	xor	a, a
	jr	00447$
00438$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00447$
00446$:
;src/player.c:77: return col;
	ld	a, b
;src/player.c:214: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), sticky_y);
00447$:
	ldhl	sp,	#27
	ld	(hl), a
00193$:
;src/player.c:217: if (IS_SOLID(stick_col)) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00197$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00197$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00197$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00203$
00197$:
;src/player.c:218: p->on_ground = 1;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:219: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:220: p->orb_buffered = 0;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00203$:
;src/player.c:225: py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:226: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00606$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00607$
00606$:
	ld	a, #0x0e
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00608$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00609$
00608$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00609$:
00607$:
	ldhl	sp,	#25
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/player.c:227: uint8_t front_center = COL_AT_PTR(c_front, py + (PLAYER_SIZE >> 1));
	ld	b, #0x00
	ld	hl, #0x0007
	add	hl, bc
	ld	d, h
	ld	e, l
	ld	a, d
	or	a, a
	jr	Z, 00449$
	ld	a, #0x07
	jr	00469$
00449$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl-)
	swap	a
	and	a, #0x0f
	ld	e, a
	ld	d, #0x00
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ldhl	sp,	#27
	ld	a, (hl)
	and	a, #0x0f
	ld	d, a
;src/player.c:227: uint8_t front_center = COL_AT_PTR(c_front, py + (PLAYER_SIZE >> 1));
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00467$
	ld	a, d
	sub	a, #0x08
	jr	C, 00468$
	xor	a, a
	jr	00469$
00467$:
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00465$
	ld	a, d
	sub	a, #0x08
	jr	NC, 00468$
	xor	a, a
	jr	00469$
00465$:
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00463$
	ld	a, d
	sub	a, #0x08
	jr	NC, 00457$
	xor	a, a
	jr	00469$
00457$:
	ld	a, #0x08
	jr	00469$
00463$:
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00468$
	ld	a, d
	sub	a, #0x08
	jr	C, 00460$
	xor	a, a
	jr	00469$
00460$:
	ld	a, #0x08
	jr	00469$
00468$:
	ld	a, e
00469$:
;src/player.c:228: if (IS_SOLID(front_center)) {
	cp	a, #0x07
	jr	Z, 00205$
	cp	a, #0x09
	jr	Z, 00205$
	cp	a, #0x05
	jr	Z, 00205$
	sub	a, #0x06
	jr	NZ, 00206$
00205$:
;src/player.c:229: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:230: return 1;
	ld	a, #0x01
	jp	00558$
00206$:
;src/player.c:234: uint8_t hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	a, h
	ldhl	sp,	#22
	ld	(hl), e
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x06
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#26
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00612$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00613$
00612$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00613$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00471$
	ld	a, #0x07
	jr	00491$
00471$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, #<(_famidash_metatile_collision)
	add	a, (hl)
	ld	l, a
	ld	a, #>(_famidash_metatile_collision)
	adc	a, #0x00
	ld	h, a
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ldhl	sp,	#27
	ld	a, (hl)
	and	a, #0x0f
	ld	d, a
;src/player.c:234: uint8_t hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00489$
	ld	a, d
	sub	a, #0x08
	jr	C, 00490$
	xor	a, a
	jr	00491$
00489$:
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00487$
	ld	a, d
	sub	a, #0x08
	jr	NC, 00490$
	xor	a, a
	jr	00491$
00487$:
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00485$
	ld	a, d
	sub	a, #0x08
	jr	NC, 00479$
	xor	a, a
	jr	00491$
00479$:
	ld	a, #0x08
	jr	00491$
00485$:
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00490$
	ld	a, d
	sub	a, #0x08
	jr	C, 00482$
	xor	a, a
	jr	00491$
00482$:
	ld	a, #0x08
	jr	00491$
00490$:
	ld	a, e
00491$:
;src/player.c:235: if (hazard_kills(p, hz, PLAYER_HBOX)) {
	push	bc
	ld	h, #0x06
	push	hl
	inc	sp
	ldhl	sp,	#32
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	pop	bc
	or	a, a
	jr	Z, 00211$
;src/player.c:236: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:237: return 1;
	ld	a, #0x01
	jp	00558$
00211$:
;src/player.c:239: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x09
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00616$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00617$
00616$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00617$:
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ldhl	sp,	#24
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00493$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ld	a, #0x07
	jr	00513$
00493$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ldhl	sp,	#25
	ld	a, (hl)
	and	a, #0x0f
	ld	d, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00511$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	C, 00512$
	xor	a, a
	jr	00513$
00511$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00509$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	NC, 00512$
	xor	a, a
	jr	00513$
00509$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00507$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	NC, 00501$
	xor	a, a
	jr	00513$
00501$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00513$
00507$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00512$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	C, 00504$
	xor	a, a
	jr	00513$
00504$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00513$
00512$:
;src/player.c:77: return col;
	ld	a, e
;src/player.c:239: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
00513$:
;src/player.c:240: if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
	push	bc
	ld	h, #0x09
	push	hl
	inc	sp
	ldhl	sp,	#32
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	pop	bc
	or	a, a
	jr	Z, 00213$
;src/player.c:241: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:242: return 1;
	ld	a, #0x01
	jp	00558$
00213$:
;src/player.c:244: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	hl, #0x0009
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00620$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00621$
00620$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00621$:
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ldhl	sp,	#24
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00515$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ld	a, #0x07
	jr	00535$
00515$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ldhl	sp,	#24
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ldhl	sp,	#26
	ld	a, (hl)
	and	a, #0x0f
	ld	d, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, e
	sub	a, #0x05
	jr	NZ, 00533$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	C, 00534$
	xor	a, a
	jr	00535$
00533$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00531$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	NC, 00534$
	xor	a, a
	jr	00535$
00531$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, e
	sub	a, #0x10
	jr	NZ, 00529$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	NC, 00523$
	xor	a, a
	jr	00535$
00523$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00535$
00529$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, e
	sub	a, #0x11
	jr	NZ, 00534$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, d
	sub	a, #0x08
	jr	C, 00526$
	xor	a, a
	jr	00535$
00526$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00535$
00534$:
;src/player.c:77: return col;
	ld	a, e
;src/player.c:244: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
00535$:
;src/player.c:245: if (hazard_kills(p, hz, PLAYER_HBOX)) {
	push	bc
	ld	h, #0x06
	push	hl
	inc	sp
	ldhl	sp,	#32
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	pop	bc
	or	a, a
	jr	Z, 00215$
;src/player.c:246: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:247: return 1;
	ld	a, #0x01
	jp	00558$
00215$:
;src/player.c:249: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00624$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	b, (hl)
	jr	00625$
00624$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	b, (hl)
00625$:
	ldhl	sp,	#23
	ld	(hl+), a
;src/player.c:59: if ((uint16_t)y & 0xFF00) {
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	a, (hl)
	or	a, a
	jr	Z, 00537$
;src/player.c:60: return (y < 0) ? COL_NONE : COL_ALL;
	ld	a, #0x07
	jr	00557$
00537$:
;src/player.c:62: uint8_t py8 = (uint8_t)y;
	ldhl	sp,	#25
;src/player.c:63: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
	ld	a, (hl-)
	ld	b, a
	swap	a
	and	a, #0x0f
	ld	e, a
	ld	d, #0x00
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;src/player.c:64: uint8_t inner_y = py8 & 0x0F;
	ld	a, b
	and	a, #0x0f
	ld	b, a
;src/player.c:66: if (col == COL_TOP) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00555$
;src/player.c:67: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00556$
	xor	a, a
	jr	00557$
00555$:
;src/player.c:68: } else if (col == COL_BOTTOM) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00553$
;src/player.c:69: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00556$
	xor	a, a
	jr	00557$
00553$:
;src/player.c:70: } else if (col == COL_DEATH_TOP_HALF) {
	ld	a, c
	sub	a, #0x10
	jr	NZ, 00551$
;src/player.c:71: if (inner_y < 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	NC, 00545$
	xor	a, a
	jr	00557$
00545$:
;src/player.c:72: return COL_DEATH;
	ld	a, #0x08
	jr	00557$
00551$:
;src/player.c:73: } else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, c
	sub	a, #0x11
	jr	NZ, 00556$
;src/player.c:74: if (inner_y >= 8) return COL_NONE;
	ld	a, b
	sub	a, #0x08
	jr	C, 00548$
	xor	a, a
	jr	00557$
00548$:
;src/player.c:75: return COL_DEATH;
	ld	a, #0x08
	jr	00557$
00556$:
;src/player.c:77: return col;
	ld	a, c
;src/player.c:249: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
00557$:
;src/player.c:250: if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
	ld	h, #0x09
	push	hl
	inc	sp
	ldhl	sp,	#30
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00217$
;src/player.c:251: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:252: return 1;
	ld	a, #0x01
	jp	00558$
00217$:
;src/player.c:258: if (p->on_ground) {
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00227$
;src/player.c:259: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00227$
;src/player.c:260: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00222$
;src/player.c:261: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00628$
	ld	bc, #0x0590
	jr	00629$
00628$:
	ld	bc, #0xfa70
00629$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:262: p->on_ground = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00227$
00222$:
;src/player.c:263: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	sub	a, #0x02
	jr	NZ, 00227$
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00227$
;src/player.c:264: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:265: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	or	a, a
	jr	Z, 00630$
	xor	a, a
	ld	d, #0xfe
	jr	00631$
00630$:
	xor	a, a
	ld	d, #0x02
00631$:
	ldhl	sp,	#26
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:266: p->on_ground = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:267: p->ball_switched = 1;
	ld	a, #0x01
	ld	(bc), a
00227$:
;src/player.c:271: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	NZ, 00229$
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00229$:
;src/player.c:274: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:281: p->anim_timer += 20; // double speed while settling
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:274: if (p->on_ground && p->mode != MODE_BALL) {
	ld	a, c
	or	a, a
	jp	Z, 00245$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jp	Z, 00245$
;src/player.c:279: uint8_t q = (p->anim_frame < 24) ? mod6_table[p->anim_frame] : (p->anim_frame % 6);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#25
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#24
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	sub	a, #0x18
	jr	NC, 00632$
	ld	de, #_mod6_table+0
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	jr	00633$
00632$:
	ld	a, c
	ld	e, #0x06
	call	__moduchar
	ld	a, c
00633$:
	ldhl	sp,	#25
	ld	(hl), a
;src/player.c:280: if (q != 0) {
	or	a, a
	jr	Z, 00238$
;src/player.c:281: p->anim_timer += 20; // double speed while settling
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0014
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:282: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jp	C, 00246$
;src/player.c:283: p->anim_timer -= 21;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	add	a, #0xeb
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:279: uint8_t q = (p->anim_frame < 24) ? mod6_table[p->anim_frame] : (p->anim_frame % 6);
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
;src/player.c:284: if (q >= 3) {
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00233$
;src/player.c:286: p->anim_frame++;
	dec	hl
	dec	hl
	ld	a, c
	inc	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:287: if (p->anim_frame >= 24) {
	sub	a, #0x18
	jr	C, 00246$
;src/player.c:288: p->anim_frame = 0;
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:289: p->anim_timer = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00246$
00233$:
;src/player.c:293: p->anim_frame--;
	dec	c
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	jr	00246$
00238$:
;src/player.c:297: p->anim_timer = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00246$
00245$:
;src/player.c:300: p->anim_timer += 10;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:301: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jr	C, 00246$
;src/player.c:302: p->anim_timer -= 21;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	add	a, #0xeb
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:303: p->anim_frame++;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/player.c:304: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00246$
	xor	a, a
	ld	(bc), a
00246$:
;src/player.c:309: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00249$
;src/player.c:310: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:311: return 1;
	ld	a, #0x01
	jr	00558$
00249$:
;src/player.c:314: p->last_joy = joy;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#28
	ld	a, (hl)
	ld	(bc), a
;src/player.c:315: return 0;
	xor	a, a
00558$:
;src/player.c:316: }
	add	sp, #31
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
