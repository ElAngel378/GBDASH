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
;src/player.c:17: p->portal_idx = 0;
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
	add	sp, #-42
	ldhl	sp,	#40
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
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00289$
00102$:
;src/player.c:51: col_at_begin(map_bank);
	ldhl	sp,	#50
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:53: if (p->mode == MODE_SHIP) {
	ldhl	sp,#40
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
	ldhl	sp,	#39
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#40
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
	ldhl	sp,#40
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
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#40
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
;src/player.c:53: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:54: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00291$
	ld	hl, #0x0034
	jr	00292$
00291$:
	ld	hl, #0xffcc
00292$:
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
	jr	00105$
00104$:
;src/player.c:57: p->vel_y.w += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00293$
	ld	hl, #0xffde
	jr	00294$
00293$:
	ld	hl, #0x0022
00294$:
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
00105$:
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00295$
	ld	hl, #0x0369
	jr	00296$
00295$:
	ld	hl, #0x0443
00296$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01622$
	bit	7, d
	jr	NZ, 01623$
	cp	a, a
	jr	01623$
01622$:
	bit	7, d
	jr	Z, 01623$
	scf
01623$:
	jr	NC, 00107$
;src/player.c:60: p->vel_y.w = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00297$
	ld	bc, #0x0369
	jr	00298$
00297$:
	ld	bc, #0x0443
00298$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00107$:
;src/player.c:61: if (p->vel_y.w < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
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
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00299$
	ld	hl, #0xfbbd
	jr	00300$
00299$:
	ld	hl, #0xfc97
00300$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01624$
	bit	7, d
	jr	NZ, 01625$
	cp	a, a
	jr	01625$
01624$:
	bit	7, d
	jr	Z, 01625$
	scf
01625$:
	jp	NC, 00121$
;src/player.c:62: p->vel_y.w = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00301$
	ld	de, #0xfbbd
	jr	00302$
00301$:
	ld	de, #0xfc97
00302$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00121$
00120$:
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#10
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
	ldhl	sp,	#6
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
	ldhl	sp,	#6
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
	ldhl	sp,	#6
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
	jr	Z, 01626$
	bit	7, d
	jr	NZ, 01627$
	cp	a, a
	jr	01627$
01626$:
	bit	7, d
	jr	Z, 01627$
	scf
01627$:
	jr	NC, 00121$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00121$:
;src/player.c:77: p->world_y.w += p->vel_y.w;
	ldhl	sp,#40
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
	ld	(hl), a
;src/player.c:75: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00125$
;src/player.c:76: if (joy & J_A) p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00303$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00304$
00303$:
	ldhl	sp,	#37
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00304$:
	ldhl	sp,	#37
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
00123$:
;src/player.c:77: p->world_y.w += p->vel_y.w;
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#37
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#35
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
	ldhl	sp,	#31
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
	jp	00289$
00125$:
;src/player.c:82: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00127$
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00127$
	ldhl	sp,#10
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
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00305$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00306$
00305$:
	ldhl	sp,	#37
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00306$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:84: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:87: uint16_t px = p->world_x;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:88: uint8_t py = p->world_y.b.h;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:89: uint16_t mx0 = px >> 4;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#17
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
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#44
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
;src/player.c:91: const uint8_t* c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#36
	ld	e, l
	ld	d, h
	ldhl	sp,	#46
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00307$
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
	ld	(hl), a
	jr	00308$
00307$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
00308$:
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:93: uint8_t x_mod_16 = (uint8_t)px & 0x0F;
	ldhl	sp,	#12
	ld	a, (hl)
	and	a, #0x0f
;src/player.c:94: uint8_t threshold = 16 - x_mod_16;
	ldhl	sp,	#37
	ld	(hl), a
	ld	a, #0x10
	sub	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
;src/player.c:104: uint8_t front_mid = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#35
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
	ldhl	sp,	#39
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, #0x0f
	ldhl	sp,	#22
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00309$
	ld	a, #0x07
	jr	00310$
00309$:
	ldhl	sp,	#37
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00313$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	jr	00314$
00313$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
00314$:
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00310$:
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
	jp	00289$
00131$:
;src/player.c:112: p->world_y.w += p->vel_y.w;
	ldhl	sp,#31
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
	ldhl	sp,	#37
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#39
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:113: uint8_t ny = p->world_y.b.h;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl), a
;src/player.c:114: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:116: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#24
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
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00315$
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00316$
00315$:
	ldhl	sp,	#35
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00316$:
;src/player.c:120: if (p->mode == MODE_SHIP) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00136$
;src/player.c:121: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE) : ny;
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00317$
	inc	hl
	ld	a, (hl+)
	ld	d, (hl)
	jr	00318$
