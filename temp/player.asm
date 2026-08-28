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
	add	sp, #-34
	ldhl	sp,	#32
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
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00231$
00102$:
;src/player.c:63: if (p->level_complete) return 0;
	ldhl	sp,#32
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
	jp	00231$
00104$:
;src/player.c:68: if (p->mode == MODE_SHIP) {
	ldhl	sp,#32
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
	ldhl	sp,	#31
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:71: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#32
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
	ldhl	sp,#32
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
	ldhl	sp,	#27
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:131: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
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
	jr	NZ, 00234$
	ld	a, #0xd6
00234$:
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
	jr	NZ, 00236$
	ld	a, #0x22
00236$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:75: p->vel_y.w += accel;
	ldhl	sp,	#27
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
	jr	Z, 01121$
	bit	7, d
	jr	NZ, 01122$
	cp	a, a
	jr	01122$
01121$:
	bit	7, d
	jr	Z, 01122$
	scf
01122$:
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
	jr	Z, 01123$
	bit	7, d
	jr	NZ, 01124$
	cp	a, a
	jr	01124$
01123$:
	bit	7, d
	jr	Z, 01124$
	scf
01124$:
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
	jr	Z, 00238$
	ld	a, #0x6b
00238$:
	ldhl	sp,	#29
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:88: p->vel_y.w -= gravity_val;
	ldhl	sp,	#27
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
	ldhl	sp,	#29
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
	jr	Z, 01127$
	bit	7, d
	jr	NZ, 01128$
	cp	a, a
	jr	01128$
01127$:
	bit	7, d
	jr	Z, 01128$
	scf
01128$:
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
	ldhl	sp,#32
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
	ldhl	sp,#32
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
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x01
00130$:
;src/player.c:103: p->world_y.w += p->vel_y.w;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
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
	jr	Z, 00239$
	ld	bc, #0x0590
	jr	00240$
00239$:
	ld	bc, #0xfa70
00240$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00134$:
;src/player.c:103: p->world_y.w += p->vel_y.w;
	ldhl	sp,#29
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
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:104: return 0;
	xor	a, a
	jp	00231$
00136$:
;src/player.c:110: p->world_y.w += p->vel_y.w;
	ldhl	sp,#29
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
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:115: uint8_t py = p->world_y.b.h;
	ldhl	sp,#32
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
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#37
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
	ldhl	sp,#32
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
;src/player.c:97: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
;src/player.c:123: p->on_ground = 0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:127: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x0f
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ldhl	sp,	#22
	ld	(hl), c
	inc	hl
;src/player.c:128: uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(3), foot_y);
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
	ld	a, #0x03
	ldhl	sp,	#19
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00241$
	ld	a, #0x07
	jr	00242$
00241$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00245$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00246$
00245$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00246$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00242$:
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:129: uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), foot_y);
	ld	a, #0x0c
	ldhl	sp,	#19
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00247$
	ld	a, #0x07
	jr	00248$
00247$:
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00251$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00252$
00251$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00252$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00248$:
	ldhl	sp,	#27
;src/player.c:130: if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01132$
	xor	a, a
01132$:
	ld	c, a
	or	a, a
	jr	NZ, 00145$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00145$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00145$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00145$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00145$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00145$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00145$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jp	NZ, 00146$
00145$:
;src/player.c:131: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00142$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00146$
00142$:
;src/player.c:132: uint8_t hit_col = IS_SOLID(cl_f) ? cl_f : cr_f;
	bit	0, c
	jr	NZ, 00256$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00256$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00256$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00253$
00256$:
	ldhl	sp,	#29
	ld	c, (hl)
	jr	00254$
00253$:
	ldhl	sp,	#27
	ld	c, (hl)
00254$:
;src/player.c:134: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ldhl	sp,	#22
	ld	a, (hl)
	and	a, #0xf0
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:133: if (hit_col == COL_BOTTOM) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00138$
;src/player.c:134: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ld	a, (hl)
	add	a, #0xf8
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00139$
00138$:
;src/player.c:136: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#29
	ld	a, (hl)
	add	a, #0xf0
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00139$:
;src/player.c:138: p->world_y.b.l = 0;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:139: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:140: if (!p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00146$
;src/player.c:141: p->on_ground = 1;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:142: p->orb_buffered = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00146$:
;src/player.c:148: int16_t head_y = py;
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:149: uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(3), head_y);
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00268$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00269$
00268$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00269$:
	ldhl	sp,	#24
	ld	a, (hl+)
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:150: uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), head_y);
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00274$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00275$
00274$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00275$:
	ldhl	sp,	#24
	ld	c, (hl)
	ld	b, #0x00
	call	_col_at_raw_cached
	ldhl	sp,	#27
