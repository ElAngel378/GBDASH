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
	ld	hl, #0x000c
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:12: p->anim_frame = 0;
	ld	hl, #0x000b
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
;src/player.c:15: p->reversed = 0;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/player.c:16: p->last_joy = 0;
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x00
;src/player.c:17: p->touching_orb = 0;
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x00
;src/player.c:18: p->level_complete = 0;
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->sp_idx = 0;
	ld	hl, #0x0013
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:20: p->activated_count = 0;
	ld	hl, #0x002d
	add	hl, de
	ld	(hl), #0x00
;src/player.c:21: p->next_activated_slot = 0;
	ld	hl, #0x002e
	add	hl, de
	ld	(hl), #0x00
;src/player.c:22: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:24: uint8_t player_tile_activated(const Player* p, uint16_t mx, uint8_t my) {
;	---------------------------------
; Function player_tile_activated
; ---------------------------------
_player_tile_activated::
	add	sp, #-9
	ldhl	sp,	#7
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:25: if (p->activated_count == 0) return 0;
	ld	hl, #0x002d
	add	hl, de
	ld	a, (hl)
	ldhl	sp,#0
	ld	(hl), a
	or	a, a
	jr	NZ, 00102$
	xor	a, a
	jr	00112$
00102$:
;src/player.c:27: uint8_t idx = p->next_activated_slot;
	ld	hl, #0x002e
	add	hl, de
	ld	c, (hl)
;src/player.c:28: for (uint8_t i = 0; i < p->activated_count; i++) {
	ld	hl, #0x0015
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ld	b, #0x00
00110$:
	ld	a, b
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00108$
;src/player.c:29: if (idx == 0) idx = MAX_ACTIVATIONS;
	ld	a, c
	or	a, a
	jr	NZ, 00104$
	ld	c, #0x08
00104$:
;src/player.c:30: idx--;
	dec	c
;src/player.c:32: if (p->activated[idx].mx == mx && p->activated[idx].my == my) return 1;
	ld	a, c
	add	a, a
	add	a, c
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	NZ, 00111$
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	NZ, 00111$
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00111$
	ld	a, #0x01
	jr	00112$
00111$:
;src/player.c:28: for (uint8_t i = 0; i < p->activated_count; i++) {
	inc	b
	jr	00110$
00108$:
;src/player.c:34: return 0;
	xor	a, a
00112$:
;src/player.c:35: }
	add	sp, #9
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:37: void player_mark_activated(Player* p, uint16_t mx, uint8_t my) {
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
;src/player.c:38: p->activated[p->next_activated_slot].mx = mx;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0015
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x002e
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
;src/player.c:39: p->activated[p->next_activated_slot].my = my;
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
;src/player.c:40: p->next_activated_slot++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/player.c:41: if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
	sub	a, #0x08
	jr	C, 00102$
	xor	a, a
	ld	(bc), a
00102$:
;src/player.c:42: if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x002d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x08
	jr	NC, 00105$
	inc	a
	ld	(bc), a
00105$:
;src/player.c:43: }
	add	sp, #6
	pop	hl
	inc	sp
	jp	(hl)
;src/player.c:45: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:46: return (int16_t)(p->world_y.b.h) - (int16_t)cam_y;
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;src/player.c:47: }
	ret
;src/player.c:49: uint8_t player_update(
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
;src/player.c:57: if (p->dead) return 1;
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
	jp	00236$
00102$:
;src/player.c:60: if (p->level_complete) {
	ldhl	sp,#36
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
;src/player.c:61: return 0;
	xor	a, a
	jp	00236$
00104$:
;src/player.c:64: col_at_begin(map_bank);
	ldhl	sp,	#46
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:66: if (p->mode == MODE_SHIP) {
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
	ld	c, a
;src/player.c:67: if (joy & J_A) {
	ldhl	sp,	#35
	ld	a, (hl-)
	dec	hl
	and	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#36
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
;src/player.c:77: if (!p->on_ground) {
	ldhl	sp,#36
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
;src/player.c:66: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00122$
;src/player.c:72: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:67: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#33
	or	a, (hl)
	jr	Z, 00106$
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00238$
	ldhl	sp,	#29
	ld	a, #0x34
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00239$
00238$:
	ldhl	sp,	#29
	ld	a, #0xcc
	ld	(hl+), a
	ld	(hl), #0xff
00239$:
	ldhl	sp,#29
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
	jr	00107$
00106$:
;src/player.c:70: p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00240$
	ld	de, #0xffde
	jr	00241$
00240$:
	ld	de, #0x0022
00241$:
	ldhl	sp,	#27
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
00107$:
;src/player.c:72: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00242$
	ld	hl, #0x0369
	jr	00243$
00242$:
	ld	hl, #0x0443
00243$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01273$
	bit	7, d
	jr	NZ, 01274$
	cp	a, a
	jr	01274$
01273$:
	bit	7, d
	jr	Z, 01274$
	scf
01274$:
	jr	NC, 00109$
;src/player.c:73: p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00244$
	ld	bc, #0x0369
	jr	00245$
00244$:
	ld	bc, #0x0443
00245$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00109$:
;src/player.c:74: if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
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
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00246$
	ld	hl, #0xfbbd
	jr	00247$
00246$:
	ld	hl, #0xfc97
00247$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01275$
	bit	7, d
	jr	NZ, 01276$
	cp	a, a
	jr	01276$
01275$:
	bit	7, d
	jr	Z, 01276$
	scf
01276$:
	jp	NC, 00123$
;src/player.c:75: p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00248$
	ld	de, #0xfbbd
	jr	00249$
00248$:
	ld	de, #0xfc97
00249$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00123$
00122$:
;src/player.c:77: if (!p->on_ground) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00123$
;src/player.c:78: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:72: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:78: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/player.c:79: p->vel_y.w -= GRAVITY;
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
;src/player.c:80: if (p->vel_y.w < -MAX_FALL_SPEED) p->vel_y.w = -MAX_FALL_SPEED;
	ld	a, b
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00123$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00123$
00117$:
;src/player.c:82: p->vel_y.w += GRAVITY;
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
;src/player.c:83: if (p->vel_y.w > MAX_FALL_SPEED) p->vel_y.w = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x06
	xor	a, a
	cp	a, c
	ld	a, #0x06
	sbc	a, b
	bit	7, e
	jr	Z, 01277$
	bit	7, d
	jr	NZ, 01278$
	cp	a, a
	jr	01278$
01277$:
	bit	7, d
	jr	Z, 01278$
	scf
01278$:
	jr	NC, 00123$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00123$:
;src/player.c:90: p->world_y.w += p->vel_y.w;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:88: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00127$
;src/player.c:89: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#33
	or	a, (hl)
	jr	Z, 00125$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
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
	ldhl	sp,	#33
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00251$:
	ldhl	sp,	#33
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
00125$:
;src/player.c:90: p->world_y.w += p->vel_y.w;
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#4
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
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
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
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:91: col_at_end();
	call	_col_at_end
;src/player.c:92: return 0;
	xor	a, a
	jp	00236$
00127$:
;src/player.c:95: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#32
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00129$
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00129$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00129$
;src/player.c:96: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
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
	jr	Z, 00252$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00253$
00252$:
	ldhl	sp,	#33
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00253$:
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:97: p->on_ground = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00129$:
;src/player.c:100: uint16_t px = p->world_x;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:101: uint8_t py = p->world_y.b.h;
	ldhl	sp,#36
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
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:102: uint16_t mx0 = px >> 4;
	ldhl	sp,	#30
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
;src/player.c:103: const uint8_t* c0 = &map[mx0 << 4];
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ld	a, #0x04
01279$:
	ldhl	sp,	#25
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01279$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#40
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
;src/player.c:104: const uint8_t* c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#32
	ld	e, l
	ld	d, h
	ldhl	sp,	#42
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00254$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
	jr	00255$
00254$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00255$:
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:106: uint8_t x_mod_16 = (uint8_t)px & 0x0F;
	ldhl	sp,	#30
	ld	a, (hl)
	and	a, #0x0f
;src/player.c:107: uint8_t threshold = 16 - x_mod_16;
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, #0x10
	sub	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
;src/player.c:117: uint8_t front_mid = COL_AT_PTR(p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#31
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
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00256$
	ld	a, #0x07
	jr	00257$
00256$:
	ldhl	sp,	#33
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00260$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00261$
00260$:
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jr	Z, 00262$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00263$
00262$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00263$:
00261$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00257$:
;src/player.c:119: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00132$
	cp	a, #0x09
	jr	Z, 00132$
	cp	a, #0x05
	jr	Z, 00132$
	sub	a, #0x06
	jr	NZ, 00133$
00132$:
;src/player.c:120: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:121: col_at_end();
	call	_col_at_end
;src/player.c:122: return 1;
	ld	a, #0x01
	jp	00236$
00133$:
;src/player.c:125: p->world_y.w += p->vel_y.w;
	ldhl	sp,#27
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
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:126: uint8_t ny = p->world_y.b.h;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#20
	ld	(hl), a
;src/player.c:127: p->on_ground = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:129: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#20
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
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00264$
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00265$
00264$:
	ldhl	sp,	#31
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00265$:
;src/player.c:133: if (p->mode == MODE_SHIP) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00138$
;src/player.c:134: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE) : ny;
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00266$
	inc	hl
	ld	a, (hl+)
	ld	d, (hl)
	jr	00267$
00266$:
	ldhl	sp,	#21
	ld	a, (hl)
	ld	d, #0x00
00267$:
	ldhl	sp,	#23
	ld	(hl+), a
	ld	(hl), d
	jr	00139$
00138$:
;src/player.c:136: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00268$
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
	jr	00269$
00268$:
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
00269$:
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00139$:
;src/player.c:139: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#33
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#34
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
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00270$
	ld	a, #0x07
	jr	00271$
00270$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00274$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00275$
00274$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00275$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00271$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:140: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00276$
	ld	a, #0x07
	jr	00277$
00276$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00280$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00281$
00280$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00281$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00277$:
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:142: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:72: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:142: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00282$
	ldhl	sp,	#33
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01288$
	bit	7, d
	jr	NZ, 01289$
	cp	a, a
	jr	01289$
01288$:
	bit	7, d
	jr	Z, 01289$
	scf
01289$:
	ld	a, #0x00
	rla
	ldhl	sp,	#34
	ld	(hl), a
	ld	a, (hl)
	xor	a, #0x01
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00283$
00282$:
	ldhl	sp,	#34
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
	ldhl	sp,	#30
	ld	(hl), a
00283$:
;src/player.c:146: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#20
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:148: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:151: p->world_y.b.l = 0;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
;src/player.c:146: py = ((ny >> 4) + 1) << 4;
;src/player.c:148: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	add	a, #0x0f
;src/player.c:146: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	inc	(hl)
;src/player.c:148: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	inc	hl
	ld	a, (hl)
	and	a, #0xf0
;src/player.c:146: py = ((ny >> 4) + 1) << 4;
	ld	(hl-), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
;src/player.c:148: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0xf0
	ld	(hl), a
;src/player.c:144: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00179$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00178$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00178$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00178$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00178$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00178$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00178$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00178$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00179$
00178$:
;src/player.c:145: if (p->gravity_flipped) {
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00141$
;src/player.c:146: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:148: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00141$:
;src/player.c:150: p->world_y.b.h = py;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#34
	ld	a, (hl)
	ld	(de), a
;src/player.c:151: p->world_y.b.l = 0;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:152: p->vel_y.w = 0;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:153: p->on_ground = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00180$
00179$:
;src/player.c:156: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#23
	ld	(hl), #0x00
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00284$
	ld	a, #0x07
	jr	00285$
00284$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00288$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00289$
00288$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00289$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00285$:
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:157: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ldhl	sp,	#24
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00290$
	ldhl	sp,	#30
	ld	(hl), #0x07
	jr	00291$
00290$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00294$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jr	00295$
00294$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
00295$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#30
	ld	(hl), a
00291$:
	ldhl	sp,	#30
;src/player.c:159: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00168$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00168$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00168$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00168$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00168$
	cp	a,#0x09
	jr	Z, 00168$
	cp	a,#0x05
	jr	Z, 00168$
	sub	a, #0x06
	jr	NZ, 00169$
00168$:
;src/player.c:160: if (p->mode == MODE_CUBE) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00147$
;src/player.c:162: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:163: col_at_end();
	call	_col_at_end
;src/player.c:164: return 1;
	ld	a, #0x01
	jp	00236$
00147$:
;src/player.c:167: if (p->gravity_flipped) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#30
	ld	(hl), a
	ld	a, (hl)
	or	a, a
;src/player.c:168: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00145$
;src/player.c:170: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	(hl), a
00145$:
;src/player.c:172: p->world_y.b.h = py;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#34
	ld	a, (hl)
	ld	(de), a
;src/player.c:173: p->world_y.b.l = 0;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:174: p->vel_y.w = 0;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00180$
00169$:
;src/player.c:177: py = ny;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:180: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00296$
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#33
	ld	(hl-), a
	ld	(hl), e
	jr	00297$
00296$:
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), a
00297$:
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:181: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#29
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
	jr	Z, 00298$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00300$
	xor	a, a
	jr	00299$
00300$:
	ld	a, #0x07
	jr	00299$
00298$:
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00302$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	jr	00303$
00302$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
00303$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00299$:
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:182: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#32
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00304$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00306$
	ld	(hl), #0x00
	jr	00305$
00306$:
	ldhl	sp,	#33
	ld	(hl), #0x07
	jr	00305$
00304$:
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00309$
00308$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00309$:
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
00305$:
	ldhl	sp,	#33
	ld	c, (hl)
;src/player.c:184: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00159$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00159$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00159$
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00159$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00159$
	cp	a,#0x09
	jr	Z, 00159$
	cp	a,#0x05
	jr	Z, 00159$
	sub	a, #0x06
	jr	NZ, 00180$
00159$:
;src/player.c:185: p->on_ground = 1;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:186: if (p->mode == MODE_CUBE) p->vel_y.w = 0;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00157$
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00180$
00157$:
;src/player.c:187: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
;src/player.c:72: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:68: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:187: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ld	a, c
	or	a, a
	jr	Z, 00154$
	bit	7, l
	jr	Z, 00180$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00180$
00154$:
;src/player.c:188: else { if (p->vel_y.w > 0) p->vel_y.w = 0; }
	ld	e, l
	xor	a, a
	ld	d, a
	cp	a, b
	sbc	a, l
	bit	7, e
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
	jr	NC, 00180$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00180$:
;src/player.c:193: const uint8_t* c_front = p->reversed ? c0 : GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00310$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00311$
00310$:
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jr	Z, 00312$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	jr	00313$
00312$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
00313$:
00311$:
;src/player.c:194: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#34
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
	ld	c, l
	ld	a, h
	ldhl	sp,	#22
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
	jr	Z, 00314$
	ld	a, #0x07
	jr	00315$
00314$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00315$:
	ldhl	sp,	#26
	ld	(hl), a
;src/player.c:195: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#27
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
	jr	Z, 00318$
	ld	a, #0x07
	jr	00319$
00318$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00319$:
	ldhl	sp,	#31
	ld	(hl), a
;src/player.c:197: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00322$
	ld	a, #0x07
	jr	00323$
00322$:
	ldhl	sp,	#22
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00326$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00327$
00326$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00327$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00323$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:198: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#16
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00328$
	inc	hl
	ld	(hl), #0x07
	jr	00329$
00328$:
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00332$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	jr	00333$
00332$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
00333$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#25
	ld	(hl), a
00329$:
	ldhl	sp,	#25
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:199: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00334$
	ld	a, #0x07
	jr	00335$
00334$:
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	or	a, a
	jr	Z, 00338$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	jr	00339$
00338$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
00339$:
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00335$:
	ldhl	sp,	#32
;src/player.c:200: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00340$
	ldhl	sp,	#34
	ld	(hl), #0x07
	jr	00341$
00340$:
	ldhl	sp,	#27
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
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	jr	00345$
00344$:
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00345$:
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#34
	ld	(hl), a
00341$:
	ldhl	sp,	#34
	ld	c, (hl)
;src/player.c:202: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00189$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00189$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00189$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00189$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00189$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00189$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00189$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00190$
00189$:
;src/player.c:203: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:204: col_at_end();
	call	_col_at_end
;src/player.c:205: return 1;
	ld	a, #0x01
	jp	00236$
00190$:
;src/player.c:208: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	dec	a
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00198$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	dec	a
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00198$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00198$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00198$
	ld	a,c
	cp	a,#0x08
	jr	Z, 00198$
	cp	a,#0x03
	jr	Z, 00198$
	cp	a,#0x04
	jr	Z, 00198$
	cp	a,#0x02
	jr	Z, 00198$
	dec	a
	jr	Z, 00198$
	ld	a,c
	cp	a,#0x10
	jr	Z, 00198$
	sub	a, #0x11
	jr	NZ, 00199$
00198$:
;src/player.c:209: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:210: col_at_end();
	call	_col_at_end
;src/player.c:211: return 1;
	ld	a, #0x01
	jp	00236$
00199$:
;src/player.c:216: col_at_end();
	call	_col_at_end
;src/player.c:218: if (p->on_ground) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:219: p->anim_timer = 0;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:220: p->anim_frame = 0;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
;src/player.c:218: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00232$
;src/player.c:219: p->anim_timer = 0;
;src/player.c:220: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00233$
00232$:
;src/player.c:222: p->anim_timer += 10;
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
;src/player.c:223: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00233$
;src/player.c:224: p->anim_timer -= 20;
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
;src/player.c:225: p->anim_frame++;
	ldhl	sp,#32
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
	jr	C, 00233$
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00233$:
;src/player.c:230: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#44
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
;src/player.c:231: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:232: return 1;
	ld	a, #0x01
	jr	00236$
00235$:
;src/player.c:235: p->last_joy = joy;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#35
	ld	a, (hl)
	ld	(bc), a
;src/player.c:236: return 0;
	xor	a, a
00236$:
;src/player.c:237: }
	add	sp, #38
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
