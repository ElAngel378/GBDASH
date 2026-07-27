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
;src/player.c:7: p->world_y = (uint16_t)start_y << 8;
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
;src/player.c:17: p->portal_idx = 0;
	ld	hl, #0x000f
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:18: p->activated_count = 0;
	ld	hl, #0x0031
	add	hl, de
	ld	(hl), #0x00
;src/player.c:19: p->next_activated_slot = 0;
	ld	hl, #0x0032
	add	hl, de
	ld	(hl), #0x00
;src/player.c:20: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:22: uint8_t player_tile_activated(const Player* p, uint16_t mx, uint16_t my) {
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
	ld	hl, #0x0031
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
	pop	bc
	jp	(hl)
;src/player.c:29: void player_mark_activated(Player* p, uint16_t mx, uint16_t my) {
;	---------------------------------
; Function player_mark_activated
; ---------------------------------
_player_mark_activated::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;src/player.c:30: p->activated[p->next_activated_slot].mx = mx;
	ld	a, d
	ld	(hl-), a
	inc	sp
	inc	sp
	push	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0032
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
;src/player.c:31: p->activated[p->next_activated_slot].my = my;
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
;src/player.c:32: p->next_activated_slot++;
	ld	a, (de)
	inc	a
	ld	(de), a
;src/player.c:33: if (p->next_activated_slot >= MAX_ACTIVATIONS) p->next_activated_slot = 0;
	sub	a, #0x08
	jr	C, 00102$
	xor	a, a
	ld	(de), a
00102$:
;src/player.c:34: if (p->activated_count < MAX_ACTIVATIONS) p->activated_count++;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0031
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
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/player.c:37: int16_t player_screen_y(const Player* p, uint16_t cam_y) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y::
;src/player.c:38: return (int16_t)(p->world_y >> 8) - (int16_t)cam_y;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a,	(hl+)
	ld	a, (hl)
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
	add	sp, #-49
	ldhl	sp,	#47
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/player.c:50: if (p->dead) return 1;
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
	ldhl	sp,	#45
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00284$
00102$:
;src/player.c:52: col_at_begin(map_bank);
	ldhl	sp,	#57
	ld	a, (hl)
	call	_col_at_begin
;src/player.c:55: if (p->mode == MODE_SHIP) {
	ldhl	sp,#47
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
;src/player.c:56: if (joy & J_A) {
	ldhl	sp,	#46
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,#47
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
	ld	(hl), a
	ldhl	sp,#47
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
;src/player.c:69: if (!p->on_ground) {
	ldhl	sp,#47
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
;src/player.c:55: if (p->mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00120$
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
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
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	e, b
	ld	d, a
;src/player.c:56: if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00104$
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	a, c
	or	a, a
	jr	Z, 00286$
	ld	hl, #0x0034
	jr	00287$
00286$:
	ld	hl, #0xffcc
00287$:
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
	jr	00105$
00104$:
;src/player.c:60: p->vel_y += (p->gravity_flipped) ? -SHIP_GRAVITY : SHIP_GRAVITY;
	ld	a, c
	or	a, a
	jr	Z, 00288$
	ld	hl, #0xffde
	jr	00289$
00288$:
	ld	hl, #0x0022
00289$:
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
00105$:
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
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
	ldhl	sp,	#45
	ld	(hl), a
	or	a, a
	jr	Z, 00290$
	ld	hl, #0x0369
	jr	00291$
00290$:
	ld	hl, #0x0443
00291$:
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 01658$
	bit	7, d
	jr	NZ, 01659$
	cp	a, a
	jr	01659$
01658$:
	bit	7, d
	jr	Z, 01659$
	scf
01659$:
	jr	NC, 00107$
;src/player.c:63: p->vel_y = (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN);
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00292$
	ld	bc, #0x0369
	jr	00293$
00292$:
	ld	bc, #0x0443
00293$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
00107$:
;src/player.c:64: if (p->vel_y < (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP))
	ldhl	sp,#8
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
	ldhl	sp,	#45
	ld	(hl), a
	or	a, a
	jr	Z, 00294$
	ld	hl, #0xfbbd
	jr	00295$
00294$:
	ld	hl, #0xfc97
00295$:
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 01660$
	bit	7, d
	jr	NZ, 01661$
	cp	a, a
	jr	01661$
01660$:
	bit	7, d
	jr	Z, 01661$
	scf
01661$:
	jp	NC, 00121$
;src/player.c:65: p->vel_y = (p->gravity_flipped ? -SHIP_MAX_VEL_DOWN : -SHIP_MAX_VEL_UP);
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ld	de, #0xfbbd
	jr	00297$
00296$:
	ld	de, #0xfc97
00297$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00121$
00120$:
;src/player.c:69: if (!p->on_ground) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00121$
;src/player.c:70: if (p->gravity_flipped) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	h, a
;src/player.c:70: if (p->gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00115$
;src/player.c:71: p->vel_y -= GRAVITY;
	ld	bc, #0xff95
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
;src/player.c:72: if (p->vel_y < -MAX_FALL_SPEED) p->vel_y = -MAX_FALL_SPEED;
	ld	a,b
	ld	(hl),a
	xor	a, #0x80
	sub	a, #0x7a
	jr	NC, 00121$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0xfa
	jr	00121$
00115$:
;src/player.c:75: p->vel_y += GRAVITY;
	ld	bc, #0x006b
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
;src/player.c:76: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x06
	xor	a, a
	cp	a, c
	ld	a, #0x06
	sbc	a, b
	bit	7, e
	jr	Z, 01662$
	bit	7, d
	jr	NZ, 01663$
	cp	a, a
	jr	01663$
01662$:
	bit	7, d
	jr	Z, 01663$
	scf
01663$:
	jr	NC, 00121$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
00121$:
;src/player.c:84: p->world_y += p->vel_y;
	ldhl	sp,#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/player.c:82: if (player_noclip) {
	ld	a, (#_player_noclip)
	or	a, a
	jr	Z, 00125$
;src/player.c:83: if (joy & J_A) p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00123$
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#45
	ld	(hl), a
	or	a, a
	jr	Z, 00298$
	dec	hl
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00299$
00298$:
	ldhl	sp,	#44
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00299$:
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/player.c:84: p->world_y += p->vel_y;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#42
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#42
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#42
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:85: col_at_end();
	call	_col_at_end
;src/player.c:86: return 0;
	xor	a, a
	jp	00284$
00125$:
;src/player.c:90: if (p->mode == MODE_CUBE && (joy & J_A) && p->on_ground) {
	ldhl	sp,#4
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
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00127$
;src/player.c:91: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00300$
	ld	bc, #0x0510
	jr	00301$
00300$:
	ld	bc, #0xfaf0
00301$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:92: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00127$:
;src/player.c:96: uint16_t px = p->world_x;
	ldhl	sp,#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/player.c:97: uint16_t py = p->world_y >> 8;
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:98: uint16_t mx0 = px >> 4;
	ldhl	sp,	#16
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
;src/player.c:99: const uint8_t* c0 = &map[mx0 << 4];
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ld	a, #0x04
01664$:
	ldhl	sp,	#42
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01664$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#51
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
;src/player.c:100: const uint8_t* c1 = (mx0 + 1 < map_w) ? c0 + 16 : c0;
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#26
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#25
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
	jr	NC, 00302$
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#44
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#43
	ld	(hl), a
	jr	00303$
00302$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
00303$:
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;src/player.c:102: uint8_t x_mod_16 = (uint8_t)px & 0x0F;
	ldhl	sp,	#16
	ld	a, (hl)
	and	a, #0x0f
;src/player.c:103: uint8_t threshold = 16 - x_mod_16;
	ld	c, a
	ld	a, #0x10
	sub	a, c
	ldhl	sp,	#28
	ld	(hl), a
;src/player.c:114: uint8_t front_mid = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE), py + 8);
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#46
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#45
	ld	(hl), a
	ld	a, #0x0f
	ldhl	sp,	#28
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	rla
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00304$
	ld	c, #0x07
	jr	00305$
00304$:
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00308$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jr	00309$
00308$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
00309$:
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00305$:
	ld	a, c
;src/player.c:116: if (IS_SOLID(front_mid)) {
	cp	a, #0x07
	jr	Z, 00130$
	cp	a, #0x09
	jr	Z, 00130$
	cp	a, #0x05
	jr	Z, 00130$
	sub	a, #0x06
	jr	NZ, 00131$
00130$:
;src/player.c:117: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:118: col_at_end();
	call	_col_at_end
;src/player.c:119: return 1;
	ld	a, #0x01
	jp	00284$
00131$:
;src/player.c:123: p->world_y += p->vel_y;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#40
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
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
	ldhl	sp,	#46
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/player.c:124: uint16_t ny = p->world_y >> 8;
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:125: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:128: int16_t check_y_foot = (p->gravity_flipped) ? ny : ny + PLAYER_SIZE;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl+)
	inc	hl
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
	ldhl	sp,	#44
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#43
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00310$
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00311$
00310$:
	ldhl	sp,	#42
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00311$:
;src/player.c:129: int16_t check_y_head = (p->gravity_flipped) ? ny + PLAYER_SIZE : ny;
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00312$
	inc	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	jr	00313$
00312$:
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl+), a
	ld	(hl), #0x00
00313$:
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
;src/player.c:132: uint8_t cl = COL_AT_PTR(GET_COL_FAST(2), check_y_foot);
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#44
	ld	(hl), #0x00
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ld	a, #0x02
	ldhl	sp,	#28
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00314$
	ld	a, #0x07
	jr	00315$
00314$:
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00318$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	jr	00319$
00318$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
00319$:
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00315$:
	ldhl	sp,	#37
	ld	(hl), a
;src/player.c:133: uint8_t cr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_foot);
	ld	a, #0x0d
	ldhl	sp,	#28
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00320$
	ld	c, #0x07
	jr	00321$
00320$:
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00324$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jr	00325$
00324$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
00325$:
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ld	c, a
00321$:
	ldhl	sp,	#39
	ld	(hl), c
;src/player.c:135: uint8_t falling = (p->gravity_flipped) ? (p->vel_y <= 0) : (p->vel_y >= 0);
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#40
	ld	(hl), a
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ldhl	sp,	#44
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:135: uint8_t falling = (p->gravity_flipped) ? (p->vel_y <= 0) : (p->vel_y >= 0);
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00326$
	ldhl	sp,	#44
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 01671$
	bit	7, d
	jr	NZ, 01672$
	cp	a, a
	jr	01672$
01671$:
	bit	7, d
	jr	Z, 01672$
	scf
01672$:
	ld	a, #0x00
	rla
	xor	a, #0x01
	ldhl	sp,	#41
	ld	(hl), a
	jr	00327$
00326$:
	ldhl	sp,	#45
	ld	a, (hl)
	rlca
	and	a,#0x01
	xor	a, #0x01
	ldhl	sp,	#41
	ld	(hl), a
00327$:
;src/player.c:139: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl+), a
	ld	(hl), #0x00
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
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#46
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#45
	ld	(hl), a
;src/player.c:142: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#42
	ld	a, (hl)
	and	a, #0xf0
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/player.c:139: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x04
01673$:
	ldhl	sp,	#42
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01673$
;src/player.c:142: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	pop	de
	push	de
	ld	hl, #0x0010
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#45
	ld	(hl-), a
	ld	(hl), e
;src/player.c:139: py = ((ny >> 4) + 1) << 4;
;src/player.c:142: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
;src/player.c:137: if (falling && (IS_SOLID(cl) || IS_SOLID(cr))) {
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00171$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00170$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00170$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00170$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00170$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00170$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00170$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00170$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00171$
00170$:
;src/player.c:138: if (p->gravity_flipped) {
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
;src/player.c:139: py = ((ny >> 4) + 1) << 4;
	inc	hl
	inc	hl
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/player.c:142: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
00136$:
;src/player.c:144: p->world_y = py << 8;
	ldhl	sp,	#44
	ld	b, (hl)
	ld	c, #0x00
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:145: p->vel_y = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/player.c:146: p->on_ground = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00172$
00171$:
;src/player.c:150: uint8_t hl = COL_AT_PTR(GET_COL_FAST(2), check_y_head);
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#39
	xor	a, a
	ld	(hl+), a
	ld	(hl), b
	or	a, b
	jr	Z, 00328$
	ld	a, #0x07
	jr	00329$
00328$:
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00332$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00333$
00332$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00333$:
	push	bc
	call	_col_at_raw_cached
	pop	bc
00329$:
	ldhl	sp,	#41
;src/player.c:151: uint8_t hr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), check_y_head);
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00334$
	ld	c, #0x07
	jr	00335$
00334$:
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00338$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00339$
00338$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00339$:
	call	_col_at_raw_cached
	ld	c, a
00335$:
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src/player.c:152: if (IS_SOLID(hl) || IS_SOLID(hr)) {
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00160$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00160$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00160$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00160$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00160$
	cp	a,#0x09
	jr	Z, 00160$
	cp	a,#0x05
	jr	Z, 00160$
	sub	a, #0x06
	jr	NZ, 00161$
00160$:
;src/player.c:153: if (p->gravity_flipped) {
	ld	a, b
	or	a, a
;src/player.c:154: py = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	jr	NZ, 00140$
;src/player.c:157: py = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#42
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00140$:
;src/player.c:159: p->world_y = py << 8;
	ldhl	sp,	#44
	ld	b, (hl)
	ld	c, #0x00
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:160: p->vel_y = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jp	00172$
00161$:
;src/player.c:163: py = ny;
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl+), a
	ld	(hl), #0x00
;src/player.c:166: int16_t sticky_y = (p->gravity_flipped) ? ny - 1 : ny + PLAYER_SIZE + 1;
	ld	a, b
	or	a, a
	jr	Z, 00340$
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#43
	ld	(hl-), a
	ld	(hl), e
	jr	00341$
00340$:
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#44
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#43
	ld	(hl), a
00341$:
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:167: uint8_t gl = COL_AT_PTR(GET_COL_FAST(2), sticky_y);
	ldhl	sp,	#39
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
	jr	Z, 00342$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00344$
	xor	a, a
	jr	00345$
00344$:
	ld	a, #0x07
00345$:
	ldhl	sp,	#37
	ld	(hl), a
	jr	00343$
00342$:
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00346$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	jr	00347$
00346$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
00347$:
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#37
	ld	(hl), a
00343$:
;src/player.c:168: uint8_t gr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - 2), sticky_y);
	ldhl	sp,	#42
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00348$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00350$
	xor	a, a
	jr	00349$
00350$:
	ld	a, #0x07
	jr	00349$
00348$:
	ldhl	sp,	#38
	ld	a, (hl)
	or	a, a
	jr	Z, 00352$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	jr	00353$
00352$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
00353$:
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00349$:
	ld	c, a
;src/player.c:169: if (IS_SOLID(gl) || IS_SOLID(gr)) {
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00151$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00151$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00151$
	ldhl	sp,	#37
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00151$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00151$
	cp	a,#0x09
	jr	Z, 00151$
	cp	a,#0x05
	jr	Z, 00151$
	sub	a, #0x06
	jr	NZ, 00172$
00151$:
;src/player.c:170: p->on_ground = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:172: if (p->mode == MODE_CUBE) p->vel_y = 0;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00149$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00172$
00149$:
;src/player.c:173: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
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
;src/player.c:57: p->vel_y += (p->gravity_flipped) ? -SHIP_THRUST : SHIP_THRUST;
	ld	l, a
;src/player.c:173: else if (p->gravity_flipped) { if (p->vel_y < 0) p->vel_y = 0; }
	ld	a, b
	or	a, a
	jr	Z, 00146$
	bit	7, l
	jr	Z, 00172$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00172$
00146$:
;src/player.c:174: else { if (p->vel_y > 0) p->vel_y = 0; }
	ld	e, l
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, l
	bit	7, e
	jr	Z, 01701$
	bit	7, d
	jr	NZ, 01702$
	cp	a, a
	jr	01702$
01701$:
	bit	7, d
	jr	Z, 01702$
	scf
01702$:
	jr	NC, 00172$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00172$:
;src/player.c:180: const uint8_t* c_front = GET_COL_FAST(PLAYER_SIZE);
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00354$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	jr	00355$
00354$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
00355$:
	ldhl	sp,	#42
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/player.c:181: uint8_t front_head = COL_AT_PTR(c_front, py + PLAYER_HBOX);
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#40
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#29
	ld	(hl), #0x00
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00356$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00358$
	xor	a, a
	jr	00359$
00358$:
	ld	a, #0x07
00359$:
	ldhl	sp,	#43
	ld	(hl), a
	jr	00357$
00356$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#43
	ld	(hl), a
00357$:
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
;src/player.c:182: uint8_t front_foot = COL_AT_PTR(c_front, py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#35
	ld	(hl), #0x00
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00360$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00362$
	ldhl	sp,	#43
	ld	(hl), #0x00
	jr	00363$
00362$:
	ldhl	sp,	#43
	ld	(hl), #0x07
00363$:
	ldhl	sp,	#43
	ld	a, (hl)
	jr	00361$
00360$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,#43
	ld	(hl), a
00361$:
	ldhl	sp,	#40
	ld	(hl), a
;src/player.c:185: uint8_t hz_tl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x06
	ldhl	sp,	#28
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00364$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00366$
	xor	a, a
	jr	00365$
00366$:
	ld	a, #0x07
	jr	00365$
00364$:
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00368$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00369$
00368$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00369$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00365$:
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:186: uint8_t hz_tr = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_HBOX);
	ld	a, #0x09
	ldhl	sp,	#28
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00370$
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00372$
	ld	(hl), #0x00
	jr	00373$
00372$:
	ldhl	sp,	#33
	ld	(hl), #0x07
00373$:
	ldhl	sp,	#33
	ld	a, (hl)
	jr	00371$
00370$:
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00374$
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	jr	00375$
00374$:
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
00375$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00371$:
	ldhl	sp,	#33
	ld	(hl), a
;src/player.c:187: uint8_t hz_bl = COL_AT_PTR(GET_COL_FAST(PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00376$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00378$
	xor	a, a
	jr	00377$
00378$:
	ld	a, #0x07
	jr	00377$
00376$:
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00380$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00381$
00380$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00381$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
00377$:
	ldhl	sp,	#41
	ld	(hl), a
;src/player.c:188: uint8_t hz_br = COL_AT_PTR(GET_COL_FAST(PLAYER_SIZE - PLAYER_HBOX), py + PLAYER_SIZE - PLAYER_HBOX);
	ldhl	sp,	#36
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00382$
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	Z, 00384$
	xor	a, a
	jr	00385$
00384$:
	ld	a, #0x07
00385$:
	ldhl	sp,	#43
	ld	(hl), a
	jr	00383$
00382$:
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00386$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00387$
00386$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00387$:
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#43
	ld	(hl), a
00383$:
;src/player.c:191: if (IS_SOLID(front_head) || IS_SOLID(front_foot)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00181$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00181$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00181$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00181$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00181$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00181$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00181$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00182$
00181$:
;src/player.c:192: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:193: col_at_end();
	call	_col_at_end
;src/player.c:194: return 1;
	ld	a, #0x01
	jp	00284$
00182$:
;src/player.c:196: if (IS_HAZARD(hz_tl) || IS_HAZARD(hz_tr) || IS_HAZARD(hz_bl) || IS_HAZARD(hz_br)) {
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x04
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	dec	a
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x10
	jp	Z, 00190$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x11
	jp	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x03
	jp	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	dec	a
	jr	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00190$
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	dec	a
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00190$
	ldhl	sp,	#41
	ld	a, (hl)
	sub	a, #0x11
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	dec	a
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00190$
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x11
	jr	NZ, 00191$
00190$:
;src/player.c:197: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/player.c:198: col_at_end();
	call	_col_at_end
;src/player.c:199: return 1;
	ld	a, #0x01
	jp	00284$
00191$:
;src/player.c:204: uint8_t tl = COL_AT_PTR(c0, py);
	ldhl	sp,	#39
	ld	(hl), #0x00
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#41
	ld	(hl-), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00388$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00390$
	xor	a, a
	jr	00389$
00390$:
	ld	a, #0x07
	jr	00389$
00388$:
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
00389$:
	ldhl	sp,	#42
	ld	(hl), a
;src/player.c:205: const uint8_t* c_right = GET_COL_FAST(PLAYER_SIZE - 1);
	ld	a, #0x0e
	ldhl	sp,	#28
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#43
	ld	(hl), a
	or	a, a
	jr	Z, 00392$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	jr	00393$
00392$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
00393$:
	ldhl	sp,	#37
	ld	(hl), e
	inc	hl
;src/player.c:206: uint8_t tr = COL_AT_PTR(c_right, py);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00394$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00396$
	xor	a, a
	jr	00395$
00396$:
	ld	a, #0x07
	jr	00395$
00394$:
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,#41
	ld	(hl), a
00395$:
	ldhl	sp,	#39
	ld	(hl), a
;src/player.c:207: uint8_t bl = COL_AT_PTR(c0, py + PLAYER_SIZE - 1);
	ldhl	sp,#4
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
	ldhl	sp,	#32
	ld	(hl), #0x00
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl+), a
	ld	a, b
	rlca
	and	a,#0x01
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00398$
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00400$
	ldhl	sp,	#31
	ld	(hl), #0x00
	jr	00399$
00400$:
	ldhl	sp,	#31
	ld	(hl), #0x07
	jr	00399$
00398$:
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#31
	ld	(hl), a
00399$:
;src/player.c:208: uint8_t br = COL_AT_PTR(c_right, py + PLAYER_SIZE - 1);
	ldhl	sp,	#33
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00402$
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00404$
	xor	a, a
	jr	00405$
00404$:
	ld	a, #0x07
00405$:
	ldhl	sp,	#38
	ld	(hl), a
	jr	00403$
00402$:
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_col_at_raw_cached
	ldhl	sp,	#38
	ld	(hl), a
00403$:
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
;src/player.c:210: uint8_t pad_l = (p->gravity_flipped) ? tl : bl;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl), a
	or	a, a
	jr	Z, 00406$
	ldhl	sp,	#42
	ld	a, (hl)
	jr	00407$
00406$:
	ldhl	sp,	#31
	ld	a, (hl)
00407$:
	ldhl	sp,	#34
;src/player.c:211: uint8_t pad_r = (p->gravity_flipped) ? tr : br;
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00408$
	ldhl	sp,	#39
	ld	a, (hl)
	jr	00409$
00408$:
	ldhl	sp,	#32
	ld	a, (hl)
00409$:
	ldhl	sp,	#35
;src/player.c:214: if (IS_PAD(pad_l) || IS_PAD(pad_r)) {
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x0b
	ld	a, #0x01
	jr	Z, 01742$
	xor	a, a
01742$:
	ldhl	sp,	#36
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0e
	ld	a, #0x01
	jr	Z, 01744$
	xor	a, a
01744$:
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x0f
	ld	a, #0x01
	jr	Z, 01746$
	xor	a, a
01746$:
	ldhl	sp,	#38
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00266$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00266$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00266$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x0b
	jr	Z, 00266$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00266$
	ldhl	sp,	#35
	ld	a, (hl)
	sub	a, #0x0f
	jp	NZ, 00267$
00266$:
;src/player.c:97: uint16_t py = p->world_y >> 8;
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/player.c:217: int16_t hy = (p->gravity_flipped) ? (int16_t)(p->world_y >> 8) : (int16_t)(p->world_y >> 8) + PLAYER_SIZE - 1;
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jr	Z, 00410$
	ldhl	sp,	#44
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00411$
00410$:
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
00411$:
	ldhl	sp,	#42
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/player.c:218: if (IS_PAD(pad_l)) { hit = pad_l; hx = px; }
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	NZ, 00219$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00219$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00220$
00219$:
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	jr	00221$
00220$:
;src/player.c:219: else { hit = pad_r; hx = px + PLAYER_SIZE - 1; }
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#41
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#40
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00221$:
;src/player.c:221: uint16_t pmx = (hx >> 4);
	ldhl	sp,	#42
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
;src/player.c:222: uint16_t pmy = ((uint16_t)hy >> 4);
	ldhl	sp,	#45
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
;src/player.c:224: if (!player_tile_activated(p, pmx, pmy)) {
	ld	e, (hl)
	ld	d, #0x00
	push	de
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	or	a, a
	jp	NZ, 00268$
;src/player.c:225: player_mark_activated(p, pmx, pmy);
	ldhl	sp,	#44
	ld	e, (hl)
	ld	d, #0x00
	push	de
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/player.c:226: if (hit == COL_PAD_BLUE) {
	ldhl	sp,	#43
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00228$
;src/player.c:227: p->gravity_flipped = !p->gravity_flipped;
	ld	a, c
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	c, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;src/player.c:228: p->vel_y = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ld	a,c
	ld	(hl),a
	or	a, a
	jr	Z, 00412$
	ld	bc, #0xfc60
	jr	00413$
00412$:
	ld	bc, #0x03a0
00413$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00229$
00228$:
;src/player.c:230: else if (hit == COL_PAD_MAGENTA) {
	ldhl	sp,	#43
	ld	a, (hl)
;src/player.c:231: p->vel_y = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
	sub	a, #0x0f
	jr	NZ, 00225$
	or	a, c
	jr	Z, 00414$
	ld	bc, #0x04e8
	jr	00415$
00414$:
	ld	bc, #0xfb18
00415$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00229$
00225$:
;src/player.c:234: p->vel_y = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ld	a, c
	or	a, a
	jr	Z, 00416$
	ld	bc, #0x07c0
	jr	00417$
00416$:
	ld	bc, #0xf840
00417$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00229$:
;src/player.c:236: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00268$
00267$:
;src/player.c:240: else if (joy & J_A) {
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jp	Z, 00268$
;src/player.c:247: omx = mx0; omy = py >> 4;
	ldhl	sp,#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/player.c:246: if (IS_ORB(tl)) {
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00234$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00234$
	ldhl	sp,	#42
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00235$
00234$:
;src/player.c:247: omx = mx0; omy = py >> 4;
	ld	l, e
	ld	h, d
;src/player.c:248: if (!player_tile_activated(p, omx, omy)) {
	push	hl
	push	de
	push	hl
	push	hl
	ldhl	sp,	#26
	ld	c, (hl)
	ldhl	sp,	#27
	ld	b, (hl)
	ldhl	sp,	#55
	ld	e, (hl)
	ldhl	sp,	#56
	ld	d, (hl)
	pop	hl
	call	_player_tile_activated
	pop	de
	pop	hl
	or	a, a
	jr	NZ, 00235$
;src/player.c:249: player_mark_activated(p, omx, omy);
	push	hl
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:250: hit = tl; goto orb_hit;
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jp	00256$
00235$:
;src/player.c:254: if (IS_ORB(tr)) {
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00240$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00240$
	ldhl	sp,	#39
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00241$
00240$:
;src/player.c:255: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = py >> 4;
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00418$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jr	00419$
00418$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
00419$:
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
;src/player.c:256: if (!player_tile_activated(p, omx, omy)) {
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
	jr	NZ, 00241$
;src/player.c:257: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:258: hit = tr; goto orb_hit;
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jp	00256$
00241$:
;src/player.c:263: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,#40
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
	ldhl	sp,	#44
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/player.c:262: if (IS_ORB(bl)) {
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00246$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00246$
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00247$
00246$:
;src/player.c:263: omx = mx0; omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/player.c:264: if (!player_tile_activated(p, omx, omy)) {
	push	de
	push	de
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_tile_activated
	pop	de
	or	a, a
	jr	NZ, 00247$
;src/player.c:265: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:266: hit = bl; goto orb_hit;
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	jr	00256$
00247$:
;src/player.c:270: if (IS_ORB(br)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00252$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00252$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ, 00268$
00252$:
;src/player.c:271: omx = GET_MX_FAST(PLAYER_SIZE - 1); omy = (py + PLAYER_SIZE - 1) >> 4;
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00420$
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	jr	00421$
00420$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
00421$:
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/player.c:272: if (!player_tile_activated(p, omx, omy)) {
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
	jp	NZ, 00268$
;src/player.c:273: player_mark_activated(p, omx, omy);
	push	de
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_player_mark_activated
;src/player.c:274: hit = br; goto orb_hit;
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
;src/player.c:279: orb_hit:
00256$:
;src/player.c:62: if (p->vel_y > (p->gravity_flipped ? SHIP_MAX_VEL_UP : SHIP_MAX_VEL_DOWN))
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
;src/player.c:280: if (hit == COL_ORB_MAGENTA) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00261$
;src/player.c:281: p->vel_y = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00422$
	ld	a, #0xd0
	ld	(hl+), a
	ld	(hl), #0x03
	jr	00423$
00422$:
	ldhl	sp,	#44
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0xfc
00423$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00262$
00261$:
;src/player.c:283: else if (hit == COL_ORB_BLUE) {
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ, 00258$
;src/player.c:284: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/player.c:285: p->vel_y = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
	or	a, a
	jr	Z, 00424$
	ld	bc, #0xfe60
	jr	00425$
00424$:
	ld	bc, #0x01a0
00425$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00262$
00258$:
;src/player.c:288: p->vel_y = (p->gravity_flipped) ? -JUMP_FORCE : JUMP_FORCE;
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jr	Z, 00426$
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0x05
	jr	00427$
00426$:
	ldhl	sp,	#44
	ld	(hl), #0xf0
	inc	hl
	ld	(hl), #0xfa
00427$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00262$:
;src/player.c:290: p->on_ground = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/player.c:292: orb_done:;
00268$:
;src/player.c:298: col_at_end();
	call	_col_at_end
;src/player.c:301: if (p->on_ground) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#45
	ld	(hl), a
;src/player.c:302: p->anim_timer = 0;
	ldhl	sp,#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
;src/player.c:303: p->anim_frame = 0;
	ldhl	sp,#47
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
;src/player.c:301: if (p->on_ground) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00279$
;src/player.c:302: p->anim_timer = 0;
;src/player.c:303: p->anim_frame = 0;
	dec	hl
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00280$
00279$:
;src/player.c:306: p->anim_timer += 10;
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
;src/player.c:307: if (p->anim_timer >= 20) {
	ld	a, e
	sub	a, #0x14
	ld	a, d
	sbc	a, #0x00
	jr	C, 00280$
;src/player.c:308: p->anim_timer -= 20;
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
;src/player.c:309: p->anim_frame++;
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
;src/player.c:310: if (p->anim_frame >= 24) p->anim_frame = 0;
	sub	a, #0x18
	jr	C, 00280$
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00280$:
;src/player.c:315: if ((p->world_y >> 8) > (uint16_t)(map_h << 4) || (int16_t)(p->world_y >> 8) < -32) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#55
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#56
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ld	a, #0x04
01775$:
	ldhl	sp,	#42
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01775$
	ldhl	sp,	#42
	ld	e, l
	ld	d, h
	ldhl	sp,	#44
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00282$
;src/player.c:316: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;src/player.c:317: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00284$
00282$:
;src/player.c:320: p->last_joy = joy;
	ldhl	sp,#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#46
	ld	a, (hl)
	ld	(bc), a
;src/player.c:321: return 0;
	xor	a, a
00284$:
;src/player.c:322: }
	add	sp, #49
	pop	hl
	add	sp, #7
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__player_noclip:
	.db #0x00	; 0
	.area _CABS (ABS)
