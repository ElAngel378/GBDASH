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
;src/player.c:6: void player_init(Player* p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init::
	dec	sp
	dec	sp
;src/player.c:7: p->world_x = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:8: p->world_y.w = (uint16_t)start_y << 8;
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
;src/player.c:9: p->vel_y.w = 0;
	ld	hl, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:10: p->on_ground = 0;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;src/player.c:11: p->dead = 0;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;src/player.c:12: p->anim_timer = 0;
	ld	hl, #0x000c
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:13: p->anim_frame = 0;
	ld	hl, #0x000b
	add	hl, de
	ld	(hl), #0x00
;src/player.c:14: p->gravity_flipped = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x00
;src/player.c:15: p->mode = MODE_CUBE;
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/player.c:16: p->reversed = 0;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/player.c:17: p->last_joy = 0;
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x00
;src/player.c:18: p->ball_switched = 0;
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->touching_orb = 0;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;src/player.c:20: p->level_complete = 0;
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x00
;src/player.c:21: p->sp_idx = 0;
	ld	hl, #0x0015
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:22: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:24: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:25: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:26: }
	ret
;src/player.c:33: static uint8_t hazard_kills(const Player* p, uint8_t col, uint8_t x_off) {
;	---------------------------------
; Function hazard_kills
; ---------------------------------
_hazard_kills:
;src/player.c:37: if (!IS_HAZARD(col)) return 0;
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
;src/player.c:39: if (col == COL_DEATH_LEFT || col == COL_DEATH_RIGHT) {
	ld	a, b
	or	a, a
	jr	NZ, 00116$
	dec	c
	jr	NZ, 00117$
00116$:
;src/player.c:40: inner_x = (uint8_t)(p->world_x + x_off) & 0x0F;
	ld	a, (de)
	ldhl	sp,	#2
	add	a, (hl)
	and	a, #0x0f
	ld	c, a
;src/player.c:41: deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
	ld	hl, #0x000a
	add	hl, de
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	e, a
;src/player.c:43: if (inner_x >= 8) return 0; // deadly zone: left half only
	ld	a, c
	sub	a, #0x08
	ld	a, #0x00
	rla
	ld	c, a
;src/player.c:41: deadly_left = (col == COL_DEATH_LEFT) ^ (p->reversed != 0);
	ld	a, b
;src/player.c:42: if (deadly_left) {
	xor	a,e
	jr	Z, 00114$
;src/player.c:43: if (inner_x >= 8) return 0; // deadly zone: left half only
	bit	0, c
	jr	NZ, 00117$
	xor	a, a
	jr	00119$
00114$:
;src/player.c:45: if (inner_x < 8) return 0;  // deadly zone: right half only
	ld	a, c
	or	a, a
	jr	Z, 00117$
	xor	a, a
	jr	00119$
00117$:
;src/player.c:48: return 1;
	ld	a, #0x01
00119$:
;src/player.c:49: }
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:56: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-35
	ldhl	sp,	#33
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:62: if (p->dead) return 1;
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
	jp	00244$
00102$:
;src/player.c:63: if (p->level_complete) return 0;
	ldhl	sp,#33
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
	jp	00244$
00104$:
;src/player.c:68: if (p->mode == MODE_SHIP) {
	ldhl	sp,#33
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
;src/player.c:70: if (joy & J_A) {
	ldhl	sp,	#32
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:71: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#33
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
;src/player.c:75: p->vel_y.w += accel;
	ldhl	sp,#33
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
	ldhl	sp,	#28
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:144: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src/player.c:68: if (p->mode == MODE_SHIP) {
	ld	a, c
;src/player.c:70: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:71: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, b
	or	a, a
	ld	a, #0x2a
	jr	NZ, 00247$
	ld	a, #0xd6
00247$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:73: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, b
	or	a, a
	ld	a, #0xde
	jr	NZ, 00249$
	ld	a, #0x22
00249$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:75: p->vel_y.w += accel;
	ldhl	sp,	#28
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
;src/player.c:78: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
;src/player.c:75: p->vel_y.w += accel;
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
;src/player.c:79: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	ld	h, a
;src/player.c:78: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:79: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
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
;src/player.c:80: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
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
	jr	Z, 01365$
	bit	7, d
	jr	NZ, 01366$
	cp	a, a
	jr	01366$
01365$:
	bit	7, d
	jr	Z, 01366$
	scf
01366$:
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
;src/player.c:82: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ld	e, h
	ld	d, #0x03
	ld	a, #0x69
	cp	a, b
	ld	a, #0x03
	sbc	a, h
	bit	7, e
	jr	Z, 01367$
	bit	7, d
	jr	NZ, 01368$
	cp	a, a
	jr	01368$
01367$:
	bit	7, d
	jr	Z, 01368$
	scf
01368$:
	jr	NC, 00113$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:83: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
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
;src/player.c:86: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ld	a, c
	sub	a, #0x02
	ld	a, #0x47
	jr	Z, 00251$
	ld	a, #0x6b
00251$:
	ldhl	sp,	#30
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:88: p->vel_y.w -= gravity_val;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, (hl)
;src/player.c:87: if (p->gravity_flipped) {
	inc	b
	dec	b
	jr	Z, 00124$
;src/player.c:88: p->vel_y.w -= gravity_val;
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
;src/player.c:89: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
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
;src/player.c:91: p->vel_y.w += gravity_val;
	ld	e, a
	ld	d, c
	ldhl	sp,	#30
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
;src/player.c:92: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
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
	jr	Z, 01371$
	bit	7, d
	jr	NZ, 01372$
	cp	a, a
	jr	01372$
01371$:
	bit	7, d
	jr	Z, 01372$
	scf
01372$:
	jr	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:97: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00130$
	ldhl	sp,#33
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
	ldhl	sp,#33
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
;src/player.c:98: p->orb_buffered = 1;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x01
00130$:
;src/player.c:103: p->world_y.w += p->vel_y.w;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:101: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00136$
;src/player.c:102: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
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
	jr	Z, 00252$
	ld	bc, #0x0590
	jr	00253$
00252$:
	ld	bc, #0xfa70
00253$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00134$:
;src/player.c:103: p->world_y.w += p->vel_y.w;
	ldhl	sp,#30
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
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:104: return 0;
	xor	a, a
	jp	00244$
00136$:
;src/player.c:110: p->world_y.w += p->vel_y.w;
	ldhl	sp,#30
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
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:115: uint8_t py = p->world_y.b.h;
	ldhl	sp,#33
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
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/player.c:116: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#16
;src/player.c:117: const uint8_t* c1 = collision_columns + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
;src/player.c:118: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:119: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#19
	ld	(hl), a
;src/player.c:125: const uint8_t* c_front = p->reversed ? GET_COL_FAST(0) : GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00254$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	jr	00255$
00254$:
	ld	a, #0x0f
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00258$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	jr	00259$
00258$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
00259$:
00255$:
	ldhl	sp,	#30
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:126: uint8_t front_center = COL_AT_PTR(c_front, py + (PLAYER_SIZE >> 1));
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#20
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
	jr	Z, 00260$
	ld	e, #0x07
	jr	00261$
00260$:
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	e, a
00261$:
;src/player.c:127: uint8_t front_top    = COL_AT_PTR(c_front, py + 2);
	ldhl	sp,	#20
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	ld	a, b
	or	a, a
	jr	Z, 00264$
	ld	c, #0x07
	jr	00265$
00264$:
	push	de
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	pop	de
	ld	c, a
00265$:
;src/player.c:128: if (IS_SOLID(front_center) || IS_SOLID(front_top)) {
	ld	a,e
	cp	a,#0x07
	jr	Z, 00137$
	cp	a,#0x09
	jr	Z, 00137$
	cp	a,#0x05
	jr	Z, 00137$
	sub	a, #0x06
	jr	Z, 00137$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00137$
	cp	a,#0x09
	jr	Z, 00137$
	cp	a,#0x05
	jr	Z, 00137$
	sub	a, #0x06
	jr	NZ, 00138$
00137$:
;src/player.c:129: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:130: return 1;
	ld	a, #0x01
	jp	00244$
00138$:
;src/player.c:97: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#24
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#23
;src/player.c:133: p->on_ground = 0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:138: if (p->vel_y.w >= 0) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	NZ, 00168$
;src/player.c:139: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#24
	ld	(hl), c
	inc	hl
;src/player.c:140: uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(2), foot_y);
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
	jr	Z, 00268$
	ld	a, #0x07
	jr	00269$
00268$:
	ld	a, #0x02
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00272$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	jr	00273$
00272$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
00273$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00269$:
	ldhl	sp,	#30
;src/player.c:141: uint8_t cm_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), foot_y);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00274$
	ld	a, #0x07
	jr	00275$
00274$:
	ld	a, #0x07
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00278$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00279$
00278$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00279$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00275$:
	ldhl	sp,	#31
;src/player.c:142: uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), foot_y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00280$
	ld	c, #0x07
	jr	00281$
00280$:
	ld	a, #0x0d
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00284$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00285$
00284$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00285$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ld	c, a
00281$:
;src/player.c:143: if (IS_SOLID(cl_f) || IS_SOLID(cm_f) || IS_SOLID(cr_f)) {
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01387$
	xor	a, a
01387$:
	ld	b, a
	or	a, a
	jr	NZ, 00154$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00154$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00154$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00154$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00154$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00154$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00154$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00154$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00154$
	cp	a,#0x09
	jr	Z, 00154$
	cp	a,#0x05
	jr	Z, 00154$
	sub	a, #0x06
	jp	NZ, 00168$
00154$:
;src/player.c:144: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00151$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jp	NZ, 00168$
00151$:
;src/player.c:145: uint8_t hit_col = IS_SOLID(cl_f) ? cl_f : (IS_SOLID(cm_f) ? cm_f : cr_f);
	bit	0, b
	jr	NZ, 00289$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00289$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00289$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00286$
00289$:
	ldhl	sp,	#30
	ld	e, (hl)
	jr	00287$
00286$:
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00300$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00300$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00300$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00297$
00300$:
	ldhl	sp,	#31
	ld	e, (hl)
	jr	00298$
00297$:
	ld	e, c
00298$:
00287$:
;src/player.c:147: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ldhl	sp,	#24
	ld	a, (hl)
	and	a, #0xf0
	ld	c, a
;src/player.c:146: if (hit_col == COL_BOTTOM) {
	ld	a, e
	sub	a, #0x06
	jr	NZ, 00147$
;src/player.c:147: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf8
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00148$
00147$:
;src/player.c:149: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf0
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00148$:
;src/player.c:151: p->world_y.b.l = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:152: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:153: if (!p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00168$
;src/player.c:154: p->on_ground = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:155: p->orb_buffered = 0;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00168$:
;src/player.c:162: if (p->vel_y.w < 0) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	de
	ld	a, (de)
	bit	7,a
	jp	Z, 00191$
;src/player.c:163: int16_t head_y = py;
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:164: uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(2), head_y);
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00312$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00313$
00312$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00313$:
	ldhl	sp,	#27
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:165: uint8_t cm_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), head_y);
	ld	a, #0x07
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00318$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00319$
00318$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00319$:
	ldhl	sp,	#27
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:166: uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), head_y);
	ld	a, #0x0d
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00324$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00325$
00324$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00325$:
	ldhl	sp,	#27
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
	ld	c, a
;src/player.c:167: if (IS_SOLID(cl_h) || IS_SOLID(cm_h) || IS_SOLID(cr_h)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01414$
	xor	a, a
01414$:
	ld	b, a
	or	a, a
	jr	NZ, 00177$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00177$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00177$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00177$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00177$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00177$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00177$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00177$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00177$
	cp	a,#0x09
	jr	Z, 00177$
	cp	a,#0x05
	jr	Z, 00177$
	sub	a, #0x06
	jp	NZ, 00191$
00177$:
;src/player.c:168: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00174$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jp	NZ, 00191$
00174$:
;src/player.c:169: uint8_t hit_col = IS_SOLID(cl_h) ? cl_h : (IS_SOLID(cm_h) ? cm_h : cr_h);
	ld	e, b
	bit	0, e
	jr	NZ, 00329$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00329$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00329$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00326$
00329$:
	ldhl	sp,	#29
	ld	c, (hl)
	jr	00327$
00326$:
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00340$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00340$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00340$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00337$
00340$:
	ldhl	sp,	#30
	ld	c, (hl)
00337$:
00327$:
;src/player.c:171: p->world_y.b.h = (head_y & ~15) + 8;
	ldhl	sp,	#31
	ld	a, (hl)
	and	a, #0xf0
	ld	b, a
;src/player.c:170: if (hit_col == COL_TOP) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00170$
;src/player.c:171: p->world_y.b.h = (head_y & ~15) + 8;
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00171$
00170$:
;src/player.c:173: p->world_y.b.h = (head_y & ~15) + 16;
	ld	a, b
	add	a, #0x10
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00171$:
;src/player.c:175: p->world_y.b.l = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/player.c:176: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:177: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00191$
;src/player.c:178: p->on_ground = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:179: p->orb_buffered = 0;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00191$:
;src/player.c:186: if (!p->on_ground) {
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00206$
;src/player.c:187: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:115: uint8_t py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;src/player.c:187: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	e, a
	ld	d, #0x00
	ld	a, c
	or	a, a
	jr	Z, 00348$
	dec	de
	jr	00349$
00348$:
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00349$:
	ldhl	sp,	#24
	ld	a, e
	ld	(hl+), a
;src/player.c:188: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
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
	jr	Z, 00350$
	ldhl	sp,	#24
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00352$
	xor	a, a
	jr	00351$
00352$:
	ld	a, #0x07
	jr	00351$
00350$:
	ld	a, #0x02
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00354$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00355$
00354$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00355$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00351$:
	ldhl	sp,	#30
;src/player.c:189: uint8_t gm = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE >> 1), sticky_y);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00356$
	ldhl	sp,	#24
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00358$
	xor	a, a
	jr	00357$
00358$:
	ld	a, #0x07
	jr	00357$
00356$:
	ld	a, #0x07
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00360$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jr	00361$
00360$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00361$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
00357$:
	ldhl	sp,	#31
;src/player.c:190: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00362$
	ldhl	sp,	#24
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00364$
	xor	a, a
	jr	00363$
00364$:
	ld	a, #0x07
	jr	00363$
00362$:
	ld	a, #0x0d
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00366$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00367$
00366$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00367$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00363$:
	ld	c, a
;src/player.c:191: if (IS_SOLID(gl) || IS_SOLID(gm) || IS_SOLID(gr)) {
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00192$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00192$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00192$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00192$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00192$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00192$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00192$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00192$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00192$
	cp	a,#0x09
	jr	Z, 00192$
	cp	a,#0x05
	jr	Z, 00192$
	sub	a, #0x06
	jr	NZ, 00206$
00192$:
;src/player.c:192: p->on_ground = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:193: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:194: p->orb_buffered = 0;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00206$:
;src/player.c:199: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ldhl	sp,#20
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
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00368$
	ld	a, #0x07
	jr	00369$
00368$:
	ldhl	sp,	#26
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x06
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00372$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	jr	00373$
00372$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
00373$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00369$:
	ldhl	sp,	#30
;src/player.c:200: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00374$
	ld	a, #0x07
	jr	00375$
00374$:
	ldhl	sp,	#26
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x09
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00378$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00379$
00378$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00379$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00375$:
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:201: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#20
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
	ld	(hl), a
	ldhl	sp,	#24
	ld	(hl), #0x00
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00380$
	ld	a, #0x07
	jr	00381$
00380$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, #0x06
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00384$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00385$
00384$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00385$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00381$:
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:202: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00386$
	ld	c, #0x07
	jr	00387$
00386$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ld	a, #0x09
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00390$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00391$
00390$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00391$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ld	c, a
00387$:
	ldhl	sp,	#28
;src/player.c:203: if (hazard_kills(p, hz_tl, PLAYER_HBOX) ||
	ld	a, c
	ld	(hl+), a
	inc	hl
	ld	a, #0x06
	push	af
	inc	sp
	ld	a, (hl)
	ldhl	sp,	#34
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	NZ, 00207$
;src/player.c:204: hazard_kills(p, hz_tr, PLAYER_SIZE - PLAYER_HBOX) ||
	ld	a, #0x09
	push	af
	inc	sp
	ldhl	sp,	#32
	ld	a, (hl+)
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	NZ, 00207$
;src/player.c:205: hazard_kills(p, hz_bl, PLAYER_HBOX) ||
	ld	a, #0x06
	push	af
	inc	sp
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#34
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	NZ, 00207$
;src/player.c:206: hazard_kills(p, hz_br, PLAYER_SIZE - PLAYER_HBOX)) {
	ld	a, #0x09
	push	af
	inc	sp
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#34
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00208$
00207$:
;src/player.c:207: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:208: return 1;
	ld	a, #0x01
	jp	00244$
00208$:
;src/player.c:214: if (p->on_ground) {
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00221$
;src/player.c:215: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00221$
;src/player.c:216: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00216$
;src/player.c:217: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00392$
	ld	bc, #0x0590
	jr	00393$
00392$:
	ld	bc, #0xfa70
00393$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:218: p->on_ground = 0;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00221$
00216$:
;src/player.c:219: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	sub	a, #0x02
	jr	NZ, 00221$
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00221$
;src/player.c:220: p->gravity_flipped = !p->gravity_flipped;
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
;src/player.c:221: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	or	a, a
	jr	Z, 00394$
	xor	a, a
	ld	d, #0xfe
	jr	00395$
00394$:
	xor	a, a
	ld	d, #0x02
00395$:
	ldhl	sp,	#30
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:222: p->on_ground = 0;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:223: p->ball_switched = 1;
	ld	a, #0x01
	ld	(bc), a
00221$:
;src/player.c:227: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	NZ, 00223$
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00223$:
;src/player.c:230: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:237: p->anim_timer += 20; // double speed while settling
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:230: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jp	Z, 00239$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jp	Z, 00239$
;src/player.c:235: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	ld	e, #0x06
	call	__moduchar
	ld	a, c
	pop	bc
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:236: if (q != 0) {
	or	a, a
	jr	Z, 00232$
;src/player.c:237: p->anim_timer += 20; // double speed while settling
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	de, #0x0014
	add	hl, de
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:238: if (p->anim_timer >= 21) {
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jp	C, 00240$
;src/player.c:239: p->anim_timer -= 21;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	add	a, #0xeb
	ld	e, a
	ld	a, h
	adc	a, #0xff
	ld	d, a
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:235: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
;src/player.c:240: if (q >= 3) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00227$
;src/player.c:242: p->anim_frame++;
	inc	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#28
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:243: if (p->anim_frame >= 24) {
	sub	a, #0x18
	jr	C, 00240$
;src/player.c:244: p->anim_frame = 0;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:245: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	jr	00240$
00227$:
;src/player.c:249: p->anim_frame--;
	ldhl	sp,	#31
	ld	a, (hl)
	dec	a
	ldhl	sp,	#28
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00240$
00232$:
;src/player.c:253: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	jr	00240$
00239$:
;src/player.c:256: p->anim_timer += 10;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	de, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:257: if (p->anim_timer >= 21) {
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jr	C, 00240$
;src/player.c:258: p->anim_timer -= 21;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	l, (hl)
	add	a, #0xeb
	ld	e, a
	ld	a, l
	adc	a, #0xff
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:259: p->anim_frame++;
	ldhl	sp,#33
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
;src/player.c:260: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00240$
	xor	a, a
	ld	(bc), a
00240$:
;src/player.c:265: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#39
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
	jr	NC, 00243$
;src/player.c:266: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:267: return 1;
	ld	a, #0x01
	jr	00244$
00243$:
;src/player.c:270: p->last_joy = joy;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#32
	ld	a, (hl)
	ld	(bc), a
;src/player.c:271: return 0;
	xor	a, a
00244$:
;src/player.c:272: }
	add	sp, #35
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