00317$:
	ldhl	sp,	#25
	ld	a, (hl)
	ld	d, #0x00
00318$:
	ldhl	sp,	#27
	ld	(hl+), a
	ld	(hl), d
	jr	00137$
00136$:
;src/player.c:123: check_y_head = (p->gravity_flipped) ? (ny + PLAYER_SIZE - PLAYER_HBOX) : (ny + PLAYER_HBOX);
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00319$
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl), a
	jr	00320$
00319$:
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl), a
00320$:
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
00137$:
;src/player.c:126: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#37
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x02
	ldhl	sp,	#22
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00321$
	ld	a, #0x07
	jr	00322$
00321$:
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00325$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00326$
00325$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
00326$:
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00322$:
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:127: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#22
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00327$
	ld	a, #0x07
	jr	00328$
00327$:
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00331$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	jr	00332$
00331$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
00332$:
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00328$:
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:129: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#37
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:129: uint8_t falling = (p->gravity_flipped) ? (p->vel_y.w <= 0) : (p->vel_y.w >= 0);
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00333$
	ldhl	sp,	#37
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01637$
	bit	7, d
	jr	NZ, 01638$
	cp	a, a
	jr	01638$
01637$:
	bit	7, d
	jr	Z, 01638$
	scf
01638$:
	ld	a, #0x00
	rla
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (hl)
	xor	a, #0x01
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	jr	00334$
00333$:
	ldhl	sp,	#38
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
	ldhl	sp,	#34
	ld	(hl), a
