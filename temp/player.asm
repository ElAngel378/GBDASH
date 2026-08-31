;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _col_at_raw_cached
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
;src/player.c:63: uint8_t player_update(
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
;src/player.c:69: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00249$
00102$:
;src/player.c:70: if (p->level_complete) return 0;
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
	jp	00249$
00104$:
;src/player.c:75: if (p->mode == MODE_SHIP) {
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
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
;src/player.c:77: if (joy & J_A) {
	ldhl	sp,	#28
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:78: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/player.c:82: p->vel_y.w += accel;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
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
;src/player.c:145: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src/player.c:75: if (p->mode == MODE_SHIP) {
	ld	a, c
;src/player.c:77: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:78: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, b
	or	a, a
	ld	a, #0x2a
	jr	NZ, 00252$
	ld	a, #0xd6
00252$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:80: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, b
	or	a, a
	ld	a, #0xde
	jr	NZ, 00254$
	ld	a, #0x22
00254$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:82: p->vel_y.w += accel;
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:85: if (p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
;src/player.c:82: p->vel_y.w += accel;
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
;src/player.c:86: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	ld	h, a
;src/player.c:85: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:86: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	ld	a, b
	sub	a, #0x97
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x7c
	jr	NC, 00109$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x97
	ld	(hl+), a
	ld	(hl), #0xfc
00109$:
;src/player.c:87: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
	ldhl	sp,#8
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
	jr	Z, 01194$
	bit	7, d
	jr	NZ, 01195$
	cp	a, a
	jr	01195$
01194$:
	bit	7, d
	jr	Z, 01195$
	scf
01195$:
	jp	NC, 00128$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x43
	ld	(hl+), a
	ld	(hl), #0x04
	jp	00128$
00117$:
;src/player.c:89: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ld	e, h
	ld	d, #0x03
	ld	a, #0x69
	cp	a, b
	ld	a, #0x03
	sbc	a, h
	bit	7, e
	jr	Z, 01196$
	bit	7, d
	jr	NZ, 01197$
	cp	a, a
	jr	01197$
01196$:
	bit	7, d
	jr	Z, 01197$
	scf
01197$:
	jr	NC, 00113$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:90: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
	ldhl	sp,#8
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
;src/player.c:93: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ld	a, c
	sub	a, #0x02
	ld	a, #0x47
	jr	Z, 00256$
	ld	a, #0x6b
00256$:
	ldhl	sp,	#26
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:95: p->vel_y.w -= gravity_val;
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, (hl)
;src/player.c:94: if (p->gravity_flipped) {
	inc	b
	dec	b
	jr	Z, 00124$
;src/player.c:95: p->vel_y.w -= gravity_val;
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
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/player.c:96: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#8
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
;src/player.c:98: p->vel_y.w += gravity_val;
	ld	e, a
	ld	d, c
	ldhl	sp,	#26
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	b, l
	ld	c, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/player.c:99: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#8
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
	jr	Z, 01200$
	bit	7, d
	jr	NZ, 01201$
	cp	a, a
	jr	01201$
01200$:
	bit	7, d
	jr	Z, 01201$
	scf
01201$:
	jr	NC, 00128$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:104: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	xor	a, a
	ldhl	sp,	#4
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
;src/player.c:105: p->orb_buffered = 1;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x01
00130$:
;src/player.c:110: p->world_y.w += p->vel_y.w;
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
;src/player.c:108: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00136$
;src/player.c:109: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00134$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00257$
	ld	bc, #0x0590
	jr	00258$
00257$:
	ld	bc, #0xfa70
00258$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00134$:
;src/player.c:110: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#8
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
;src/player.c:111: return 0;
	xor	a, a
	jp	00249$
00136$:
;src/player.c:117: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#8
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
;src/player.c:122: uint8_t py = p->world_y.b.h;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
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
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/player.c:123: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#14
;src/player.c:124: const uint8_t* c1 = collision_columns + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
;src/player.c:125: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:126: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#17
	ld	(hl), a
;src/player.c:104: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
;src/player.c:131: p->on_ground = 0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:135: if (p->vel_y.w >= 0) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	NZ, 00161$
;src/player.c:136: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#12
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x0f
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ldhl	sp,	#20
	ld	(hl), c
	inc	hl
;src/player.c:137: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), foot_y);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00259$
	ld	b, #0x07
	jr	00260$
00259$:
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ld	b, a
00260$:
;src/player.c:138: if (!IS_SOLID(hit_col)) {
	ld	a,b
	cp	a,#0x07
	jr	Z, 00143$
	cp	a,#0x09
	jr	Z, 00143$
	cp	a,#0x05
	jr	Z, 00143$
	sub	a, #0x06
	jr	Z, 00143$
;src/player.c:139: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), foot_y);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00265$
	ld	b, #0x07
	jr	00266$
00265$:
	ld	a, #0x07
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00269$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00270$
00269$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00270$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	b, a
00266$:
;src/player.c:140: if (!IS_SOLID(hit_col)) {
	ld	a,b
	cp	a,#0x07
	jr	Z, 00143$
	cp	a,#0x09
	jr	Z, 00143$
	cp	a,#0x05
	jr	Z, 00143$
	sub	a, #0x06
	jr	Z, 00143$
;src/player.c:141: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), foot_y);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00271$
	ld	b, #0x07
	jr	00272$
00271$:
	ld	a, #0x0f
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00275$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00276$
00275$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00276$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ld	b, a
00272$:
00143$:
;src/player.c:144: if (IS_SOLID(hit_col)) {
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
;src/player.c:145: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00152$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00161$
00152$:
;src/player.c:147: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ldhl	sp,	#20
	ld	a, (hl)
	and	a, #0xf0
	ld	c, a
;src/player.c:146: if (hit_col == COL_BOTTOM) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00148$
;src/player.c:147: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf8
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00149$
00148$:
;src/player.c:149: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf0
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00149$:
;src/player.c:151: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:152: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:153: if (!p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00161$
;src/player.c:154: p->on_ground = 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:155: p->orb_buffered = 0;
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
;src/player.c:162: if (p->vel_y.w < 0) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	Z, 00186$
;src/player.c:163: int16_t head_y = py;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:164: uint8_t hit_col = COL_AT_PTR(GET_COL_FAST(0), head_y);
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
;src/player.c:165: if (!IS_SOLID(hit_col)) {
	ld	b, a
	sub	a, #0x07
	jr	Z, 00168$
	ld	a,b
	cp	a,#0x09
	jr	Z, 00168$
	cp	a,#0x05
	jr	Z, 00168$
	sub	a, #0x06
	jr	Z, 00168$
;src/player.c:166: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), head_y);
	ld	a, #0x07
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00287$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00288$
00287$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00288$:
	ldhl	sp,	#25
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
;src/player.c:167: if (!IS_SOLID(hit_col)) {
	ld	b, a
	sub	a, #0x07
	jr	Z, 00168$
	ld	a,b
	cp	a,#0x09
	jr	Z, 00168$
	cp	a,#0x05
	jr	Z, 00168$
	sub	a, #0x06
	jr	Z, 00168$
;src/player.c:168: hit_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), head_y);
	ld	a, #0x0f
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00293$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00294$
00293$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00294$:
	ldhl	sp,	#25
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
	ld	b, a
00168$:
;src/player.c:171: if (IS_SOLID(hit_col)) {
	ld	a,b
	cp	a,#0x07
	jr	Z, 00180$
	cp	a,#0x09
	jr	Z, 00180$
	cp	a,#0x05
	jr	Z, 00180$
	sub	a, #0x06
	jr	NZ, 00186$
00180$:
;src/player.c:172: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00177$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00186$
00177$:
;src/player.c:174: p->world_y.b.h = (head_y & ~15) + 8;
	ldhl	sp,	#27
	ld	a, (hl)
	and	a, #0xf0
	ld	c, a
;src/player.c:173: if (hit_col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00173$
;src/player.c:174: p->world_y.b.h = (head_y & ~15) + 8;
	ld	a, c
	add	a, #0x08
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00174$
00173$:
;src/player.c:176: p->world_y.b.h = (head_y & ~15) + 16;
	ld	a, c
	add	a, #0x10
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00174$:
;src/player.c:178: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:179: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:180: if (p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00186$
;src/player.c:181: p->on_ground = 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:182: p->orb_buffered = 0;
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
;src/player.c:189: if (!p->on_ground) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00203$
;src/player.c:190: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:122: uint8_t py = p->world_y.b.h;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;src/player.c:190: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	e, a
	ld	d, #0x00
	ld	a, c
	or	a, a
	jr	Z, 00295$
	dec	de
	jr	00296$
00295$:
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00296$:
	ldhl	sp,	#20
	ld	a, e
	ld	(hl+), a
;src/player.c:191: uint8_t stick_col = COL_AT_PTR(GET_COL_FAST(0), sticky_y);
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00297$
	ldhl	sp,	#20
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00299$
	xor	a, a
	jr	00298$
00299$:
	ld	a, #0x07
	jr	00298$
00297$:
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00298$:
;src/player.c:192: if (!IS_SOLID(stick_col)) {
	cp	a, #0x07
	jp	Z, 00193$
	cp	a, #0x09
	jp	Z, 00193$
	cp	a, #0x05
	jp	Z, 00193$
	cp	a, #0x06
	jp	Z, 00193$
;src/player.c:193: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), sticky_y);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00303$
	ldhl	sp,	#20
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00305$
	xor	a, a
	jr	00304$
00305$:
	ld	a, #0x07
	jr	00304$
00303$:
	ld	a, #0x07
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00307$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00308$
00307$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00308$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00304$:
;src/player.c:194: if (!IS_SOLID(stick_col)) {
	cp	a, #0x07
	jr	Z, 00193$
	cp	a, #0x09
	jr	Z, 00193$
	cp	a, #0x05
	jr	Z, 00193$
	cp	a, #0x06
	jr	Z, 00193$
;src/player.c:195: stick_col = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), sticky_y);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00309$
	ldhl	sp,	#20
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00311$
	xor	a, a
	jr	00310$
00311$:
	ld	a, #0x07
	jr	00310$
00309$:
	ld	a, #0x0f
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00313$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00314$
00313$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00314$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00310$:
00193$:
;src/player.c:198: if (IS_SOLID(stick_col)) {
	cp	a, #0x07
	jr	Z, 00197$
	cp	a, #0x09
	jr	Z, 00197$
	cp	a, #0x05
	jr	Z, 00197$
	sub	a, #0x06
	jr	NZ, 00203$
00197$:
;src/player.c:199: p->on_ground = 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:200: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
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
00203$:
;src/player.c:206: py = p->world_y.b.h;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:207: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
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
	jr	Z, 00315$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00316$
00315$:
	ld	a, #0x0e
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00317$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00318$
00317$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00318$:
00316$:
	ldhl	sp,	#26
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/player.c:208: uint8_t front_center = COL_AT_PTR(c_front, py + (PLAYER_SIZE >> 1));
	ldhl	sp,	#22
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, b
	or	a, a
	jr	Z, 00319$
	ld	a, #0x07
	jr	00320$
00319$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00320$:
;src/player.c:209: if (IS_SOLID(front_center)) {
	cp	a, #0x07
	jr	Z, 00204$
	cp	a, #0x09
	jr	Z, 00204$
	cp	a, #0x05
	jr	Z, 00204$
	sub	a, #0x06
	jr	NZ, 00205$
00204$:
;src/player.c:210: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:211: return 1;
	ld	a, #0x01
	jp	00249$
00205$:
;src/player.c:215: uint8_t hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#24
	ld	(hl), #0x00
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00323$
	ld	a, #0x07
	jr	00324$
00323$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x06
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00327$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00328$
00327$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00328$:
	call	_col_at_raw_cached
00324$:
;src/player.c:216: if (hazard_kills(p, hz, PLAYER_HBOX)) {
	ld	h, #0x06
	push	hl
	inc	sp
	ldhl	sp,	#30
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00210$
;src/player.c:217: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:218: return 1;
	ld	a, #0x01
	jp	00249$
00210$:
;src/player.c:220: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00329$
	ld	a, #0x07
	jr	00330$
00329$:
	ldhl	sp,	#26
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x09
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00333$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00334$
00333$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00334$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00330$:
;src/player.c:221: if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
	ld	h, #0x09
	push	hl
	inc	sp
	ldhl	sp,	#30
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00212$
;src/player.c:222: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:223: return 1;
	ld	a, #0x01
	jp	00249$
00212$:
;src/player.c:225: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), c
	inc	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00335$
	ld	a, #0x07
	jr	00336$
00335$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ld	a, #0x06
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00339$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00340$
00339$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00340$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00336$:
;src/player.c:226: if (hazard_kills(p, hz, PLAYER_HBOX)) {
	ld	h, #0x06
	push	hl
	inc	sp
	ldhl	sp,	#30
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00214$
;src/player.c:227: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:228: return 1;
	ld	a, #0x01
	jp	00249$
00214$:
;src/player.c:230: hz = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00341$
	ld	c, #0x07
	jr	00342$
00341$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, #0x09
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00345$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00346$
00345$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00346$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ld	c, a
00342$:
	ld	a, c
;src/player.c:231: if (hazard_kills(p, hz, PLAYER_SIZE - PLAYER_HBOX)) {
	ld	h, #0x09
	push	hl
	inc	sp
	ldhl	sp,	#30
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00216$
;src/player.c:232: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:233: return 1;
	ld	a, #0x01
	jp	00249$
00216$:
;src/player.c:239: if (p->on_ground) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00226$
;src/player.c:240: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00226$
;src/player.c:241: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00221$
;src/player.c:242: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00347$
	ld	bc, #0x0590
	jr	00348$
00347$:
	ld	bc, #0xfa70
00348$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:243: p->on_ground = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00226$
00221$:
;src/player.c:244: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	sub	a, #0x02
	jr	NZ, 00226$
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
	jr	NZ, 00226$
;src/player.c:245: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#6
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
;src/player.c:246: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	or	a, a
	jr	Z, 00349$
	xor	a, a
	ld	d, #0xfe
	jr	00350$
00349$:
	xor	a, a
	ld	d, #0x02
00350$:
	ldhl	sp,	#26
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:247: p->on_ground = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:248: p->ball_switched = 1;
	ld	a, #0x01
	ld	(bc), a
00226$:
;src/player.c:252: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	NZ, 00228$
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
00228$:
;src/player.c:255: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:262: p->anim_timer += 20; // double speed while settling
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
;src/player.c:255: if (p->on_ground && p->mode != MODE_BALL) {
	ld	a, c
	or	a, a
	jp	Z, 00244$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jp	Z, 00244$
;src/player.c:260: uint8_t q = (p->anim_frame < 24) ? mod6_table[p->anim_frame] : (p->anim_frame % 6);
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
	jr	NC, 00351$
	ld	de, #_mod6_table+0
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	jr	00352$
00351$:
	ld	a, c
	ld	e, #0x06
	call	__moduchar
	ld	a, c
00352$:
	ldhl	sp,	#25
	ld	(hl), a
;src/player.c:261: if (q != 0) {
	or	a, a
	jr	Z, 00237$
;src/player.c:262: p->anim_timer += 20; // double speed while settling
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
;src/player.c:263: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jp	C, 00245$
;src/player.c:264: p->anim_timer -= 21;
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
;src/player.c:260: uint8_t q = (p->anim_frame < 24) ? mod6_table[p->anim_frame] : (p->anim_frame % 6);
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
;src/player.c:265: if (q >= 3) {
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00232$
;src/player.c:267: p->anim_frame++;
	dec	hl
	dec	hl
	ld	a, c
	inc	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:268: if (p->anim_frame >= 24) {
	sub	a, #0x18
	jr	C, 00245$
;src/player.c:269: p->anim_frame = 0;
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:270: p->anim_timer = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00245$
00232$:
;src/player.c:274: p->anim_frame--;
	dec	c
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	jr	00245$
00237$:
;src/player.c:278: p->anim_timer = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00245$
00244$:
;src/player.c:281: p->anim_timer += 10;
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
;src/player.c:282: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jr	C, 00245$
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
;src/player.c:284: p->anim_frame++;
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
;src/player.c:285: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00245$
	xor	a, a
	ld	(bc), a
00245$:
;src/player.c:290: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	sla	b
	rl	e
	sla	b
	rl	e
	sla	b
	rl	e
	sla	b
	rl	e
	ld	d, #0x00
	ld	a, b
	sub	a, c
	ld	a, e
	sbc	a, d
	jr	NC, 00248$
;src/player.c:291: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:292: return 1;
	ld	a, #0x01
	jr	00249$
00248$:
;src/player.c:295: p->last_joy = joy;
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
;src/player.c:296: return 0;
	xor	a, a
00249$:
;src/player.c:297: }
	add	sp, #31
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