;src/player.c:151: if (IS_SOLID(cl_h) || IS_SOLID(cr_h)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01150$
	xor	a, a
01150$:
	ld	c, a
	or	a, a
	jr	NZ, 00162$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00162$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00162$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00162$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00162$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00162$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00162$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jp	NZ, 00163$
00162$:
;src/player.c:152: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00159$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00163$
00159$:
;src/player.c:153: uint8_t hit_col = IS_SOLID(cl_h) ? cl_h : cr_h;
	bit	0, c
	jr	NZ, 00279$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00279$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00279$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00276$
00279$:
	ldhl	sp,	#26
	ld	b, (hl)
	jr	00277$
00276$:
	ldhl	sp,	#27
	ld	b, (hl)
00277$:
;src/player.c:155: p->world_y.b.h = (head_y & ~15) + 8;
	ldhl	sp,	#29
	ld	a, (hl)
	and	a, #0xf0
	ld	c, a
;src/player.c:154: if (hit_col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00155$
;src/player.c:155: p->world_y.b.h = (head_y & ~15) + 8;
	ld	a, c
	add	a, #0x08
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00156$
00155$:
;src/player.c:157: p->world_y.b.h = (head_y & ~15) + 16;
	ld	a, c
	add	a, #0x10
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00156$:
;src/player.c:159: p->world_y.b.l = 0;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;src/player.c:160: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:161: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00163$
;src/player.c:162: p->on_ground = 1;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:163: p->orb_buffered = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00163$:
;src/player.c:169: if (!p->on_ground) {
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00181$
;src/player.c:170: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
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
;src/player.c:170: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	e, a
	ld	d, #0x00
	ld	a, c
	or	a, a
	jr	Z, 00287$
	dec	de
	jr	00288$
00287$:
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00288$:
	ldhl	sp,	#22
	ld	a, e
	ld	(hl+), a
;src/player.c:171: uint8_t gl = COL_AT_PTR(GET_COL_FAST(3), sticky_y);
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
	jr	Z, 00289$
	ldhl	sp,	#22
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00291$
	xor	a, a
	jr	00290$
00291$:
	ld	a, #0x07
	jr	00290$
00289$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00293$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00294$
00293$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00294$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00290$:
	ldhl	sp,	#29
;src/player.c:172: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), sticky_y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00295$
	ldhl	sp,	#22
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00297$
	xor	a, a
	jr	00296$
00297$:
	ld	a, #0x07
	jr	00296$
00295$:
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00299$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00300$
00299$:
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00300$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00296$:
	ld	c, a
;src/player.c:173: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00171$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00171$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00171$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00171$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00171$
	cp	a,#0x09
	jr	Z, 00171$
	cp	a,#0x05
	jr	Z, 00171$
	sub	a, #0x06
	jr	NZ, 00181$
00171$:
;src/player.c:174: p->on_ground = 1;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:175: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:176: p->orb_buffered = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00181$:
;src/player.c:181: py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:182: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	or	a, a
	jr	Z, 00301$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	d, (hl)
	jr	00302$
00301$:
	ld	a, #0x0e
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00303$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	d, (hl)
	jr	00304$
00303$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	d, (hl)
00304$:
00302$:
	ldhl	sp,	#23
	ld	(hl+), a
;src/player.c:186: uint8_t f0 = COL_AT_PTR(c_front, py + 2);
	ld	a, d
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	ld	a, b
	or	a, a
	jr	Z, 00305$
	ld	e, #0x07
	jr	00306$
00305$:
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	e, a
00306$:
;src/player.c:187: uint8_t f1 = COL_AT_PTR(c_front, py + 7);
	push	de
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, b
	or	a, a
	jr	Z, 00309$
	ld	d, #0x07
	jr	00310$
00309$:
	push	de
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	pop	de
	ld	d, a
00310$:
;src/player.c:188: uint8_t f2 = COL_AT_PTR(c_front, py + 12);
	push	de
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00313$
	ld	c, #0x07
	jr	00314$
00313$:
	push	de
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	pop	de
	ld	c, a
00314$:
;src/player.c:190: if (IS_SOLID(f0) || IS_SOLID(f1) || IS_SOLID(f2)) {
	ld	a,e
	cp	a,#0x07
	jr	Z, 00182$
	cp	a,#0x09
	jr	Z, 00182$
	cp	a,#0x05
	jr	Z, 00182$
	sub	a, #0x06
	jr	Z, 00182$
	ld	a,d
	cp	a,#0x07
	jr	Z, 00182$
	cp	a,#0x09
	jr	Z, 00182$
	cp	a,#0x05
	jr	Z, 00182$
	sub	a, #0x06
	jr	Z, 00182$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00182$
	cp	a,#0x09
	jr	Z, 00182$
	cp	a,#0x05
	jr	Z, 00182$
	sub	a, #0x06
	jr	NZ, 00183$
00182$:
;src/player.c:191: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:192: return 1;
	ld	a, #0x01
	jp	00231$
00183$:
;src/player.c:198: uint8_t h_side = p->reversed ? PLAYER_HBOX : (PLAYER_SIZE - PLAYER_HBOX);
	pop	de
	push	de
	ld	a, (de)
	or	a, a
	ld	a, #0x06
	jr	NZ, 00318$
	ld	a, #0x09
00318$:
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:199: const uint8_t* c_hazard = GET_COL_FAST(h_side);
	ld	a, (hl)
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00319$
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	b, (hl)
	jr	00320$
00319$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	b, (hl)
00320$:
	ldhl	sp,	#18
	ld	(hl+), a
	ld	(hl), b
;src/player.c:201: uint8_t h0 = COL_AT_PTR(c_hazard, py + 3);
	ldhl	sp,	#25
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	or	a, a
	jr	Z, 00321$
	ld	a, #0x07
	jr	00322$
00321$:
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00322$:
	ldhl	sp,	#23
	ld	(hl), a
;src/player.c:202: uint8_t h1 = COL_AT_PTR(c_hazard, py + 8);
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#25
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00325$
	ldhl	sp,	#26
	ld	(hl), #0x07
	jr	00326$
00325$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#26
	ld	(hl), a
00326$:
;src/player.c:203: uint8_t h2 = COL_AT_PTR(c_hazard, py + 12);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00329$
	inc	hl
	ld	(hl), #0x07
	jr	00330$
00329$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#30
	ld	(hl), a
00330$:
;src/player.c:205: if (hazard_kills(p, h0, h_side) ||
	ldhl	sp,	#24
	ld	a, (hl-)
	push	af
	inc	sp
	ld	a, (hl)
	ldhl	sp,	#33
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	NZ, 00195$
;src/player.c:206: hazard_kills(p, h1, h_side) ||
	ldhl	sp,	#24
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	ldhl	sp,	#33
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	NZ, 00195$
;src/player.c:207: hazard_kills(p, h2, h_side)) {
	ldhl	sp,	#24
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#31
	ld	a, (hl+)
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hazard_kills
	or	a, a
	jr	Z, 00196$
00195$:
;src/player.c:208: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:209: return 1;
	ld	a, #0x01
	jp	00231$
00196$:
;src/player.c:215: if (p->on_ground) {
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00208$
;src/player.c:216: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00208$
;src/player.c:217: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00203$
;src/player.c:218: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00333$
	ld	bc, #0x0590
	jr	00334$
00333$:
	ld	bc, #0xfa70
00334$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:219: p->on_ground = 0;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00208$
00203$:
;src/player.c:220: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	sub	a, #0x02
	jr	NZ, 00208$
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00208$
;src/player.c:221: p->gravity_flipped = !p->gravity_flipped;
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
;src/player.c:222: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	or	a, a
	jr	Z, 00335$
	xor	a, a
	ld	d, #0xfe
	jr	00336$
00335$:
	xor	a, a
	ld	d, #0x02
00336$:
	ldhl	sp,	#29
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:223: p->on_ground = 0;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:224: p->ball_switched = 1;
	ld	a, #0x01
	ld	(bc), a
00208$:
;src/player.c:228: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	NZ, 00210$
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
00210$:
;src/player.c:231: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:238: p->anim_timer += 20; // double speed while settling
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:231: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jp	Z, 00226$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jp	Z, 00226$
;src/player.c:236: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
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
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:237: if (q != 0) {
	or	a, a
	jr	Z, 00219$
;src/player.c:238: p->anim_timer += 20; // double speed while settling
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
;src/player.c:239: if (p->anim_timer >= 21) {
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jp	C, 00227$
;src/player.c:240: p->anim_timer -= 21;
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
;src/player.c:236: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
;src/player.c:241: if (q >= 3) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00214$
;src/player.c:243: p->anim_frame++;
	inc	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#27
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:244: if (p->anim_frame >= 24) {
	sub	a, #0x18
	jr	C, 00227$
;src/player.c:245: p->anim_frame = 0;
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:246: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	jr	00227$
00214$:
;src/player.c:250: p->anim_frame--;
	ldhl	sp,	#30
	ld	a, (hl)
	dec	a
	ldhl	sp,	#27
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00227$
00219$:
;src/player.c:254: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	jr	00227$
00226$:
;src/player.c:257: p->anim_timer += 10;
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
;src/player.c:258: if (p->anim_timer >= 21) {
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jr	C, 00227$
;src/player.c:259: p->anim_timer -= 21;
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
;src/player.c:260: p->anim_frame++;
	ldhl	sp,#32
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
;src/player.c:261: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00227$
	xor	a, a
	ld	(bc), a
00227$:
;src/player.c:266: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
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
	jr	NC, 00230$
;src/player.c:267: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:268: return 1;
	ld	a, #0x01
	jr	00231$
00230$:
;src/player.c:271: p->last_joy = joy;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a, (hl)
	ld	(bc), a
;src/player.c:272: return 0;
	xor	a, a
00231$:
;src/player.c:273: }
	add	sp, #34
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
