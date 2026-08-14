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
;src/player.c:18: p->touching_orb = 0;
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->level_complete = 0;
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x00
;src/player.c:20: p->sp_idx = 0;
	ld	hl, #0x0013
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:23: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:25: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:26: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:27: }
	ret
;src/player.c:34: uint8_t player_update(
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
;src/player.c:40: if (p->dead) return 1;
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
	jp	00239$
00102$:
;src/player.c:42: if (p->level_complete) {
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00104$
;src/player.c:43: return 0;
	xor	a, a
	jp	00239$
00104$:
;src/player.c:46: if (p->mode == MODE_SHIP) {
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
;src/player.c:47: if (joy & J_A) {
	ldhl	sp,	#34
	ld	a, (hl-)
	dec	hl
	and	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
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
;src/player.c:57: if (!p->on_ground) {
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
;src/player.c:46: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00122$
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#26
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:47: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#32
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00241$
	ldhl	sp,	#28
	ld	a, #0x34
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00242$
00241$:
	ldhl	sp,	#28
	ld	a, #0xcc
	ld	(hl+), a
	ld	(hl), #0xff
00242$:
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#26
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
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00107$
00106$:
;src/player.c:50: p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00243$
	ld	de, #0xffde
	jr	00244$
00243$:
	ld	de, #0x0022
00244$:
	ldhl	sp,	#26
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
	ldhl	sp,	#31
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00245$
	ld	hl, #0x0369
	jr	00246$
00245$:
	ld	hl, #0x0443
00246$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01274$
	bit	7, d
	jr	NZ, 01275$
	cp	a, a
	jr	01275$
01274$:
	bit	7, d
	jr	Z, 01275$
	scf
01275$:
	jr	NC, 00109$
;src/player.c:53: p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00247$
	ld	bc, #0x0369
	jr	00248$
00247$:
	ld	bc, #0x0443
00248$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00109$:
;src/player.c:54: if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
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
	ldhl	sp,	#31
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00249$
	ld	hl, #0xfbbd
	jr	00250$
00249$:
	ld	hl, #0xfc97
00250$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01276$
	bit	7, d
	jr	NZ, 01277$
	cp	a, a
	jr	01277$
01276$:
	bit	7, d
	jr	Z, 01277$
	scf
01277$:
	jp	NC, 00123$
;src/player.c:55: p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00251$
	ld	de, #0xfbbd
	jr	00252$
00251$:
	ld	de, #0xfc97
00252$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00123$
00122$:
;src/player.c:57: if (!p->on_ground) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00123$
;src/player.c:58: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:58: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:59: p->vel_y.w -= GRAVITY;
	ld	bc, #0xff99
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:60: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ld	a, b
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00123$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00123$
00117$:
;src/player.c:62: p->vel_y.w += GRAVITY;
	ld	bc, #0x0067
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:63: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x06
	xor	a, a
	cp	a, c
	ld	a, #0x06
	sbc	a, b
	bit	7, e
	jr	Z, 01278$
	bit	7, d
	jr	NZ, 01279$
	cp	a, a
	jr	01279$
01278$:
	bit	7, d
	jr	Z, 01279$
	scf
01279$:
	jr	NC, 00123$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00123$:
;src/player.c:70: p->world_y.w += p->vel_y.w;
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
;src/player.c:68: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00127$
;src/player.c:69: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#32
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
	jr	Z, 00253$
	dec	hl
	ld	a, #0xfc
	ld	(hl+), a
	ld	(hl), #0x04
	jr	00254$
00253$:
	ldhl	sp,	#32
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xfb
00254$:
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
;src/player.c:70: p->world_y.w += p->vel_y.w;
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
;src/player.c:71: return 0;
	xor	a, a
	jp	00239$
00127$:
;src/player.c:74: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00129$
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00129$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00129$
;src/player.c:75: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00255$
	dec	hl
	ld	a, #0xfc
	ld	(hl+), a
	ld	(hl), #0x04
	jr	00256$
00255$:
	ldhl	sp,	#32
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xfb
00256$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:76: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00129$:
;src/player.c:79: uint8_t py = p->world_y.b.h;
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
;src/player.c:80: const uint8_t* c0 = collision_columns;
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#15
;src/player.c:81: const uint8_t* c1 = collision_columns + 16;
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
;src/player.c:83: uint8_t x_mod_16 = (uint8_t)p->world_x & 0x0F;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
;src/player.c:84: uint8_t threshold = 16 - x_mod_16;
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, #0x10
	sub	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/player.c:88: uint8_t front_mid = COL_AT_PTR(p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE), py + 8);
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
	jr	Z, 00257$
	ld	a, #0x07
	jr	00258$
00257$:
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
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00261$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00262$
00261$:
	ld	a, #0x0f
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00263$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00264$
00263$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00264$:
00262$:
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00258$:
;src/player.c:90: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00132$
	cp	a, #0x09
	jr	Z, 00132$
	cp	a, #0x05
	jr	Z, 00132$
	sub	a, #0x06
	jr	NZ, 00133$
00132$:
;src/player.c:91: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:92: return 1;
	ld	a, #0x01
	jp	00239$
00133$:
;src/player.c:95: p->world_y.w += p->vel_y.w;
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
;src/player.c:96: uint8_t ny = p->world_y.b.h;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:97: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:99: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
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
	jr	Z, 00265$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00266$
00265$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00266$:
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#30
	ld	(hl), c
	inc	hl
;src/player.c:100: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00267$
	inc	hl
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01286$
	bit	7, d
	jr	NZ, 01287$
	cp	a, a
	jr	01287$
01286$:
	bit	7, d
	jr	Z, 01287$
	scf
01287$:
	ld	a, #0x00
	rla
	xor	a, #0x01
	jr	00268$
00267$:
	ldhl	sp,	#31
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
00268$:
	ld	c, a
;src/player.c:103: uint8_t hit_foot = 0;
	ldhl	sp,	#26
	ld	(hl), #0x00
;src/player.c:105: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ld	a, #0x02
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:106: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#18
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:104: if (falling) {
	ld	a, c
	or	a, a
	jp	Z, 00147$
;src/player.c:105: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
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
	jr	Z, 00269$
	ld	a, #0x07
	jr	00270$
00269$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00273$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jr	00274$
00273$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00274$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
00270$:
	ldhl	sp,	#31
;src/player.c:106: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	(hl+), a
	ld	a, (hl+)
	or	a, (hl)
	jr	Z, 00275$
	ld	c, #0x07
	jr	00276$
00275$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00279$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00280$
00279$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00280$:
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
	ld	c, a
00276$:
;src/player.c:107: if (IS_SOLID(cl) || IS_SOLID(cr)) hit_foot = 1;
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00137$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00137$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00137$
	ldhl	sp,	#31
	ld	a, (hl)
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
	jr	NZ, 00147$
00137$:
	ldhl	sp,	#26
	ld	(hl), #0x01
00147$:
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:112: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#21
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:114: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:117: p->world_y.b.l = 0;
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
;src/player.c:112: py = ((ny >> 4) + 1) << 4;
;src/player.c:114: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	add	a, #0x0f
;src/player.c:112: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	inc	(hl)
;src/player.c:114: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	a, (hl)
	and	a, #0xf0
;src/player.c:112: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
;src/player.c:114: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0xf0
	ld	(hl), a
;src/player.c:110: if (hit_foot) {
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00190$
;src/player.c:111: if (p->gravity_flipped) {
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/player.c:112: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:114: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00149$:
;src/player.c:116: p->world_y.b.h = py;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(de), a
;src/player.c:117: p->world_y.b.l = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:118: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:119: p->on_ground = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00191$
00190$:
;src/player.c:123: if (p->mode == MODE_SHIP) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00152$
;src/player.c:124: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE) : ny;
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00281$
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00153$
00281$:
	ldhl	sp,	#22
	ld	e, (hl)
	ld	d, #0x00
	jr	00153$
00152$:
;src/player.c:126: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00283$
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	jr	00284$
00283$:
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
00284$:
00153$:
;src/player.c:129: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
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
	jr	Z, 00285$
	ld	a, #0x07
	jr	00286$
00285$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00289$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00290$
00289$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00290$:
	pop	bc
	push	bc
	call	_col_at_raw_cached
00286$:
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:130: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ldhl	sp,	#26
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00291$
	inc	hl
	ld	(hl), #0x07
	jr	00292$
00291$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00295$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	jr	00296$
00295$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
00296$:
	pop	bc
	push	bc
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#26
	ld	(hl), a
00292$:
	ldhl	sp,	#26
	ld	c, (hl)
;src/player.c:132: if (IS_SOLID(hl) || IS_SOLID(hr)) {
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
	jr	NZ, 00180$
00179$:
;src/player.c:133: if (p->mode == MODE_CUBE) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00158$
;src/player.c:134: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:135: return 1;
	ld	a, #0x01
	jp	00239$
00158$:
;src/player.c:137: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
	ld	a, (hl)
	or	a, a
;src/player.c:138: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00156$
;src/player.c:140: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	(hl), a
00156$:
;src/player.c:142: p->world_y.b.h = py;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(de), a
;src/player.c:143: p->world_y.b.l = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:144: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00191$
00180$:
;src/player.c:147: py = ny;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:150: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00297$
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
	jr	00298$
00297$:
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
00298$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:151: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
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
	jr	Z, 00299$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00301$
	xor	a, a
	jr	00300$
00301$:
	ld	a, #0x07
	jr	00300$
00299$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00303$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00304$
00303$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00304$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00300$:
	ldhl	sp,	#29
;src/player.c:152: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00305$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00307$
	ld	(hl), #0x00
	jr	00306$
00307$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00306$
00305$:
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00309$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00310$
00309$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00310$:
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
00306$:
	ldhl	sp,	#32
	ld	c, (hl)
;src/player.c:154: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00170$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00170$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00170$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00170$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00170$
	cp	a,#0x09
	jr	Z, 00170$
	cp	a,#0x05
	jr	Z, 00170$
	sub	a, #0x06
	jr	NZ, 00191$
00170$:
;src/player.c:155: p->on_ground = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:156: if (p->mode == MODE_CUBE) p->vel_y.w = 0;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00168$
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00191$
00168$:
;src/player.c:157: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:52: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/player.c:48: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:157: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
	dec	hl
	bit	7, (hl)
	jr	Z, 00191$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00191$
00165$:
;src/player.c:158: else { if (p->vel_y.w > 0) p->vel_y.w = 0; }
	ldhl	sp,	#30
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00191$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00191$:
;src/player.c:163: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE - 1);
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00311$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	jr	00312$
00311$:
	ld	a, #0x0e
	ldhl	sp,	#18
	sub	a, (hl)
	jr	NC, 00313$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00314$
00313$:
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00314$:
	ld	b, e
	ld	e, a
00312$:
	ldhl	sp,	#31
	ld	a, b
	ld	(hl+), a
;src/player.c:164: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
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
	jr	Z, 00315$
	ld	a, #0x07
	jr	00316$
00315$:
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00316$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:165: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
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
	jr	Z, 00319$
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00320$
00319$:
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
00320$:
	ldhl	sp,	#32
;src/player.c:167: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00192$
	ldhl	sp,	#33
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
	jr	NZ, 00193$
00192$:
;src/player.c:168: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:169: return 1;
	ld	a, #0x01
	jp	00239$
00193$:
;src/player.c:172: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
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
	jr	Z, 00323$
	ld	a, #0x07
	jr	00324$
00323$:
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
	jr	Z, 00327$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00328$
00327$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00328$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00324$:
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:173: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
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
	jr	Z, 00329$
	inc	hl
	ld	(hl), #0x07
	jr	00330$
00329$:
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
	jr	Z, 00333$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00334$
00333$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00334$:
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
00330$:
	ldhl	sp,	#26
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:174: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00335$
	ld	a, #0x07
	jr	00336$
00335$:
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
	jr	Z, 00339$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00340$
00339$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00340$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00336$:
	ldhl	sp,	#31
;src/player.c:175: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00341$
	ld	c, #0x07
	jr	00342$
00341$:
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
	jr	Z, 00345$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00346$
00345$:
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00346$:
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
00342$:
;src/player.c:177: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00201$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	dec	a
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00201$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	dec	a
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00201$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00201$
	ld	a,c
	cp	a,#0x08
	jr	Z, 00201$
	cp	a,#0x03
	jr	Z, 00201$
	cp	a,#0x04
	jr	Z, 00201$
	cp	a,#0x02
	jr	Z, 00201$
	dec	a
	jr	Z, 00201$
	ld	a,c
	cp	a,#0x10
	jr	Z, 00201$
	sub	a, #0x11
	jr	NZ, 00202$
00201$:
;src/player.c:178: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:179: return 1;
	ld	a, #0x01
	jp	00239$
00202$:
;src/player.c:182: if (p->on_ground) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:183: p->anim_timer = 0;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:184: p->anim_frame = 0;
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
;src/player.c:182: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00235$
;src/player.c:183: p->anim_timer = 0;
;src/player.c:184: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00236$
00235$:
;src/player.c:186: p->anim_timer += 10;
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
;src/player.c:187: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00236$
;src/player.c:188: p->anim_timer -= 20;
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
;src/player.c:189: p->anim_frame++;
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
;src/player.c:190: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00236$
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00236$:
;src/player.c:194: if (p->world_y.b.h > (map_h << 4)) {
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
	jr	NC, 00238$
;src/player.c:195: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:196: return 1;
	ld	a, #0x01
	jr	00239$
00238$:
;src/player.c:199: p->last_joy = joy;
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
;src/player.c:200: return 0;
	xor	a, a
00239$:
;src/player.c:201: }
	add	sp, #37
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
