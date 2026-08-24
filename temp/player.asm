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
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x00
;src/player.c:20: p->level_complete = 0;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;src/player.c:21: p->sp_idx = 0;
	ld	hl, #0x0014
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
;src/player.c:33: uint8_t player_update(
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
;src/player.c:39: if (p->dead) return 1;
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
	jp	00232$
00102$:
;src/player.c:40: if (p->level_complete) return 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00104$
	xor	a, a
	jp	00232$
00104$:
;src/player.c:45: if (p->mode == MODE_SHIP) {
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
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:47: if (joy & J_A) {
	ldhl	sp,	#31
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
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
;src/player.c:52: p->vel_y.w += accel;
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
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:103: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#26
;src/player.c:45: if (p->mode == MODE_SHIP) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
;src/player.c:47: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	ld	e, #0x2a
	jr	NZ, 00235$
	ld	e, #0xd6
00235$:
	ld	a, e
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:50: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	ld	c, #0xde
	jr	NZ, 00237$
	ld	c, #0x22
00237$:
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:52: p->vel_y.w += accel;
	ldhl	sp,	#29
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
;src/player.c:55: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
;src/player.c:52: p->vel_y.w += accel;
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:56: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
;src/player.c:55: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:56: if (p->vel_y.w < -SHIP_MAX_VEL_UP) p->vel_y.w = -SHIP_MAX_VEL_UP;
	dec	hl
	ld	a, (hl+)
	sub	a, #0x97
	ld	a, (hl)
	sbc	a, #0xfc
	ld	d, (hl)
	ld	a, #0xfc
	bit	7,a
	jr	Z, 01158$
	bit	7, d
	jr	NZ, 01159$
	cp	a, a
	jr	01159$
01158$:
	bit	7, d
	jr	Z, 01159$
	scf
01159$:
	jr	NC, 00109$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x97
	ld	(hl+), a
	ld	(hl), #0xfc
00109$:
;src/player.c:57: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, #0x43
	sub	a, (hl)
	inc	hl
	ld	a, #0x04
	sbc	a, (hl)
	ld	a, #0x04
	ld	d, a
	bit	7, (hl)
	jr	Z, 01160$
	bit	7, d
	jr	NZ, 01161$
	cp	a, a
	jr	01161$
01160$:
	bit	7, d
	jr	Z, 01161$
	scf
01161$:
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
;src/player.c:59: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ldhl	sp,	#29
	ld	a, #0x69
	sub	a, (hl)
	inc	hl
	ld	a, #0x03
	sbc	a, (hl)
	ld	a, #0x03
	ld	d, a
	bit	7, (hl)
	jr	Z, 01162$
	bit	7, d
	jr	NZ, 01163$
	cp	a, a
	jr	01163$
01162$:
	bit	7, d
	jr	Z, 01163$
	scf
01163$:
	jr	NC, 00113$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:60: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xbd
	ld	a, (hl)
	sbc	a, #0xfb
	ld	d, (hl)
	ld	a, #0xfb
	bit	7,a
	jr	Z, 01164$
	bit	7, d
	jr	NZ, 01165$
	cp	a, a
	jr	01165$
01164$:
	bit	7, d
	jr	Z, 01165$
	scf
01165$:
	jp	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xbd
	ld	(hl+), a
	ld	(hl), #0xfb
	jp	00128$
00127$:
;src/player.c:63: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00238$
	ldhl	sp,	#28
	ld	(hl), #0x47
	jr	00239$
00238$:
	ldhl	sp,	#28
	ld	(hl), #0x6b
00239$:
	ldhl	sp,	#28
	ld	a, (hl-)
	ld	(hl+), a
;src/player.c:65: p->vel_y.w -= gravity_val;
;src/player.c:64: if (p->gravity_flipped) {
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00124$
;src/player.c:65: p->vel_y.w -= gravity_val;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#26
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:66: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x00
	ld	a, (hl)
	sbc	a, #0xfa
	ld	d, (hl)
	ld	a, #0xfa
	bit	7,a
	jr	Z, 01168$
	bit	7, d
	jr	NZ, 01169$
	cp	a, a
	jr	01169$
01168$:
	bit	7, d
	jr	Z, 01169$
	scf
01169$:
	jr	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00128$
00124$:
;src/player.c:68: p->vel_y.w += gravity_val;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:69: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x06
	sbc	a, (hl)
	ld	a, #0x06
	ld	d, a
	bit	7, (hl)
	jr	Z, 01170$
	bit	7, d
	jr	NZ, 01171$
	cp	a, a
	jr	01171$
01170$:
	bit	7, d
	jr	Z, 01171$
	scf
01171$:
	jr	NC, 00128$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:75: p->world_y.w += p->vel_y.w;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#25
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:73: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00132$
;src/player.c:74: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00130$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00240$
	dec	hl
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00241$
00240$:
	ldhl	sp,	#29
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00241$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00130$:
;src/player.c:75: p->world_y.w += p->vel_y.w;
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#27
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:76: return 0;
	xor	a, a
	jp	00232$
00132$:
;src/player.c:82: p->world_y.w += p->vel_y.w;
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:87: uint8_t py = p->world_y.b.h;
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
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:88: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#15
;src/player.c:89: const uint8_t* c1 = collision_columns + 16;
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
;src/player.c:90: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:91: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:95: p->on_ground = 0;
	ldhl	sp,#32
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
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:99: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#23
;src/player.c:100: uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(2), foot_y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#28
	ld	(hl), #0x00
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl+), a
	ld	a, #0x02
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00242$
	ld	a, #0x07
	jr	00243$
00242$:
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00246$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00247$
00246$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00247$:
	pop	bc
	push	bc
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00243$:
	ldhl	sp,	#25
	ld	(hl), a
;src/player.c:101: uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), foot_y);
	ld	a, #0x0d
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00248$
	inc	hl
	ld	(hl), #0x07
	jr	00249$
00248$:
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00252$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00253$
00252$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00253$:
	pop	bc
	push	bc
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#29
	ld	(hl), a
00249$:
	ldhl	sp,	#29
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:105: p->world_y.b.l = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:102: if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00138$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00138$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00138$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00138$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00138$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00138$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00138$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00139$
00138$:
;src/player.c:103: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00135$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00139$
00135$:
;src/player.c:104: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#22
	ld	a, (hl)
	and	a, #0xf0
	add	a, #0xf0
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:105: p->world_y.b.l = 0;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:106: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:107: if (!p->gravity_flipped) p->on_ground = 1;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00139$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00139$:
;src/player.c:112: int16_t head_y = py;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:113: uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(2), head_y);
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00258$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00259$
00258$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00259$:
	ldhl	sp,	#20
	ld	a, (hl+)
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	e, a
;src/player.c:114: uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), head_y);
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00264$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00265$
00264$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00265$:
	push	de
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	pop	de
	ld	c, a
