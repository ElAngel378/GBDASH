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
;src/player.c:33: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-38
	ldhl	sp,	#36
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
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00252$
00102$:
;src/player.c:40: if (p->level_complete) return 0;
	ldhl	sp,#36
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
	jp	00252$
00104$:
;src/player.c:45: if (p->mode == MODE_SHIP) {
	ldhl	sp,#36
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
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:47: if (joy & J_A) {
	ldhl	sp,	#35
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#36
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
;src/player.c:52: p->vel_y.w += accel;
	ldhl	sp,#36
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
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:108: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
;src/player.c:45: if (p->mode == MODE_SHIP) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
;src/player.c:47: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	ld	e, #0x2a
	jr	NZ, 00255$
	ld	e, #0xd6
00255$:
	ld	a, e
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:50: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	ld	c, #0xde
	jr	NZ, 00257$
	ld	c, #0x22
00257$:
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:52: p->vel_y.w += accel;
	ldhl	sp,	#33
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
;src/player.c:55: if (p->gravity_flipped) {
	ldhl	sp,#6
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
	ldhl	sp,	#33
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
	jr	Z, 01307$
	bit	7, d
	jr	NZ, 01308$
	cp	a, a
	jr	01308$
01307$:
	bit	7, d
	jr	Z, 01308$
	scf
01308$:
	jr	NC, 00109$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x97
	ld	(hl+), a
	ld	(hl), #0xfc
00109$:
;src/player.c:57: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
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
	jr	Z, 01309$
	bit	7, d
	jr	NZ, 01310$
	cp	a, a
	jr	01310$
01309$:
	bit	7, d
	jr	Z, 01310$
	scf
01310$:
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
;src/player.c:59: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ldhl	sp,	#33
	ld	a, #0x69
	sub	a, (hl)
	inc	hl
	ld	a, #0x03
	sbc	a, (hl)
	ld	a, #0x03
	ld	d, a
	bit	7, (hl)
	jr	Z, 01311$
	bit	7, d
	jr	NZ, 01312$
	cp	a, a
	jr	01312$
01311$:
	bit	7, d
	jr	Z, 01312$
	scf
01312$:
	jr	NC, 00113$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:60: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
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
	jr	Z, 01313$
	bit	7, d
	jr	NZ, 01314$
	cp	a, a
	jr	01314$
01313$:
	bit	7, d
	jr	Z, 01314$
	scf
01314$:
	jp	NC, 00128$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xbd
	ld	(hl+), a
	ld	(hl), #0xfb
	jp	00128$
00127$:
;src/player.c:63: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00258$
	ldhl	sp,	#32
	ld	(hl), #0x47
	jr	00259$
00258$:
	ldhl	sp,	#32
	ld	(hl), #0x6b
00259$:
	ldhl	sp,	#32
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
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:66: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
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
	jr	Z, 01317$
	bit	7, d
	jr	NZ, 01318$
	cp	a, a
	jr	01318$
01317$:
	bit	7, d
	jr	Z, 01318$
	scf
01318$:
	jr	NC, 00128$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00128$
00124$:
;src/player.c:68: p->vel_y.w += gravity_val;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:69: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
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
	jr	Z, 01319$
	bit	7, d
	jr	NZ, 01320$
	cp	a, a
	jr	01320$
01319$:
	bit	7, d
	jr	Z, 01320$
	scf
01320$:
	jr	NC, 00128$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:74: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/player.c:75: p->orb_buffered = 1;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:74: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00130$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	bit	4, a
	jr	NZ, 00130$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00130$
;src/player.c:75: p->orb_buffered = 1;
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00130$:
;src/player.c:80: p->world_y.w += p->vel_y.w;
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/player.c:78: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00136$
;src/player.c:79: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
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
	jr	Z, 00260$
	ld	de, #0x0590
	jr	00261$
00260$:
	ld	de, #0xfa70
00261$:
	ldhl	sp,	#33
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00134$:
;src/player.c:80: p->world_y.w += p->vel_y.w;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	ld	d, a
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:81: return 0;
	xor	a, a
	jp	00252$
00136$:
;src/player.c:87: p->world_y.w += p->vel_y.w;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	ld	d, a
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:92: uint8_t py = p->world_y.b.h;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/player.c:93: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#20
;src/player.c:94: const uint8_t* c1 = collision_columns + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#23
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#22
	ld	(hl), a
;src/player.c:95: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:96: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#23
	ld	(hl), a
;src/player.c:100: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:104: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#31
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
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#25
;src/player.c:105: uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(3), foot_y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x03
	ldhl	sp,	#23
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00262$
	ld	a, #0x07
	jr	00263$
00262$:
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00266$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00267$
00266$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00267$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00263$:
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:106: uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), foot_y);
	ld	a, #0x0c
	ldhl	sp,	#23
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00268$
	ld	a, #0x07
	jr	00269$
00268$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00272$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00273$
00272$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00273$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00269$:
	ldhl	sp,	#29
;src/player.c:107: if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01324$
	xor	a, a
01324$:
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 01326$
	xor	a, a
01326$:
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 01328$
	xor	a, a
01328$:
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	ld	a, #0x01
	jr	Z, 01330$
	xor	a, a
01330$:
	ld	c, a
;src/player.c:115: p->world_y.b.l = 0;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:107: if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	or	a, c
	jr	NZ, 00145$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00145$
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
	jr	NZ, 00146$
00145$:
;src/player.c:108: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00142$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00146$
00142$:
;src/player.c:109: uint8_t hit_col = IS_SOLID(cl_f) ? cl_f : cr_f;
	ldhl	sp,	#30
	bit	0, (hl)
	jr	NZ, 00277$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00277$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00277$
	bit	0, c
	jr	Z, 00274$
00277$:
	ldhl	sp,	#27
	ld	c, (hl)
	jr	00275$
00274$:
	ldhl	sp,	#29
	ld	c, (hl)
00275$:
;src/player.c:111: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ldhl	sp,	#24
	ld	a, (hl)
	and	a, #0xf0
	ld	b, a
;src/player.c:110: if (hit_col == COL_BOTTOM) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00138$
;src/player.c:111: p->world_y.b.h = (foot_y & ~15) + 8 - PLAYER_SIZE - 1;
	ld	a, b
	add	a, #0xf8
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00139$
00138$:
;src/player.c:113: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ld	a, b
	add	a, #0xf0
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00139$:
;src/player.c:115: p->world_y.b.l = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:116: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:117: if (!p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00146$
;src/player.c:118: p->on_ground = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:119: p->orb_buffered = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00146$:
;src/player.c:125: int16_t head_y = py;
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:126: uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(3), head_y);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00289$
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00290$
00289$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00290$:
	push	bc
	call	_col_at_raw_cached
	pop	bc
	ldhl	sp,	#25
	ld	(hl), a
;src/player.c:127: uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), head_y);
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00295$
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00296$
00295$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00296$:
	call	_col_at_raw_cached
	ldhl	sp,	#27
