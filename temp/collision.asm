;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module collision
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hUGE_init
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _col_at_begin
	.globl _col_at_end
	.globl _col_at_raw
	.globl _col_at_raw_cached
	.globl _col_at
	.globl _load_bkg_tileset
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
;src/collision.c:9: void col_at_begin(uint8_t map_bank) {
;	---------------------------------
; Function col_at_begin
; ---------------------------------
_col_at_begin::
	ld	c, a
;src/collision.c:10: if (_current_bank == map_bank) {
	ldh	a, (__current_bank + 0)
	sub	a, c
	jr	NZ, 00102$
;src/collision.c:11: _prev_map_bank = 0xFF;
	ld	hl, #__prev_map_bank
	ld	(hl), #0xff
;src/collision.c:12: return;
	ret
00102$:
;src/collision.c:14: _prev_map_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	(#__prev_map_bank),a
;src/collision.c:15: SWITCH_ROM(map_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/collision.c:16: }
	ret
;src/collision.c:18: void col_at_end(void) {
;	---------------------------------
; Function col_at_end
; ---------------------------------
_col_at_end::
;src/collision.c:19: if (_prev_map_bank != 0xFF) {
	ld	a, (#__prev_map_bank)
	inc	a
	ret	Z
;src/collision.c:20: SWITCH_ROM(_prev_map_bank);
	ld	a, (__prev_map_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:22: }
	ret
;src/collision.c:24: uint8_t col_at_raw(
;	---------------------------------
; Function col_at_raw
; ---------------------------------
_col_at_raw::
;src/collision.c:30: if ((uint16_t)world_py >= 256u) {
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
;src/collision.c:31: return (world_py < 0) ? COL_NONE : COL_ALL;
	bit	7, b
	jr	Z, 00107$
	xor	a, a
	jr	00105$
00107$:
	ld	a, #0x07
	jr	00105$
00102$:
;src/collision.c:33: uint16_t mx = world_px >> 4;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/collision.c:34: if (mx >= map_w) return COL_ALL;
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
;src/collision.c:36: return col_at_raw_cached(&map[mx << 4], (uint16_t)world_py);
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
;src/collision.c:37: }
	add	sp, #4
	pop	hl
	add	sp, #4
	jp	(hl)
;src/collision.c:39: uint8_t col_at_raw_cached(const uint8_t *col_ptr, uint16_t world_py) {
;	---------------------------------
; Function col_at_raw_cached
; ---------------------------------
_col_at_raw_cached::
;src/collision.c:40: uint8_t py8 = (uint8_t)world_py;
;src/collision.c:41: uint8_t col = famidash_metatile_collision[col_ptr[py8 >> 4]];
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
;src/collision.c:45: if ((py8 & 0x0F) < 8) return COL_NONE;
	ld	a, c
	and	a, #0x0f
	sub	a, #0x08
	ld	a, #0x00
	rla
	ld	c, a
;src/collision.c:43: if (col >= 0x10) {
;src/collision.c:44: if (col == COL_DEATH_TOP_HALF) {
	ld	a,b
	cp	a,#0x10
	jr	C, 00110$
;src/collision.c:45: if ((py8 & 0x0F) < 8) return COL_NONE;
	sub	a, #0x10
	jr	NZ, 00104$
	or	a, c
	jr	Z, 00102$
	xor	a, a
	ret
00102$:
;src/collision.c:46: return COL_DEATH;
	ld	a, #0x08
	ret
00104$:
;src/collision.c:48: if (col == COL_DEATH_BOTTOM_HALF) {
	ld	a, b
	sub	a, #0x11
	jr	NZ, 00110$
;src/collision.c:49: if ((py8 & 0x0F) >= 8) return COL_NONE;
	bit	0, c
	jr	NZ, 00106$
	xor	a, a
	ret
00106$:
;src/collision.c:50: return COL_DEATH;
	ld	a, #0x08
	ret
00110$:
;src/collision.c:53: if (col == COL_PAD) {
	ld	a, b
;src/collision.c:54: if ((py8 & 0x0F) < 8) return COL_NONE;
	sub	a, #0x0b
	jr	NZ, 00114$
	or	a, c
	jr	Z, 00114$
	xor	a, a
	ret
00114$:
;src/collision.c:57: return col;
	ld	a, b
;src/collision.c:58: }
	ret
;src/collision.c:61: uint8_t col_at(
;	---------------------------------
; Function col_at
; ---------------------------------
_col_at::
;src/collision.c:69: col_at_begin(map_bank);
	push	bc
	push	de
	ldhl	sp,	#10
	ld	a, (hl)
	call	_col_at_begin
	pop	de
	pop	bc
;src/collision.c:70: res = col_at_raw(world_px, world_py, map, map_w);
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
;src/collision.c:71: col_at_end();
	push	bc
	call	_col_at_end
	pop	bc
;src/collision.c:72: return res;
	ld	a, c
;src/collision.c:73: }
	pop	hl
	add	sp, #5
	jp	(hl)
;src/collision.c:77: void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count, uint8_t bank) {
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
	dec	sp
;src/collision.c:78: uint8_t _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/collision.c:79: SWITCH_ROM(bank);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:80: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/collision.c:81: set_bkg_data(0, 128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/collision.c:82: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00103$
00102$:
;src/collision.c:84: set_bkg_data(0, (uint8_t)tile_count, tiles);
	ld	a, c
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
00103$:
;src/collision.c:86: SWITCH_ROM(_prev);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:87: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;src/collision.c:89: void draw_mt_column(uint8_t ring_col, uint16_t map_col,
;	---------------------------------
; Function draw_mt_column
; ---------------------------------
_draw_mt_column::
	add	sp, #-4
;src/collision.c:92: uint8_t bx = ring_col << 1;
	add	a, a
	ldhl	sp,	#0
;src/collision.c:94: uint8_t _prev = _current_bank;
	ld	(hl+), a
	ldh	a, (__current_bank + 0)
	ld	(hl), a
;src/collision.c:95: SWITCH_ROM(map_bank);
	ldhl	sp,	#10
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/collision.c:97: const uint8_t *map_ptr = &map[(uint16_t)map_col << 4];
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
;src/collision.c:98: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ldhl	sp,	#3
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00101$
;src/collision.c:99: uint8_t mt = *map_ptr++;
	ld	a, (bc)
	ld	e, a
	inc	bc
;src/collision.c:100: uint8_t by = (r & (BKG_MT_H - 1)) << 1;
	ld	a, (hl-)
	and	a, #0x0f
	add	a, a
	ld	(hl), a
;src/collision.c:102: set_bkg_tiles(bx, by, 2, 1, metatiles[mt]);
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #_metatiles
	add	hl, de
	push	de
	push	hl
	ld	hl, #0x102
	push	hl
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/collision.c:103: set_bkg_tiles(bx, by + 1, 2, 1, metatiles[mt] + 2);
	ld	hl,#_metatiles + 1
	add	hl,de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl)
	inc	a
	push	de
	ld	h, #0x01
	push	hl
	inc	sp
	ld	h, #0x02
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/collision.c:98: for (uint8_t r = 0; r < BKG_MT_H; r++) {
	ldhl	sp,	#3
	inc	(hl)
	jr	00103$
00101$:
;src/collision.c:106: SWITCH_ROM(_prev);
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/collision.c:107: }
	add	sp, #4
	pop	hl
	add	sp, #5
	jp	(hl)
;src/collision.c:109: void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint8_t map_bank) {
;	---------------------------------
; Function fill_scroll_bg
; ---------------------------------
_fill_scroll_bg::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/collision.c:110: uint16_t cols = (map_w < 16) ? map_w : 16;
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
;src/collision.c:111: for (uint16_t c = 0; c < cols; c++) {
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
;src/collision.c:112: draw_mt_column((uint8_t)(c % 16), c, map, map_w, map_bank);
	ld	a, e
	and	a, #0x0f
	push	bc
	push	de
	ldhl	sp,	#10
	ld	h, (hl)
	push	hl
	inc	sp
	push	bc
	push	af
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	call	_draw_mt_column
	pop	de
	pop	bc
;src/collision.c:111: for (uint16_t c = 0; c < cols; c++) {
	inc	de
	jr	00103$
00105$:
;src/collision.c:114: }
	add	sp, #4
	pop	hl
	inc	sp
	jp	(hl)
;src/collision.c:120: void init_music_banked(const hUGESong_t * song, uint8_t bank, uint8_t divider) {
;	---------------------------------
; Function init_music_banked
; ---------------------------------
_init_music_banked::
	ld	c, a
;src/collision.c:121: uint8_t _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	b, a
;src/collision.c:122: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/collision.c:123: current_song_bank = bank;
	ld	hl, #_current_song_bank
	ld	(hl), c
;src/collision.c:124: SWITCH_ROM(bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/collision.c:126: hUGE_init(song);
	push	bc
	call	_hUGE_init
	pop	bc
;src/collision.c:127: TMA_REG = divider;
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(_TMA_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/collision.c:129: SWITCH_ROM(_prev);
	ld	a, b
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), b
;src/collision.c:130: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/collision.c:131: }
	pop	hl
	inc	sp
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
