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
	add	sp, #-49
	ldhl	sp,	#46
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
	ldhl	sp,	#48
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00280$
00102$:
;src/player.c:51: col_at_begin(map_bank);
	ldhl	sp,	#57
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:54: if (p->mode == MODE_SHIP) {
	ldhl	sp,#46
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
	ld	c, a
;src/player.c:55: if (joy & J_A) {
	ldhl	sp,	#45
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:56: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#46
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
	ld	(hl), a
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:54: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:60: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
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
;src/player.c:56: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:55: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:56: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00282$
	ld	hl, #0x0004
	jr	00283$
00282$:
	ld	hl, #0xfffc
00283$:
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
	jr	00105$
00104$:
;src/player.c:58: p->vel_y += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00284$
	ld	hl, #0xfffd
	jr	00285$
00284$:
	ld	hl, #0x0003
00285$:
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
00105$:
;src/player.c:60: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#10
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
	ld	a, #0x3c
	cp	a, c
	ld	a, #0x00
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
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x3c
	ld	(hl+), a
	ld	(hl), #0x00
00107$:
;src/player.c:61: if (p->vel_y < -SHIP_MAX_VEL) p->vel_y = -SHIP_MAX_VEL;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0xc4
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jp	NC, 00121$
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, #0xc4
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00121$
00120$:
;src/player.c:64: if (!p->on_ground) {
	ldhl	sp,#14
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
;src/player.c:60: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
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
;src/player.c:56: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:65: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00115$
;src/player.c:66: p->vel_y -= GRAVITY;
	ld	bc, #0xfff9
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:67: if (p->vel_y < -MAX_FALL_SPEED) p->vel_y = -MAX_FALL_SPEED;
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00121$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xa0
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00121$
00115$:
;src/player.c:69: p->vel_y += GRAVITY;
	ld	bc, #0x0007
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
;src/player.c:70: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x60
	cp	a, c
	ld	a, #0x00
	sbc	a, b
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
	jr	NC, 00121$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x60
	ld	(hl+), a
	ld	(hl), #0x00
00121$:
;src/player.c:78: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src/player.c:76: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jp	Z, 00125$
;src/player.c:77: if (joy & J_A) p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#48
	ld	(hl), a
	or	a, a
	jr	Z, 00286$
	ld	(hl), #0x4d
	jr	00287$
00286$:
	ldhl	sp,	#48
	ld	(hl), #0xb3
00287$:
	ldhl	sp,	#48
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/player.c:78: p->world_y += (int8_t)(p->vel_y >> 4);
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#41
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#43
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#41
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#40
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:79: col_at_end();
	call	_col_at_end
;src/player.c:80: return 0;
	xor	a, a
	jp	00280$
00125$:
;src/player.c:84: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00127$
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00127$
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00127$
;src/player.c:85: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	ld	a, #0x4d
	jr	NZ, 00289$
	ld	a, #0xb3
00289$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:86: p->on_ground = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:90: uint16_t px = p->world_x;
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/player.c:91: uint16_t py = p->world_y;
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#43
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:92: uint16_t mx0 = px >> 4;
	ldhl	sp,	#18
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
;src/player.c:93: const uint8_t *c0 = &map[mx0 << 4];
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
	ldhl	sp,	#51
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#24
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#23
	ld	(hl), a
;src/player.c:94: const uint8_t *c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#53
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00290$
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#43
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#42
	ld	(hl), a
	jr	00291$
00290$:
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
00291$:
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
;src/player.c:96: uint8_t x_mod_16 = (uint8_t)px & 0x0F;
	ldhl	sp,	#18
	ld	a, (hl)
	and	a, #0x0f
;src/player.c:97: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#30
	ld	(hl), a
;src/player.c:108: uint8_t front_mid = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#45
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#44
	ld	(hl), a
	ld	a, #0x0f
	ldhl	sp,	#30
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00292$
	ldhl	sp,	#44
	bit	7, (hl)
	jr	Z, 00294$
	xor	a, a
	jr	00293$
00294$:
	ld	a, #0x07
	jr	00293$
00292$:
	ldhl	sp,	#43
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00297$
00296$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00297$:
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00293$:
;src/player.c:110: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00130$
	cp	a, #0x09
	jr	Z, 00130$
	cp	a, #0x05
	jr	Z, 00130$
	sub	a, #0x06
	jr	NZ, 00131$
00130$:
;src/player.c:111: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:112: col_at_end();
	call	_col_at_end
;src/player.c:113: return 1;
	ld	a, #0x01
	jp	00280$
00131$:
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:60: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#37
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00298$
	ld	de, #0x0000
	ldhl	sp,	#37
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#44
	ld	(hl-), a
	ld	(hl), e
	jr	00299$
00298$:
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00299$:
;src/player.c:118: int8_t pixels = (int8_t)(effective_vel >> 4);
	ldhl	sp,	#44
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
;src/player.c:119: if (p->gravity_flipped) pixels = -pixels;
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
	xor	a, a
	ldhl	sp,	#48
	sub	a, (hl)
	ld	(hl), a
00136$:
;src/player.c:120: int16_t ny = py + pixels;
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#39
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#45
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#44
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:121: p->on_ground = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:124: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#32
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
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00300$
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00301$
00300$:
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00301$:
;src/player.c:125: int16_t check_y_head = (p->gravity_flipped) ? ny + PLAYER_SIZE : ny;
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00302$
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	jr	00303$
00302$:
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
00303$:
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
;src/player.c:128: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x02
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00304$
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00306$
	xor	a, a
	jr	00305$
00306$:
	ld	a, #0x07
	jr	00305$
00304$:
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	jr	00309$
00308$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
00309$:
	pop	bc
	push	bc
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00305$:
	ldhl	sp,	#41
	ld	(hl), a
;src/player.c:129: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00310$
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00312$
	xor	a, a
	jr	00311$
00312$:
	ld	a, #0x07
	jr	00311$
00310$:
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00314$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00315$
00314$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00315$:
	pop	bc
	push	bc
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00311$:
	ldhl	sp,	#43
	ld	(hl), a
;src/player.c:131: uint8_t falling = (p->gravity_flipped) ? (pixels <= 0) : (pixels >= 0);
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl), a
	or	a, a
	jr	Z, 00316$
	ldhl	sp,	#48
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01633$
	bit	7, d
	jr	NZ, 01634$
	cp	a, a
	jr	01634$
01633$:
	bit	7, d
	jr	Z, 01634$
	scf
01634$:
	ld	a, #0x00
	rla
	ldhl	sp,	#48
	ld	(hl), a
	xor	a, #0x01
	ld	(hl), a
	jr	00317$
00316$:
	ldhl	sp,	#48
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
	ld	(hl), a
00317$:
;src/player.c:135: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	inc	de
;src/player.c:137: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#36
	ld	a, (hl+)
	and	a, #0xf0
	ld	c, a
	ld	b, (hl)
;src/player.c:135: py = ((ny >> 4) + 1) << 4;
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
;src/player.c:137: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ld	a, c
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/player.c:135: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:137: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#36
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:133: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00173$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00172$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00172$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00172$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00172$
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
	jr	NZ, 00173$
00172$:
;src/player.c:134: if (p->gravity_flipped) {
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
;src/player.c:135: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00139$
00138$:
;src/player.c:137: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00139$:
;src/player.c:139: p->vel_y = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:140: p->on_ground = 1;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00174$
00173$:
;src/player.c:143: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#43
	ld	(hl), #0x00
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	a, (hl+)
	inc	hl
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00318$
	dec	hl
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00320$
	xor	a, a
	jr	00319$
00320$:
	ld	a, #0x07
	jr	00319$
00318$:
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00322$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00323$
00322$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00323$:
	pop	bc
	push	bc
	call	_col_at_raw_cached
00319$:
	ldhl	sp,	#48
	ld	(hl), a
;src/player.c:144: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ldhl	sp,	#44
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00324$
	dec	hl
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00326$
	xor	a, a
	jr	00327$
00326$:
	ld	a, #0x07
00327$:
	ldhl	sp,	#44
	ld	(hl), a
	jr	00325$
00324$:
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00328$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00329$
00328$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00329$:
	pop	bc
	push	bc
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#44
	ld	(hl), a
00325$:
	ldhl	sp,	#44
	ld	c, (hl)
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src/player.c:145: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00162$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00162$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00162$
	ldhl	sp,	#48
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
;src/player.c:146: if (p->gravity_flipped) {
	ld	a, b
	or	a, a
	jr	Z, 00141$
;src/player.c:147: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00142$
00141$:
;src/player.c:149: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00142$:
;src/player.c:151: p->vel_y = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00174$
00163$:
;src/player.c:153: py = ny;
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
;src/player.c:156: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ld	a, b
	or	a, a
	jr	Z, 00330$
	ldhl	sp,#34
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	jr	00331$
00330$:
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
00331$:
;src/player.c:157: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#36
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, b
	rlca
	and	a,#0x01
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00332$
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00334$
	xor	a, a
	jr	00333$
00334$:
	ld	a, #0x07
	jr	00333$
00332$:
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00336$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00337$
00336$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00337$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00333$:
	ldhl	sp,	#41
;src/player.c:158: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00338$
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00340$
	ld	(hl), #0x00
	jr	00339$
00340$:
	ldhl	sp,	#48
	ld	(hl), #0x07
	jr	00339$
00338$:
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	Z, 00342$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	jr	00343$
00342$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
00343$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#48
	ld	(hl), a
00339$:
	ldhl	sp,	#48
	ld	c, (hl)
;src/player.c:159: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00153$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00153$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00153$
	ldhl	sp,	#41
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
;src/player.c:160: p->on_ground = 1;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:162: if (p->mode == MODE_CUBE) p->vel_y = 0;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00151$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00151$:
;src/player.c:163: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#48
	ld	(hl), a
;src/player.c:60: if (p->vel_y > SHIP_MAX_VEL) p->vel_y = SHIP_MAX_VEL;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#41
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:56: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
;src/player.c:163: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00148$
	ldhl	sp,	#42
	bit	7, (hl)
	jr	Z, 00174$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00174$
00148$:
;src/player.c:164: else { if (p->vel_y > 0) p->vel_y = 0; }
	ldhl	sp,	#41
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01663$
	bit	7, d
	jr	NZ, 01664$
	cp	a, a
	jr	01664$
01663$:
	bit	7, d
	jr	Z, 01664$
	scf
01664$:
	jr	NC, 00174$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00174$:
;src/player.c:168: p->world_y = py;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:171: const uint8_t *c_front = GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00344$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	jr	00345$
00344$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
00345$:
	ldhl	sp,	#41
	ld	(hl), c
	inc	hl
;src/player.c:172: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), #0x00
	inc	hl
	ld	(hl), a
	ld	b, a
	ldhl	sp,	#31
	ld	(hl), e
	inc	hl
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00346$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00348$
	xor	a, a
	jr	00347$
00348$:
	ld	a, #0x07
	jr	00347$
00346$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00347$:
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:173: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), #0x00
	inc	hl
	ld	(hl+), a
	ld	b, a
	ld	(hl), e
	inc	hl
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00350$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00352$
	xor	a, a
	jr	00351$
00352$:
	ld	a, #0x07
	jr	00351$
00350$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00351$:
	ldhl	sp,	#40
	ld	(hl), a
;src/player.c:176: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00354$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00356$
	xor	a, a
	jr	00355$
00356$:
	ld	a, #0x07
	jr	00355$
00354$:
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00358$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jr	00359$
00358$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00359$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_col_at_raw_cached
00355$:
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:177: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00360$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00362$
	ld	(hl), #0x00
	jr	00363$
00362$:
	ldhl	sp,	#33
	ld	(hl), #0x07
00363$:
	ldhl	sp,	#33
	ld	a, (hl)
	jr	00361$
00360$:
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00364$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	jr	00365$
00364$:
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
00365$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00361$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:178: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00366$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00368$
	xor	a, a
	jr	00367$
00368$:
	ld	a, #0x07
	jr	00367$
00366$:
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00370$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00371$
00370$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00371$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00367$:
	ldhl	sp,	#41
	ld	(hl), a
;src/player.c:179: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00372$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00374$
	xor	a, a
	jr	00375$
00374$:
	ld	a, #0x07
00375$:
	ldhl	sp,	#48
	ld	(hl), a
	jr	00373$
00372$:
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00376$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00377$
00376$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00377$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#48
	ld	(hl), a
00373$:
;src/player.c:182: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00183$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00183$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00183$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00183$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00183$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00183$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00183$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00184$
00183$:
;src/player.c:183: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:184: col_at_end();
	call	_col_at_end
;src/player.c:185: return 1;
	ld	a, #0x01
	jp	00280$
00184$:
;src/player.c:187: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	dec	a
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00192$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	dec	a
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00192$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	dec	a
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00192$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	dec	a
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00192$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00193$
00192$:
;src/player.c:188: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:189: col_at_end();
	call	_col_at_end
;src/player.c:190: return 1;
	ld	a, #0x01
	jp	00280$
00193$:
;src/player.c:195: uint8_t tl = COL_AT_PTR(c0, py);
	ldhl	sp,	#39
	ld	(hl), #0x00
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#41
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00378$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00380$
	xor	a, a
	jr	00379$
00380$:
	ld	a, #0x07
	jr	00379$
00378$:
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00379$:
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:196: const uint8_t *c_right = GET_COL_FAST(PLAYER_SIZE - 1);
	ld	a, #0x0e
	ldhl	sp,	#30
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#48
	ld	(hl), a
	or	a, a
	jr	Z, 00382$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00383$
00382$:
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00383$:
	ldhl	sp,	#30
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/player.c:197: uint8_t tr = COL_AT_PTR(c_right, py);
	ldhl	sp,	#40
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00384$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00386$
	xor	a, a
	jr	00385$
00386$:
	ld	a, #0x07
	jr	00385$
00384$:
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,#41
	ld	(hl), a
00385$:
	ldhl	sp,	#39
	ld	(hl), a
;src/player.c:198: uint8_t bl = COL_AT_PTR(c0, py + PLAYER_SIZE - 1);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#42
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#34
	ld	(hl), #0x00
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00388$
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00390$
	ldhl	sp,	#33
	ld	(hl), #0x00
	jr	00391$
00390$:
	ldhl	sp,	#33
	ld	(hl), #0x07
00391$:
	ldhl	sp,	#33
	ld	d, (hl)
	jr	00389$
00388$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	d, a
00389$:
	ldhl	sp,	#32
	ld	(hl), d
;src/player.c:199: uint8_t br = COL_AT_PTR(c_right, py + PLAYER_SIZE - 1);
	ldhl	sp,	#35
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00392$
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00394$
	ld	(hl), #0x00
	jr	00393$
00394$:
	ldhl	sp,	#38
	ld	(hl), #0x07
	jr	00393$
00392$:
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#38
	ld	(hl), a
00393$:
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:201: uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl), a
	or	a, a
	jr	Z, 00396$
	ldhl	sp,	#42
	ld	a, (hl)
	jr	00397$
00396$:
	ldhl	sp,	#32
	ld	a, (hl)
00397$:
	ldhl	sp,	#35
;src/player.c:202: uint8_t pad_r = (p->gravity_flipped) ? tr : br;
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00398$
	ldhl	sp,	#39
	ld	a, (hl)
	jr	00399$
00398$:
	ldhl	sp,	#33
	ld	a, (hl)
00399$:
	ldhl	sp,	#36
;src/player.c:205: if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01704$
	xor	a, a
01704$:
	ldhl	sp,	#37
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01706$
	xor	a, a
01706$:
	ldhl	sp,	#38
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00264$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00264$
	dec	hl
	dec	hl
	ld	a, (hl)
	sub	a, #0x0b
	jr	Z, 00264$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x0e
	jp	NZ, 00265$
00264$:
;src/player.c:208: int16_t hy = (p->gravity_flipped) ? py : (py + PLAYER_SIZE - 1);
	ldhl	sp,	#34
	ld	a, (hl)
	or	a, a
	jr	Z, 00400$
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00401$
00400$:
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00401$:
;src/player.c:209: if (IS_PAD(pad_l)) { hit = pad_l; hx = px; }
	ldhl	sp,	#37
	ld	a, (hl)
	or	a, a
	jr	NZ, 00221$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00222$
00221$:
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00223$
00222$:
;src/player.c:210: else               { hit = pad_r; hx = px + PLAYER_SIZE - 1; }
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	b, (hl)
	add	a, #0x0e
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ldhl	sp,	#43
	ld	(hl), c
	inc	hl
	ld	(hl), a
00223$:
;src/player.c:212: uint16_t pmx = (hx >> 4);
	ldhl	sp,#43
	ld	a, (hl+)
	ld	c, a
;src/player.c:213: uint16_t pmy = ((uint16_t)hy >> 4);
;src/player.c:215: if (!player_tile_activated(p, pmx, pmy)) {
	ld	a, (hl+)
	inc	hl
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	push	bc
	push	de
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jp	NZ, 00266$
;src/player.c:216: player_mark_activated(p, pmx, pmy);
	push	de
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:217: if (hit == COL_PAD_BLUE) {
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00226$
;src/player.c:218: p->gravity_flipped = !p->gravity_flipped;
	ld	a, c
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:219: p->vel_y = (p->gravity_flipped) ? -64 : 64;
	or	a, a
	ld	a, #0xc0
	jr	NZ, 00403$
	ld	a, #0x40
00403$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00227$
00226$:
;src/player.c:221: p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ld	a, c
	or	a, a
	ld	a, #0x7d
	jr	NZ, 00405$
	ld	a, #0x83
00405$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00227$:
;src/player.c:223: p->on_ground = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00266$
00265$:
;src/player.c:227: else if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#8
	or	a, (hl)
	jp	Z, 00266$
;src/player.c:234: omx = mx0; omy = py >> 4;
	ldhl	sp,#43
	ld	a, (hl+)
	ld	e, a
;src/player.c:233: if (IS_ORB(tl)) {
	ld	a, (hl-)
	dec	hl
	ld	d, a
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00232$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00232$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00233$
00232$:
;src/player.c:234: omx = mx0; omy = py >> 4;
	ld	l, e
	ld	h, d
;src/player.c:235: if (!player_tile_activated(p, omx, omy)) {
	push	hl
	push	de
	push	hl
	push	hl
	ldhl	sp,	#28
	ld	c, (hl)
	ldhl	sp,	#29
	ld	b, (hl)
	ldhl	sp,	#54
	ld	e, (hl)
	ldhl	sp,	#55
	ld	d, (hl)
	pop	hl
	call	_player_tile_activated
	pop	de
	pop	hl
	or	a, a
	jr	NZ, 00233$
;src/player.c:236: player_mark_activated(p, omx, omy);
	push	hl
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:237: hit = tl; goto orb_hit;
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	jp	00254$
00233$:
;src/player.c:241: if (IS_ORB(tr)) {
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00238$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00238$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00239$
00238$:
;src/player.c:242: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = py >> 4;
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00406$
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	jr	00407$
00406$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
00407$:
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
;src/player.c:243: if (!player_tile_activated(p, omx, omy)) {
	ld	a, (hl+)
	inc	hl
	ld	b, a
	push	bc
	push	de
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00239$
;src/player.c:244: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:245: hit = tr; goto orb_hit;
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	jp	00254$
00239$:
;src/player.c:250: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:249: if (IS_ORB(bl)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00244$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00244$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00245$
00244$:
;src/player.c:250: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/player.c:251: if (!player_tile_activated(p, omx, omy)) {
	push	de
	push	de
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#50
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	or	a, a
	jr	NZ, 00245$
;src/player.c:252: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:253: hit = bl; goto orb_hit;
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	jr	00254$
00245$:
;src/player.c:257: if (IS_ORB(br)) {
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00250$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00250$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ, 00266$
00250$:
;src/player.c:258: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00408$
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	jr	00409$
00408$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
00409$:
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/player.c:259: if (!player_tile_activated(p, omx, omy)) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	push	bc
	push	de
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	pop	bc
	or	a, a
	jp	NZ, 00266$
;src/player.c:260: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:261: hit = br; goto orb_hit;
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
;src/player.c:266: orb_hit:
00254$:
;src/player.c:117: int16_t effective_vel = p->gravity_flipped ? -p->vel_y : p->vel_y;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl), a
;src/player.c:267: if (hit == COL_ORB_MAGENTA) {
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00259$
;src/player.c:268: p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00410$
	ldhl	sp,	#48
	ld	(hl), #0x3c
	jr	00411$
00410$:
	ldhl	sp,	#48
	ld	(hl), #0xc4
00411$:
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00260$
00259$:
;src/player.c:269: } else if (hit == COL_ORB_BLUE) {
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ, 00256$
;src/player.c:270: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:271: p->vel_y = (p->gravity_flipped) ? -64 : 64;
	or	a, a
	ld	a, #0xc0
	jr	NZ, 00413$
	ld	a, #0x40
00413$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00260$
00256$:
;src/player.c:273: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE+9 : JUMP_FORCE-9;
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	ld	a, #0x56
	jr	NZ, 00415$
	ld	a, #0xaa
00415$:
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00260$:
;src/player.c:275: p->on_ground = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:277: orb_done: ;
00266$:
;src/player.c:283: col_at_end();
	call	_col_at_end
;src/player.c:286: if (p->on_ground) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#48
;src/player.c:287: p->anim_timer = 0;
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:288: p->anim_frame = 0;
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#45
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#44
	ld	(hl), a
;src/player.c:286: if (p->on_ground) {
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00275$
;src/player.c:287: p->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/player.c:288: p->anim_frame = 0;
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00276$
00275$:
;src/player.c:290: p->anim_timer += 10;
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
;src/player.c:291: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00276$
;src/player.c:292: p->anim_timer -= 20;
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
;src/player.c:293: p->anim_frame++;
	ldhl	sp,#43
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
;src/player.c:294: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00276$
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00276$:
;src/player.c:299: if (p->world_y > (int16_t)((uint16_t)map_h << 4) || p->world_y < -32) {
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#55
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
	jr	Z, 01733$
	bit	7, d
	jr	NZ, 01734$
	cp	a, a
	jr	01734$
01733$:
	bit	7, d
	jr	Z, 01734$
	scf
01734$:
	jr	C, 00277$
	ld	a, c
	sub	a, #0xe0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00278$
00277$:
;src/player.c:300: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;src/player.c:301: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00280$
00278$:
;src/player.c:304: p->last_joy = joy;
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#45
	ld	a, (hl)
	ld	(bc), a
;src/player.c:305: return 0;
	xor	a, a
00280$:
;src/player.c:306: }
	add	sp, #49
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