;src/player.c:128: if (IS_SOLID(cl_h) || IS_SOLID(cr_h)) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x07
	ld	a, #0x01
	jr	Z, 01341$
	xor	a, a
01341$:
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 01343$
	xor	a, a
01343$:
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 01345$
	xor	a, a
01345$:
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x06
	ld	a, #0x01
	jr	Z, 01347$
	xor	a, a
01347$:
	ld	c, a
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	NZ, 00162$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00162$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00162$
	or	a, c
	jr	NZ, 00162$
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
	jr	NZ, 00163$
00162$:
;src/player.c:129: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00159$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00163$
00159$:
;src/player.c:130: uint8_t hit_col = IS_SOLID(cl_h) ? cl_h : cr_h;
	ldhl	sp,	#29
	bit	0, (hl)
	jr	NZ, 00300$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00300$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00300$
	bit	0, c
	jr	Z, 00297$
00300$:
	ldhl	sp,	#25
	ld	c, (hl)
	jr	00298$
00297$:
	ldhl	sp,	#27
	ld	c, (hl)
00298$:
;src/player.c:132: p->world_y.b.h = (head_y & ~15) + 8;
	ldhl	sp,	#32
	ld	a, (hl)
	and	a, #0xf0
	ld	(hl), a
;src/player.c:131: if (hit_col == COL_TOP) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00155$
;src/player.c:132: p->world_y.b.h = (head_y & ~15) + 8;
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00156$
00155$:
;src/player.c:134: p->world_y.b.h = (head_y & ~15) + 16;
	ldhl	sp,	#32
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00156$:
;src/player.c:136: p->world_y.b.l = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:137: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:138: if (p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00163$
;src/player.c:139: p->on_ground = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:140: p->orb_buffered = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00163$:
;src/player.c:146: if (!p->on_ground) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00181$
;src/player.c:147: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:92: uint8_t py = p->world_y.b.h;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:147: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#34
	ld	(hl-), a
	ld	(hl), e
	jr	00309$
00308$:
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
00309$:
;src/player.c:148: uint8_t gl = COL_AT_PTR(GET_COL_FAST(3), sticky_y);
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rlca
	and	a,#0x01
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00310$
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00312$
	xor	a, a
	jr	00311$
00312$:
	ld	a, #0x07
	jr	00311$
00310$:
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00314$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	jr	00315$
00314$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
00315$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00311$:
	ldhl	sp,	#33
;src/player.c:149: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 3), sticky_y);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00316$
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00318$
	ld	(hl), #0x00
	jr	00317$
00318$:
	ldhl	sp,	#34
	ld	(hl), #0x07
	jr	00317$
00316$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00320$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00321$
00320$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00321$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#34
	ld	(hl), a
00317$:
	ldhl	sp,	#34
