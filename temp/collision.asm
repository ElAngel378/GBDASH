;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module collision
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hUGE_init
	.globl _queue_bg_column
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _draw_mt_column_immediate
	.globl _col_at_begin
	.globl _col_at_end
	.globl _col_at_raw
	.globl _col_at_raw_cached
	.globl _col_at
	.globl _load_bkg_tileset
	.globl _load_collision_columns
	.globl _prepare_mt_column
	.globl _draw_mt_column
	.globl _fill_scroll_bg
	.globl _init_music_banked
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
__prev_map_bank:
	.ds 1
_metatile_column_tiles:
	.ds 64
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
	.area _CODE
;src/collision.c:12: void draw_mt_column_immediate(
;	---------------------------------
; Function draw_mt_column_immediate
; ---------------------------------
_draw_mt_column_immediate::
	add	sp, #-10
;src/collision.c:22: uint8_t bx = ring_col << 1;
	add	a, a
	ldhl	sp,	#2
;src/collision.c:24: uint8_t _prev = _current_bank;
	ld	(hl+), a
	ldh	a, (__current_bank + 0)
	ld	(hl), a
;src/collision.c:25: SWITCH_ROM(map_bank);
	ldhl	sp,	#16
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:27: const uint8_t *map_ptr = &map[(uint16_t)map_col << 4];
	ld	a, e
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/collision.c:29: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00101$
;src/collision.c:30: const uint8_t *tiles =
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_metatiles_rev
	add	hl, bc
	ld	c, l
	ld	b, h
	jr	00108$
00107$:
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_metatiles
	add	hl, bc
	ld	c, l
	ld	b, h
00108$:
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;src/collision.c:34: uint8_t offset = r << 2;
	ld	a, b
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, a
	add	a, a
	ld	(hl), a
;src/collision.c:36: metatile_column_tiles[offset]     = tiles[0];
	ld	de, #_metatile_column_tiles
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
;src/collision.c:37: metatile_column_tiles[offset + 1] = tiles[1];
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	ld	a, (hl-)
	dec	hl
	inc	a
	add	a, #<(_metatile_column_tiles)
	ld	c, a
	ld	a, #0x00
	adc	a, #>(_metatile_column_tiles)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/collision.c:38: metatile_column_tiles[offset + 2] = tiles[2];
	ld	a, (hl+)
	ld	d, a
	inc	de
	ld	a, (de)
	ld	(bc), a
	ld	e, (hl)
	inc	e
	inc	e
	ld	d, #0x00
	ld	hl, #_metatile_column_tiles
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	pop	hl
	push	hl
	ld	(hl), a
;src/collision.c:39: metatile_column_tiles[offset + 3] = tiles[3];
	ldhl	sp,	#8
	inc	(hl)
	inc	(hl)
	inc	(hl)
	ld	a, (hl-)
	dec	hl
	add	a, #<(_metatile_column_tiles)
	ld	c, a
	ld	a, #0x00
	adc	a, #>(_metatile_column_tiles)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/collision.c:29: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	inc	(hl)
	jp	00103$
00101$:
;src/collision.c:42: SWITCH_ROM(_prev);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:50: metatile_column_tiles
;src/collision.c:46: bx,
	ld	de, #_metatile_column_tiles
	push	de
	ld	hl, #0x2002
	push	hl
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
;src/collision.c:52: }
	add	sp, #16
	pop	hl
	add	sp, #6
	jp	(hl)