00334$:
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#24
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#37
	ld	(hl), a
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:138: p->world_y.b.l = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
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
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00176$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00176$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00176$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00176$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00176$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00176$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00176$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00177$
00176$:
;src/player.c:132: if (p->gravity_flipped) {
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00139$
;src/player.c:133: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:135: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00139$:
;src/player.c:137: p->world_y.b.h = py;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	ld	(de), a
;src/player.c:138: p->world_y.b.l = 0;
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:139: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:140: p->on_ground = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00178$
00177$:
;src/player.c:143: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	xor	a, a
	ld	(hl+), a
	ld	(hl), b
	or	a, b
	jr	Z, 00335$
	ld	a, #0x07
	jr	00336$
00335$:
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00339$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00340$
00339$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00340$:
	push	bc
	call	_col_at_raw_cached
	pop	bc
00336$:
	ldhl	sp,	#34
;src/player.c:144: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00341$
	ld	c, #0x07
	jr	00342$
00341$:
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00345$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00346$
00345$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00346$:
	call	_col_at_raw_cached
	ld	c, a
00342$:
;src/player.c:146: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00166$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00166$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00166$
	ldhl	sp,	#34
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
	jp	00289$
00145$:
;src/player.c:154: if (p->gravity_flipped) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
;src/player.c:155: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00143$
;src/player.c:157: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(hl), a
00143$:
;src/player.c:159: p->world_y.b.h = py;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	ld	(de), a
;src/player.c:160: p->world_y.b.l = 0;
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:161: p->vel_y.w = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00178$
00167$:
;src/player.c:164: py = ny;
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:167: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00347$
	ldhl	sp,#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	jr	00348$
00347$:
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
00348$:
;src/player.c:168: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#33
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
	jr	Z, 00349$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00351$
	xor	a, a
	jr	00350$
00351$:
	ld	a, #0x07
	jr	00350$
00349$:
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00353$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00354$
00353$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00354$:
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00350$:
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:169: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00355$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00357$
	xor	a, a
	jr	00356$
00357$:
	ld	a, #0x07
	jr	00356$
00355$:
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00359$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	jr	00360$
00359$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
00360$:
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00356$:
	ld	c, a
;src/player.c:171: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00157$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00157$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00157$
	ldhl	sp,	#32
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
	ldhl	sp,	#10
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
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00178$
00155$:
;src/player.c:174: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
;src/player.c:55: p->vel_y.w += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:174: else if (p->gravity_flipped) { if (p->vel_y.w < 0) p->vel_y.w = 0; }
	ld	a, b
	or	a, a
	jr	Z, 00152$
	bit	7, l
	jr	Z, 00178$
	ldhl	sp,	#6
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
	cp	a, c
	sbc	a, l
	bit	7, e
	jr	Z, 01666$
	bit	7, d
	jr	NZ, 01667$
	cp	a, a
	jr	01667$
01666$:
	bit	7, d
	jr	Z, 01667$
	scf
01667$:
	jr	NC, 00178$
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00178$:
;src/player.c:180: const uint8_t* c_front = GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00361$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	c, (hl)
	jr	00362$
00361$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, (hl)
00362$:
	ldhl	sp,	#32
	ld	(hl+), a
	ld	(hl), c
;src/player.c:181: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#36
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#34
	ld	(hl), #0x00
	ldhl	sp,	#37
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00363$
	ld	a, #0x07
	jr	00364$
00363$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00364$:
	ldhl	sp,	#25
;src/player.c:182: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#26
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
	jr	Z, 00367$
	ld	c, #0x07
	jr	00368$
00367$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,#33
	ld	(hl), a
	ld	c, (hl)
00368$:
	ldhl	sp,	#30
	ld	(hl), c
;src/player.c:184: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#22
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00371$
	ld	a, #0x07
	jr	00372$
00371$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00375$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00376$
00375$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00376$:
	call	_col_at_raw_cached
00372$:
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:185: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#22
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#33
	ld	(hl+), a
	ld	a, (hl+)
	or	a, (hl)
	jr	Z, 00377$
	ld	c, #0x07
	jr	00378$
00377$:
	ldhl	sp,	#36
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00381$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	jr	00382$
00381$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
00382$:
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00378$:
	ldhl	sp,	#37
	ld	(hl), c
;src/player.c:186: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00383$
	ld	a, #0x07
	jr	00384$
00383$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00387$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	d, (hl)
	jr	00388$
00387$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	d, (hl)
00388$:
	ld	c, b
	ld	b, e
	ld	e, a
	call	_col_at_raw_cached
00384$:
	ldhl	sp,	#36
	ld	(hl), a
;src/player.c:187: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#29
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00389$
	ldhl	sp,	#35
	ld	(hl), #0x07
	jr	00390$
00389$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00393$
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	jr	00394$
00393$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
00394$:
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#35
	ld	(hl), a
00390$:
;src/player.c:189: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00187$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00187$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00187$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00187$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00187$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00187$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00187$
	ldhl	sp,	#30
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
	jp	00289$
00188$:
;src/player.c:195: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00196$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	dec	a
	jr	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00196$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	dec	a
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00196$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	dec	a
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00196$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00395$
00196$:
;src/player.c:196: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:197: col_at_end();
	call	_col_at_end
;src/player.c:198: return 1;
	ld	a, #0x01
	jp	00289$
;src/player.c:201: uint8_t tl = COL_AT_PTR(c0, py);
00395$:
	ldhl	sp,	#38
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#38
	ld	(hl), a
	pop	bc
;src/player.c:202: const uint8_t* c_right = GET_COL_FAST(PLAYER_SIZE - 1);
	ld	a, #0x0e
	ldhl	sp,	#22
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#37
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00399$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00400$
00399$:
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00400$:
	ldhl	sp,	#31
	ld	(hl), e
	inc	hl
;src/player.c:203: uint8_t tr = COL_AT_PTR(c_right, py);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:204: uint8_t bl = COL_AT_PTR(c0, py + PLAYER_SIZE - 1);
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
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
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00405$
	ld	c, #0x07
	jr	00406$
00405$:
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
00406$:
	ldhl	sp,	#25
	ld	(hl), c
;src/player.c:205: uint8_t br = COL_AT_PTR(c_right, py + PLAYER_SIZE - 1);
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00409$
	ld	c, #0x07
	jr	00410$
00409$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,#32
	ld	(hl), a
	ld	c, (hl)
00410$:
	ldhl	sp,	#26
	ld	(hl), c
;src/player.c:207: uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00413$
	ldhl	sp,	#36
	ld	a, (hl)
	jr	00414$
00413$:
	ldhl	sp,	#25
	ld	a, (hl)
00414$:
	ldhl	sp,	#28
;src/player.c:208: uint8_t pad_r = (p->gravity_flipped) ? tr : br;
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00415$
	ldhl	sp,	#33
	ld	a, (hl)
	jr	00416$
00415$:
	ldhl	sp,	#26
	ld	a, (hl)
00416$:
	ldhl	sp,	#29
;src/player.c:210: if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01707$
	xor	a, a
01707$:
	ldhl	sp,	#30
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01709$
	xor	a, a
01709$:
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	sub	a, #0x0f
	ld	a, #0x01
	jr	Z, 01711$
	xor	a, a
01711$:
	ldhl	sp,	#32
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00272$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00272$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00272$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x0b
	jr	Z, 00272$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00272$
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x0f
	jp	NZ, 00273$
00272$:
;src/player.c:88: uint8_t py = p->world_y.b.h;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:213: int16_t hy = (p->gravity_flipped) ? (int16_t)(p->world_y.b.h) : (int16_t)(p->world_y.b.h) + PLAYER_SIZE - 1;
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00417$
	ldhl	sp,	#37
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00418$
00417$:
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl), a
00418$:
	ldhl	sp,	#35
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/player.c:215: if (IS_PAD(pad_l)) { hit = pad_l; hx = px; }
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	NZ, 00225$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00225$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00226$
00225$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	jr	00227$
00226$:
;src/player.c:216: else { hit = pad_r; hx = px + PLAYER_SIZE - 1; }
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#34
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#33
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00227$:
;src/player.c:218: uint8_t pmx = (hx >> 4);
	ldhl	sp,#34
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
	ld	(hl), c