;src/player.c:150: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00171$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00171$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00171$
	ldhl	sp,	#33
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
;src/player.c:151: p->on_ground = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:152: p->vel_y.w = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:153: p->orb_buffered = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00181$:
;src/player.c:158: py = p->world_y.b.h;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:159: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00322$
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00323$
00322$:
	ld	a, #0x0e
	ldhl	sp,	#23
	sub	a, (hl)
	jr	NC, 00324$
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00325$
00324$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00325$:
00323$:
	ldhl	sp,	#32
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/player.c:160: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#30
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#24
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
	jr	Z, 00326$
	ld	a, #0x07
	jr	00327$
00326$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00327$:
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:161: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#28
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
	jr	Z, 00330$
	ld	c, #0x07
	jr	00331$
00330$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00331$:
;src/player.c:162: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00182$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00182$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00182$
	ldhl	sp,	#34
	ld	a, (hl)
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
;src/player.c:163: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:164: return 1;
	ld	a, #0x01
	jp	00252$
00183$:
;src/player.c:168: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#23
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00334$
	ld	a, #0x07
	jr	00335$
00334$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00338$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00339$
00338$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00339$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00335$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:169: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#23
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00340$
	ld	a, #0x07
	jr	00341$
00340$:
	ldhl	sp,	#24
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00344$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	jr	00345$
00344$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
00345$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00341$:
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:170: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#31
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00346$
	ld	a, #0x07
	jr	00347$
00346$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00350$
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	d, (hl)
	jr	00351$
00350$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	d, (hl)
00351$:
	ld	c, b
	ld	b, e
	ld	e, a
	call	_col_at_raw_cached
00347$:
	ldhl	sp,	#32
;src/player.c:171: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00352$
	ldhl	sp,	#34
	ld	(hl), #0x07
	jr	00353$
00352$:
	ldhl	sp,	#28
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00356$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00357$
00356$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00357$:
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#34
	ld	(hl), a
00353$:
;src/player.c:172: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	dec	a
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00191$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	dec	a
	jr	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00191$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00191$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	dec	a
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00191$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00192$
00191$:
;src/player.c:173: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:174: return 1;
	ld	a, #0x01
	jp	00252$
00192$:
;src/player.c:180: if (p->on_ground) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:185: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
;src/player.c:180: if (p->on_ground) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00229$
;src/player.c:181: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jp	Z, 00229$
;src/player.c:182: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00224$
;src/player.c:183: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00358$
	dec	hl
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00359$
00358$:
	ldhl	sp,	#29
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00359$:
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:184: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00229$
00224$:
;src/player.c:185: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00229$
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00229$
;src/player.c:186: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#6
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
;src/player.c:187: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	Z, 00360$
	ld	de, #0xfe00
	jr	00361$
00360$:
	ld	de, #0x0200
00361$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:188: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:189: p->ball_switched = 1;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00229$:
;src/player.c:193: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	NZ, 00231$
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00231$:
;src/player.c:196: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:201: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:203: p->anim_timer += 20; // double speed while settling
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:196: if (p->on_ground && p->mode != MODE_BALL) {
	ld	a, c
	or	a, a
	jp	Z, 00247$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jp	Z, 00247$
;src/player.c:201: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	e, #0x06
	call	__moduchar
	ld	a, c
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:202: if (q != 0) {
	or	a, a
	jr	Z, 00240$
;src/player.c:203: p->anim_timer += 20; // double speed while settling
	ldhl	sp,#33
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
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:204: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jp	C, 00248$
;src/player.c:205: p->anim_timer -= 21;
	ldhl	sp,#33
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
;src/player.c:201: uint8_t q = p->anim_frame % 6;
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
;src/player.c:206: if (q >= 3) {
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00235$
;src/player.c:208: p->anim_frame++;
	inc	hl
	inc	c
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/player.c:209: if (p->anim_frame >= 24) {
	ld	a, c
	sub	a, #0x18
	jr	C, 00248$
;src/player.c:210: p->anim_frame = 0;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:211: p->anim_timer = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00248$
00235$:
;src/player.c:215: p->anim_frame--;
	dec	c
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	jr	00248$
00240$:
;src/player.c:219: p->anim_timer = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00248$
00247$:
;src/player.c:222: p->anim_timer += 10;
	ldhl	sp,#33
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
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:223: if (p->anim_timer >= 21) {
	ld	a, c
	sub	a, #0x15
	ld	a, b
	sbc	a, #0x00
	jr	C, 00248$
;src/player.c:224: p->anim_timer -= 21;
	ldhl	sp,#33
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
;src/player.c:225: p->anim_frame++;
	ldhl	sp,#31
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
;src/player.c:226: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00248$
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00248$:
;src/player.c:231: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#42
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
	jr	NC, 00251$
;src/player.c:232: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:233: return 1;
	ld	a, #0x01
	jr	00252$
00251$:
;src/player.c:236: p->last_joy = joy;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#35
	ld	a, (hl)
	ld	(de), a
;src/player.c:237: return 0;
	xor	a, a
00252$:
;src/player.c:238: }
	add	sp, #38
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
