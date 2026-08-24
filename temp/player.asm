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
;src/player.c:24: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:26: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:27: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:28: }
	ret
;src/player.c:35: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-37
	ldhl	sp,	#35
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:41: if (p->dead) return 1;
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
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00248$
00102$:
;src/player.c:43: if (p->level_complete) {
	ldhl	sp,#35
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
;src/player.c:44: return 0;
	xor	a, a
	jp	00248$
00104$:
;src/player.c:47: if (p->mode == MODE_SHIP) {
	ldhl	sp,#35
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
;src/player.c:48: if (joy & J_A) {
	ldhl	sp,	#34
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#28
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:49: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#35
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
;src/player.c:58: if (!p->on_ground) {
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
;src/player.c:47: if (p->mode == MODE_SHIP) {
	ld	a, c
	dec	a
	jp	NZ, 00122$
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	c, a
	pop	af
;src/player.c:49: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:48: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#28
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:49: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00250$
	ld	hl, #0x0034
	jr	00251$
00250$:
	ld	hl, #0xffcc
00251$:
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00107$
00106$:
;src/player.c:51: p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00252$
	ld	hl, #0xffde
	jr	00253$
00252$:
	ld	hl, #0x0022
00253$:
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00107$:
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00254$
	ld	hl, #0x0369
	jr	00255$
00254$:
	ld	hl, #0x0443
00255$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01336$
	bit	7, d
	jr	NZ, 01337$
	cp	a, a
	jr	01337$
01336$:
	bit	7, d
	jr	Z, 01337$
	scf
01337$:
	jr	NC, 00109$
;src/player.c:54: p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00256$
	ld	bc, #0x0369
	jr	00257$
00256$:
	ld	bc, #0x0443
00257$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00109$:
;src/player.c:55: if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00258$
	ld	hl, #0xfbbd
	jr	00259$
00258$:
	ld	hl, #0xfc97
00259$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01338$
	bit	7, d
	jr	NZ, 01339$
	cp	a, a
	jr	01339$
01338$:
	bit	7, d
	jr	Z, 01339$
	scf
01339$:
	jp	NC, 00123$
;src/player.c:56: p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00260$
	ld	de, #0xfbbd
	jr	00261$
00260$:
	ld	de, #0xfc97
00261$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jp	00123$
00122$:
;src/player.c:58: if (!p->on_ground) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00123$
;src/player.c:59: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ld	a, c
	sub	a, #0x02
	ld	c, #0x66
	jr	Z, 00263$
	ld	c, #0x67
00263$:
	ld	b, #0x00
;src/player.c:60: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
;src/player.c:61: p->vel_y.w -= gravity_val;
	ld	e, l
	ld	d, a
;src/player.c:60: if (p->gravity_flipped) {
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/player.c:61: p->vel_y.w -= gravity_val;
	ld	a, e
	sub	a, c
	ld	c, a
	ld	a, d
	sbc	a, b
	ld	b, a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:62: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00123$
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00123$
00117$:
;src/player.c:64: p->vel_y.w += gravity_val;
	ld	a, e
	add	a, c
	ld	c, a
	ld	a, d
	adc	a, b
	ld	b, a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:65: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#6
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
	jr	Z, 01342$
	bit	7, d
	jr	NZ, 01343$
	cp	a, a
	jr	01343$
01342$:
	bit	7, d
	jr	Z, 01343$
	scf
01343$:
	jr	NC, 00123$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00123$:
;src/player.c:72: p->world_y.w += p->vel_y.w;
	ldhl	sp,#35
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
;src/player.c:70: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00127$
;src/player.c:71: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#28
	or	a, (hl)
	jr	Z, 00125$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00264$
	dec	hl
	ld	a, #0xfc
	ld	(hl+), a
	ld	(hl), #0x04
	jr	00265$
00264$:
	ldhl	sp,	#32
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xfb
00265$:
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00125$:
;src/player.c:72: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:73: return 0;
	xor	a, a
	jp	00248$
00127$:
;src/player.c:76: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	or	a, a
	jr	NZ, 00137$
	ldhl	sp,	#28
	or	a, (hl)
	jr	Z, 00137$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00137$
;src/player.c:77: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00266$
	ld	bc, #0x04fc
	jr	00267$
00266$:
	ld	bc, #0xfb04
00267$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:78: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00138$
00137$:
;src/player.c:79: } else if (p->mode == MODE_BALL) {
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00138$
;src/player.c:80: if ((joy & J_A) && !p->ball_switched && p->on_ground) {
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#28
	or	a, (hl)
	jr	Z, 00129$
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00129$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00129$
;src/player.c:81: p->gravity_flipped = !p->gravity_flipped;
	dec	hl
	dec	hl
	dec	hl
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
;src/player.c:82: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	or	a, a
	jr	Z, 00268$
	ldhl	sp,	#32
	ld	a, #0x9a
	ld	(hl+), a
	ld	(hl), #0xfd
	jr	00269$
00268$:
	ldhl	sp,	#32
	ld	a, #0x66
	ld	(hl+), a
	ld	(hl), #0x02
00269$:
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:83: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:84: p->ball_switched = 1;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00129$:
;src/player.c:86: if (!(joy & J_A)) {
	xor	a, a
	ldhl	sp,	#28
	or	a, (hl)
	jr	NZ, 00138$
;src/player.c:87: p->ball_switched = 0;
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00138$:
;src/player.c:91: uint8_t py = p->world_y.b.h;
	ldhl	sp,#35
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
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:92: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#15
;src/player.c:93: const uint8_t* c1 = collision_columns + 16;
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
;src/player.c:95: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:96: uint8_t threshold = 16 - x_mod_16;
	ld	a, #0x10
	sub	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/player.c:100: uint8_t front_mid = COL_AT_PTR(p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00270$
	ld	a, #0x07
	jr	00271$
00270$:
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00274$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00275$
00274$:
	ld	a, #0x0f
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00276$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00277$
00276$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00277$:
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00275$:
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00271$:
;src/player.c:102: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00141$
	cp	a, #0x09
	jr	Z, 00141$
	cp	a, #0x05
	jr	Z, 00141$
	sub	a, #0x06
	jr	NZ, 00142$
00141$:
;src/player.c:103: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:104: return 1;
	ld	a, #0x01
	jp	00248$
00142$:
;src/player.c:107: p->world_y.w += p->vel_y.w;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#28
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:108: uint8_t ny = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:109: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:111: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl+)
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
	ldhl	sp,	#26
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00278$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00279$
00278$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00279$:
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
;src/player.c:49: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#30
	ld	(hl), c
	inc	hl
;src/player.c:112: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00280$
	inc	hl
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01352$
	bit	7, d
	jr	NZ, 01353$
	cp	a, a
	jr	01353$
01352$:
	bit	7, d
	jr	Z, 01353$
	scf
01353$:
	ld	a, #0x00
	rla
	xor	a, #0x01
	jr	00281$
00280$:
	ldhl	sp,	#31
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
00281$:
	ld	c, a
;src/player.c:115: uint8_t hit_foot = 0;
	ldhl	sp,	#26
	ld	(hl), #0x00
;src/player.c:117: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ld	a, #0x02
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:118: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:116: if (falling) {
	ld	a, c
	or	a, a
	jp	Z, 00156$
;src/player.c:117: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	inc	hl
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00282$
	ld	a, #0x07
	jr	00283$
00282$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00286$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jr	00287$
00286$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00287$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
00283$:
	ldhl	sp,	#31
;src/player.c:118: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00288$
	inc	hl
	ld	(hl), #0x07
	jr	00289$
00288$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00292$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00293$
00292$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00293$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#33
	ld	(hl), a
00289$:
	ldhl	sp,	#33
;src/player.c:119: if (IS_SOLID(cl) || IS_SOLID(cr)) hit_foot = 1;
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00146$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00146$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00146$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00146$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00146$
	cp	a,#0x09
	jr	Z, 00146$
	cp	a,#0x05
	jr	Z, 00146$
	sub	a, #0x06
	jr	NZ, 00156$
00146$:
	ldhl	sp,	#26
	ld	(hl), #0x01
00156$:
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:124: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#21
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:126: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:129: p->world_y.b.l = 0;
	ldhl	sp,#35
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
;src/player.c:124: py = ((ny >> 4) + 1) << 4;
;src/player.c:126: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	add	a, #0x0f
;src/player.c:124: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	inc	(hl)
;src/player.c:126: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	a, (hl)
	and	a, #0xf0
;src/player.c:124: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
;src/player.c:126: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0xf0
	ld	(hl), a
;src/player.c:122: if (hit_foot) {
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00199$
;src/player.c:123: if (p->gravity_flipped) {
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
;src/player.c:124: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:126: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00158$:
;src/player.c:128: p->world_y.b.h = py;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(de), a
;src/player.c:129: p->world_y.b.l = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:130: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:131: p->on_ground = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00200$
00199$:
;src/player.c:135: if (p->mode == MODE_SHIP) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00161$
;src/player.c:136: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE) : ny;
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00294$
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00162$
00294$:
	ldhl	sp,	#22
	ld	e, (hl)
	ld	d, #0x00
	jr	00162$
00161$:
;src/player.c:138: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	jr	00297$
00296$:
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
00297$:
00162$:
;src/player.c:141: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	inc	sp
	inc	sp
	push	de
	ldhl	sp,	#25
	ld	(hl), #0x00
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00298$
	ld	a, #0x07
	jr	00299$
00298$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00302$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00303$
00302$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00303$:
	pop	bc
	push	bc
	call	_col_at_raw_cached
00299$:
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:142: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ldhl	sp,	#26
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00304$
	inc	hl
	ld	(hl), #0x07
	jr	00305$
00304$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	jr	00309$
00308$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
00309$:
	pop	bc
	push	bc
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#26
	ld	(hl), a
00305$:
	ldhl	sp,	#26
	ld	c, (hl)
;src/player.c:144: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00188$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00188$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00188$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00188$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00188$
	cp	a,#0x09
	jr	Z, 00188$
	cp	a,#0x05
	jr	Z, 00188$
	sub	a, #0x06
	jr	NZ, 00189$
00188$:
;src/player.c:145: if (p->mode == MODE_CUBE) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00167$
;src/player.c:146: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:147: return 1;
	ld	a, #0x01
	jp	00248$
00167$:
;src/player.c:149: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
	ld	a, (hl)
	or	a, a
;src/player.c:150: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00165$
;src/player.c:152: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(hl), a
00165$:
;src/player.c:154: p->world_y.b.h = py;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(de), a
;src/player.c:155: p->world_y.b.l = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:156: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00200$
00189$:
;src/player.c:159: py = ny;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:162: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00310$
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
	ldhl	sp,	#32
	ld	(hl-), a
	ld	(hl), e
	jr	00311$
00310$:
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
00311$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:163: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#30
	ld	(hl), #0x00
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00312$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00314$
	xor	a, a
	jr	00313$
00314$:
	ld	a, #0x07
	jr	00313$
00312$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00316$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00317$
00316$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00317$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00313$:
	ldhl	sp,	#29
;src/player.c:164: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00318$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00320$
	ld	(hl), #0x00
	jr	00319$
00320$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00319$
00318$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00322$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00323$
00322$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00323$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#32
	ld	(hl), a
00319$:
	ldhl	sp,	#32
	ld	c, (hl)
;src/player.c:166: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00179$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00179$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00179$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00179$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00179$
	cp	a,#0x09
	jr	Z, 00179$
	cp	a,#0x05
	jr	Z, 00179$
	sub	a, #0x06
	jr	NZ, 00200$
00179$:
;src/player.c:167: p->on_ground = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:168: if (p->mode == MODE_CUBE) p->vel_y.w = 0;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00177$
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00200$
00177$:
;src/player.c:169: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:53: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/player.c:49: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:169: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00174$
	dec	hl
	bit	7, (hl)
	jr	Z, 00200$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00200$
00174$:
;src/player.c:170: else { if (p->vel_y.w > 0) p->vel_y.w = 0; }
	ldhl	sp,	#30
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01383$
	bit	7, d
	jr	NZ, 01384$
	cp	a, a
	jr	01384$
01383$:
	bit	7, d
	jr	Z, 01384$
	scf
01384$:
	jr	NC, 00200$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00200$:
;src/player.c:175: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00324$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	jr	00325$
00324$:
	ld	a, #0x0e
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00326$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00327$
00326$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00327$:
	ld	b, e
	ld	e, a
00325$:
	ldhl	sp,	#31
	ld	a, b
	ld	(hl+), a
;src/player.c:176: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#27
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
	ldhl	sp,	#23
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
	jr	Z, 00328$
	ld	a, #0x07
	jr	00329$
00328$:
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00329$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:177: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#30
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
	jr	Z, 00332$
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00333$
00332$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#32
	ld	(hl), a
00333$:
	ldhl	sp,	#32
;src/player.c:179: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00201$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00201$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00201$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00201$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00201$
	cp	a,#0x09
	jr	Z, 00201$
	cp	a,#0x05
	jr	Z, 00201$
	sub	a, #0x06
	jr	NZ, 00202$
00201$:
;src/player.c:180: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:181: return 1;
	ld	a, #0x01
	jp	00248$
00202$:
;src/player.c:184: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00336$
	ld	a, #0x07
	jr	00337$
00336$:
	ldhl	sp,	#23
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00340$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00341$
00340$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00341$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00337$:
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:185: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00342$
	inc	hl
	ld	(hl), #0x07
	jr	00343$
00342$:
	ldhl	sp,	#23
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00346$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00347$
00346$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00347$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#26
	ld	(hl), a
00343$:
	ldhl	sp,	#26
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:186: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00348$
	ld	a, #0x07
	jr	00349$
00348$:
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00352$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00353$
00352$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00353$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00349$:
	ldhl	sp,	#31
;src/player.c:187: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00354$
	ld	c, #0x07
	jr	00355$
00354$:
	ldhl	sp,	#27
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00358$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00359$
00358$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00359$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00355$:
;src/player.c:189: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00210$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	dec	a
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00210$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	dec	a
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00210$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00210$
	ld	a,c
	cp	a,#0x08
	jr	Z, 00210$
	cp	a,#0x03
	jr	Z, 00210$
	cp	a,#0x04
	jr	Z, 00210$
	cp	a,#0x02
	jr	Z, 00210$
	dec	a
	jr	Z, 00210$
	ld	a,c
	cp	a,#0x10
	jr	Z, 00210$
	sub	a, #0x11
	jr	NZ, 00211$
00210$:
;src/player.c:190: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:191: return 1;
	ld	a, #0x01
	jp	00248$
00211$:
;src/player.c:194: if (p->on_ground) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:195: p->anim_timer = 0;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:196: p->anim_frame = 0;
	ldhl	sp,#35
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
;src/player.c:194: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00244$
;src/player.c:195: p->anim_timer = 0;
;src/player.c:196: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00245$
00244$:
;src/player.c:198: p->anim_timer += 10;
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
;src/player.c:199: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00245$
;src/player.c:200: p->anim_timer -= 20;
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
;src/player.c:201: p->anim_frame++;
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
;src/player.c:202: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00245$
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00245$:
;src/player.c:206: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#41
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
	jr	NC, 00247$
;src/player.c:207: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:208: return 1;
	ld	a, #0x01
	jr	00248$
00247$:
;src/player.c:211: p->last_joy = joy;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#34
	ld	a, (hl)
	ld	(bc), a
;src/player.c:212: return 0;
	xor	a, a
00248$:
;src/player.c:213: }
	add	sp, #37
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
