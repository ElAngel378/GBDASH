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
	add	sp, #-39
	ldhl	sp,	#37
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
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00236$
00102$:
;src/player.c:40: if (p->level_complete) return 0;
	ldhl	sp,#37
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
	jp	00236$
00104$:
;src/player.c:45: if (p->mode == MODE_SHIP) {
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:47: if (joy & J_A) {
	ldhl	sp,	#36
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
;src/player.c:52: p->vel_y.w += accel;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:108: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
;src/player.c:45: if (p->mode == MODE_SHIP) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
;src/player.c:47: if (joy & J_A) {
	dec	a
	jp	NZ,00127$
	ldhl	sp,	#8
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:48: accel = (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	ld	e, #0x2a
	jr	NZ, 00239$
	ld	e, #0xd6
00239$:
	ld	a, e
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	jr	00107$
00106$:
;src/player.c:50: accel = (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	ld	c, #0xde
	jr	NZ, 00241$
	ld	c, #0x22
00241$:
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
00107$:
;src/player.c:52: p->vel_y.w += accel;
	ldhl	sp,	#34
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:55: if (p->gravity_flipped) {
	ldhl	sp,#10
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
	ldhl	sp,	#34
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
	jr	Z, 01183$
	bit	7, d
	jr	NZ, 01184$
	cp	a, a
	jr	01184$
01183$:
	bit	7, d
	jr	Z, 01184$
	scf
01184$:
	jr	NC, 00109$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x97
	ld	(hl+), a
	ld	(hl), #0xfc
00109$:
;src/player.c:57: if (p->vel_y.w > SHIP_MAX_VEL_DOWN) p->vel_y.w = SHIP_MAX_VEL_DOWN;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
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
	jr	Z, 01185$
	bit	7, d
	jr	NZ, 01186$
	cp	a, a
	jr	01186$
01185$:
	bit	7, d
	jr	Z, 01186$
	scf
01186$:
	jp	NC, 00128$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x43
	ld	(hl+), a
	ld	(hl), #0x04
	jp	00128$
00117$:
;src/player.c:59: if (p->vel_y.w > SHIP_MAX_VEL_UP) p->vel_y.w = SHIP_MAX_VEL_UP;
	ldhl	sp,	#34
	ld	a, #0x69
	sub	a, (hl)
	inc	hl
	ld	a, #0x03
	sbc	a, (hl)
	ld	a, #0x03
	ld	d, a
	bit	7, (hl)
	jr	Z, 01187$
	bit	7, d
	jr	NZ, 01188$
	cp	a, a
	jr	01188$
01187$:
	bit	7, d
	jr	Z, 01188$
	scf
01188$:
	jr	NC, 00113$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x03
00113$:
;src/player.c:60: if (p->vel_y.w < -SHIP_MAX_VEL_DOWN) p->vel_y.w = -SHIP_MAX_VEL_DOWN;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
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
	jr	Z, 01189$
	bit	7, d
	jr	NZ, 01190$
	cp	a, a
	jr	01190$
01189$:
	bit	7, d
	jr	Z, 01190$
	scf
01190$:
	jp	NC, 00128$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xbd
	ld	(hl+), a
	ld	(hl), #0xfb
	jp	00128$
00127$:
;src/player.c:63: uint16_t gravity_val = (p->mode == MODE_BALL) ? BALL_GRAVITY : GRAVITY;
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00242$
	ldhl	sp,	#33
	ld	(hl), #0x47
	jr	00243$
00242$:
	ldhl	sp,	#33
	ld	(hl), #0x6b
00243$:
	ldhl	sp,	#33
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
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#31
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:66: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
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
	jr	Z, 01193$
	bit	7, d
	jr	NZ, 01194$
	cp	a, a
	jr	01194$
01193$:
	bit	7, d
	jr	Z, 01194$
	scf
01194$:
	jr	NC, 00128$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00128$
00124$:
;src/player.c:68: p->vel_y.w += gravity_val;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:69: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
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
	jr	Z, 01195$
	bit	7, d
	jr	NZ, 01196$
	cp	a, a
	jr	01196$
01195$:
	bit	7, d
	jr	Z, 01196$
	scf
01196$:
	jr	NC, 00128$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00128$:
;src/player.c:74: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src/player.c:75: p->orb_buffered = 1;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
;src/player.c:74: if ((joy & J_A) && !(p->last_joy & J_A) && !p->on_ground) {
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jr	Z, 00130$
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	bit	4, a
	jr	NZ, 00130$
	ldhl	sp,#16
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
	ldhl	sp,#37
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
;src/player.c:78: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00136$
;src/player.c:79: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jr	Z, 00134$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00244$
	ld	de, #0x0590
	jr	00245$
00244$:
	ld	de, #0xfa70
00245$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00134$:
;src/player.c:80: p->world_y.w += p->vel_y.w;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:81: return 0;
	xor	a, a
	jp	00236$
00136$:
;src/player.c:87: p->world_y.w += p->vel_y.w;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:92: uint8_t py = p->world_y.b.h;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/player.c:93: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#24
;src/player.c:94: const uint8_t* c1 = collision_columns + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:95: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:96: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:100: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:104: int16_t foot_y = py + PLAYER_SIZE;
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#32
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
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#29
;src/player.c:105: uint8_t cl_f = COL_AT_PTR(GET_COL_FAST(2), foot_y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#34
	ld	(hl), #0x00
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, #0x02
	ldhl	sp,	#27
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00246$
	ld	a, #0x07
	jr	00247$
00246$:
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00250$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00251$
00250$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00251$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00247$:
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:106: uint8_t cr_f = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), foot_y);
	ld	a, #0x0d
	ldhl	sp,	#27
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00252$
	inc	hl
	ld	(hl), #0x07
	jr	00253$
00252$:
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00256$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	jr	00257$
00256$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
00257$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#35
	ld	(hl), a
00253$:
	ldhl	sp,	#35
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:110: p->world_y.b.l = 0;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:107: if (IS_SOLID(cl_f) || IS_SOLID(cr_f)) {
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00142$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00142$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00142$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00142$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00142$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00142$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00142$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00143$
00142$:
;src/player.c:108: if (!p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00139$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00143$
00139$:
;src/player.c:109: p->world_y.b.h = (foot_y & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#28
	ld	a, (hl)
	and	a, #0xf0
	add	a, #0xf0
	ldhl	sp,	#20
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:110: p->world_y.b.l = 0;
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:111: p->vel_y.w = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:112: if (!p->gravity_flipped) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00143$
;src/player.c:113: p->on_ground = 1;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:114: p->orb_buffered = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00143$:
;src/player.c:120: int16_t head_y = py;
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:121: uint8_t cl_h = COL_AT_PTR(GET_COL_FAST(2), head_y);
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00262$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00263$
00262$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00263$:
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	e, a
;src/player.c:122: uint8_t cr_h = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), head_y);
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00268$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00269$
00268$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00269$:
	push	de
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	pop	de
	ld	c, a
;src/player.c:123: if (IS_SOLID(cl_h) || IS_SOLID(cr_h)) {
	ld	a,e
	cp	a,#0x07
	jr	Z, 00156$
	cp	a,#0x09
	jr	Z, 00156$
	cp	a,#0x05
	jr	Z, 00156$
	sub	a, #0x06
	jr	Z, 00156$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00156$
	cp	a,#0x09
	jr	Z, 00156$
	cp	a,#0x05
	jr	Z, 00156$
	sub	a, #0x06
	jr	NZ, 00157$
00156$:
;src/player.c:124: if (p->gravity_flipped || p->mode == MODE_SHIP) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00153$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00157$
00153$:
;src/player.c:125: p->world_y.b.h = (head_y & ~15) + 16;
	ldhl	sp,	#33
	ld	a, (hl)
	and	a, #0xf0
	add	a, #0x10
	ldhl	sp,	#20
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:126: p->world_y.b.l = 0;
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:127: p->vel_y.w = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:128: if (p->gravity_flipped) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00157$
;src/player.c:129: p->on_ground = 1;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:130: p->orb_buffered = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00157$:
;src/player.c:136: if (!p->on_ground) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00175$
;src/player.c:137: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:92: uint8_t py = p->world_y.b.h;
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:137: int16_t sticky_y = (p->gravity_flipped) ? (p->world_y.b.h - 1) : (p->world_y.b.h + PLAYER_SIZE + 1);
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00270$
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#35
	ld	(hl-), a
	ld	(hl), e
	jr	00271$
00270$:
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), a
00271$:
;src/player.c:138: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#28
	ld	(hl), #0x00
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00272$
	ldhl	sp,	#35
	ld	a, (hl)
	or	a, a
	jr	Z, 00274$
	xor	a, a
	jr	00273$
00274$:
	ld	a, #0x07
	jr	00273$
00272$:
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00276$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00277$
00276$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00277$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00273$:
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:139: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00278$
	ldhl	sp,	#35
	ld	a, (hl)
	or	a, a
	jr	Z, 00280$
	ld	(hl), #0x00
	jr	00279$
00280$:
	ldhl	sp,	#35
	ld	(hl), #0x07
	jr	00279$
00278$:
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00282$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00283$
00282$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00283$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#35
	ld	(hl), a
00279$:
	ldhl	sp,	#35
;src/player.c:140: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00165$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00165$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00165$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00165$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00165$
	cp	a,#0x09
	jr	Z, 00165$
	cp	a,#0x05
	jr	Z, 00165$
	sub	a, #0x06
	jr	NZ, 00175$
00165$:
;src/player.c:141: p->on_ground = 1;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:142: p->vel_y.w = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:143: p->orb_buffered = 0;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00175$:
;src/player.c:148: py = p->world_y.b.h;
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:149: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00284$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00285$
00284$:
	ld	a, #0x0e
	ldhl	sp,	#27
	sub	a, (hl)
	jr	NC, 00286$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00287$
00286$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00287$:
00285$:
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/player.c:150: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#30
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
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#18
	ld	(hl), #0x00
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00288$
	ldhl	sp,	#35
	ld	(hl), #0x07
	jr	00289$
00288$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
	ldhl	sp,	#35
	ld	(hl), a
00289$:
	ldhl	sp,	#35
	ld	a, (hl-)
	ld	(hl), a
;src/player.c:151: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00292$
	ld	c, #0x07
	jr	00293$
00292$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
	ldhl	sp,#35
	ld	(hl), a
	ld	c, (hl)
00293$:
;src/player.c:152: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00176$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00176$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00176$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00176$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00176$
	cp	a,#0x09
	jr	Z, 00176$
	cp	a,#0x05
	jr	Z, 00176$
	sub	a, #0x06
	jr	NZ, 00177$
00176$:
;src/player.c:153: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:154: return 1;
	ld	a, #0x01
	jp	00236$
00177$:
;src/player.c:158: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#27
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00296$
	ld	a, #0x07
	jr	00297$
00296$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00300$
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00301$
00300$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00301$:
	call	_col_at_raw_cached
00297$:
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:159: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#27
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00302$
	ld	c, #0x07
	jr	00303$
00302$:
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	or	a, a
	jr	Z, 00306$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	jr	00307$
00306$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
00307$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00303$:
	ldhl	sp,	#28
	ld	(hl), c
;src/player.c:160: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#32
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00308$
	ld	a, #0x07
	jr	00309$
00308$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00312$
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	d, (hl)
	jr	00313$
00312$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	d, (hl)
00313$:
	ld	c, b
	ld	b, e
	ld	e, a
	call	_col_at_raw_cached
00309$:
	ldhl	sp,	#33
;src/player.c:161: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00314$
	ldhl	sp,	#35
	ld	(hl), #0x07
	jr	00315$
00314$:
	ldhl	sp,	#29
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	or	a, a
	jr	Z, 00318$
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00319$
00318$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00319$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#35
	ld	(hl), a
00315$:
;src/player.c:162: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	dec	a
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00185$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	dec	a
	jr	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00185$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	dec	a
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00185$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	dec	a
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00185$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00186$
00185$:
;src/player.c:163: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:164: return 1;
	ld	a, #0x01
	jp	00236$
00186$:
;src/player.c:170: if (p->on_ground) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:175: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
;src/player.c:170: if (p->on_ground) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00223$
;src/player.c:171: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jp	Z, 00223$
;src/player.c:172: if (p->mode == MODE_CUBE) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00218$
;src/player.c:173: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00320$
	dec	hl
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00321$
00320$:
	ldhl	sp,	#30
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00321$:
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:174: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00223$
00218$:
;src/player.c:175: } else if (p->mode == MODE_BALL && !p->ball_switched) {
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00223$
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00223$
;src/player.c:176: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#10
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
;src/player.c:177: p->vel_y.w = (p->gravity_flipped) ? -BALL_SWITCH_VEL : BALL_SWITCH_VEL;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	Z, 00322$
	ld	de, #0xfe00
	jr	00323$
00322$:
	ld	de, #0x0200
00323$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:178: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:179: p->ball_switched = 1;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00223$:
;src/player.c:183: if (!(joy & J_A)) p->ball_switched = 0;
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jr	NZ, 00225$
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00225$:
;src/player.c:186: if (p->on_ground && p->mode != MODE_BALL) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:187: p->anim_timer = 0;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:188: p->anim_frame = 0;
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
;src/player.c:186: if (p->on_ground && p->mode != MODE_BALL) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00231$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	Z, 00231$
;src/player.c:187: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/player.c:188: p->anim_frame = 0;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00232$
00231$:
;src/player.c:190: p->anim_timer += 10;
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
;src/player.c:191: if (p->anim_timer >= 21) {
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jr	C, 00232$
;src/player.c:192: p->anim_timer -= 21;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	add	a, #0xeb
	ld	e, a
	ld	a, h
	adc	a, #0xff
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:193: p->anim_frame++;
	ldhl	sp,#33
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
;src/player.c:194: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00232$
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00232$:
;src/player.c:199: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#43
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
	jr	NC, 00235$
;src/player.c:200: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:201: return 1;
	ld	a, #0x01
	jr	00236$
00235$:
;src/player.c:204: p->last_joy = joy;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#36
	ld	a, (hl)
	ld	(de), a
;src/player.c:205: return 0;
	xor	a, a
00236$:
;src/player.c:206: }
	add	sp, #39
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
