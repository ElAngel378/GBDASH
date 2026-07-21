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
	.globl _player_tile_activated
	.globl _player_mark_activated
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
;src/player.c:17: p->activated_count = 0;
	ld	hl, #0x002f
	add	hl, de
	ld	(hl), #0x00
;src/player.c:18: p->next_activated_slot = 0;
	ld	hl, #0x0030
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: }
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:21: uint8_t player_tile_activated(const Player *p, uint16_t mx, uint16_t my) {
;	---------------------------------
; Function player_tile_activated
; ---------------------------------
_player_tile_activated::
	add	sp, #-9
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:22: for (uint8_t i = 0; i < p->activated_count; i++) {
	push	de
	ld	hl, #0x000f
	add	hl, de
	pop	de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #0x002f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl), #0x00
00106$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#8
;src/player.c:23: if (p->activated[i].mx == mx && p->activated[i].my == my) return 1;
	ld	a,(hl)
	cp	a,c
	jr	NC, 00104$
	add	a, a
	add	a, a
	ld	e, a
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	NZ, 00107$
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	NZ, 00107$
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00107$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
	ld	a, #0x01
	jr	00108$
00107$:
;src/player.c:22: for (uint8_t i = 0; i < p->activated_count; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jr	00106$
00104$:
;src/player.c:25: return 0;
	xor	a, a
00108$:
;src/player.c:26: }
	add	sp, #9
	pop	hl
	pop	bc
	jp	(hl)
;src/player.c:28: void player_mark_activated(Player *p, uint16_t mx, uint16_t my) {
;	---------------------------------
; Function player_mark_activated
; ---------------------------------
_player_mark_activated::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;src/player.c:29: p->activated[p->next_activated_slot].mx = mx;
	ld	a, d
	ld	(hl-), a
	inc	sp
	inc	sp
	push	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, a
	add	a, a
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/player.c:30: p->activated[p->next_activated_slot].my = my;
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	ld	a, #0x00
	adc	a, b
	ld	b, a
	inc	bc
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/player.c:31: p->next_activated_slot++;
	ld	a, (de)
	inc	a
	ld	(de), a
;src/player.c:32: if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
	sub	a, #0x08
	jr	C, 00102$
	xor	a, a
	ld	(de), a
00102$:
;src/player.c:33: if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x002f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x08
	jr	NC, 00105$
	inc	a
	ld	(bc), a
00105$:
;src/player.c:34: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:36: int16_t player_screen_y(const Player *p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:37: return (int16_t)p->world_y - (int16_t)cam_y;
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
;src/player.c:38: }
	ret
;src/player.c:40: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-54
	ldhl	sp,	#52
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:48: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#24
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#23
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#50
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00263$
00102$:
;src/player.c:50: col_at_begin(map_bank);
	ldhl	sp,	#62
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:53: if (p->mode == MODE_SHIP) {
	ldhl	sp,#52
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
;src/player.c:54: if (joy & J_A) {
	ldhl	sp,	#51
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#24
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:55: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:63: if (!p->on_ground) {
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:53: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:59: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
;src/player.c:98: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
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
;src/player.c:55: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:54: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#24
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:55: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00265$
	ld	hl, #0x0008
	jr	00266$
00265$:
	ld	hl, #0xfff8
00266$:
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00105$
00104$:
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00267$
	ld	hl, #0xfffb
	jr	00268$
00267$:
	ld	hl, #0x0005
00268$:
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00105$:
;src/player.c:59: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#26
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
	jr	Z, 01113$
	bit	7, d
	jr	NZ, 01114$
	cp	a, a
	jr	01114$
01113$:
	bit	7, d
	jr	Z, 01114$
	scf
01114$:
	jr	NC, 00107$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x00
00107$:
;src/player.c:60: if (p->vel_y < -SHIP_MAX_VEL) p->vel_y = -SHIP_MAX_VEL;
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
;src/player.c:63: if (!p->on_ground) {
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00121$
;src/player.c:64: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
;src/player.c:55: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:64: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00115$
;src/player.c:65: p->vel_y -= GRAVITY;
	ld	bc, #0xfff6
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:66: if (p->vel_y < -MAX_FALL_SPEED) p->vel_y = -MAX_FALL_SPEED;
	ld	a, c
	sub	a, #0x90
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00121$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00121$
00115$:
;src/player.c:68: p->vel_y += GRAVITY;
	ld	bc, #0x000a
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
;src/player.c:69: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x70
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 01115$
	bit	7, d
	jr	NZ, 01116$
	cp	a, a
	jr	01116$
01115$:
	bit	7, d
	jr	Z, 01116$
	scf
01116$:
	jr	NC, 00121$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x70
	ld	(hl+), a
	ld	(hl), #0x00
00121$:
;src/player.c:77: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:75: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00125$
;src/player.c:76: if (joy & J_A) p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#24
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#50
	ld	(hl), a
	or	a, a
	jr	Z, 00269$
	ld	(hl), #0x5d
	jr	00270$
00269$:
	ldhl	sp,	#50
	ld	(hl), #0xa3
00270$:
	ldhl	sp,	#50
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/player.c:77: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#26
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
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:78: col_at_end();
	call	_col_at_end
;src/player.c:79: return 0;
	xor	a, a
	jp	00263$
00125$:
;src/player.c:83: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	pop	de
	push	de
	ld	a, (de)
	or	a, a
	jr	NZ, 00127$
	ldhl	sp,	#24
	or	a, (hl)
	jr	Z, 00127$
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00127$
;src/player.c:84: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	ld	a, #0x5d
	jr	NZ, 00272$
	ld	a, #0xa3
00272$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:85: p->on_ground = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:89: uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,	#52
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#53
	ld	a, (hl)
	ldhl	sp,	#35
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
;src/player.c:91: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00130$
	cp	a, #0x09
	jr	Z, 00130$
	cp	a, #0x05
	jr	Z, 00130$
	sub	a, #0x06
	jr	NZ, 00131$
00130$:
;src/player.c:92: p->dead = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:93: col_at_end();
	call	_col_at_end
;src/player.c:94: return 1;
	ld	a, #0x01
	jp	00263$
00131$:
;src/player.c:98: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
	ldhl	sp,	#47
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:98: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ld	a, c
	or	a, a
	jr	Z, 00273$
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#50
	ld	(hl-), a
	ld	(hl), e
	jr	00274$
00273$:
	ldhl	sp,	#47
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00274$:
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	b, a
;src/player.c:99: int8_t pixels = (int8_t)(effective_vel >> 4);
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
;src/player.c:100: if (p->gravity_flipped) pixels = -pixels;
	ld	a, c
	or	a, a
	jr	Z, 00136$
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
00136$:
;src/player.c:101: int16_t ny = p->world_y + pixels;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#48
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
	ldhl	sp,	#37
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:102: p->on_ground = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:105: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#37
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
	ldhl	sp,	#51
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00275$
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
	jr	00276$
00275$:
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#50
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
00276$:
;src/player.c:106: int16_t check_y_head = (p->gravity_flipped) ? ny + PLAYER_SIZE : ny;
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00277$
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#50
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jr	00278$
00277$:
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
00278$:
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:109: uint8_t cl = col_at_raw(p->world_x + 2, check_y_foot, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#52
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#43
	ld	(hl), a
;src/player.c:110: uint8_t cr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_foot, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#52
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#44
	ld	(hl), a
;src/player.c:112: uint8_t falling = (p->gravity_flipped) ? (pixels <= 0) : (pixels >= 0);
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#45
	ld	(hl), a
	or	a, a
	jr	Z, 00279$
	ldhl	sp,	#48
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
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
	ld	a, #0x00
	rla
	xor	a, #0x01
	ldhl	sp,	#46
	ld	(hl), a
	jr	00280$
00279$:
	ldhl	sp,	#48
	ld	a, (hl-)
	dec	hl
	rlca
	and	a, #0x01
	xor	a, #0x01
	ld	(hl), a
00280$:
;src/player.c:116: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,#37
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
;src/player.c:118: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	push	hl
	ldhl	sp,	#51
	ld	a, (hl)
	pop	hl
	and	a, #0xf0
	push	hl
	ldhl	sp,	#52
	ld	b, (hl)
	pop	hl
;src/player.c:116: p->world_y = ((ny >> 4) + 1) << 4;
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
;src/player.c:118: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
;src/player.c:116: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#47
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/player.c:118: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:114: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#46
	ld	a, (hl)
	or	a, a
	jr	Z, 00173$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00172$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00173$
00172$:
;src/player.c:115: if (p->gravity_flipped) {
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
;src/player.c:116: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00139$
00138$:
;src/player.c:118: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00139$:
;src/player.c:120: p->vel_y = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:121: p->on_ground = 1;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00174$
00173$:
;src/player.c:124: uint8_t hl = col_at_raw(p->world_x + 2, check_y_head, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ldhl	sp,	#46
	ld	(hl), a
;src/player.c:125: uint8_t hr = col_at_raw(p->world_x + PLAYER_SIZE - 2, check_y_head, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw
	ld	c, a
;src/player.c:126: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00162$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00162$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00162$
	ldhl	sp,	#46
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
;src/player.c:127: if (p->gravity_flipped) {
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00141$
;src/player.c:128: p->world_y = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00142$
00141$:
;src/player.c:130: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00142$:
;src/player.c:132: p->vel_y = 0;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00174$
00163$:
;src/player.c:134: p->world_y = ny;
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:137: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00281$
	ldhl	sp,#39
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	jr	00282$
00281$:
	ldhl	sp,#39
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
00282$:
;src/player.c:138: uint8_t gl = col_at_raw(p->world_x + 2, sticky_y, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#52
	ld	(hl), a
	pop	bc
;src/player.c:139: uint8_t gr = col_at_raw(p->world_x + PLAYER_SIZE - 2, sticky_y, map, map_w, map_h);
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ld	c, a
;src/player.c:140: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00153$
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00153$
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00153$
	ldhl	sp,	#50
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
;src/player.c:141: p->on_ground = 1;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:143: if (p->mode == MODE_CUBE) p->vel_y = 0;
	pop	de
	push	de
	ld	a, (de)
	or	a, a
	jr	NZ, 00151$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00151$:
;src/player.c:144: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
;src/player.c:55: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:144: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ld	a, c
	or	a, a
	jr	Z, 00148$
	bit	7, l
	jr	Z, 00174$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00148$:
;src/player.c:145: else { if (p->vel_y > 0) p->vel_y = 0; }
	ld	e, l
	xor	a, a
	ld	d, a
	cp	a, b
	sbc	a, l
	bit	7, e
	jr	Z, 01152$
	bit	7, d
	jr	NZ, 01153$
	cp	a, a
	jr	01153$
01152$:
	bit	7, d
	jr	Z, 01153$
	scf
01153$:
	jr	NC, 00174$
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00174$:
;src/player.c:151: uint8_t front_head = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#36
	ld	(hl), a
;src/player.c:152: uint8_t front_foot = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#37
	ld	(hl), a
;src/player.c:155: uint8_t hz_tl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:156: uint8_t hz_tr = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#39
	ld	(hl), a
;src/player.c:157: uint8_t hz_bl = col_at_raw(p->world_x + PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#40
	ld	(hl), a
;src/player.c:158: uint8_t hz_br = col_at_raw(p->world_x + PLAYER_SIZE - PLAYER_HBOX, p->world_y + PLAYER_SIZE - PLAYER_HBOX, map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,#34
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
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#41
	ld	(hl), a
;src/player.c:161: uint8_t tl = col_at_raw(p->world_x,                  p->world_y,                  map, map_w, map_h);
	ldhl	sp,#32
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
	ldhl	sp,	#49
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:162: uint8_t tr = col_at_raw(p->world_x + PLAYER_SIZE - 1, p->world_y,                  map, map_w, map_h);
	ldhl	sp,#32
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
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000e
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#43
	ld	(hl), a
;src/player.c:163: uint8_t bl = col_at_raw(p->world_x,                  p->world_y + PLAYER_SIZE - 1, map, map_w, map_h);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#49
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw
	ldhl	sp,	#44
	ld	(hl), a
;src/player.c:164: uint8_t br = col_at_raw(p->world_x + PLAYER_SIZE - 1, p->world_y + PLAYER_SIZE - 1, map, map_w, map_h);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	de, #0x000e
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ldhl	sp,	#45
	ld	(hl), a
;src/player.c:166: uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#46
	ld	(hl), a
	or	a, a
	jr	Z, 00283$
	ldhl	sp,	#42
	ld	a, (hl)
	jr	00284$
00283$:
	ldhl	sp,	#44
	ld	a, (hl)
00284$:
	ldhl	sp,	#47
;src/player.c:167: uint8_t pad_r = (p->gravity_flipped) ? tr : br;
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00285$
	ldhl	sp,	#43
	ld	a, (hl)
	jr	00286$
00285$:
	ldhl	sp,	#45
	ld	a, (hl)
00286$:
	ldhl	sp,	#48
;src/player.c:170: if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01155$
	xor	a, a
01155$:
	ldhl	sp,	#49
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01157$
	xor	a, a
01157$:
	ldhl	sp,	#50
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00208$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00208$
	dec	hl
	dec	hl
	ld	a, (hl)
	sub	a, #0x0b
	jr	Z, 00208$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x0e
	jp	NZ, 00209$
00208$:
;src/player.c:89: uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/player.c:173: int16_t hy = (p->gravity_flipped) ? p->world_y : (p->world_y + PLAYER_SIZE - 1);
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00287$
	dec	hl
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	jr	00288$
00287$:
	ldhl	sp,#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#44
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#43
	ld	(hl), a
00288$:
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;src/player.c:89: uint8_t front_mid = col_at_raw(p->world_x + PLAYER_SIZE, p->world_y + 8, map, map_w, map_h);
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#43
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:174: if (IS_PAD(pad_l)) { hit = pad_l; hx = p->world_x; }
	ldhl	sp,	#49
	ld	a, (hl)
	or	a, a
	jr	NZ, 00183$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00184$
00183$:
	ldhl	sp,	#47
	ld	a, (hl)
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	jr	00185$
00184$:
;src/player.c:175: else               { hit = pad_r; hx = p->world_x + PLAYER_SIZE - 1; }
	ldhl	sp,	#48
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000e
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#48
	ld	(hl), c
	inc	hl
	ld	(hl), a
00185$:
;src/player.c:177: uint16_t pmx = (hx >> 4);
	ldhl	sp,	#49
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/player.c:178: uint16_t pmy = ((uint16_t)hy >> 4);
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/player.c:180: if (!player_tile_activated(p, pmx, pmy)) {
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#54
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	or	a, a
	jp	NZ, 00210$
;src/player.c:181: player_mark_activated(p, pmx, pmy);
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#54
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:98: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:182: if (hit == COL_PAD_BLUE) {
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00188$
;src/player.c:183: p->gravity_flipped = !p->gravity_flipped;
	ld	a, c
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:184: p->vel_y = (p->gravity_flipped) ? -64 : 64;
	or	a, a
	ld	a, #0xc0
	jr	NZ, 00290$
	ld	a, #0x40
00290$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00189$
00188$:
;src/player.c:186: p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ld	a, c
	or	a, a
	jr	Z, 00291$
	ld	de, #0x0094
	jr	00292$
00291$:
	ld	de, #0xff6c
00292$:
	ld	c, e
	ld	b, d
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00189$:
;src/player.c:188: p->on_ground = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00210$
00209$:
;src/player.c:192: else if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#24
	or	a, (hl)
	jp	Z, 00210$
;src/player.c:193: struct { uint8_t col; uint16_t x; int16_t y; } corners[4] = {
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#5
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, h
	ld	a, l
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), c
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#13
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, h
	ld	a, l
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), c
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, h
	ld	a, l
	ldhl	sp,	#18
	ld	(hl+), a
	ld	(hl), c
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x000e
	add	hl, bc
	ld	c, h
	ld	a, l
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), c
;src/player.c:200: for (uint8_t i = 0; i < 4; i++) {
	ldhl	sp,	#50
	ld	(hl), #0x00
00262$:
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00210$
;src/player.c:201: if (!IS_ORB(corners[i].col)) continue;
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #2
	add	hl, sp
	add	hl, bc
	ld	a, (hl)
	cp	a, #0x0a
	jr	Z, 00193$
	cp	a, #0x0c
	jr	Z, 00193$
	sub	a, #0x0d
	jp	NZ, 00204$
00193$:
;src/player.c:203: uint16_t omx = (corners[i].x >> 4);
	ld	hl, #2
	add	hl, sp
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/player.c:204: uint16_t omy = ((uint16_t)corners[i].y >> 4);
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	l, (hl)
	ld	e, a
	ld	d, l
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/player.c:206: if (player_tile_activated(p, omx, omy)) continue; // already used, skip entirely
	push	bc
	push	de
	push	de
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jp	NZ, 00204$
;src/player.c:208: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#54
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:210: uint8_t hit = corners[i].col;
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/player.c:98: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#49
;src/player.c:211: if (hit == COL_ORB_MAGENTA) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00202$
;src/player.c:212: p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,	#49
	ld	a, (hl)
	or	a, a
	jr	Z, 00293$
	inc	hl
	ld	(hl), #0x3c
	jr	00294$
00293$:
	ldhl	sp,	#50
	ld	(hl), #0xc4
00294$:
	ldhl	sp,	#50
	ld	a, (hl-)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00203$
00202$:
;src/player.c:213: } else if (hit == COL_ORB_BLUE) {
	ldhl	sp,	#50
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ, 00199$
;src/player.c:214: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#28
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:215: p->vel_y = (p->gravity_flipped) ? -64 : 64;
	or	a, a
	ld	a, #0xc0
	jr	NZ, 00296$
	ld	a, #0x40
00296$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00203$
00199$:
;src/player.c:217: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE+7 : JUMP_FORCE-7;
	ldhl	sp,	#49
	ld	a, (hl)
	or	a, a
	ld	a, #0x64
	jr	NZ, 00298$
	ld	a, #0x9c
00298$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00203$:
;src/player.c:219: p->on_ground = 0;
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:220: break; // only fire once per frame even if multiple corners overlap different orbs
	jr	00210$
00204$:
;src/player.c:200: for (uint8_t i = 0; i < 4; i++) {
	ldhl	sp,	#50
	inc	(hl)
	jp	00262$
00210$:
;src/player.c:225: if (IS_SOLID(front_head) || IS_SOLID(front_foot) ||
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jp	Z, 00214$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00214$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00214$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00214$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x07
	jp	Z, 00214$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00214$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00214$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00214$
;src/player.c:226: IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	dec	a
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00214$
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	dec	a
	jr	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00214$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	dec	a
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00214$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	dec	a
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00214$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00215$
00214$:
;src/player.c:227: p->dead = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:228: col_at_end();
	call	_col_at_end
;src/player.c:229: return 1;
	ld	a, #0x01
	jp	00263$
00215$:
;src/player.c:232: col_at_end();
	call	_col_at_end
;src/player.c:235: if (p->on_ground) {
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#50
	ld	(hl), a
;src/player.c:236: p->anim_timer = 0;
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:237: p->anim_frame = 0;
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
;src/player.c:235: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00256$
;src/player.c:236: p->anim_timer = 0;
;src/player.c:237: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00257$
00256$:
;src/player.c:239: p->anim_timer += 10;
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
;src/player.c:240: if (p->anim_timer >= 17) {
	ld	a, e
	sub	a, #0x11
	ld	a, d
	sbc	a, #0x00
	jr	C, 00257$
;src/player.c:241: p->anim_timer -= 17;
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
;src/player.c:242: p->anim_frame++;
	ldhl	sp,#48
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
;src/player.c:243: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00257$
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00257$:
;src/player.c:248: if (p->world_y > (int16_t)((uint16_t)map_h << 4) || p->world_y < -32) {
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#60
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
	jr	Z, 01209$
	bit	7, d
	jr	NZ, 01210$
	cp	a, a
	jr	01210$
01209$:
	bit	7, d
	jr	Z, 01210$
	scf
01210$:
	jr	C, 00258$
	ld	a, c
	sub	a, #0xe0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00259$
00258$:
;src/player.c:249: p->dead = 1;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;src/player.c:250: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00263$
00259$:
;src/player.c:253: p->last_joy = joy;
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#51
	ld	a, (hl)
	ld	(bc), a
;src/player.c:254: return 0;
	xor	a, a
00263$:
;src/player.c:255: }
	add	sp, #54
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