;src/player.c:115: if (IS_SOLID(cl_h) || IS_SOLID(cr_h)) {
	ld	a,e
	cp	a,#0x07
	jr	Z, 00152$
	cp	a,#0x09
	jr	Z, 00152$
	cp	a,#0x05
	jr	Z, 00152$
	sub	a, #0x06
	jr	Z, 00152$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00152$
	cp	a,#0x09
	jr	Z, 00152$
	cp	a,#0x05
	jr	Z, 00152$
	sub	a, #0x06
	jr	NZ, 00153$
00152$:
;src/player.c:116: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00149$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00153$
00149$:
;src/player.c:117: p->world_y.b.h = (head_y & ~15) + 16;
	ldhl	sp,	#27
	ld	a, (hl)
	and	a, #0xf0
	add	a, #0x10
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:118: p->world_y.b.l = 0;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:119: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:120: if (p->gravity_flipped) p->on_ground = 1;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00153$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00153$:
;src/player.c:125: if (!p->on_ground) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00171$
;src/player.c:126: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:87: uint8_t py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:126: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00266$
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	(hl), e
	jr	00267$
00266$:
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
00267$:
;src/player.c:127: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00268$
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00270$
	xor	a, a
	jr	00269$
00270$:
	ld	a, #0x07
	jr	00269$
00268$:
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00272$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00273$
00272$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00273$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00269$:
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:128: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00274$
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00276$
	ld	(hl), #0x00
	jr	00275$
00276$:
	ldhl	sp,	#29
	ld	(hl), #0x07
	jr	00275$
00274$:
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00278$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00279$
00278$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00279$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#29
	ld	(hl), a
00275$:
	ldhl	sp,	#29
;src/player.c:129: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00161$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00161$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00161$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00161$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00161$
	cp	a,#0x09
	jr	Z, 00161$
	cp	a,#0x05
	jr	Z, 00161$
	sub	a, #0x06
	jr	NZ, 00171$
00161$:
;src/player.c:130: p->on_ground = 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:131: p->vel_y.w = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00171$:
;src/player.c:136: py = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:137: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#28
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00280$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00281$
00280$:
	ld	a, #0x0e
	ldhl	sp,	#30
	sub	a, (hl)
	jr	NC, 00282$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00283$
00282$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00283$:
00281$:
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/player.c:138: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00284$
	ldhl	sp,	#29
	ld	(hl), #0x07
	jr	00285$
00284$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
	ldhl	sp,	#29
	ld	(hl), a
00285$:
	ldhl	sp,	#29
	ld	a, (hl-)
	ld	(hl), a
;src/player.c:139: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00288$
	ld	c, #0x07
	jr	00289$
00288$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
	ldhl	sp,#29
	ld	(hl), a
	ld	c, (hl)
00289$:
;src/player.c:140: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00172$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00172$
	cp	a,#0x09
	jr	Z, 00172$
	cp	a,#0x05
	jr	Z, 00172$
	sub	a, #0x06
	jr	NZ, 00173$
00172$:
;src/player.c:141: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:142: return 1;
	ld	a, #0x01
	jp	00232$
00173$:
;src/player.c:146: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#30
	sub	a, (hl)
	dec	hl
	dec	hl
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00292$
	ld	a, #0x07
	jr	00293$
00292$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00297$
00296$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00297$:
	call	_col_at_raw_cached
00293$:
	ldhl	sp,	#29
;src/player.c:147: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	(hl+), a
	ld	a, #0x09
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00298$
	ld	c, #0x07
	jr	00299$
00298$:
	ldhl	sp,	#20
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00302$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	jr	00303$
00302$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
00303$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00299$:
	ldhl	sp,	#23
	ld	(hl), c
;src/player.c:148: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#27
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00304$
	ld	a, #0x07
	jr	00305$
00304$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	d, (hl)
	jr	00309$
00308$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	d, (hl)
00309$:
	ld	c, b
	ld	b, e
	ld	e, a
	call	_col_at_raw_cached
00305$:
	ldhl	sp,	#28
;src/player.c:149: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00310$
	ldhl	sp,	#30
	ld	(hl), #0x07
	jr	00311$
00310$:
	ldhl	sp,	#24
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00314$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	jr	00315$
00314$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
00315$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#30
	ld	(hl), a
00311$:
;src/player.c:150: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	dec	a
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00181$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	dec	a
	jr	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00181$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	dec	a
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00181$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	dec	a
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00181$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00182$
00181$:
;src/player.c:151: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:152: return 1;
	ld	a, #0x01
	jp	00232$
00182$:
;src/player.c:158: if (p->on_ground) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:163: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
;src/player.c:158: if (p->on_ground) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00219$
;src/player.c:159: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jp	Z, 00219$
;src/player.c:160: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00214$
;src/player.c:161: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#26
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00316$
	dec	hl
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00317$
00316$:
	ldhl	sp,	#25
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00317$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:162: p->on_ground = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00219$
00214$:
;src/player.c:163: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00219$
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00219$
;src/player.c:164: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/player.c:165: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	Z, 00318$
	ld	de, #0xfe00
	jr	00319$
00318$:
	ld	de, #0x0200
00319$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:166: p->on_ground = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:167: p->ball_switched = 1;
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00219$:
;src/player.c:171: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	NZ, 00221$
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00221$:
;src/player.c:174: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:175: p->anim_timer = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:176: p->anim_frame = 0;
	ldhl	sp,#32
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
;src/player.c:174: if (p->on_ground && p->mode != MODE_BALL) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00227$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	Z, 00227$
;src/player.c:175: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/player.c:176: p->anim_frame = 0;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00228$
00227$:
;src/player.c:178: p->anim_timer += 10;
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
;src/player.c:179: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00228$
;src/player.c:180: p->anim_timer -= 20;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	add	a, #0xec
	ld	e, a
	ld	a, h
	adc	a, #0xff
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:181: p->anim_frame++;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	inc	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:182: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00228$
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00228$:
;src/player.c:187: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	NC, 00231$
;src/player.c:188: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:189: return 1;
	ld	a, #0x01
	jr	00232$
00231$:
;src/player.c:192: p->last_joy = joy;
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
;src/player.c:193: return 0;
	xor	a, a
00232$:
;src/player.c:194: }
	add	sp, #34
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