;src/collision.c:55: void col_at_begin(uint8_t map_bank) {
;	---------------------------------
; Function col_at_begin
; ---------------------------------
_col_at_begin::
	ld	c, a
;src/collision.c:56: if (_current_bank == map_bank) {
	ldh	a, (__current_bank + 0)
	sub	a, c
	jr	NZ, 00102$
;src/collision.c:57: _prev_map_bank = 0xFF;
	ld	hl, #__prev_map_bank
	ld	(hl), #0xff
;src/collision.c:58: return;
	ret
00102$:
;src/collision.c:61: _prev_map_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	(#__prev_map_bank),a
;src/collision.c:62: SWITCH_ROM(map_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/collision.c:63: }
	ret
;src/collision.c:66: void col_at_end(void) {
;	---------------------------------
; Function col_at_end
; ---------------------------------
_col_at_end::
;src/collision.c:67: if (_prev_map_bank != 0xFF) {
	ld	a, (#__prev_map_bank)
	inc	a
	ret	Z
;src/collision.c:68: SWITCH_ROM(_prev_map_bank);
	ld	a, (__prev_map_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:70: }
	ret
;src/collision.c:73: uint8_t col_at_raw(
;	---------------------------------
; Function col_at_raw
; ---------------------------------
_col_at_raw::
;src/collision.c:79: if ((uint16_t)world_py >= 256u) {
	add	sp, #-2
	push	bc
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x00
	ld	a, (hl)
	sbc	a, #0x01
	jr	C, 00102$
;src/collision.c:80: return (world_py < 0) ? COL_NONE : COL_ALL;
	bit	7, b
	jr	Z, 00107$
	xor	a, a
	jr	00105$
00107$:
	ld	a, #0x07
	jr	00105$
00102$:
;src/collision.c:83: uint16_t mx = world_px >> 4;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/collision.c:85: if (mx >= map_w) return COL_ALL;
	ldhl	sp,	#8
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00104$
	ld	a, #0x07
	jr	00105$
00104$:
;src/collision.c:88: &map[mx << 4],
	ld	a, e
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	pop	bc
	push	bc
	call	_col_at_raw_cached
00105$:
;src/collision.c:91: }
	add	sp, #4
	pop	hl
	add	sp, #4
	jp	(hl)
;src/collision.c:94: uint8_t col_at_raw_cached(
;	---------------------------------
; Function col_at_raw_cached
; ---------------------------------
_col_at_raw_cached::
;src/collision.c:98: uint8_t py8 = (uint8_t)world_py;
;src/collision.c:100: uint8_t col =
	ld	a, c
	swap	a
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	b, (hl)
;src/collision.c:103: uint8_t inner_y = py8 & 0x0F;
	ld	a, c
	and	a, #0x0f
;src/collision.c:106: if (inner_y >= 8) return COL_NONE;
	sub	a, #0x08
	ld	a, #0x00
	rla
	ld	c, a
;src/collision.c:105: if (col == COL_TOP) {
	ld	a, b
	sub	a, #0x05
	jr	NZ, 00118$
;src/collision.c:106: if (inner_y >= 8) return COL_NONE;
	bit	0, c
	jr	NZ, 00119$
	xor	a, a
	ret
00118$:
;src/collision.c:108: else if (col == COL_BOTTOM) {
	ld	a, b
;src/collision.c:109: if (inner_y < 8) return COL_NONE;
	sub	a, #0x06
	jr	NZ, 00115$
	or	a, c
	jr	Z, 00119$
	xor	a, a
	ret
00115$:
;src/collision.c:111: else if (col == COL_DEATH_TOP_HALF) {
	ld	a, b
;src/collision.c:112: if (inner_y < 8) return COL_NONE;
	sub	a, #0x10
	jr	NZ, 00112$
	or	a, c
	jr	Z, 00106$
	xor	a, a
	ret
00106$:
;src/collision.c:113: return COL_DEATH;
	ld	a, #0x08
	ret
00112$:
;src/collision.c:115: else if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00119$
;src/collision.c:116: if (inner_y >= 8) return COL_NONE;
	bit	0, c
	jr	NZ, 00108$
	xor	a, a
	ret
00108$:
;src/collision.c:117: return COL_DEATH;
	ld	a, #0x08
	ret
00119$:
;src/collision.c:120: return col;
	ld	a, b
;src/collision.c:121: }
	ret
;src/collision.c:124: uint8_t col_at(
;	---------------------------------
; Function col_at
; ---------------------------------
_col_at::
;src/collision.c:133: col_at_begin(map_bank);
	push	bc
	push	de
	ldhl	sp,	#10
	ld	a, (hl)
	call	_col_at_begin
	pop	de
	pop	bc
;src/collision.c:135: world_px,
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_col_at_raw
	ld	c, a
;src/collision.c:140: col_at_end();
	push	bc
	call	_col_at_end
	pop	bc
;src/collision.c:142: return res;
	ld	a, c
;src/collision.c:143: }
	pop	hl
	add	sp, #5
	jp	(hl)
;src/collision.c:146: void load_bkg_tileset(
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
	dec	sp
;src/collision.c:151: uint8_t _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/collision.c:153: SWITCH_ROM(bank);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:155: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/collision.c:156: set_bkg_data(0, 128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/collision.c:157: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00103$
00102$:
;src/collision.c:162: (uint8_t)tile_count,
	ld	a, c
;src/collision.c:161: 0,
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
00103$:
;src/collision.c:167: SWITCH_ROM(_prev);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:168: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;src/collision.c:171: void load_collision_columns(
;	---------------------------------
; Function load_collision_columns
; ---------------------------------
_load_collision_columns::
	add	sp, #-6
;src/collision.c:178: uint8_t _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/collision.c:184: SWITCH_ROM(map_bank);
	ldhl	sp,	#10
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:186: left = &map[map_col << 4];
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;src/collision.c:189: (map_col + 1u < map_w)
	inc	de
	ldhl	sp,	#8
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00106$
;src/collision.c:191: : left;
	ld	hl, #0x0010
	add	hl, bc
	ld	e, l
	ld	a, h
	jr	00107$
00106$:
	ld	e, c
	ld	a, b
00107$:
	ldhl	sp,	#1
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/collision.c:193: for (i = 0; i < 16; i++) {
	ldhl	sp,	#5
	ld	(hl), #0x00
00102$:
;src/collision.c:194: columns[i]      = left[i];
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/collision.c:195: columns[i + 16] = right[i];
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x10
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#11
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
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/collision.c:193: for (i = 0; i < 16; i++) {
	ldhl	sp,	#5
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00102$
;src/collision.c:198: SWITCH_ROM(_prev);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:199: }
	add	sp, #6
	pop	hl
	add	sp, #5
	jp	(hl)
;src/collision.c:202: void prepare_mt_column(
;	---------------------------------
; Function prepare_mt_column
; ---------------------------------
_prepare_mt_column::
	add	sp, #-10
;src/collision.c:212: uint8_t bx = ring_col << 1;
	add	a, a
	ldhl	sp,	#2
;src/collision.c:217: uint8_t _prev = _current_bank;
	ld	(hl+), a
	ldh	a, (__current_bank + 0)
	ld	(hl), a
;src/collision.c:218: SWITCH_ROM(map_bank);
	ldhl	sp,	#16
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:220: const uint8_t *map_ptr =
	ld	a, e
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/collision.c:223: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00101$
;src/collision.c:224: const uint8_t *tiles =
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_metatiles_rev
	add	hl, bc
	ld	c, l
	ld	b, h
	jr	00108$
00107$:
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_metatiles
	add	hl, bc
	ld	c, l
	ld	b, h
00108$:
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;src/collision.c:228: uint8_t offset = r << 2;
	ld	a, b
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, a
	add	a, a
	ld	(hl), a
;src/collision.c:230: metatile_column_tiles[offset]     = tiles[0];
	ld	de, #_metatile_column_tiles
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
;src/collision.c:231: metatile_column_tiles[offset + 1] = tiles[1];
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	ld	a, (hl-)
	dec	hl
	inc	a
	add	a, #<(_metatile_column_tiles)
	ld	c, a
	ld	a, #0x00
	adc	a, #>(_metatile_column_tiles)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/collision.c:232: metatile_column_tiles[offset + 2] = tiles[2];
	ld	a, (hl+)
	ld	d, a
	inc	de
	ld	a, (de)
	ld	(bc), a
	ld	e, (hl)
	inc	e
	inc	e
	ld	d, #0x00
	ld	hl, #_metatile_column_tiles
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	pop	hl
	push	hl
	ld	(hl), a
;src/collision.c:233: metatile_column_tiles[offset + 3] = tiles[3];
	ldhl	sp,	#8
	inc	(hl)
	inc	(hl)
	inc	(hl)
	ld	a, (hl-)
	dec	hl
	add	a, #<(_metatile_column_tiles)
	ld	c, a
	ld	a, #0x00
	adc	a, #>(_metatile_column_tiles)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
;src/collision.c:223: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	inc	(hl)
	jp	00103$
00101$:
;src/collision.c:236: SWITCH_ROM(_prev);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:240: metatile_column_tiles
;src/collision.c:239: bx,
	ld	de, #_metatile_column_tiles
	ldhl	sp,	#2
	ld	a, (hl)
	call	_queue_bg_column
;src/collision.c:242: }
	add	sp, #10
	pop	hl
	add	sp, #6
	jp	(hl)
;src/collision.c:245: void draw_mt_column(
;	---------------------------------
; Function draw_mt_column
; ---------------------------------
_draw_mt_column::
;src/collision.c:254: ring_col,
	ldhl	sp,	#7
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#7
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#6
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ldhl	sp,	#6
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_prepare_mt_column
;src/collision.c:261: }
	pop	hl
	add	sp, #6
	jp	(hl)
;src/collision.c:264: void fill_scroll_bg(
;	---------------------------------
; Function fill_scroll_bg
; ---------------------------------
_fill_scroll_bg::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/collision.c:270: uint16_t cols =
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x10
	ld	a, d
	sbc	a, #0x00
	jr	C, 00108$
	ld	e, #0x10
00108$:
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
;src/collision.c:275: for (uint16_t c = 0; c < cols; c++) {
	ld	de, #0x0000
	ld	(hl), e
00103$:
	ldhl	sp,	#0
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00105$
;src/collision.c:277: (uint8_t)(c % 16),
	ld	a, e
	and	a, #0x0f
	push	bc
	push	de
	ldhl	sp,	#11
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#11
	ld	h, (hl)
	push	hl
	inc	sp
	push	bc
	push	af
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	call	_draw_mt_column_immediate
	pop	de
	pop	bc
;src/collision.c:275: for (uint16_t c = 0; c < cols; c++) {
	inc	de
	jr	00103$
00105$:
;src/collision.c:285: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/collision.c:294: void init_music_banked(
;	---------------------------------
; Function init_music_banked
; ---------------------------------
_init_music_banked::
	ld	c, a
;src/collision.c:299: uint8_t _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	b, a
;src/collision.c:301: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/collision.c:302: current_song_bank = bank;
	ld	hl, #_current_song_bank
	ld	(hl), c
;src/collision.c:304: SWITCH_ROM(bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/collision.c:307: hUGE_init(song);
	push	bc
	call	_hUGE_init
	pop	bc
;src/collision.c:308: TMA_REG = divider;
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(_TMA_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/collision.c:311: SWITCH_ROM(_prev);
	ld	a, b
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), b
;src/collision.c:313: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/collision.c:314: }
	pop	hl
	inc	sp
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
