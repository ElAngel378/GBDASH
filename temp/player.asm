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
	.globl _col_at_raw_cached
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
;src/player.c:5: void player_init(Player* p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init::
	dec	sp
	dec	sp
;src/player.c:6: p->world_x = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:7: p->world_y.w = (uint16_t)start_y << 8;
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
;src/player.c:8: p->vel_y.w = 0;
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
;src/player.c:17: p->sp_idx = 0;
	ld	hl, #0x000f
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:18: p->activated_count = 0;
	ld	hl, #0x0029
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->next_activated_slot = 0;
	ld	hl, #0x002a
	add	hl, de
	ld	(hl), #0x00
;src/player.c:20: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:22: uint8_t player_tile_activated(const Player* p, uint16_t mx, uint8_t my) {
;	---------------------------------
; Function player_tile_activated
; ---------------------------------
_player_tile_activated::
	add	sp, #-9
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:23: for (uint8_t i = 0; i < p->activated_count; i++) {
	push	de
	ld	hl, #0x0011
	add	hl, de
	pop	de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #0x0029
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
;src/player.c:24: if (p->activated[i].mx == mx && p->activated[i].my == my) return 1;
	ld	a,(hl)
	cp	a,c
	jr	NC, 00104$
	ld	c, a
	add	a, a
	add	a, c
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
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00107$
	ld	a, #0x01
	jr	00108$
00107$:
;src/player.c:23: for (uint8_t i = 0; i < p->activated_count; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jr	00106$
00104$:
;src/player.c:26: return 0;
	xor	a, a
00108$:
;src/player.c:27: }
	add	sp, #9
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:29: void player_mark_activated(Player* p, uint16_t mx, uint8_t my) {
;	---------------------------------
; Function player_mark_activated
; ---------------------------------
_player_mark_activated::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
;src/player.c:30: p->activated[p->next_activated_slot].mx = mx;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x002a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
	add	a, a
	add	a, e
	ld	e, a
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:31: p->activated[p->next_activated_slot].my = my;
	ld	a, (bc)
	ld	e, a
	add	a, a
	add	a, e
	ld	e, a
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
;src/player.c:32: p->next_activated_slot++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/player.c:33: if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
	sub	a, #0x08
	jr	C, 00102$
	xor	a, a
	ld	(bc), a
00102$:
;src/player.c:34: if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0029
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x08
	jr	NC, 00105$
	inc	a
	ld	(bc), a
00105$:
;src/player.c:35: }
	add	sp, #6
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:37: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:38: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:39: }
	ret
;src/player.c:41: uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update::
	add	sp, #-36
	ldhl	sp,	#34
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:49: if (p->dead) return 1;
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
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00234$
00102$:
;src/player.c:51: col_at_begin(map_bank);
	ldhl	sp,	#44
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:53: if (p->mode == MODE_SHIP) {
	ldhl	sp,#34
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
;src/player.c:54: if (joy & J_A) {
	ldhl	sp,	#33
	ld	a, (hl-)
	dec	hl
	and	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,#34
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
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/player.c:53: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#4
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
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:54: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#31
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00236$
	ldhl	sp,	#27
	ld	a, #0x34
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00237$
00236$:
	ldhl	sp,	#27
	ld	a, #0xcc
	ld	(hl+), a
	ld	(hl), #0xff
00237$:
	ldhl	sp,#27
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
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00105$
00104$:
;src/player.c:57: p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00238$
	ld	de, #0xffde
	jr	00239$
00238$:
	ld	de, #0x0022
00239$:
	ldhl	sp,	#25
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00105$:
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#4
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
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00240$
	ld	hl, #0x0369
	jr	00241$
00240$:
	ld	hl, #0x0443
00241$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01246$
	bit	7, d
	jr	NZ, 01247$
	cp	a, a
	jr	01247$
01246$:
	bit	7, d
	jr	Z, 01247$
	scf
01247$:
	jr	NC, 00107$
;src/player.c:60: p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00242$
	ld	bc, #0x0369
	jr	00243$
00242$:
	ld	bc, #0x0443
00243$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00107$:
;src/player.c:61: if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
	ldhl	sp,#4
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
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00244$
	ld	hl, #0xfbbd
	jr	00245$
00244$:
	ld	hl, #0xfc97
00245$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01248$
	bit	7, d
	jr	NZ, 01249$
	cp	a, a
	jr	01249$
01248$:
	bit	7, d
	jr	Z, 01249$
	scf
01249$:
	jp	NC, 00121$
;src/player.c:62: p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00246$
	ld	de, #0xfbbd
	jr	00247$
00246$:
	ld	de, #0xfc97
00247$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00121$
00120$:
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00121$
;src/player.c:65: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:65: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00115$
;src/player.c:66: p->vel_y.w -= GRAVITY;
	ld	bc, #0xff95
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:67: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ld	a, b
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00121$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00121$
00115$:
;src/player.c:69: p->vel_y.w += GRAVITY;
	ld	bc, #0x006b
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:70: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x06
	xor	a, a
	cp	a, c
	ld	a, #0x06
	sbc	a, b
	bit	7, e
	jr	Z, 01250$
	bit	7, d
	jr	NZ, 01251$
	cp	a, a
	jr	01251$
01250$:
	bit	7, d
	jr	Z, 01251$
	scf
01251$:
	jr	NC, 00121$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00121$:
;src/player.c:77: p->world_y.w += p->vel_y.w;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:75: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00125$
;src/player.c:76: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#31
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00248$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00249$
00248$:
	ldhl	sp,	#31
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00249$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/player.c:77: p->world_y.w += p->vel_y.w;
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:78: col_at_end();
	call	_col_at_end
;src/player.c:79: return 0;
	xor	a, a
	jp	00234$
00125$:
;src/player.c:82: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00127$
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00127$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00127$
;src/player.c:83: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00250$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00251$
00250$:
	ldhl	sp,	#31
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00251$:
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:84: p->on_ground = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:87: uint16_t px = p->world_x;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#28
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:88: uint8_t py = p->world_y.b.h;
	ldhl	sp,#34
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
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:89: uint16_t mx0 = px >> 4;
	ldhl	sp,	#28
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
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
;src/player.c:90: const uint8_t* c0 = &map[mx0 << 4];
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ld	a, #0x04
01252$:
	ldhl	sp,	#23
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01252$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#38
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/player.c:91: const uint8_t* c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#30
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00252$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
	jr	00253$
00252$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
00253$:
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:93: uint8_t x_mod_16 = (uint8_t)px & 0x0F;
	ldhl	sp,	#28
	ld	a, (hl)
	and	a, #0x0f
;src/player.c:94: uint8_t threshold = 16 - x_mod_16;
	ldhl	sp,	#31
	ld	(hl), a
	ld	a, #0x10
	sub	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
;src/player.c:104: uint8_t front_mid = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#29
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
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, #0x0f
	ldhl	sp,	#16
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00254$
	ld	a, #0x07
	jr	00255$
00254$:
	ldhl	sp,	#31
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jr	Z, 00258$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00259$
00258$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00259$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00255$:
;src/player.c:106: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00130$
	cp	a, #0x09
	jr	Z, 00130$
	cp	a, #0x05
	jr	Z, 00130$
	sub	a, #0x06
	jr	NZ, 00131$
00130$:
;src/player.c:107: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:108: col_at_end();
	call	_col_at_end
;src/player.c:109: return 1;
	ld	a, #0x01
	jp	00234$
00131$:
;src/player.c:112: p->world_y.w += p->vel_y.w;
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:113: uint8_t ny = p->world_y.b.h;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl), a
;src/player.c:114: p->on_ground = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:116: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#18
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
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00260$
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00261$
00260$:
	ldhl	sp,	#29
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00261$:
;src/player.c:120: if (p->mode == MODE_SHIP) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00136$
;src/player.c:121: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE) : ny;
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00262$
	inc	hl
	ld	a, (hl+)
	ld	d, (hl)
	jr	00263$
00262$:
	ldhl	sp,	#19
	ld	a, (hl)
	ld	d, #0x00
00263$:
	ldhl	sp,	#21
	ld	(hl+), a
	ld	(hl), d
	jr	00137$
00136$:
;src/player.c:123: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00264$
	ldhl	sp,#19
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
	ld	(hl), a
	jr	00265$
00264$:
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl), a
00265$:
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
00137$:
;src/player.c:126: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#31
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x02
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00266$
	ld	a, #0x07
	jr	00267$
00266$:
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00270$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00271$
00270$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00271$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00267$:
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:127: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00272$
	ld	a, #0x07
	jr	00273$
00272$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00276$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00277$
00276$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00277$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00273$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:129: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:129: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00278$
	ldhl	sp,	#31
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01261$
	bit	7, d
	jr	NZ, 01262$
	cp	a, a
	jr	01262$
01261$:
	bit	7, d
	jr	Z, 01262$
	scf
01262$:
	ld	a, #0x00
	rla
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	xor	a, #0x01
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00279$
00278$:
	ldhl	sp,	#32
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
	ldhl	sp,	#28
	ld	(hl), a
00279$:
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#18
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:138: p->world_y.b.l = 0;
	ldhl	sp,#34
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
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	add	a, #0x0f
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	inc	(hl)
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	a, (hl)
	and	a, #0xf0
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0xf0
	ld	(hl), a
;src/player.c:131: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00176$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00176$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00176$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00176$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00176$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00176$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00176$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00177$
00176$:
;src/player.c:132: if (p->gravity_flipped) {
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00139$
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00139$:
;src/player.c:137: p->world_y.b.h = py;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a, (hl)
	ld	(de), a
;src/player.c:138: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:139: p->vel_y.w = 0;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:140: p->on_ground = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00178$
00177$:
;src/player.c:143: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#21
	ld	(hl), #0x00
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00280$
	ld	a, #0x07
	jr	00281$
00280$:
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00284$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00285$
00284$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00285$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00281$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:144: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ldhl	sp,	#22
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00286$
	ldhl	sp,	#28
	ld	(hl), #0x07
	jr	00287$
00286$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00290$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	jr	00291$
00290$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
00291$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#28
	ld	(hl), a
00287$:
	ldhl	sp,	#28
;src/player.c:146: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00166$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00166$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00166$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00166$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00166$
	cp	a,#0x09
	jr	Z, 00166$
	cp	a,#0x05
	jr	Z, 00166$
	sub	a, #0x06
	jr	NZ, 00167$
00166$:
;src/player.c:147: if (p->mode == MODE_CUBE) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00145$
;src/player.c:149: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:150: col_at_end();
	call	_col_at_end
;src/player.c:151: return 1;
	ld	a, #0x01
	jp	00234$
00145$:
;src/player.c:154: if (p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#28
	ld	(hl), a
	ld	a, (hl)
	or	a, a
;src/player.c:155: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00143$
;src/player.c:157: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(hl), a
00143$:
;src/player.c:159: p->world_y.b.h = py;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a, (hl)
	ld	(de), a
;src/player.c:160: p->world_y.b.l = 0;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:161: p->vel_y.w = 0;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00178$
00167$:
;src/player.c:164: py = ny;
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:167: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00292$
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#31
	ld	(hl-), a
	ld	(hl), e
	jr	00293$
00292$:
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), a
00293$:
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:168: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00294$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	xor	a, a
	jr	00295$
00296$:
	ld	a, #0x07
	jr	00295$
00294$:
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00298$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00299$
00298$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00299$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00295$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:169: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00300$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00302$
	ld	(hl), #0x00
	jr	00301$
00302$:
	ldhl	sp,	#31
	ld	(hl), #0x07
	jr	00301$
00300$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00304$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	jr	00305$
00304$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
00305$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#31
	ld	(hl), a
00301$:
	ldhl	sp,	#31
	ld	c, (hl)
;src/player.c:171: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00157$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00157$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00157$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00157$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00157$
	cp	a,#0x09
	jr	Z, 00157$
	cp	a,#0x05
	jr	Z, 00157$
	sub	a, #0x06
	jr	NZ, 00178$
00157$:
;src/player.c:172: p->on_ground = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:173: if (p->mode == MODE_CUBE) p->vel_y.w = 0;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00155$
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00178$
00155$:
;src/player.c:174: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:174: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ld	a, c
	or	a, a
	jr	Z, 00152$
	bit	7, l
	jr	Z, 00178$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00178$
00152$:
;src/player.c:175: else { if (p->vel_y.w > 0) p->vel_y.w = 0; }
	ld	e, l
	xor	a, a
	ld	d, a
	cp	a, b
	sbc	a, l
	bit	7, e
	jr	Z, 01290$
	bit	7, d
	jr	NZ, 01291$
	cp	a, a
	jr	01291$
01290$:
	bit	7, d
	jr	Z, 01291$
	scf
01291$:
	jr	NC, 00178$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00178$:
;src/player.c:180: const uint8_t* c_front = GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jr	Z, 00306$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00307$
00306$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00307$:
	ldhl	sp,	#30
	ld	(hl), e
	inc	hl
;src/player.c:181: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#28
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
	jr	Z, 00308$
	ld	a, #0x07
	jr	00309$
00308$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00309$:
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:182: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#25
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
	jr	Z, 00312$
	ld	a, #0x07
	jr	00313$
00312$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00313$:
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:184: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00316$
	ld	a, #0x07
	jr	00317$
00316$:
	ldhl	sp,	#20
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00320$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	jr	00321$
00320$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00321$:
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00317$:
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:185: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00322$
	inc	hl
	ld	(hl), #0x07
	jr	00323$
00322$:
	ldhl	sp,	#20
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00326$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	jr	00327$
00326$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
00327$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#23
	ld	(hl), a
00323$:
	ldhl	sp,	#23
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:186: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#28
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00328$
	ld	a, #0x07
	jr	00329$
00328$:
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00332$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	jr	00333$
00332$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
00333$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00329$:
	ldhl	sp,	#30
;src/player.c:187: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00334$
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00335$
00334$:
	ldhl	sp,	#25
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00338$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	jr	00339$
00338$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
00339$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#32
	ld	(hl), a
00335$:
	ldhl	sp,	#32
	ld	c, (hl)
;src/player.c:189: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00187$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00187$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00187$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00187$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00187$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00187$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00187$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00188$
00187$:
;src/player.c:190: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:191: col_at_end();
	call	_col_at_end
;src/player.c:192: return 1;
	ld	a, #0x01
	jp	00234$
00188$:
;src/player.c:195: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	dec	a
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00196$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	dec	a
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00196$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	dec	a
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00196$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00196$
	ld	a,c
	cp	a,#0x08
	jr	Z, 00196$
	cp	a,#0x03
	jr	Z, 00196$
	cp	a,#0x04
	jr	Z, 00196$
	cp	a,#0x02
	jr	Z, 00196$
	dec	a
	jr	Z, 00196$
	ld	a,c
	cp	a,#0x10
	jr	Z, 00196$
	sub	a, #0x11
	jr	NZ, 00197$
00196$:
;src/player.c:196: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:197: col_at_end();
	call	_col_at_end
;src/player.c:198: return 1;
	ld	a, #0x01
	jp	00234$
00197$:
;src/player.c:203: col_at_end();
	call	_col_at_end
;src/player.c:205: if (p->on_ground) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:206: p->anim_timer = 0;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:207: p->anim_frame = 0;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
;src/player.c:205: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00230$
;src/player.c:206: p->anim_timer = 0;
;src/player.c:207: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00231$
00230$:
;src/player.c:209: p->anim_timer += 10;
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
;src/player.c:210: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00231$
;src/player.c:211: p->anim_timer -= 20;
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
;src/player.c:212: p->anim_frame++;
	ldhl	sp,#30
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
;src/player.c:213: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00231$
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00231$:
;src/player.c:217: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#10
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
	jr	NC, 00233$
;src/player.c:218: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:219: return 1;
	ld	a, #0x01
	jr	00234$
00233$:
;src/player.c:222: p->last_joy = joy;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(bc), a
;src/player.c:223: return 0;
	xor	a, a
00234$:
;src/player.c:224: }
	add	sp, #36
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