;src/player.c:219: uint8_t pmy = ((uint16_t)hy >> 4);
	ldhl	sp,	#38
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
	ld	a, (hl+)
	ld	(hl), a
;src/player.c:221: if (!player_tile_activated(p, pmx, pmy)) {
	ldhl	sp,	#35
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#38
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#35
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	or	a, a
	jp	NZ, 00274$
;src/player.c:222: player_mark_activated(p, pmx, pmy);
	ldhl	sp,	#38
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#35
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:223: if (hit == COL_PAD_BLUE) {
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00234$
;src/player.c:224: p->gravity_flipped = !p->gravity_flipped;
	ld	a, c
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	c, a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/player.c:225: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ld	a, c
	or	a, a
	jr	Z, 00419$
	ld	bc, #0xfc60
	jr	00420$
00419$:
	ld	bc, #0x03a0
00420$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00235$
00234$:
;src/player.c:226: } else if (hit == COL_PAD_MAGENTA) {
	ldhl	sp,	#36
	ld	a, (hl)
;src/player.c:227: p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
	sub	a, #0x0f
	jr	NZ, 00231$
	or	a, c
	jr	Z, 00421$
	ld	bc, #0x04e8
	jr	00422$
00421$:
	ld	bc, #0xfb18
00422$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00235$
00231$:
;src/player.c:229: p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ld	a, c
	or	a, a
	jr	Z, 00423$
	ld	bc, #0x07c0
	jr	00424$
00423$:
	ld	bc, #0xf840
00424$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00235$:
;src/player.c:231: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00274$
00273$:
;src/player.c:233: } else if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jp	Z, 00274$
;src/player.c:238: omx = mx0; omy = py >> 4;
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	swap	a
	and	a, #0x0f
;src/player.c:237: if (IS_ORB(tl)) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00240$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00240$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00241$
00240$:
;src/player.c:238: omx = mx0; omy = py >> 4;
	ldhl	sp,	#32
	ld	c, (hl)
	ldhl	sp,	#38
;src/player.c:239: if (!player_tile_activated(p, omx, omy)) {
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	b, #0x00
	push	bc
	push	de
	ld	a, e
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00241$
;src/player.c:240: player_mark_activated(p, omx, omy);
	ld	a, e
	push	af
	inc	sp
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:241: hit = tl; goto orb_hit;
	ldhl	sp,	#36
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	jp	00262$
00241$:
;src/player.c:245: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = py >> 4;
	ldhl	sp,	#32
	ld	a, (hl)
	inc	a
	ldhl	sp,	#28
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
;src/player.c:244: if (IS_ORB(tr)) {
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00246$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00246$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00247$
00246$:
;src/player.c:245: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = py >> 4;
	ldhl	sp,	#37
	ld	a, (hl)
	or	a, a
	jr	Z, 00425$
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	jr	00426$
00425$:
	ldhl	sp,	#28
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00426$:
	ldhl	sp,	#30
	ld	c, (hl)
	ldhl	sp,	#38
;src/player.c:246: if (!player_tile_activated(p, omx, omy)) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	b, #0x00
	push	bc
	push	de
	push	de
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00247$
;src/player.c:247: player_mark_activated(p, omx, omy);
	push	de
	inc	sp
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:248: hit = tr; goto orb_hit;
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	jp	00262$
00247$:
;src/player.c:252: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	e, a
	ld	c, (hl)
	sra	c
	rr	e
	sra	c
	rr	e
	sra	c
	rr	e
	sra	c
	rr	e
;src/player.c:251: if (IS_ORB(bl)) {
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00252$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00252$
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00253$
00252$:
;src/player.c:252: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#32
	ld	c, (hl)
	ld	d, e
;src/player.c:253: if (!player_tile_activated(p, omx, omy)) {
	ld	b, #0x00
	push	bc
	push	de
	push	de
	inc	sp
	ldhl	sp,	#45
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00253$
;src/player.c:254: player_mark_activated(p, omx, omy);
	push	de
	inc	sp
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:255: hit = bl; goto orb_hit;
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	jr	00262$
00253$:
;src/player.c:258: if (IS_ORB(br)) {
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00258$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00258$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ, 00274$
00258$:
;src/player.c:259: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#37
	ld	a, (hl)
	or	a, a
	jr	Z, 00427$
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	jr	00428$
00427$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
00428$:
	ld	d, e
;src/player.c:260: if (!player_tile_activated(p, omx, omy)) {
	ld	b, #0x00
	push	bc
	push	de
	push	de
	inc	sp
	ldhl	sp,	#45
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jp	NZ, 00274$
;src/player.c:261: player_mark_activated(p, omx, omy);
	push	de
	inc	sp
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:262: hit = br; goto orb_hit;
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:267: orb_hit:
00262$:
;src/player.c:59: if (p->vel_y.w > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#37
;src/player.c:268: if (hit == COL_ORB_MAGENTA) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00267$
;src/player.c:269: p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,	#37
	ld	a, (hl)
	or	a, a
	jr	Z, 00429$
	ld	a, #0xd0
	ld	(hl+), a
	ld	(hl), #0x03
	jr	00430$
00429$:
	ldhl	sp,	#37
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0xfc
00430$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00268$
00267$:
;src/player.c:270: } else if (hit == COL_ORB_BLUE) {
	ldhl	sp,	#38
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ, 00264$
;src/player.c:271: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:272: p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
	or	a, a
	jr	Z, 00431$
	ld	bc, #0xfe60
	jr	00432$
00431$:
	ld	bc, #0x01a0
00432$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00268$
00264$:
;src/player.c:274: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 144 : JUMP_FORCE - 144;
	ldhl	sp,	#37
	ld	a, (hl)
	or	a, a
	jr	Z, 00433$
	ld	a, #0xa0
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00434$
00433$:
	ldhl	sp,	#37
	ld	(hl), #0x60
	inc	hl
	ld	(hl), #0xfa
00434$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00268$:
;src/player.c:276: p->on_ground = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:278: orb_done:;
00274$:
;src/player.c:280: col_at_end();
	call	_col_at_end
;src/player.c:282: if (p->on_ground) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#38
	ld	(hl), a
;src/player.c:283: p->anim_timer = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:284: p->anim_frame = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
;src/player.c:282: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00285$
;src/player.c:283: p->anim_timer = 0;
;src/player.c:284: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00286$
00285$:
;src/player.c:286: p->anim_timer += 10;
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
;src/player.c:287: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00286$
;src/player.c:288: p->anim_timer -= 20;
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
;src/player.c:289: p->anim_frame++;
	ldhl	sp,#36
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
;src/player.c:290: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00286$
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00286$:
;src/player.c:294: if (p->world_y.b.h > (map_h << 4)) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#48
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
	jr	NC, 00288$
;src/player.c:295: p->dead = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/player.c:296: return 1;
	ld	a, #0x01
	jr	00289$
00288$:
;src/player.c:299: p->last_joy = joy;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#39
	ld	a, (hl)
	ld	(bc), a
;src/player.c:300: return 0;
	xor	a, a
00289$:
;src/player.c:301: }
	add	sp, #42
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
