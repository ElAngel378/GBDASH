;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _col_at_end
	.globl _col_at_begin
	.globl _col_at_raw
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
;src/player.c:5: void player_init(Player *p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init::
;src/player.c:6: p->world_x = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:7: p->world_y = start_y;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/player.c:8: p->vel_y = 0;
	ld	hl, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:9: p->on_ground = 0;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;src/player.c:10: p->dead = 0;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;src/player.c:11: p->anim_timer = 0;
	ld	hl, #0x000b
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:12: p->anim_frame = 0;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/player.c:13: p->gravity_flipped = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x00
;src/player.c:14: p->mode = MODE_CUBE;
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/player.c:15: p->last_joy = 0;
	ld	hl, #0x000d
	add	hl, de
	ld	(hl), #0x00
;src/player.c:16: p->touching_orb = 0;
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x00
;src/player.c:17: }
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:19: int16_t player_screen_y(const Player *p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:20: return (int16_t)p->world_y - (int16_t)cam_y;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	l, (hl)
	sub	a, c
	ld	c, a
	ld	a, l
	sbc	a, b
	ld	b, a
;src/player.c:21: }
	ret
;src/player.c:23: uint8_t player_update(
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
;src/player.c:31: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
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
	ldhl	sp,	#30
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00258$
00102$:
;src/player.c:33: col_at_begin(map_bank);
	ldhl	sp,	#42
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:36: if (p->mode == MODE_SHIP) {
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
;src/player.c:37: if (joy & J_A) {
	ldhl	sp,	#31
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:38: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#32
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
	ld	(hl), a
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:46: if (!p->on_ground) {
	ldhl	sp,#32
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
;src/player.c:36: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:42: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
;src/player.c:81: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
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
;src/player.c:38: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:37: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#10
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:38: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00260$
	ld	hl, #0x0008
	jr	00261$
00260$:
	ld	hl, #0xfff8
00261$:
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
	jr	00105$
00104$:
;src/player.c:40: p->vel_y += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00262$
	ld	hl, #0xfffb
	jr	00263$
00262$:
	ld	hl, #0x0005
00263$:
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
00105$:
;src/player.c:42: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x40
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 01174$
	bit	7, d
	jr	NZ, 01175$
	cp	a, a
	jr	01175$
01174$:
	bit	7, d
	jr	Z, 01175$
	scf
01175$:
	jr	NC, 00107$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x00
00107$:
;src/player.c:43: if (p->vel_y < -SHIP_MAX_VEL) p->vel_y = -SHIP_MAX_VEL;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0xc0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jp	NC, 00121$
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, #0xc0
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00121$
00120$:
;src/player.c:46: if (!p->on_ground) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00121$
;src/player.c:47: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:42: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
;src/player.c:38: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:47: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00115$
;src/player.c:48: p->vel_y -= GRAVITY;
	ld	bc, #0xfff6
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:49: if (p->vel_y < -MAX_FALL_SPEED) p->vel_y = -MAX_FALL_SPEED;
	ld	a, c
	sub	a, #0x90
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00121$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00121$
00115$:
;src/player.c:51: p->vel_y += GRAVITY;
	ld	bc, #0x000a
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
;src/player.c:52: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x70
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 01176$
	bit	7, d
	jr	NZ, 01177$
	cp	a, a
	jr	01177$
01176$:
	bit	7, d
	jr	Z, 01177$
	scf
01177$:
	jr	NC, 00121$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x70
	ld	(hl+), a
	ld	(hl), #0x00
00121$:
;src/player.c:60: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
;src/player.c:58: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00125$
;src/player.c:59: if (joy & J_A) p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#10
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	or	a, a
	jr	Z, 00264$
	ld	(hl), #0x5d
	jr	00265$
00264$:
	ldhl	sp,	#30
	ld	(hl), #0xa3
00265$:
	ldhl	sp,	#30
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/player.c:60: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, h
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:61: col_at_end();
	call	_col_at_end
;src/player.c:62: return 0;
	xor	a, a
	jp	00258$
00125$:
;src/player.c:66: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	pop	de
	push	de
	ld	a, (de)
	or	a, a
	jr	NZ, 00127$
	ldhl	sp,	#10
	or	a, (hl)
	jr	Z, 00127$
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00127$
;src/player.c:67: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	ld	a, #0x5d
	jr	NZ, 00267$
	ld	a, #0xa3
00267$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:68: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:72: uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000f
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
;src/player.c:74: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00130$
	cp	a, #0x09
	jr	Z, 00130$
	cp	a, #0x05
	jr	Z, 00130$
	sub	a, #0x06
	jr	NZ, 00131$
00130$:
;src/player.c:75: p->dead = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:76: col_at_end();
	call	_col_at_end
;src/player.c:77: return 1;
	ld	a, #0x01
	jp	00258$
00131$:
;src/player.c:81: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
;src/player.c:42: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
	ldhl	sp,	#25
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:81: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ld	a, c
	or	a, a
	jr	Z, 00268$
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#28
	ld	(hl-), a
	ld	(hl), e
	jr	00269$
00268$:
	ldhl	sp,	#25
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00269$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	b, a
;src/player.c:82: int8_t pixels = (int8_t)(effective_vel >> 4);
	ld	a, (hl-)
	dec	hl
	ld	e, a
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	ld	(hl), b
;src/player.c:83: if (p->gravity_flipped) pixels = -pixels;
	ld	a, c
	or	a, a
	jr	Z, 00136$
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
00136$:
;src/player.c:84: int16_t ny = p->world_y + pixels;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:85: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:88: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
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
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00270$
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	jr	00271$
00270$:
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
00271$:
;src/player.c:89: int16_t check_y_head = (p->gravity_flipped) ? ny + PLAYER_SIZE : ny;
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00272$
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00273$
00272$:
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00273$:
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;src/player.c:92: uint8_t cl = col_at_raw(p->world_x + 2, check_y_foot, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	e, c
	ld	d, a
	inc	de
	inc	de
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:93: uint8_t cr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_foot, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000d
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#22
	ld	(hl), a
;src/player.c:95: uint8_t falling = (p->gravity_flipped) ? (pixels <= 0) : (pixels >= 0);
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#23
	ld	(hl), a
	or	a, a
	jr	Z, 00274$
	ldhl	sp,	#26
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01184$
	bit	7, d
	jr	NZ, 01185$
	cp	a, a
	jr	01185$
01184$:
	bit	7, d
	jr	Z, 01185$
	scf
01185$:
	ld	a, #0x00
	rla
	xor	a, #0x01
	ldhl	sp,	#24
	ld	(hl), a
	jr	00275$
00274$:
	ldhl	sp,	#26
	ld	a, (hl-)
	dec	hl
	rlca
	and	a, #0x01
	xor	a, #0x01
	ld	(hl), a
00275$:
;src/player.c:99: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	l, c
	ld	h, b
	inc	hl
;src/player.c:101: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	push	hl
	ldhl	sp,	#29
	ld	a, (hl)
	pop	hl
	and	a, #0xf0
	push	hl
	ldhl	sp,	#30
	ld	b, (hl)
	pop	hl
;src/player.c:99: p->world_y = ((ny >> 4) + 1) << 4;
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
;src/player.c:101: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
;src/player.c:99: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#25
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/player.c:101: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:97: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00173$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00172$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00173$
00172$:
;src/player.c:98: if (p->gravity_flipped) {
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
;src/player.c:99: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00139$
00138$:
;src/player.c:101: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00139$:
;src/player.c:103: p->vel_y = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:104: p->on_ground = 1;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00174$
00173$:
;src/player.c:107: uint8_t hl = col_at_raw(p->world_x + 2, check_y_head, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	e, c
	ld	d, a
	inc	de
	inc	de
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:108: uint8_t hr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_head, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000d
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ld	c, a
;src/player.c:109: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00162$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00162$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00162$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00162$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00162$
	cp	a,#0x09
	jr	Z, 00162$
	cp	a,#0x05
	jr	Z, 00162$
	sub	a, #0x06
	jr	NZ, 00163$
00162$:
;src/player.c:110: if (p->gravity_flipped) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00141$
;src/player.c:111: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00142$
00141$:
;src/player.c:113: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00142$:
;src/player.c:115: p->vel_y = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00174$
00163$:
;src/player.c:117: p->world_y = ny;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:120: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00276$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	jr	00277$
00276$:
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
00277$:
;src/player.c:121: uint8_t gl = col_at_raw(p->world_x + 2, sticky_y, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	ld	d, a
	inc	de
	inc	de
	push	bc
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#30
	ld	(hl), a
	pop	bc
;src/player.c:122: uint8_t gr = col_at_raw(p->world_x + PLAYER_SIZE - 2, sticky_y, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000d
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ld	c, a
;src/player.c:123: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00153$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00153$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00153$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00153$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00153$
	cp	a,#0x09
	jr	Z, 00153$
	cp	a,#0x05
	jr	Z, 00153$
	sub	a, #0x06
	jr	NZ, 00174$
00153$:
;src/player.c:124: p->on_ground = 1;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:126: if (p->mode == MODE_CUBE) p->vel_y = 0;
	pop	de
	push	de
	ld	a, (de)
	or	a, a
	jr	NZ, 00151$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00151$:
;src/player.c:127: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
;src/player.c:42: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
	ld	b, a
	inc	de
	ld	a, (de)
;src/player.c:38: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:127: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ld	a, c
	or	a, a
	jr	Z, 00148$
	bit	7, l
	jr	Z, 00174$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00148$:
;src/player.c:128: else { if (p->vel_y > 0) p->vel_y = 0; }
	ld	e, l
	xor	a, a
	ld	d, a
	cp	a, b
	sbc	a, l
	bit	7, e
	jr	Z, 01213$
	bit	7, d
	jr	NZ, 01214$
	cp	a, a
	jr	01214$
01213$:
	bit	7, d
	jr	Z, 01214$
	scf
01214$:
	jr	NC, 00174$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00174$:
;src/player.c:134: uint8_t front_head = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0006
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000f
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#20
	ld	(hl), a
;src/player.c:135: uint8_t front_foot = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0009
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000f
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:138: uint8_t hz_tl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0006
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#22
	ld	(hl), a
;src/player.c:139: uint8_t hz_tr = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0006
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#23
	ld	(hl), a
;src/player.c:140: uint8_t hz_bl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0009
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:141: uint8_t hz_br = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0009
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#25
	ld	(hl), a
;src/player.c:144: uint8_t mid = col_at_raw(p->world_x + 8, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
;src/player.c:146: if (IS_PAD(mid) || IS_PAD(front_head) || IS_PAD(front_foot)) {
	ldhl	sp,#26
	ld	(hl), a
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01216$
	xor	a, a
01216$:
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01218$
	xor	a, a
01218$:
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01220$
	xor	a, a
01220$:
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01222$
	xor	a, a
01222$:
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	NZ, 00203$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00203$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00203$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00203$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x0b
	jr	Z, 00203$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00204$
00203$:
;src/player.c:147: uint8_t hit = (IS_PAD(mid)) ? mid : (IS_PAD(front_head) ? front_head : front_foot);
	ldhl	sp,	#27
	bit	0, (hl)
	jr	NZ, 00281$
	inc	hl
	bit	0, (hl)
	jr	Z, 00278$
00281$:
	ldhl	sp,	#26
	ld	c, (hl)
	jr	00279$
00278$:
	ldhl	sp,	#29
	bit	0, (hl)
	jr	NZ, 00286$
	inc	hl
	bit	0, (hl)
	jr	Z, 00283$
00286$:
	ldhl	sp,	#20
	ld	c, (hl)
	jr	00284$
00283$:
	ldhl	sp,	#21
	ld	c, (hl)
00284$:
00279$:
;src/player.c:81: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;src/player.c:148: if (hit == COL_PAD_BLUE) {
	ld	a, c
	sub	a, #0x0e
	jr	NZ, 00184$
;src/player.c:149: p->gravity_flipped = !p->gravity_flipped;
	ld	a, l
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#14
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:150: p->vel_y = (p->gravity_flipped) ? -20 : 20;
	or	a, a
	ld	a, #0xec
	jr	NZ, 00289$
	ld	a, #0x14
00289$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00185$
00184$:
;src/player.c:152: p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ld	a, l
	or	a, a
	jr	Z, 00290$
	ld	de, #0x008c
	jr	00291$
00290$:
	ld	de, #0xff74
00291$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00185$:
;src/player.c:154: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00205$
00204$:
;src/player.c:155: } else if ((joy & J_A) && (IS_ORB(mid) || IS_ORB(front_head) || IS_ORB(front_foot))) {
	xor	a, a
	ldhl	sp,	#10
	or	a, (hl)
	jp	Z, 00205$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0a
	ld	a, #0x01
	jr	Z, 01229$
	xor	a, a
01229$:
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0c
	ld	a, #0x01
	jr	Z, 01231$
	xor	a, a
01231$:
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0d
	ld	a, #0x01
	jr	Z, 01233$
	xor	a, a
01233$:
	ld	c, a
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x0a
	ld	a, #0x01
	jr	Z, 01235$
	xor	a, a
01235$:
	ld	e, a
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x0c
	ld	a, #0x01
	jr	Z, 01237$
	xor	a, a
01237$:
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x0d
	ld	a, #0x01
	jr	Z, 01239$
	xor	a, a
01239$:
	ld	d, a
	ld	a, b
	or	a, a
	jr	NZ, 00192$
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	NZ, 00192$
	or	a, c
	jr	NZ, 00192$
	or	a, e
	jr	NZ, 00192$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00192$
	or	a, d
	jr	NZ, 00192$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00192$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00192$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ, 00205$
00192$:
;src/player.c:156: uint8_t hit = (IS_ORB(mid)) ? mid : (IS_ORB(front_head) ? front_head : front_foot);
	bit	0, b
	jr	NZ, 00295$
	ldhl	sp,	#29
	bit	0, (hl)
	jr	NZ, 00295$
	bit	0, c
	jr	Z, 00292$
00295$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00293$
00292$:
	bit	0, e
	jr	NZ, 00303$
	ldhl	sp,	#30
	ld	c, (hl)
	bit	0, c
	jr	NZ, 00303$
	bit	0, d
	jr	Z, 00300$
00303$:
	ldhl	sp,	#20
	ld	a, (hl)
	jr	00301$
00300$:
	ldhl	sp,	#21
	ld	a, (hl)
00301$:
	ldhl	sp,	#30
	ld	(hl), a
00293$:
;src/player.c:81: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
;src/player.c:157: if (hit == COL_ORB_MAGENTA) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00190$
;src/player.c:158: p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	inc	hl
	ld	(hl), #0x3c
	jr	00309$
00308$:
	ldhl	sp,	#30
	ld	(hl), #0xc4
00309$:
	ldhl	sp,	#30
	ld	a, (hl-)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00191$
00190$:
;src/player.c:159: } else if (hit == COL_ORB_BLUE) {
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ, 00187$
;src/player.c:160: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#14
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:161: p->vel_y = (p->gravity_flipped) ? -20 : 20;
	or	a, a
	ld	a, #0xec
	jr	NZ, 00311$
	ld	a, #0x14
00311$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00191$
00187$:
;src/player.c:163: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	ld	a, #0x5d
	jr	NZ, 00313$
	ld	a, #0xa3
00313$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00191$:
;src/player.c:165: p->on_ground = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00205$:
;src/player.c:169: if (IS_SOLID(front_head) || IS_SOLID(front_foot) ||
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x07
	jp	Z, 00211$
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00211$
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00211$
	ldhl	sp,	#20
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00211$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x07
	jp	Z, 00211$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00211$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00211$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00211$
;src/player.c:170: IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	dec	a
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00211$
	ldhl	sp,	#22
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	dec	a
	jr	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00211$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	dec	a
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00211$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	dec	a
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00211$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00212$
00211$:
;src/player.c:171: p->dead = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:172: col_at_end();
	call	_col_at_end
;src/player.c:173: return 1;
	ld	a, #0x01
	jp	00258$
00212$:
;src/player.c:176: col_at_end();
	call	_col_at_end
;src/player.c:179: if (p->on_ground) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:180: p->anim_timer = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:181: p->anim_frame = 0;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
;src/player.c:179: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00253$
;src/player.c:180: p->anim_timer = 0;
;src/player.c:181: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00254$
00253$:
;src/player.c:183: p->anim_timer += 10;
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
;src/player.c:184: if (p->anim_timer >= 17) {
	ld	a, e
	sub	a, #0x11
	ld	a, d
	sbc	a, #0x00
	jr	C, 00254$
;src/player.c:185: p->anim_timer -= 17;
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	add	a, #0xef
	ld	e, a
	ld	a, h
	adc	a, #0xff
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/player.c:186: p->anim_frame++;
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
;src/player.c:187: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00254$
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00254$:
;src/player.c:72: uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;src/player.c:192: if (p->world_y > (int16_t)((uint16_t)map_h << 4) || p->world_y < -32) {
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	ld	l, a
	ld	h, e
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
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
	jr	C, 00255$
	ld	a, c
	sub	a, #0xe0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00256$
00255$:
;src/player.c:193: p->dead = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;src/player.c:194: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00258$
00256$:
;src/player.c:197: p->last_joy = joy;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a, (hl)
	ld	(bc), a
;src/player.c:198: return 0;
	xor	a, a
00258$:
;src/player.c:199: }
	add	sp, #34
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
