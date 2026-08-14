;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module gameplay
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hide_sprites_range
	.globl _sp_cache_load
	.globl _player_screen_y
	.globl _player_update
	.globl _player_init
	.globl _load_collision_columns
	.globl _load_bkg_tileset
	.globl _fill_scroll_bg
	.globl _draw_mt_column
	.globl _init_music_banked
	.globl _puts
	.globl _printf
	.globl _gotoxy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
	.globl _sp_cache_reset
	.globl _sp_cache_update
	.globl b_setup_menu_font
	.globl _setup_menu_font
	.globl b_draw_menu
	.globl _draw_menu
	.globl b_play_level
	.globl _play_level
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
	.area _CODE_1
;src/gameplay.c:55: void sp_cache_reset(ActiveSp *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
	add	sp, #-1
	push	de
;src/gameplay.c:57: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:58: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache[i].active = 0;
	ldhl	sp,	#2
	ld	(hl), #0x00
00102$:
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	add	hl, bc
	ld	bc, #0x0004
	add	hl, bc
	ld	(hl), #0x00
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00102$
;src/gameplay.c:59: }
	add	sp, #3
	ret
_level_sprite_cost_table:
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
;src/gameplay.c:61: void sp_cache_update(const Level *l, uint16_t cam_px,
;	---------------------------------
; Function sp_cache_update
; ---------------------------------
_sp_cache_update::
	add	sp, #-11
	ldhl	sp,	#7
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:65: uint8_t sp_bank = l->sp_bank;
	ld	hl, #0x0014
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/gameplay.c:66: const SpDef *sp_list = l->sp_list;
	ld	hl, #0x0012
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#1
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:69: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#10
	ld	(hl), #0x00
00115$:
;src/gameplay.c:71: if (!cache[i].active) continue;
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:72: object_x = (uint16_t)cache[i].def.c << 4;
	ldhl	sp,#5
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
;src/gameplay.c:73: if (object_x + 32u < cam_px) cache[i].active = 0;
	ld	de, #0x0020
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00105$
	xor	a, a
	ld	(bc), a
00105$:
;src/gameplay.c:69: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#10
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:77: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00116$:
;src/gameplay.c:78: if (cache[i].active) {
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/gameplay.c:79: if (count != i) cache[count] = cache[i];
	ldhl	sp,	#9
	ld	a, (hl+)
	sub	a, (hl)
	jr	Z, 00108$
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	bc, #0x0006
	push	bc
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	___memcpy
00108$:
;src/gameplay.c:80: count++;
	ldhl	sp,	#9
	inc	(hl)
00117$:
;src/gameplay.c:77: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#10
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00116$
;src/gameplay.c:83: while (count < MAX_ACTIVE_SP_OBJECTS) cache[count++].active = 0;
	dec	hl
	ld	a, (hl+)
	ld	(hl), a
00112$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00114$
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	inc	(hl)
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	bc, #0x0004
	add	hl, bc
	ld	(hl), #0x00
	jr	00112$
00114$:
;src/gameplay.c:85: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx);
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	call	_sp_cache_load
;src/gameplay.c:86: }
	add	sp, #11
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:88: static uint8_t process_and_draw_sprites(
;	---------------------------------
; Function process_and_draw_sprites
; ---------------------------------
_process_and_draw_sprites:
	add	sp, #-34
	ldhl	sp,	#31
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#29
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:93: uint16_t px = p->world_x;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:94: uint16_t py = p->world_y.b.h;
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
;src/gameplay.c:95: uint8_t reversed = p->reversed;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
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
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:97: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#33
	ld	(hl), #0x00
00202$:
	ldhl	sp,	#33
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00197$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00197$
;src/gameplay.c:99: if (!cache[i].active) break;
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00197$
;src/gameplay.c:101: uint16_t obj_x = (uint16_t)cache[i].def.c << 4;
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	sla	c
	adc	a, a
	sla	c
	adc	a, a
	sla	c
	adc	a, a
	sla	c
	adc	a, a
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:104: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x00b0
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00197$
;src/gameplay.c:106: uint8_t obj = cache[i].def.obj;
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
;src/gameplay.c:107: uint16_t obj_y = (uint16_t)(map_height - 1u - cache[i].def.r) << 4;
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#22
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:112: if (obj == OBJ_LEVEL_END) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:113: if (px >= (obj_x - 180)) p->level_complete = 1;
	ld	a, c
	add	a, #0x4c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00196$
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;src/gameplay.c:114: continue; // End triggers aren't drawn
	jp	00196$
00108$:
;src/gameplay.c:117: if (obj_x <= px + 15) { // Only process physics if touching horizontally
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	jp	C, 00178$
;src/gameplay.c:118: switch (obj) {
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jp	Z, 00110$
	ldhl	sp,	#27
	ld	a, (hl)
	dec	a
	jp	Z, 00110$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00726$
	xor	a, a
00726$:
	ldhl	sp,	#28
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00144$
	dec	hl
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00144$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00117$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00117$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00129$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00144$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00129$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00129$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00129$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00129$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x64
	jp	Z, 00161$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x65
	jp	Z, 00161$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x66
	jp	Z, 00161$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x67
	jp	Z, 00161$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00170$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00164$
	jp	00178$
;src/gameplay.c:120: case OBJ_SHIP_PORTAL:
00110$:
;src/gameplay.c:121: if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00178$
	ld	hl, #0x001f
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#22
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:122: if (!cache[i].activated) {
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:123: p->mode = (obj == OBJ_CUBE_PORTAL) ? MODE_CUBE : MODE_SHIP;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#27
	ld	a, (hl)
	or	a,a
	jr	Z, 00206$
	ld	a, #0x01
00206$:
	ld	(de), a
;src/gameplay.c:124: cache[i].activated = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:127: break;
	jp	00178$
;src/gameplay.c:130: case OBJ_GRAVITY_UP:
00117$:
;src/gameplay.c:131: if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00178$
	ld	hl, #0x001f
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#22
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:132: if (!cache[i].activated) {
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:133: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00743$
	xor	a, a
00743$:
;src/gameplay.c:134: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	cp	a, l
	jr	Z, 00119$
;src/gameplay.c:135: p->gravity_flipped = target_flipped;
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:136: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#25
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl-), a
	pop	de
	push	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00119$:
;src/gameplay.c:138: cache[i].activated = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:141: break;
	jp	00178$
;src/gameplay.c:147: case OBJ_PAD_BLUE_UP:
00129$:
;src/gameplay.c:149: uint8_t is_ceiling_pad = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00208$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00208$
	xor	a, a
	jr	00209$
00208$:
	ld	a, #0x01
00209$:
	ld	b, a
;src/gameplay.c:150: uint16_t pad_top = is_ceiling_pad ? obj_y : (obj_y + 12);
	or	a, a
	jr	Z, 00210$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	e, (hl)
	jr	00211$
00210$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	e, h
00211$:
	ld	d, c
;src/gameplay.c:151: uint16_t pad_bot = is_ceiling_pad ? (obj_y + 4) : (obj_y + 16);
	ld	a, b
	or	a, a
	jr	Z, 00212$
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	jr	00213$
00212$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
00213$:
;src/gameplay.c:153: if (py <= pad_bot && (py + PLAYER_SIZE) >= pad_top) {
	ldhl	sp,	#8
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x000f
	add	hl, bc
	ld	a, l
	sub	a, d
	ld	a, h
	sbc	a, e
	jp	C, 00178$
;src/gameplay.c:154: if (!cache[i].activated) {
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:155: cache[i].activated = 1;
	ld	(hl), #0x01
;src/gameplay.c:156: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00133$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00134$
00133$:
;src/gameplay.c:157: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#13
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
;src/gameplay.c:158: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00214$
	ld	bc, #0xfc60
	jr	00215$
00214$:
	ld	bc, #0x03a0
00215$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jr	00135$
00134$:
;src/gameplay.c:159: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00131$
;src/gameplay.c:160: p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00216$
	ldhl	sp,	#25
	ld	a, #0xe8
	ld	(hl+), a
	ld	(hl), #0x04
	jr	00217$
00216$:
	ldhl	sp,	#25
	ld	a, #0x18
	ld	(hl+), a
	ld	(hl), #0xfb
00217$:
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00135$
00131$:
;src/gameplay.c:162: p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00218$
	ld	de, #0x0762
	jr	00219$
00218$:
	ld	de, #0xf89e
00219$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00135$:
;src/gameplay.c:164: p->on_ground = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:167: break;
	jp	00178$
;src/gameplay.c:172: case OBJ_ORB_BLUE:
00144$:
;src/gameplay.c:174: if (joy & J_A) {
	ldhl	sp,	#21
	ld	a, (hl)
	or	a, a
	jp	Z, 00178$
;src/gameplay.c:175: if (py <= obj_y + 16 && (py + PLAYER_SIZE) >= obj_y) {
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00178$
	ld	hl, #0x000f
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#22
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:176: if (!cache[i].activated) {
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:177: cache[i].activated = 1;
	ld	(hl), #0x01
;src/gameplay.c:178: if (obj == OBJ_ORB_BLUE) {
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/gameplay.c:179: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#13
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
;src/gameplay.c:180: p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00220$
	ld	bc, #0xfe60
	jr	00221$
00220$:
	ld	bc, #0x01a0
00221$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jr	00150$
00149$:
;src/gameplay.c:181: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00146$
;src/gameplay.c:182: p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00222$
	ld	de, #0x03d0
	jr	00223$
00222$:
	ld	de, #0xfc30
00223$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00150$
00146$:
;src/gameplay.c:184: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 120 : JUMP_FORCE - 120;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00224$
	ld	de, #0x0574
	jr	00225$
00224$:
	ld	de, #0xfa8c
00225$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00150$:
;src/gameplay.c:186: p->on_ground = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:190: break;
	jp	00178$
;src/gameplay.c:193: case 100: case 101: case 102: case 103:
00161$:
;src/gameplay.c:194: if (!cache[i].activated) {
	ldhl	sp,	#33
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00196$
;src/gameplay.c:195: *target_bg_idx = obj - 100;
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a, (hl)
	add	a, #0x9c
	ld	(de), a
;src/gameplay.c:196: cache[i].activated = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:198: continue; // Background triggers aren't drawn
	jp	00196$
;src/gameplay.c:200: case OBJ_MIRROR_PORTAL:
00164$:
;src/gameplay.c:201: if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	C, 00178$
	ld	hl, #0x001f
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#22
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00178$
;src/gameplay.c:202: if (!cache[i].activated) {
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00178$
;src/gameplay.c:203: p->reversed = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:204: cache[i].activated = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:207: break;
	jr	00178$
;src/gameplay.c:209: case OBJ_MIRROR_EXIT:
00170$:
;src/gameplay.c:210: if (py <= obj_y + 32 && (py + PLAYER_SIZE + 16) >= obj_y) {
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	e, (hl)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	C, 00178$
	ld	hl, #0x001f
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#22
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00178$
;src/gameplay.c:211: if (!cache[i].activated) {
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00178$
;src/gameplay.c:212: p->reversed = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:213: cache[i].activated = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:217: }
00178$:
;src/gameplay.c:223: if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00196$
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	ld	hl, #_famidash_sprite_table
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#26
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#25
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	or	a, c
	jp	Z, 00196$
;src/gameplay.c:228: if (reversed) {
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	Z, 00183$
;src/gameplay.c:229: screen_x = 128 - ((uint8_t)obj_x - (uint8_t)cam_px) + 8;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	ld	(hl), a
	ld	a, #0x88
	sub	a, (hl)
	ld	(hl), a
	jr	00184$
00183$:
;src/gameplay.c:231: screen_x = ((uint8_t)obj_x - (uint8_t)cam_px) + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#36
	ld	c, (hl)
	sub	a, c
	add	a, #0x28
	ldhl	sp,	#28
	ld	(hl), a
00184$:
;src/gameplay.c:234: uint8_t screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#38
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#26
;src/gameplay.c:238: if (screen_x > 160 && screen_x < 232) continue;
	ld	(hl+), a
	inc	hl
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00186$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00196$
00186$:
;src/gameplay.c:239: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#26
	sub	a, (hl)
	jr	NC, 00189$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00196$
00189$:
;src/gameplay.c:241: uint8_t cost = level_sprite_cost_table[obj];
	ldhl	sp,	#27
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_level_sprite_cost_table
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;src/gameplay.c:242: if (oam_start + cost > MAX_HARDWARE_SPRITES - 2) break;
	ldhl	sp,	#45
	ld	c, (hl)
	ld	b, #0x00
	ld	h, b
	ld	l, a
	add	hl, bc
	ld	a, #0x26
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	C, 00197$
;src/gameplay.c:244: const metasprite_t *sprite = famidash_sprite_table[obj];
	ldhl	sp,#24
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:246: if (reversed) {
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	Z, 00194$
;src/gameplay.c:248: oam_start, (uint8_t)screen_x, (uint8_t)screen_y);
	ldhl	sp,	#45
	ld	c, (hl)
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, b
	ld	(hl+), a
	ld	(hl), e
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x58
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldhl	sp,	#26
	ld	l, (hl)
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00226$
	ld	de, #0x0010
	jr	00227$
00226$:
	ld	de, #0x0008
00227$:
	ld	a, l
	sub	a, e
	ld	d, a
	ldhl	sp,	#28
	ld	e, (hl)
	ld	a, c
	call	___move_metasprite_hflip
;src/gameplay.c:248: oam_start, (uint8_t)screen_x, (uint8_t)screen_y);
	ldhl	sp,	#45
	add	a, (hl)
	ld	(hl), a
	jr	00196$
00194$:
;src/gameplay.c:251: oam_start, (uint8_t)screen_x, (uint8_t)screen_y);
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ldhl	sp,	#24
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x58
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#26
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:251: oam_start, (uint8_t)screen_x, (uint8_t)screen_y);
	ldhl	sp,	#27
	add	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
00196$:
;src/gameplay.c:97: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#33
	inc	(hl)
	jp	00202$
00197$:
;src/gameplay.c:254: return oam_start;
	ldhl	sp,	#45
	ld	a, (hl)
;src/gameplay.c:255: }
	add	sp, #34
	pop	hl
	add	sp, #10
	jp	(hl)
;src/gameplay.c:257: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 1
_setup_menu_font::
;src/gameplay.c:258: font_init();
	call	_font_init
;src/gameplay.c:259: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:260: }
	ret
;src/gameplay.c:262: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 1
_draw_menu::
;src/gameplay.c:263: fill_bkg_rect(0, 0, 20, 18, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/gameplay.c:264: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:265: printf("GBDASH DEMO 01\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:266: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:267: gotoxy(1, 2 + i);
	ld	a,c
	cp	a,b
	jr	NC, 00104$
	add	a, #0x02
	push	bc
	ld	h, a
	ld	l, #0x01
	push	hl
	call	_gotoxy
	pop	hl
	pop	bc
;src/gameplay.c:268: if (i == selected) printf("0 %s", game_levels[i]->name);
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	ld	b, l
	ld	e, h
	ld	a, (#_selected)
	sub	a, c
	jr	NZ, 00102$
	ld	l, b
	ld	h, e
	ld	de, #_game_levels
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
	pop	bc
	jr	00107$
00102$:
;src/gameplay.c:269: else printf("  %s", game_levels[i]->name);
	ld	a, #<(_game_levels)
	add	a, b
	ld	l, a
	ld	a, #>(_game_levels)
	adc	a, e
	ld	h, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00107$:
;src/gameplay.c:266: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:271: printf("\n\n\n\n\n\n\n\nSotospro24");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:272: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:273: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:274: }
	ret
___str_1:
	.ascii "GBDASH DEMO 01"
	.db 0x00
___str_2:
	.ascii "0 %s"
	.db 0x00
___str_3:
	.ascii "  %s"
	.db 0x00
___str_4:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "Sotospro24"
	.db 0x00
;src/gameplay.c:276: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 1
_play_level::
	add	sp, #-128
	add	sp, #-86
;src/gameplay.c:286: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #220
	add	hl, sp
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ld	hl, #212
	add	hl, sp
	ld	(hl), e
	inc	hl
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #156
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:287: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #212
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #211
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #206
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:288: level_map = l->map;
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #158
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:289: level_tile_count = l->tile_count;
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #160
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:290: level_map_w = l->map_width;
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #162
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:291: level_map_h = l->map_height;
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #209
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #164
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:292: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:293: level_map_bank = l->map_bank;
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #167
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:295: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:296: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:297: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:299: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #212
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #170
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #169
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00102$
;src/gameplay.c:300: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #213
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #220
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #215
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:301: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:302: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:305: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #212
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:306: uint16_t cam_py = 112;
	ld	hl, #170
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:307: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #164
	add	hl, sp
	ld	a, (hl+)
	ld	c, (hl)
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
;src/gameplay.c:308: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #204
	add	hl, sp
	ld	(hl+), a
	ld	a, c
	ld	(hl-), a
	ld	a, #0x90
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00104$
	ld	hl,#0xcc
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0090
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ld	hl, #172
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:309: else cam_py_max = 0;
	xor	a, a
	ld	hl, #172
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:310: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #174
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:315: uint8_t target_bg_idx = 0;
	ldhl	sp,	#0
;src/gameplay.c:316: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:324: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #7
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:327: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:328: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #166
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #161
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #207
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:329: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:330: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:331: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x2458
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:333: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #168
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #164
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #160
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:334: BGP_REG = bg_pals[0];
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:335: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:336: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:337: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:338: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:339: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:340: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:341: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:344: uint16_t scroll_acc = 0;
	ld	hl, #176
	add	hl, sp
;src/gameplay.c:345: uint8_t prev_joy = 0;
;src/gameplay.c:346: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:348: uint16_t sp_stream_idx = 0;
	xor	a, a
	ldhl	sp,	#122
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:349: uint16_t sp_cache_col = 0xFFFF;
	ld	hl, #179
	add	hl, sp
;src/gameplay.c:351: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:352: sp_cache_reset(active_sp, &sp_stream_idx);
	ld	hl, #122
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #185
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #184
	add	hl, sp
	ld	(hl), a
	ld	hl, #26
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #187
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #186
	add	hl, sp
	ld	(hl), a
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:353: while (1) {
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #187
	add	hl, sp
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	ld	hl, #188
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #191
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #190
	add	hl, sp
	ld	(hl), a
	ld	hl, #208
	add	hl, sp
	ld	a, (hl)
	ld	hl, #191
	add	hl, sp
	ld	(hl), a
	ld	hl, #209
	add	hl, sp
	ld	a, (hl)
	ld	hl, #192
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x9c
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #195
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #194
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank
	ld	hl, #220
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #197
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #197
	add	hl, sp
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	ld	hl, #198
	add	hl, sp
	ld	(hl), a
00184$:
;src/gameplay.c:354: uint8_t joy = joypad();
	call	_joypad
	ld	hl, #199
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:355: if (joy & J_START) break;
	push	hl
	ld	hl, #201
	add	hl, sp
	bit	7, (hl)
	pop	hl
	jp	NZ, 00185$
;src/gameplay.c:357: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ld	hl, #201
	add	hl, sp
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#21
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:358: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCX_REG + 0), a
	ld	a, #0x00
	ldh	(_SCY_REG + 0), a
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:361: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:363: fill_bkg_rect(0, 0, 20, 18, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/gameplay.c:364: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:365: printf("LEVEL COMPLETE");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:366: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:367: printf("Press A to exit");
	ld	de, #___str_6
	push	de
	call	_printf
	pop	de
;src/gameplay.c:368: waitpadup();
	call	_waitpadup
;src/gameplay.c:369: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00185$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:370: break;
00112$:
;src/gameplay.c:373: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ld	hl, #201
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ld	hl, #179
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	NZ, 00115$
	ld	hl, #_player_noclip
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00115$:
;src/gameplay.c:374: prev_joy = joy;
	ld	hl, #199
	add	hl, sp
	ld	a, (hl)
	ld	hl, #177
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:376: uint16_t px_prev = cam_px >> 4;
	ld	hl, #212
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
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
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
;src/gameplay.c:377: uint8_t needs_render = 0;
	ld	(hl+), a
;src/gameplay.c:378: uint16_t need_col = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:379: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:382: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x000a
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	hl, #211
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x04
00580$:
	ld	hl, #208
	add	hl, sp
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00580$
	ld	hl, #212
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #210
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #208
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00123$
;src/gameplay.c:383: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x02ca
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #212
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:384: cam_px += scroll_acc >> 8;
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #212
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #214
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #213
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:385: scroll_acc &= 0xFF;
	ld	hl, #210
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #176
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:376: uint16_t px_prev = cam_px >> 4;
	ld	hl, #212
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
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
;src/gameplay.c:386: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:387: if (px_curr != px_prev) {
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00581$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00123$
00581$:
;src/gameplay.c:388: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #208
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #212
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:389: if (need > loaded_r && need < level_map_w) {
	ld	hl, #174
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #210
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
	ld	hl, #210
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #162
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:390: needs_render = 1;
	ld	hl, #204
	add	hl, sp
	ld	(hl), #0x01
;src/gameplay.c:391: need_col = need;
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	ld	hl, #206
	add	hl, sp
	ld	(hl), a
00123$:
;src/gameplay.c:396: player.world_x = cam_px;
	ld	hl, #212
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:399: if ((cam_px >> 4) != sp_cache_col) {
	ld	hl, #179
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00582$
	ld	hl, #180
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00125$
00582$:
;src/gameplay.c:400: sp_cache_update(l, cam_px, active_sp, &sp_stream_idx);
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #216
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #160
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:401: sp_cache_col = cam_px >> 4;
	ld	hl, #200
	add	hl, sp
	ld	a, (hl)
	ld	hl, #179
	add	hl, sp
	ld	(hl), a
	ld	hl, #201
	add	hl, sp
	ld	a, (hl)
	ld	hl, #180
	add	hl, sp
	ld	(hl), a
00125$:
;src/gameplay.c:404: if (player.reversed != prev_reversed) {
	ldhl	sp,	#15
	ld	c, (hl)
	ld	hl, #207
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jp	Z, 00132$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:408: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00217$
	ld	hl,#0xbd
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	jr	00218$
00217$:
	ld	hl,#0xbb
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
00218$:
	ld	e, c
;src/gameplay.c:409: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #166
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #161
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:412: uint16_t start_col = cam_px >> 4;
	ld	hl, #200
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:413: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #211
	add	hl, sp
	ld	(hl), #0x00
00210$:
;src/gameplay.c:414: uint16_t curr_col = start_col + i;
	ld	e, c
	ld	d, b
;src/gameplay.c:413: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00130$
;src/gameplay.c:414: uint16_t curr_col = start_col + i;
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	a, h
	ld	hl, #209
	add	hl, sp
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:415: if (curr_col < level_map_w) {
	ld	hl, #209
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #162
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00211$
;src/gameplay.c:416: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #209
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
;src/gameplay.c:379: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	h, (hl)
;src/gameplay.c:417: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	inc	h
	dec	h
	jr	Z, 00127$
	ld	e, a
	xor	a, a
	sub	a, e
	and	a, #0x0f
00127$:
;src/gameplay.c:418: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	push	hl
	inc	sp
	ld	hl, #170
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #166
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #164
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #217
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
	pop	bc
00211$:
;src/gameplay.c:413: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #211
	add	hl, sp
	inc	(hl)
	jr	00210$
00130$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:423: loaded_r = start_col + 15;
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #174
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
00132$:
;src/gameplay.c:426: uint16_t collision_col = cam_px >> 4;
	ld	hl, #200
	add	hl, sp
	ld	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	ld	hl, #201
	add	hl, sp
	ld	a, (hl)
	ld	hl, #211
	add	hl, sp
;src/gameplay.c:427: if (collision_col != cached_collision_col) {
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #181
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00584$
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	ld	hl, #182
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00134$
00584$:
;src/gameplay.c:429: level_map_bank, collision_columns);
	ld	hl, #124
	add	hl, sp
;src/gameplay.c:428: load_collision_columns(collision_col, level_map, level_map_w,
	push	hl
	ld	hl, #169
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #165
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #163
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #215
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:430: cached_collision_col = collision_col;
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
00134$:
;src/gameplay.c:432: died = player_update(&player, joy, collision_columns, level_map_h);
;src/gameplay.c:324: player_init(&player, 0, 240);
;src/gameplay.c:432: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #164
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #126
	add	hl, sp
	push	hl
	ld	hl, #203
	add	hl, sp
	ld	a, (hl)
	ld	hl, #9
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:434: py = player_screen_y(&player, cam_py);
	ld	hl, #170
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #5
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:435: if (py < CAM_Y_TOP_ZONE) {
	ld	hl, #207
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:438: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	hl, #172
	add	hl, sp
	ld	a, (hl)
	ld	hl, #209
	add	hl, sp
	ld	(hl), a
	ld	hl, #173
	add	hl, sp
	ld	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:435: if (py < CAM_Y_TOP_ZONE) {
	ld	hl, #207
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00585$
	bit	7, d
	jr	NZ, 00586$
	cp	a, a
	jr	00586$
00585$:
	bit	7, d
	jr	Z, 00586$
	scf
00586$:
	jr	NC, 00146$
;src/gameplay.c:436: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:437: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00136$
	ld	bc, #0x0000
00136$:
;src/gameplay.c:438: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #172
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00138$
	ld	hl, #209
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00138$:
;src/gameplay.c:439: cam_py = (uint16_t)target_cam_py;
	ld	hl, #170
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00147$
00146$:
;src/gameplay.c:441: else if (py > CAM_Y_BOTTOM_ZONE) {
	ld	hl, #207
	add	hl, sp
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00147$
;src/gameplay.c:442: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:443: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00140$
	ld	bc, #0x0000
00140$:
;src/gameplay.c:444: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #172
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00142$
	ld	hl, #209
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00142$:
;src/gameplay.c:445: cam_py = (uint16_t)target_cam_py;
	ld	hl, #170
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00147$:
;src/gameplay.c:450: if (player.reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/gameplay.c:452: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	ld	(hl), a
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #210
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #210
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0080
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #210
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #203
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:453: sprite_x_final = 128; // Mirrored player position
	ld	hl, #208
	add	hl, sp
	ld	(hl), #0x80
	jr	00150$
00149$:
;src/gameplay.c:455: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #212
	add	hl, sp
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
	ld	hl, #213
	add	hl, sp
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00219$
	ld	hl,#0xcf
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #210
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	jr	00220$
00219$:
	xor	a, a
	ld	hl, #209
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00220$:
	ld	hl, #209
	add	hl, sp
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #203
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:456: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	hl, #207
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00221$
	ld	hl, #212
	add	hl, sp
	ld	a, (hl)
	jr	00222$
00221$:
	ld	a, #0x20
00222$:
	ld	hl, #208
	add	hl, sp
	ld	(hl), a
00150$:
;src/gameplay.c:458: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #170
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #5
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ld	hl, #209
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:460: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:461: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #3
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #201
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:462: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #170
	add	hl, sp
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
	ld	hl, #202
	add	hl, sp
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	hl, #207
	add	hl, sp
	ld	a, (hl)
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:464: if (needs_render) {
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00154$
;src/gameplay.c:465: loaded_r = need_col;
	inc	hl
	ld	a, (hl)
	ld	hl, #174
	add	hl, sp
	ld	(hl), a
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	ld	hl, #175
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:466: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ld	hl, #205
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:379: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:468: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00152$
	xor	a, a
	ld	hl, #207
	add	hl, sp
	sub	a, (hl)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00152$:
;src/gameplay.c:469: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #168
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #164
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #211
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	_draw_mt_column
00154$:
;src/gameplay.c:472: uint8_t oam_index = process_and_draw_sprites(
	ld	hl,#0xbf
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	xor	a, a
	push	af
	inc	sp
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	hl, #202
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #9
	add	hl, sp
	push	hl
	ld	hl, #176
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #220
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #195
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_process_and_draw_sprites
	ld	hl, #206
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:477: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#14
;src/gameplay.c:379: uint8_t prev_reversed = player.reversed;
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
;src/gameplay.c:479: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x18
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:480: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #209
	add	hl, sp
	ld	a, (hl)
	add	a, #0x08
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:482: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #210
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:477: if (player.mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00174$
;src/gameplay.c:478: if (player.gravity_flipped) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jp	Z, 00162$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #208
	add	hl, sp
;src/gameplay.c:479: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	add	a, #0x18
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	hl, #204
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl+)
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ld	hl, #205
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #208
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00223$
	ld	bc, #0x0010
	jr	00224$
00223$:
	ld	bc, #0x0008
00224$:
	ld	hl, #210
	add	hl, sp
	ld	a, (hl-)
	sub	a, c
	ld	d, a
	ld	a, (hl-)
	dec	hl
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:479: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00156$:
;src/gameplay.c:480: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #206
	add	hl, sp
	ld	a, (hl+)
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ld	hl, #208
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00225$
	ld	hl, #204
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00226$
00225$:
	ld	hl, #204
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00226$:
	ld	hl, #210
	add	hl, sp
	ld	e, (hl)
	ld	hl, #204
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #209
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:480: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00162$:
;src/gameplay.c:482: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #207
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00159$
	inc	hl
	ld	b, (hl)
	ld	hl, #204
	add	hl, sp
	ld	c, (hl)
	ld	hl, #_ship_metasprites
	ld	a,	(hl+)
	ld	h, (hl)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	e, a
	ld	d, h
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ld	d, b
	ld	a, c
	add	a, #0xf8
	ld	e, a
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:482: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00159$:
;src/gameplay.c:483: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #208
	add	hl, sp
	ld	b, (hl)
	ld	hl, #205
	add	hl, sp
	ld	c, (hl)
	ld	hl, #_ship_metasprites
	ld	a,	(hl+)
	ld	h, (hl)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	e, a
	ld	d, h
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:483: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00174$:
;src/gameplay.c:486: if (player.gravity_flipped) {
	ldhl	sp,	#13
	ld	c, (hl)
;src/gameplay.c:480: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:486: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jp	Z, 00171$
;src/gameplay.c:487: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #207
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
	ld	hl, #210
	add	hl, sp
	ld	c, (hl)
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ld	hl, #208
	add	hl, sp
	ld	a, (hl)
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
	pop	af
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00227$
	ld	hl, #0x0010
	jr	00228$
00227$:
	ld	hl, #0x0008
00228$:
	ld	a, c
	sub	a, l
	ld	d, a
	ld	hl, #210
	add	hl, sp
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:487: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00165$:
;src/gameplay.c:488: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #208
	add	hl, sp
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	add	a, #0x16
	ld	c, a
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	e, a
	ld	d, l
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ld	d, b
	ld	a, c
	add	a, #0xf8
	ld	e, a
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:488: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jp	00175$
00171$:
;src/gameplay.c:490: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #207
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	inc	hl
	inc	hl
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #206
	add	hl, sp
	ld	a, (hl-)
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00229$
	ld	hl, #207
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00230$
00229$:
	ld	hl, #207
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00230$:
	ld	hl, #210
	add	hl, sp
	ld	e, (hl)
	ld	hl, #207
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #209
	add	hl, sp
	ld	e, (hl)
	ld	d, b
	ld	hl, #205
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:490: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	jr	00175$
00168$:
;src/gameplay.c:491: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #208
	add	hl, sp
	ld	b, (hl)
	ld	hl, #205
	add	hl, sp
	ld	c, (hl)
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	e, a
	ld	d, l
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:491: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #206
	add	hl, sp
	add	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
00175$:
;src/gameplay.c:496: if (oam_index < previous_oam_index) {
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #178
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00177$
;src/gameplay.c:497: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00177$:
;src/gameplay.c:499: previous_oam_index = oam_index;
	ld	hl, #210
	add	hl, sp
	ld	a, (hl)
	ld	hl, #178
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:352: sp_cache_reset(active_sp, &sp_stream_idx);
	ld	hl, #122
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #185
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #184
	add	hl, sp
	ld	(hl), a
	ld	hl, #26
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #187
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #186
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:501: if (died) {
	ld	hl, #211
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00184$
;src/gameplay.c:502: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:503: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:504: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:505: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:506: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:507: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:508: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:509: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:510: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:511: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00213$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00178$
	call	_wait_vbl_done
	inc	c
	jr	00213$
00178$:
;src/gameplay.c:512: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:513: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:514: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:515: if (level_songs[idx]) {
	ld	hl,#0xa8
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00180$
;src/gameplay.c:516: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xc1
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #213
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xc3
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #213
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
;src/gameplay.c:517: current_song_bank = song_bank[idx];
	ld	hl,#0xc3
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00180$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:521: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0xc5
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #212
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #166
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #161
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #213
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:523: cam_px = 0;
	xor	a, a
	ld	hl, #212
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:524: cam_py = 112;
	ld	hl, #170
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:525: scroll_acc = 0;
	ld	hl, #176
	add	hl, sp
;src/gameplay.c:526: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:527: target_bg_idx = 0;
	ldhl	sp,	#0
;src/gameplay.c:528: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #7
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:529: sp_cache_reset(active_sp, &sp_stream_idx);
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:530: sp_cache_col = 0xFFFF;
	ld	hl, #179
	add	hl, sp
;src/gameplay.c:531: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:532: cached_collision_col = 0xFFFF;
	ld	hl, #181
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:534: BGP_REG = bg_pals[0];
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:535: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #168
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #164
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #160
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:536: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:537: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:538: enable_interrupts();
	jp	00184$
00185$:
;src/gameplay.c:542: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:544: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:546: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:548: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:549: }
	add	sp, #127
	add	sp, #87
	ret
___str_5:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_6:
	.ascii "Press A to exit"
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
