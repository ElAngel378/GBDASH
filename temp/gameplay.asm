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
	.globl _flush_mt_column
	.globl _prepare_mt_column
	.globl _init_music_banked
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
	.globl _collision_columns
	.globl _active_sp
	.globl _sp_cache_reset
	.globl _sp_cache_update
	.globl b_setup_menu_font
	.globl _setup_menu_font
	.globl b_draw_text
	.globl _draw_text
	.globl b_draw_levels
	.globl _draw_levels
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
_famidash_bg_palettes:
	.ds 32
_active_sp::
	.ds 112
_collision_columns::
	.ds 32
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
	.area _CODE_10
;src/gameplay.c:173: static palette_color_t famidash_darker(palette_color_t color) {
;	---------------------------------
; Function famidash_darker
; ---------------------------------
_famidash_darker:
	push	de
;src/gameplay.c:174: return RGB((color & 0x1Fu) * 3u / 4u,
	ldhl	sp,	#1
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x1f
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	and	a, #0x1f
	add	a, a
	add	a, a
	ld	b, a
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	srl	e
	rr	d
	srl	e
	rr	d
	srl	e
	rr	d
	srl	e
	rr	d
	srl	e
	rr	d
	ld	a, d
	and	a, #0x1f
	ld	l, a
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	and	a, #0x1f
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, b
	ld	c, l
	or	a, h
	ld	b, a
	ldhl	sp,	#0
	ld	a, (hl+)
	and	a, #0x1f
	ld	l, a
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	and	a, #0x1f
	or	a, c
	ld	c, a
;src/gameplay.c:177: }
	inc	sp
	inc	sp
	ret
_nes_master_palette:
	.dw #0x294a
	.dw #0x4400
	.dw #0x4841
	.dw #0x4406
	.dw #0x3008
	.dw #0x180b
	.dw #0x0014
	.dw #0x0067
	.dw #0x00a4
	.dw #0x00e1
	.dw #0x0100
	.dw #0x00e0
	.dw #0x1cc0
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x5ad6
	.dw #0x4ce0
	.dw #0x74c6
	.dw #0x706b
	.dw #0x641b
	.dw #0x3054
	.dw #0x001b
	.dw #0x00ef
	.dw #0x016a
	.dw #0x01c5
	.dw #0x01e1
	.dw #0x15c0
	.dw #0x3d80
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x7fff
	.dw #0x7ee7
	.dw #0x7def
	.dw #0x7d96
	.dw #0x54ff
	.dw #0x597f
	.dw #0x31bf
	.dw #0x01ff
	.dw #0x029b
	.dw #0x030e
	.dw #0x0380
	.dw #0x3727
	.dw #0x6fa0
	.dw #0x1ce7
	.dw #0x0000
	.dw #0x0000
	.dw #0x7fff
	.dw #0x7f35
	.dw #0x7ef7
	.dw #0x7eda
	.dw #0x7ebf
	.dw #0x6abf
	.dw #0x5adf
	.dw #0x3f7f
	.dw #0x3f59
	.dw #0x3f76
	.dw #0x4b95
	.dw #0x5b93
	.dw #0x7354
	.dw #0x5294
	.dw #0x0000
	.dw #0x0000
_vibrant_palette_default:
	.dw #0x4ce0
	.dw #0x4400
	.dw #0x0000
	.dw #0x7fff
	.dw #0x294a
	.dw #0x4400
	.dw #0x4ce0
	.dw #0x7fff
	.dw #0x294a
	.dw #0x4400
	.dw #0x0000
	.dw #0x0380
	.dw #0x4ce0
	.dw #0x4400
	.dw #0x0000
	.dw #0x0000
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
;src/gameplay.c:179: static void famidash_reset_bg_palettes(void) {
;	---------------------------------
; Function famidash_reset_bg_palettes
; ---------------------------------
_famidash_reset_bg_palettes:
	dec	sp
;src/gameplay.c:181: for (i = 0; i != 16; i++) famidash_bg_palettes[i] = vibrant_palette_default[i];
	ldhl	sp,	#0
	ld	(hl), #0x00
00102$:
	ldhl	sp,	#0
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sla	e
	rl	d
	ld	hl, #_famidash_bg_palettes
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_vibrant_palette_default
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	ldhl	sp,	#0
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	NZ, 00102$
;src/gameplay.c:182: set_bkg_palette(0, 4, famidash_bg_palettes);
	ld	de, #_famidash_bg_palettes
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_palette
;src/gameplay.c:183: }
	add	sp, #5
	ret
;src/gameplay.c:185: static void famidash_apply_bg_trigger(uint8_t color_id) {
;	---------------------------------
; Function famidash_apply_bg_trigger
; ---------------------------------
_famidash_apply_bg_trigger:
;src/gameplay.c:188: if (color_id == 31u) color = RGB(0, 29, 27); /* FamiDash $9F: Use Aqua as default player color */
	ld	c, a
	sub	a, #0x1f
	jr	NZ, 00105$
	ld	bc, #0x6fa0
	jr	00106$
00105$:
;src/gameplay.c:189: else if (color_id == 46u) {                       /* FamiDash $AE: Ground Color 2 Trigger */
	ld	a, c
	sub	a, #0x2e
	jr	NZ, 00102$
;src/gameplay.c:191: famidash_bg_palettes[6] = color;
	ld	hl, #(_famidash_bg_palettes + 12)
	ld	a, #0x80
	ld	(hl+), a
;src/gameplay.c:192: famidash_bg_palettes[5] = famidash_darker(color);
	ld	de, #0x0380
	ld	(hl), d
	call	_famidash_darker
	ld	hl, #(_famidash_bg_palettes + 10)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:193: set_bkg_palette(0, 4, famidash_bg_palettes);
	ld	de, #_famidash_bg_palettes
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/gameplay.c:194: return;
	ret
00102$:
;src/gameplay.c:197: color = nes_master_palette[color_id & 0x3Fu];
	ld	de, #_nes_master_palette+0
	ld	a, c
	and	a, #0x3f
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00106$:
;src/gameplay.c:200: famidash_bg_palettes[0] = color;
	ld	hl, #_famidash_bg_palettes
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:201: color = famidash_darker(color);
	ld	e, c
	ld	d, b
	call	_famidash_darker
;src/gameplay.c:202: famidash_bg_palettes[1] = color;
	ld	hl, #(_famidash_bg_palettes + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:203: famidash_bg_palettes[9] = color;
	ld	hl, #(_famidash_bg_palettes + 18)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:204: famidash_bg_palettes[13] = color;
	ld	hl, #(_famidash_bg_palettes + 26)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:205: set_bkg_palette(0, 4, famidash_bg_palettes);
	ld	de, #_famidash_bg_palettes
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/gameplay.c:206: }
	ret
;src/gameplay.c:223: void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
;src/gameplay.c:225: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:226: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
	ld	hl, #0x0050
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, #0x00
00102$:
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0x00
	inc	e
	ld	a, e
	sub	a, #0x10
	jr	C, 00102$
;src/gameplay.c:227: }
	ret
_gbc_sprite_palettes:
	.dw #0x7fff
	.dw #0x7fe0
	.dw #0x03e0
	.dw #0x0000
	.dw #0x7fff
	.dw #0x0000
	.dw #0x03e0
	.dw #0x03e0
	.dw #0x7fff
	.dw #0x0000
	.dw #0x7fe0
	.dw #0x7fe0
	.dw #0x7fff
	.dw #0x0000
	.dw #0x03ff
	.dw #0x03ff
	.dw #0x7fff
	.dw #0x0000
	.dw #0x7d9f
	.dw #0x7d9f
	.dw #0x7fff
	.dw #0x0000
	.dw #0x001f
	.dw #0x001f
;src/gameplay.c:229: void sp_cache_update(const Level *l, uint16_t cam_px,
;	---------------------------------
; Function sp_cache_update
; ---------------------------------
_sp_cache_update::
	add	sp, #-24
	ldhl	sp,	#20
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#18
	ld	a, c
	ld	(hl+), a
;src/gameplay.c:233: uint8_t sp_bank = l->sp_bank;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#2
	ld	(hl), a
;src/gameplay.c:234: const SpDef *sp_list = l->sp_list;
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:237: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#23
	ld	(hl), #0x00
00115$:
;src/gameplay.c:238: if (!cache->active[i]) continue;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:239: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#23
	ld	a, (hl)
	add	a, a
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	de, #0x0020
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#18
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00105$
	xor	a, a
	ld	(bc), a
00105$:
;src/gameplay.c:237: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:243: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0060
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#22
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00116$:
;src/gameplay.c:244: if (cache->active[i]) {
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
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
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00117$
;src/gameplay.c:245: if (count != i) {
	ldhl	sp,	#22
	ld	a, (hl+)
	sub	a, (hl)
	jp	Z, 00108$
;src/gameplay.c:246: cache->obj[count] = cache->obj[i];
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;src/gameplay.c:247: cache->px[count] = cache->px[i];
	ldhl	sp,	#22
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#23
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:248: cache->py[count] = cache->py[i];
	ldhl	sp,	#17
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:249: cache->active[count] = cache->active[i];
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:250: cache->activated[count] = cache->activated[i];
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
00108$:
;src/gameplay.c:252: count++;
	ldhl	sp,	#22
	inc	(hl)
00117$:
;src/gameplay.c:243: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00116$
;src/gameplay.c:255: while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;
	dec	hl
	ld	c, (hl)
00112$:
	ld	a, c
	sub	a, #0x10
	jr	NC, 00114$
	ld	e, c
	inc	c
	ld	d, #0x00
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
	jr	00112$
00114$:
;src/gameplay.c:257: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	call	_sp_cache_load
;src/gameplay.c:258: }
	add	sp, #24
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:265: static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x1
; ---------------------------------
_draw_oam_2x1:
	add	sp, #-8
	push	de
	ldhl	sp,	#9
	ld	(hl), a
;src/gameplay.c:267: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ld	bc, #_shadow_OAM+0
	ldhl	sp,	#12
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;src/gameplay.c:270: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c,l
	ld	b,h
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	dec	hl
	dec	hl
	pop	de
	push	de
	inc	de
	inc	de
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	push	de
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/gameplay.c:271: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#8
	ld	(hl), a
;src/gameplay.c:269: if (!reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;src/gameplay.c:270: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl)
	ld	(bc), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, (de)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:271: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jr	00103$
00102$:
;src/gameplay.c:273: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (de)
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:274: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
	ldhl	sp,	#14
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:276: return 2;
	ld	a, #0x02
;src/gameplay.c:277: }
	add	sp, #10
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:283: static uint8_t draw_oam_2x2(uint8_t tile_base, uint8_t oam_idx,
;	---------------------------------
; Function draw_oam_2x2
; ---------------------------------
_draw_oam_2x2:
;src/gameplay.c:420: __endasm;
;	Build &shadow_OAM[oam_idx] while preserving tile_base in A.
	push	af
	xor	a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	pop	af
	ld	e, a ; E = tile_base
;	Save the OAM pointer while reading the stack arguments.
;	Stack after PUSH HL: saved OAM pointer, return address, sx, sy, reversed.
	push	hl
	ldhl	sp, #4
	ld	b, (hl) ; B = sx
	inc	hl
	ld	c, (hl) ; C = sy
	inc	hl
	ld	a, (hl)
	pop	hl ; Restore the OAM pointer.
	or	a
	jr	NZ, 00102$
;	Normal order: top-left, top-right, bottom-left, bottom-right.
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	hl
	ld	a, e
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	inc	hl
	ld	(hl), c
	inc	hl
	ld	a, b
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	add	#2
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	(hl), b
	inc	hl
	ld	a, e
	add	#4
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	a, b
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	add	#6
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	jr	00103$
00102$:
;	Mirror order: reverse columns and set horizontal flip.
	ld	(hl), c
	inc	hl
	ld	a, b
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
	inc	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	hl
	ld	a, e
	add	#2
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	a, b
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	add	#4
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	(hl), b
	inc	hl
	ld	a, e
	add	#6
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
00103$:
	ld	a, #4
	pop	hl ; Return address
	add	sp, #3 ; sy, sx, reversed
	jp	(hl)
;src/gameplay.c:421: }
;src/gameplay.c:424: static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x3
; ---------------------------------
_draw_oam_2x3:
	add	sp, #-12
	ldhl	sp,	#11
	ld	(hl), a
;src/gameplay.c:425: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#14
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;src/gameplay.c:428: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c,l
	ld	b,h
	inc	hl
	inc	sp
	inc	sp
	push	hl
	push	de
	ld	hl, #0x0002
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	push	de
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
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
;src/gameplay.c:429: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#15
;src/gameplay.c:430: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	a, (hl+)
	ld	e, (hl)
;src/gameplay.c:429: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	add	a, #0x08
	ldhl	sp,	#8
;src/gameplay.c:430: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, e
	add	a, #0x10
;src/gameplay.c:432: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, e
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:427: if (!reversed) {
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:428: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl-)
	ld	(bc), a
	pop	bc
	push	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:429: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:430: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:431: *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:432: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:433: *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00103$
00102$:
;src/gameplay.c:435: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	pop	bc
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:436: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#16
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:437: *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:438: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:439: *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:440: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:442: return 6;
	ld	a, #0x06
;src/gameplay.c:443: }
	add	sp, #12
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:446: static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_3x3
; ---------------------------------
_draw_oam_3x3:
	add	sp, #-13
	ldhl	sp,	#12
	ld	(hl), a
;src/gameplay.c:447: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#15
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;src/gameplay.c:450: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c,l
	ld	b,h
	inc	hl
	inc	sp
	inc	sp
	push	hl
	push	de
	ld	hl, #0x0002
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	push	de
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
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
;src/gameplay.c:451: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#16
;src/gameplay.c:454: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
;src/gameplay.c:451: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	a, d
	add	a, #0x08
	ldhl	sp,	#8
;src/gameplay.c:452: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, d
	add	a, #0x10
;src/gameplay.c:454: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, e
	add	a, #0x10
;src/gameplay.c:458: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, e
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:449: if (!reversed) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:450: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl-)
	ld	(bc), a
	pop	bc
	push	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:451: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:452: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:454: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:455: *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:456: *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:458: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:459: *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:460: *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00103$
00102$:
;src/gameplay.c:462: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
	pop	bc
	push	bc
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:463: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:464: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#17
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:466: *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:467: *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:468: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:470: *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:471: *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	inc	de
;src/gameplay.c:472: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ld	(bc), a
	inc	bc
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:475: return 9;
	ld	a, #0x09
;src/gameplay.c:476: }
	add	sp, #13
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:478: inline static uint8_t draw_oam_deco(const FamidashDeco *deco, uint8_t tile_base,
;	---------------------------------
; Function draw_oam_deco
; ---------------------------------
_draw_oam_deco:
	add	sp, #-17
	ld	c, e
	ld	b, d
	ldhl	sp,	#16
	ld	(hl), a
;src/gameplay.c:481: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#19
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	e, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ldhl	sp,	#0
	ld	(hl), e
	inc	hl
;src/gameplay.c:482: uint8_t count = deco->count;
	ld	(hl+), a
	ld	a, (bc)
	ld	(hl), a
;src/gameplay.c:483: const int8_t *dx = deco->x;
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:484: const int8_t *dy = deco->y;
	ld	hl, #0x0005
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:485: const uint8_t *dt = deco->tile;
	ld	hl, #0x0008
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/gameplay.c:486: const uint8_t *dp = deco->props;
	ld	hl, #0x000b
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:490: if (count > 1) {
	ld	a, #0x01
	ldhl	sp,	#2
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#14
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	ld	(hl), a
;src/gameplay.c:488: if (!reversed) {
	ldhl	sp,	#22
	ld	a, (hl)
	or	a, a
	jp	NZ, 00110$
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	pop	de
	push	de
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	pop	af
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(bc), a
	inc	bc
;src/gameplay.c:490: if (count > 1) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jp	Z, 00111$
;src/gameplay.c:491: *oam++ = sy + dy[1]; *oam++ = sx + dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1];
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#13
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#15
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	(bc), a
	inc	bc
;src/gameplay.c:492: if (count > 2) {
	ld	a, #0x02
	ldhl	sp,	#2
	sub	a, (hl)
	jp	NC, 00111$
;src/gameplay.c:493: *oam++ = sy + dy[2]; *oam++ = sx + dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2];
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#13
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#15
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00111$
00110$:
;src/gameplay.c:497: uint8_t rx = sx + deco->width - 8;
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#20
	add	a, (hl)
	add	a, #0xf8
;src/gameplay.c:498: *oam++ = sy + dy[0]; *oam++ = rx - dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0] ^ S_FLIPX;
	pop	de
	push	de
	push	af
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(de), a
	pop	af
	ldhl	sp,	#11
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl), a
	pop	af
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#12
	sub	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
;src/gameplay.c:499: if (count > 1) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
;src/gameplay.c:500: *oam++ = sy + dy[1]; *oam++ = rx - dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1] ^ S_FLIPX;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#13
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, e
	ld	(bc), a
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
;src/gameplay.c:501: if (count > 2) {
	ld	a, #0x02
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00111$
;src/gameplay.c:502: *oam++ = sy + dy[2]; *oam++ = rx - dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2] ^ S_FLIPX;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#13
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, e
	ld	(bc), a
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00111$:
;src/gameplay.c:506: return count;
	ldhl	sp,	#2
	ld	a, (hl)
;src/gameplay.c:507: }
	add	sp, #17
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:509: static void process_sprite_logic(
;	---------------------------------
; Function process_sprite_logic
; ---------------------------------
_process_sprite_logic:
	add	sp, #-69
	ldhl	sp,	#66
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#64
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:514: uint16_t px = p->world_x;
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:515: uint16_t py = p->world_y.b.h;
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
;src/gameplay.c:517: uint8_t player_col = (uint8_t)(px >> 4);
	xor	a, a
	ld	(hl+), a
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/gameplay.c:519: uint16_t p_front = px + 15u;
	ld	a, e
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:520: uint16_t p_bottom = py + PLAYER_SIZE;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), c
	inc	hl
;src/gameplay.c:521: uint16_t p_feet = py + PLAYER_SIZE;
	ld	(hl+), a
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:523: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0060
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#39
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#41
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#47
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#73
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#47
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#52
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#53
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl), a
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#58
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#68
	ld	(hl), #0x00
00222$:
;src/gameplay.c:524: if (!cache->active[i]) break;
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00223$
;src/gameplay.c:526: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#68
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#58
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#59
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:527: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x00b0
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#59
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00223$
;src/gameplay.c:529: uint8_t obj = cache->obj[i];
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#63
	ld	(hl), a
;src/gameplay.c:531: if (obj == OBJ_LEVEL_END) {
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:532: if (px >= (obj_x - 180u)) {
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00b4
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ldhl	sp,	#5
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00220$
;src/gameplay.c:533: p->level_complete = 1;
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;src/gameplay.c:535: continue;
	jp	00220$
00108$:
;src/gameplay.c:539: if (obj >= 38 && obj < 64) continue;
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x26
	jr	C, 00110$
	ld	a, (hl)
	sub	a, #0x40
	jp	C, 00220$
00110$:
;src/gameplay.c:542: if (obj >= 100 && obj <= 147 &&
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x64
	jp	C, 00130$
	ld	a, #0x93
	sub	a, (hl)
	jp	C, 00130$
;src/gameplay.c:543: obj != OBJ_MIRROR_EXIT && obj != OBJ_MIRROR_PORTAL) {
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00130$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00130$
;src/gameplay.c:545: if (!cache->activated[i]) {
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00126$
;src/gameplay.c:546: uint8_t obj_col = (uint8_t)(obj_x >> 4);
	ldhl	sp,#59
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
	ld	a, e
;src/gameplay.c:549: if (obj_col > BG_TRIGGER_LEAD_TILES) {
	cp	a, #0x0c
	jr	C, 00113$
;src/gameplay.c:550: trigger_col = obj_col - BG_TRIGGER_LEAD_TILES;
	add	a, #0xf5
	ld	e, a
	jr	00114$
00113$:
;src/gameplay.c:552: trigger_col = 0;
	ld	e, #0x00
00114$:
;src/gameplay.c:555: if (player_col >= trigger_col) {
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	jr	C, 00126$
;src/gameplay.c:556: uint8_t pal_idx = (uint8_t)(obj - 100);
	ldhl	sp,	#63
	ld	a, (hl)
	add	a, #0x9c
	ld	e, a
;src/gameplay.c:558: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00116$
;src/gameplay.c:559: famidash_apply_bg_trigger(pal_idx);
	push	bc
	push	de
	ld	a, e
	call	_famidash_apply_bg_trigger
	pop	de
	pop	bc
00116$:
;src/gameplay.c:563: *target_bg_idx = (pal_idx == 15) ? 3 : 2;
	ldhl	sp,	#74
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#75
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
;src/gameplay.c:562: if (pal_idx < 16) {
;src/gameplay.c:563: *target_bg_idx = (pal_idx == 15) ? 3 : 2;
	ld	a,e
	cp	a,#0x10
	jr	NC, 00121$
	sub	a, #0x0f
	ld	a, #0x03
	jr	Z, 00226$
	ld	a, #0x02
00226$:
	ldhl	sp,	#59
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00122$
00121$:
;src/gameplay.c:564: } else if (pal_idx < 32) {
	ld	a, e
	sub	a, #0x20
	jr	NC, 00118$
;src/gameplay.c:565: *target_bg_idx = 1;
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00122$
00118$:
;src/gameplay.c:567: *target_bg_idx = 0;
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00122$:
;src/gameplay.c:570: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
00126$:
;src/gameplay.c:574: if (obj_x > p_front + 16u) break;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#61
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	NC, 00220$
	jp	00223$
;src/gameplay.c:575: continue;
00130$:
;src/gameplay.c:578: uint16_t obj_y = cache->py[i];
	ldhl	sp,	#58
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#39
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:580: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00217$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00217$
;src/gameplay.c:582: if (obj_x <= p_front && px <= obj_x + 48u) {
	ldhl	sp,	#7
	ld	e, l
	ld	d, h
	ldhl	sp,	#59
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00220$
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
;src/gameplay.c:583: if (py <= obj_y + 14u && p_bottom >= obj_y) {
	ld	e, c
	ld	d, b
	ld	hl, #0x000e
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
	ldhl	sp,	#11
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00220$
;src/gameplay.c:584: if (!cache->activated[i]) {
	ldhl	sp,#54
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00220$
;src/gameplay.c:585: uint8_t target_flipped = (obj >= 18);
	inc	hl
	ld	a, (hl)
	sub	a, #0x12
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	c, a
;src/gameplay.c:586: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, c
	jr	Z, 00135$
;src/gameplay.c:587: p->gravity_flipped = target_flipped;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/gameplay.c:588: p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	sra	h
	rr	l
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
00135$:
;src/gameplay.c:590: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00220$
00217$:
;src/gameplay.c:594: } else if (obj_x + 2 <= p_front && px <= obj_x + 15) {
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ldhl	sp,	#7
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jp	C, 00213$
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00213$
;src/gameplay.c:595: switch (obj) {
	ldhl	sp,	#63
	ld	a, (hl)
	or	a, a
	jr	Z, 00146$
	ldhl	sp,	#63
	ld	a, (hl)
	dec	a
	jr	Z, 00146$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00146$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00852$
	xor	a, a
00852$:
	ldhl	sp,	#60
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00186$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00186$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00159$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00159$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00171$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00186$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00171$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00171$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00171$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00171$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00203$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00203$
	jp	00220$
;src/gameplay.c:598: case OBJ_BALL_PORTAL:
00146$:
;src/gameplay.c:600: if (py <= obj_y + 35 && p_bottom >= (obj_y - 3)) {
	ld	hl, #0x0023
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
	ld	a, c
	add	a, #0xfd
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00220$
;src/gameplay.c:601: if (!cache->activated[i]) {
	ldhl	sp,#52
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00220$
;src/gameplay.c:602: if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00151$
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00152$
00151$:
;src/gameplay.c:603: else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
	ldhl	sp,	#63
	ld	a, (hl)
	dec	a
	jr	NZ, 00148$
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00152$
00148$:
;src/gameplay.c:604: else p->mode = MODE_BALL;
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
00152$:
;src/gameplay.c:605: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:608: break;
	jp	00220$
;src/gameplay.c:611: case OBJ_GRAVITY_UP:
00159$:
;src/gameplay.c:613: if (py <= obj_y + 35 && p_bottom >= (obj_y - 3)) {
	ld	hl, #0x0023
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
	ld	a, c
	add	a, #0xfd
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00220$
;src/gameplay.c:614: if (!cache->activated[i]) {
	ldhl	sp,#50
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00220$
;src/gameplay.c:615: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	inc	hl
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00867$
	xor	a, a
00867$:
	ldhl	sp,	#63
	ld	(hl), a
;src/gameplay.c:616: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#63
	sub	a, (hl)
	jr	Z, 00161$
;src/gameplay.c:617: p->gravity_flipped = target_flipped;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#63
	ld	a, (hl)
	ld	(de), a
;src/gameplay.c:618: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	sra	b
	rr	c
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00161$:
;src/gameplay.c:620: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:623: break;
	jp	00220$
;src/gameplay.c:629: case OBJ_PAD_BLUE_UP:
00171$:
;src/gameplay.c:631: uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00228$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00228$
	xor	a, a
	jr	00229$
00228$:
	ld	a, #0x01
00229$:
	ld	e, a
;src/gameplay.c:583: if (py <= obj_y + 14u && p_bottom >= obj_y) {
	ldhl	sp,	#59
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/gameplay.c:632: uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
	or	a, a
	jr	Z, 00230$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	jr	00231$
00230$:
	push	de
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	pop	de
	ld	c, l
	ld	a, h
00231$:
	ldhl	sp,	#61
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:633: uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);
	ld	a, e
	or	a, a
	jr	Z, 00232$
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	jr	00233$
00232$:
	ldhl	sp,#59
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00233$:
;src/gameplay.c:635: if (py <= pad_bot && p_bottom >= pad_top) {
	ldhl	sp,	#2
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
	ldhl	sp,	#11
	ld	e, l
	ld	d, h
	ldhl	sp,	#61
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00220$
;src/gameplay.c:636: if (!cache->activated[i]) {
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00220$
;src/gameplay.c:637: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:588: p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
;src/gameplay.c:638: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00175$
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00176$
00175$:
;src/gameplay.c:639: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:640: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	or	a, a
	jr	Z, 00234$
	ld	bc, #0xfc60
	jr	00235$
00234$:
	ld	bc, #0x03a0
00235$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00177$
00176$:
;src/gameplay.c:641: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00173$
;src/gameplay.c:642: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00236$
	ld	bc, #0xfca0
	jr	00237$
00236$:
	ld	bc, #0xfaf0
00237$:
;src/gameplay.c:643: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00238$
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00238$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00177$
00173$:
;src/gameplay.c:645: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00240$
	ld	bc, #0xfb10
	jr	00241$
00240$:
	ld	bc, #0xf840
00241$:
;src/gameplay.c:646: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00242$
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00242$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00177$:
;src/gameplay.c:648: p->on_ground = 0;
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:651: break;
	jp	00220$
;src/gameplay.c:656: case OBJ_ORB_BLUE:
00186$:
;src/gameplay.c:658: if (joy & J_A) {
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jp	Z, 00220$
;src/gameplay.c:659: if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	bit	4, a
	jr	Z, 00198$
	ldhl	sp,#45
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00220$
00198$:
	ld	e, c
	ld	d, b
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00220$
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00220$
;src/gameplay.c:660: if (!cache->activated[i]) {
	ldhl	sp,#43
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00220$
;src/gameplay.c:661: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:662: p->orb_buffered = 0; // Clear buffer after hit
	ldhl	sp,	#45
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:588: p->vel_y.w = (p->vel_y.w >> 1); // Halve velocity
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
;src/gameplay.c:663: if (obj == OBJ_ORB_BLUE) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00191$
;src/gameplay.c:664: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:665: int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00244$
	ldhl	sp,	#59
	ld	a, #0xa0
	ld	(hl+), a
	ld	(hl), #0x01
	jr	00245$
00244$:
	ldhl	sp,	#59
	ld	a, #0xa0
	ld	(hl+), a
	ld	(hl), #0x03
00245$:
	ldhl	sp,	#59
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#60
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/gameplay.c:666: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00246$
	ld	de, #0x0000
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	(hl), e
	jr	00247$
00246$:
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
00247$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00192$
00191$:
;src/gameplay.c:667: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00188$
;src/gameplay.c:668: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00248$
	ld	bc, #0xfcd0
	jr	00249$
00248$:
	ld	bc, #0xfc30
00249$:
	inc	sp
	inc	sp
	push	bc
;src/gameplay.c:669: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00250$
	ld	de, #0x0000
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	(hl), e
	jr	00251$
00250$:
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
00251$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00192$
00188$:
;src/gameplay.c:671: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00252$
	ld	bc, #0xfbf0
	jr	00253$
00252$:
	ld	bc, #0xfa70
00253$:
;src/gameplay.c:672: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00254$
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00254$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00192$:
;src/gameplay.c:674: p->on_ground = 0;
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:678: break;
	jr	00220$
;src/gameplay.c:683: case OBJ_MIRROR_EXIT:
00203$:
;src/gameplay.c:684: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ld	e, c
	ld	d, b
	ld	hl, #0x0020
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00220$
	ldhl	sp,	#11
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00220$
;src/gameplay.c:685: if (!cache->activated[i]) {
	ldhl	sp,#41
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#68
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	NZ, 00220$
;src/gameplay.c:686: p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
	push	de
	ldhl	sp,#73
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x7e
	ld	a, #0x01
	jr	Z, 00257$
	xor	a, a
00257$:
	ld	(bc), a
;src/gameplay.c:687: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(de), a
;src/gameplay.c:691: }
	jr	00220$
00213$:
;src/gameplay.c:692: } else if (obj_x > p_front + 16) {
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#61
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00223$
;src/gameplay.c:693: break;
00220$:
;src/gameplay.c:523: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#68
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00222$
00223$:
;src/gameplay.c:696: }
	add	sp, #69
	pop	hl
	add	sp, #5
	jp	(hl)
;src/gameplay.c:698: static uint8_t draw_sprites(
;	---------------------------------
; Function draw_sprites
; ---------------------------------
_draw_sprites:
	add	sp, #-31
	ldhl	sp,	#27
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:706: uint8_t deco_max = (_cpu == CGB_TYPE) ? 12 : 4;
	ld	a, (#__cpu)
	sub	a, #0x11
	ld	a, #0x0c
	jr	Z, 00183$
	ld	a, #0x04
00183$:
	ldhl	sp,	#0
	ld	(hl), a
;src/gameplay.c:708: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#29
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00179$:
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00162$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00162$
;src/gameplay.c:709: if (!cache->active[i]) break;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00162$
;src/gameplay.c:711: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#30
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:712: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00b0
	add	hl, de
	ld	e, c
	ld	d, b
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jp	C, 00162$
;src/gameplay.c:714: uint8_t obj = cache->obj[i];
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl), a
;src/gameplay.c:715: if (obj == OBJ_LEVEL_END || obj >= 100) continue;
	ld	a, (hl)
	sub	a, #0x0f
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x64
	jp	NC, 00161$
;src/gameplay.c:720: dist_x = (uint8_t)obj_x - (uint8_t)cam_px;
	inc	hl
	ld	a, c
	ld	c, (hl)
	sub	a, c
;src/gameplay.c:723: if (dist_x > 176 && dist_x < 224) continue;
	cp	a, #0xb1
	jr	C, 00109$
	cp	a, #0xe0
	jp	C, 00161$
00109$:
;src/gameplay.c:726: screen_x = 128 - dist_x + 8;
	ld	c, a
;src/gameplay.c:725: if (reversed) {
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;src/gameplay.c:726: screen_x = 128 - dist_x + 8;
	ld	a, #0x88
	sub	a, c
	ldhl	sp,	#8
	ld	(hl), a
	jr	00113$
00112$:
;src/gameplay.c:728: screen_x = dist_x + PLAYER_SCREEN_X + 8;
	ld	a, c
	add	a, #0x28
	ldhl	sp,	#8
	ld	(hl), a
00113$:
;src/gameplay.c:731: screen_y = ((uint8_t)cache->py[i] - (uint8_t)cam_py) + 16;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#33
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#23
	ld	(hl), a
;src/gameplay.c:733: if (screen_x > 160 && screen_x < 232) continue;
	ld	a, #0xa0
	ldhl	sp,	#8
	sub	a, (hl)
	jr	NC, 00115$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00161$
00115$:
;src/gameplay.c:734: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#23
	sub	a, (hl)
	jr	NC, 00118$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00161$
00118$:
;src/gameplay.c:736: if (obj >= 38) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x26
	jp	C, 00130$
;src/gameplay.c:737: if (deco_drawn >= deco_max) continue;
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	jp	NC, 00161$
;src/gameplay.c:739: if (_cpu == CGB_TYPE && obj < 64) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jp	NZ, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x40
	jp	NC, 00161$
;src/gameplay.c:740: const FamidashDeco *deco = famidash_deco_table[obj];
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	ld	de, #_famidash_deco_table
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:741: if (deco) {
	ldhl	sp,	#10
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00161$
;src/gameplay.c:742: if (oam_start > MAX_HARDWARE_SPRITES - deco->count) break;
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl), a
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x28
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00472$
	bit	7, d
	jr	NZ, 00473$
	cp	a, a
	jr	00473$
00472$:
	bit	7, d
	jr	Z, 00473$
	scf
00473$:
	jp	C, 00162$
;src/gameplay.c:743: deco_drawn++;
	ldhl	sp,	#29
	inc	(hl)
;src/gameplay.c:745: oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#36
	ld	e, (hl)
;src/gameplay.c:481: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:482: uint8_t count = deco->count;
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:483: const int8_t *dx = deco->x;
	ldhl	sp,#9
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
;src/gameplay.c:484: const int8_t *dy = deco->y;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src/gameplay.c:485: const uint8_t *dt = deco->tile;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
;src/gameplay.c:486: const uint8_t *dp = deco->props;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl-), a
	ld	a, (hl-)
	ld	(hl), a
;src/gameplay.c:490: if (count > 1) {
	ld	a, #0x01
	ldhl	sp,	#13
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#23
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	ld	(hl), a
;src/gameplay.c:488: if (!reversed) {
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jp	NZ, 00172$
;src/gameplay.c:489: *oam++ = sy + dy[0]; *oam++ = sx + dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0];
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#24
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	pop	af
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:490: if (count > 1) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00173$
;src/gameplay.c:491: *oam++ = sy + dy[1]; *oam++ = sx + dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1];
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#22
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#24
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	de
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	(bc), a
	inc	bc
;src/gameplay.c:492: if (count > 2) {
	ld	a, #0x02
	ldhl	sp,	#13
	sub	a, (hl)
	jp	NC, 00173$
;src/gameplay.c:493: *oam++ = sy + dy[2]; *oam++ = sx + dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2];
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#22
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#24
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	de
	inc	de
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00173$
00172$:
;src/gameplay.c:497: uint8_t rx = sx + deco->width - 8;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	inc	de
	ld	a, (de)
	add	a, (hl)
	add	a, #0xf8
;src/gameplay.c:498: *oam++ = sy + dy[0]; *oam++ = rx - dx[0]; *oam++ = dt[0] + tile_base; *oam++ = dp[0] ^ S_FLIPX;
	ldhl	sp,	#11
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	pop	af
	ldhl	sp,#14
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl), a
	pop	af
	ldhl	sp,	#24
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#12
	sub	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:499: if (count > 1) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00173$
;src/gameplay.c:500: *oam++ = sy + dy[1]; *oam++ = rx - dx[1]; *oam++ = dt[1] + tile_base; *oam++ = dp[1] ^ S_FLIPX;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#22
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, e
	ld	(bc), a
	inc	bc
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	de
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	inc	bc
;src/gameplay.c:501: if (count > 2) {
	ld	a, #0x02
	ldhl	sp,	#13
	sub	a, (hl)
	jr	NC, 00173$
;src/gameplay.c:502: *oam++ = sy + dy[2]; *oam++ = rx - dx[2]; *oam++ = dt[2] + tile_base; *oam++ = dp[2] ^ S_FLIPX;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#22
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, e
	ld	(bc), a
	inc	bc
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	de
	inc	de
	ld	a, (de)
	add	a, #0x70
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00173$:
;src/gameplay.c:745: oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#36
	add	a, (hl)
	ld	(hl), a
;src/gameplay.c:748: continue;
	jp	00161$
00130$:
;src/gameplay.c:751: if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
	ld	a, #0x1f
	ldhl	sp,	#36
	sub	a, (hl)
	jp	C, 00162$
;src/gameplay.c:752: const metasprite_t *sprite = famidash_sprite_table[obj];
	ldhl	sp,	#24
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	ld	de, #_famidash_sprite_table
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#21
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:753: if (sprite == 0) continue;
	ldhl	sp,	#22
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00161$
;src/gameplay.c:756: if (_cpu != CGB_TYPE && (
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	Z, 00136$
;src/gameplay.c:757: obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00161$
;src/gameplay.c:758: obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00161$
;src/gameplay.c:759: obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK)) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00161$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00161$
;src/gameplay.c:760: continue;
00136$:
;src/gameplay.c:763: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00158$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00158$
;src/gameplay.c:745: oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
;src/gameplay.c:764: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	Z, 00146$
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x70
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00184$
	ldhl	sp,	#20
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00185$
00184$:
	ldhl	sp,	#20
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00185$:
	ldhl	sp,	#23
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#20
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:764: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#36
	add	a, (hl)
	ld	(hl), a
	jp	00161$
00146$:
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ldhl	sp,	#21
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#22
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x70
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:765: else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#24
	add	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	jp	00161$
00158$:
;src/gameplay.c:766: } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00152$
	ld	a, (hl)
	dec	a
	jr	Z, 00152$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00153$
00152$:
;src/gameplay.c:767: oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#24
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x70
	ldhl	sp,	#25
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_3x3
	ldhl	sp,	#36
	add	a, (hl)
	ld	(hl), a
	jr	00161$
00153$:
;src/gameplay.c:768: } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00148$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00149$
00148$:
;src/gameplay.c:769: oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#24
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x70
	ldhl	sp,	#25
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x3
	ldhl	sp,	#36
	add	a, (hl)
	ld	(hl), a
	jr	00161$
00149$:
;src/gameplay.c:771: oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#24
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x70
	ldhl	sp,	#25
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x1
	ldhl	sp,	#36
	add	a, (hl)
	ld	(hl), a
00161$:
;src/gameplay.c:708: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#30
	inc	(hl)
	jp	00179$
00162$:
;src/gameplay.c:774: return oam_start;
	ldhl	sp,	#36
	ld	a, (hl)
;src/gameplay.c:775: }
	add	sp, #31
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:777: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 10
_setup_menu_font::
;src/gameplay.c:778: set_bkg_data(FONT_PUSAB_START, 39, FontPusab);
	ld	de, #_FontPusab
	push	de
	ld	hl, #0x27d0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/gameplay.c:779: }
	ret
;src/gameplay.c:781: void draw_text(uint8_t x, uint8_t y, const char *str) BANKED {
;	---------------------------------
; Function draw_text
; ---------------------------------
	b_draw_text	= 10
_draw_text::
	dec	sp
;src/gameplay.c:783: while (*str) {
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00122$:
	ld	a, (bc)
	or	a, a
	jr	Z, 00125$
;src/gameplay.c:784: char c = *str;
;src/gameplay.c:785: if (c == ' ') tile = 0;
	ld	l, a
	sub	a, #0x20
	jr	NZ, 00120$
	xor	a, a
	jr	00121$
00120$:
;src/gameplay.c:786: else if (c == '%') tile = 1;
	ld	a, l
	sub	a, #0x25
	jr	NZ, 00117$
	ld	a, #0x01
	jr	00121$
00117$:
;src/gameplay.c:787: else if (c == '/') tile = 2;
	ld	a, l
	sub	a, #0x2f
	jr	NZ, 00114$
	ld	a, #0x02
	jr	00121$
00114$:
;src/gameplay.c:788: else if (c >= '0' && c <= '9') tile = (c - '0') + 3;
	ld	a, l
	xor	a, #0x80
	sub	a, #0xb0
	jr	C, 00110$
	ld	a, #0x39
	sub	a, l
	jr	C, 00110$
	ld	a, l
	add	a, #0xd3
	jr	00121$
00110$:
;src/gameplay.c:789: else if (c >= 'A' && c <= 'Z') tile = (c - 'A') + 13;
	ld	a, l
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00106$
	ld	a, #0x5a
	sub	a, l
	jr	C, 00106$
	ld	a, l
	add	a, #0xcc
	jr	00121$
00106$:
;src/gameplay.c:790: else if (c >= 'a' && c <= 'z') tile = (c - 'a') + 13;
	ld	a, l
	xor	a, #0x80
	sub	a, #0xe1
	jr	C, 00102$
	ld	a, #0x7a
	sub	a, l
	jr	C, 00102$
	ld	a, l
	add	a, #0xac
	jr	00121$
00102$:
;src/gameplay.c:791: else tile = 0;
	xor	a, a
00121$:
;src/gameplay.c:792: set_bkg_tile_xy(x++, y, FONT_PUSAB_START + tile);
	add	a, #0xd0
	ld	e, a
	ldhl	sp,	#0
	ld	d, (hl)
	inc	(hl)
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	push	bc
	ld	a, e
	push	af
	inc	sp
	ld	e, (hl)
	ld	a, d
	call	_set_bkg_tile_xy
	pop	bc
;src/gameplay.c:793: str++;
	inc	bc
	jr	00122$
00125$:
;src/gameplay.c:795: }
	inc	sp
	ret
;src/gameplay.c:797: void draw_levels(void) BANKED {
;	---------------------------------
; Function draw_levels
; ---------------------------------
	b_draw_levels	= 10
_draw_levels::
;src/gameplay.c:798: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
;src/gameplay.c:803: set_bkg_palette(0, 1, menu_pal);
	ld	de, #_draw_levels_menu_pal_30000_416
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/gameplay.c:807: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/gameplay.c:808: fill_bkg_rect(0, 0, 32, 32, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x20
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/gameplay.c:809: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
00102$:
;src/gameplay.c:811: BGP_REG = 0x2F; // Inverted Palette: White=00, Light Gray=Dark Gray(10), Dark Gray=Black(11), Black=Black(11)
	ld	a, #0x2f
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:812: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:813: draw_text(0, 0, "LEVEL SELECT");
	ld	de, #___str_0
	push	de
	xor	a, a
	rrca
	push	af
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/gameplay.c:814: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00108$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
	ld	a, c
	sub	a, b
	jr	NC, 00106$
;src/gameplay.c:816: draw_text(1, 2 + i, "0"); // cursor icon
	ld	b, c
;src/gameplay.c:817: draw_text(3, 2 + i, game_levels[i]->name);
	ld	l, c
	xor	a, a
;src/gameplay.c:816: draw_text(1, 2 + i, "0"); // cursor icon
	inc	b
	inc	b
;src/gameplay.c:817: draw_text(3, 2 + i, game_levels[i]->name);
	ld	h, a
	add	hl, hl
;src/gameplay.c:815: if (i == selected) {
	ld	a, (_selected)
	sub	a, c
	jr	NZ, 00104$
;src/gameplay.c:816: draw_text(1, 2 + i, "0"); // cursor icon
	push	hl
	push	bc
	ld	de, #___str_1
	push	de
	ld	c, #0x01
	push	bc
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
	pop	bc
	pop	hl
;src/gameplay.c:817: draw_text(3, 2 + i, game_levels[i]->name);
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
	ld	c, #0x03
	push	bc
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
	pop	bc
	jr	00109$
00104$:
;src/gameplay.c:819: draw_text(3, 2 + i, game_levels[i]->name);
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
	ld	c, #0x03
	push	bc
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
	pop	bc
00109$:
;src/gameplay.c:814: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00108$
00106$:
;src/gameplay.c:822: draw_text(0, 16, "PRESS START TO PLAY");
	ld	de, #___str_2
	push	de
	ld	hl, #0x1000
	push	hl
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/gameplay.c:823: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:824: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:825: }
	ret
_draw_levels_menu_pal_30000_416:
	.dw #0x1442
	.dw #0x498c
	.dw #0x7f39
	.dw #0x7fff
___str_0:
	.ascii "LEVEL SELECT"
	.db 0x00
___str_1:
	.ascii "0"
	.db 0x00
___str_2:
	.ascii "PRESS START TO PLAY"
	.db 0x00
;src/gameplay.c:831: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 10
_play_level::
	add	sp, #-84
;src/gameplay.c:841: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ldhl	sp,	#90
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#82
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
	ldhl	sp,	#30
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:842: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:843: level_map = l->map;
	ld	(hl-), a
	dec	hl
	dec	hl
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
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:844: level_tile_count = l->tile_count;
	ldhl	sp,#30
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
	ldhl	sp,	#36
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:845: level_map_w = l->map_width;
	ldhl	sp,#30
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
	ldhl	sp,	#38
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:846: level_map_h = l->map_height;
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#40
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:847: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:848: level_map_bank = l->map_bank;
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#43
	ld	(hl), a
;src/gameplay.c:849: if (_cpu == CGB_TYPE) level_tiles = chr_gb_cgb_tiles;
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
	ldhl	sp,	#32
	ld	a, #<(_chr_gb_cgb_tiles)
	ld	(hl+), a
	ld	(hl), #>(_chr_gb_cgb_tiles)
00102$:
;src/gameplay.c:851: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:852: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:853: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:855: if (level_songs[idx]) {
	ld	de, #_level_songs
	ldhl	sp,	#82
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
	jr	Z, 00104$
;src/gameplay.c:856: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#83
	ld	(hl), a
	ld	de, #_song_bank+0
	ldhl	sp,	#90
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ldhl	sp,	#85
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:857: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:858: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00104$:
;src/gameplay.c:861: uint16_t cam_px = 0;
	xor	a, a
	ldhl	sp,	#82
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:862: uint16_t cam_py = 112;
	ldhl	sp,	#46
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:863: uint16_t cam_py_max = (level_map_h << 4);
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	b, (hl)
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
;src/gameplay.c:864: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	c, a
	ld	a, #0x90
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00106$
	ld	a, c
	add	a, #0x70
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ldhl	sp,	#48
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00107$
00106$:
;src/gameplay.c:865: else cam_py_max = 0;
	xor	a, a
	ldhl	sp,	#48
	ld	(hl+), a
	ld	(hl), a
00107$:
;src/gameplay.c:866: uint16_t loaded_r = BKG_MT_W - 1;
	ldhl	sp,	#50
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:871: uint8_t target_bg_idx = 0;
	ldhl	sp,	#0
;src/gameplay.c:872: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	a, #0x39
	ld	(hl+), a
	ld	a, #0x3e
	ld	(hl+), a
	ld	(hl), #0x3f
;src/gameplay.c:880: player_init(&player, 0, 240);
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
;src/gameplay.c:883: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:884: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#42
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:885: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:886: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:887: set_sprite_data(12, 4, ball_tiles);
	ld	de, #_ball_tiles
	push	de
	ld	hl, #0x40c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:888: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x5c70
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:890: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#44
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:892: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00109$
;src/gameplay.c:895: famidash_reset_bg_palettes();
	call	_famidash_reset_bg_palettes
;src/gameplay.c:896: set_sprite_palette(0, 6, gbc_sprite_palettes);
	ld	de, #_gbc_sprite_palettes
	push	de
	ld	hl, #0x600
	push	hl
	call	_set_sprite_palette
	add	sp, #4
00109$:
;src/gameplay.c:899: BGP_REG = bg_pals[0];
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:900: OBP0_REG = bg_pals[0];
	ld	a, (hl)
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:901: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:902: OBP1_REG = bg_pals[0];
	ld	a, (hl)
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:903: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:904: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:905: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:906: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:909: uint16_t scroll_acc = 0;
	ldhl	sp,	#52
;src/gameplay.c:910: uint8_t prev_joy = 0;
;src/gameplay.c:911: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:912: uint16_t sp_stream_idx = 0;
	xor	a, a
	ldhl	sp,	#28
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:913: uint16_t sp_cache_col = 0xFFFF;
	ldhl	sp,	#55
;src/gameplay.c:914: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:915: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#59
;src/gameplay.c:916: uint8_t reduce_flash = 0;
	ld	(hl+), a
	ld	(hl), #0x00
;src/gameplay.c:917: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #28
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	de, #_active_sp
	call	_sp_cache_reset
;src/gameplay.c:918: while (1) {
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#65
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#64
	ld	(hl), a
	ld	de, #_song_bank
	ldhl	sp,	#90
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#67
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#66
	ld	(hl), a
00211$:
;src/gameplay.c:919: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#77
	ld	(hl), a
;src/gameplay.c:920: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#79
	bit	7, (hl)
	pop	hl
	jp	NZ, 00212$
;src/gameplay.c:922: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ldhl	sp,	#79
	bit	2, (hl)
	pop	hl
	jr	NZ, 00115$
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jp	Z, 00116$
00115$:
;src/gameplay.c:923: HIDE_SPRITES;
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
;src/gameplay.c:926: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:928: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/gameplay.c:929: fill_bkg_rect(0, 0, 32, 32, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x20
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/gameplay.c:930: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/gameplay.c:931: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:932: draw_text(3, 6, "LEVEL COMPLETE");
	ld	de, #___str_3
	push	de
	ld	a, #0x06
	push	af
	inc	sp
	ld	a, #0x03
	push	af
	inc	sp
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/gameplay.c:933: draw_text(3, 12, "PRESS A TO EXIT");
	ld	de, #___str_4
	push	de
	ld	a, #0x0c
	push	af
	inc	sp
	ld	a, #0x03
	push	af
	inc	sp
	ld	e, #b_draw_text
	ld	hl, #_draw_text
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/gameplay.c:934: waitpadup();
	call	_waitpadup
;src/gameplay.c:935: while (!(joypad() & J_A)) wait_vbl_done();
00112$:
	call	_joypad
	bit	4, a
	jp	NZ, 00212$
	call	_wait_vbl_done
	jr	00112$
;src/gameplay.c:936: break;
00116$:
;src/gameplay.c:940: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ldhl	sp,	#79
	bit	5, (hl)
	pop	hl
	jr	Z, 00119$
	push	hl
	ldhl	sp,	#55
	bit	5, (hl)
	pop	hl
	jr	NZ, 00119$
	ld	hl, #_player_noclip
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00119$:
;src/gameplay.c:941: if ((joy & J_SELECT) && !(prev_joy & J_SELECT)) {
	push	hl
	ldhl	sp,	#79
	bit	6, (hl)
	pop	hl
	jr	Z, 00122$
	push	hl
	ldhl	sp,	#55
	bit	6, (hl)
	pop	hl
	jr	NZ, 00122$
;src/gameplay.c:942: reduce_flash = !reduce_flash;
	ldhl	sp,	#60
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00122$:
;src/gameplay.c:944: prev_joy = joy;
	ldhl	sp,	#77
	ld	a, (hl)
	ldhl	sp,	#53
	ld	(hl), a
;src/gameplay.c:946: uint16_t px_prev = cam_px >> 4;
	ldhl	sp,	#82
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#79
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
	ld	(hl), a
;src/gameplay.c:947: uint8_t needs_render = 0;
	ldhl	sp,	#67
;src/gameplay.c:948: uint16_t need_col = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:951: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	c, (hl)
	add	a, #0xf6
	ld	l, a
	ld	a, c
	adc	a, #0xff
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#82
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	NC, 00130$
;src/gameplay.c:952: scroll_acc += SCROLL_SPEED_FP;
	ldhl	sp,	#52
	ld	a, (hl)
	ldhl	sp,	#78
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
	ldhl	sp,	#77
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#76
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#79
	ld	(hl), a
;src/gameplay.c:953: cam_px += scroll_acc >> 8;
	ld	a, (hl)
	ldhl	sp,	#75
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#82
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#84
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#83
	ld	(hl), a
;src/gameplay.c:954: scroll_acc &= 0xFF;
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#52
	ld	(hl), c
;src/gameplay.c:946: uint16_t px_prev = cam_px >> 4;
	ldhl	sp,	#82
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#79
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
;src/gameplay.c:955: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:956: if (px_curr != px_prev) {
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00711$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00130$
00711$:
;src/gameplay.c:957: uint16_t need = px_curr + VIEW_MT_W;
	ldhl	sp,	#75
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
	ldhl	sp,	#82
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#81
	ld	(hl), a
;src/gameplay.c:958: if (need > loaded_r && need < level_map_w) {
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#80
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00130$
	ldhl	sp,	#80
	ld	e, l
	ld	d, h
	ldhl	sp,	#38
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00130$
;src/gameplay.c:959: needs_render = 1;
	ldhl	sp,	#67
	ld	(hl), #0x01
;src/gameplay.c:960: need_col = need;
	ldhl	sp,	#80
	ld	a, (hl)
	ldhl	sp,	#68
	ld	(hl), a
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#69
	ld	(hl), a
00130$:
;src/gameplay.c:965: player.world_x = cam_px;
	ldhl	sp,	#82
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:917: sp_cache_reset(&active_sp, &sp_stream_idx);
;src/gameplay.c:968: if ((cam_px >> 4) != sp_cache_col) {
	ldhl	sp,	#78
	ld	a, (hl)
	ldhl	sp,	#55
	sub	a, (hl)
	jr	NZ, 00712$
	ldhl	sp,	#79
	ld	a, (hl)
	ldhl	sp,	#56
	sub	a, (hl)
	jr	Z, 00132$
00712$:
;src/gameplay.c:969: sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
	ld	hl, #28
	add	hl, sp
	push	hl
	ld	de, #_active_sp
	push	de
	ldhl	sp,	#86
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:970: sp_cache_col = cam_px >> 4;
	ldhl	sp,	#78
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl), a
	ldhl	sp,	#79
	ld	a, (hl)
	ldhl	sp,	#56
	ld	(hl), a
00132$:
;src/gameplay.c:975: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	ldhl	sp,	#0
	push	hl
	ldhl	sp,	#79
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #8
	add	hl, sp
	push	hl
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_active_sp
	call	_process_sprite_logic
;src/gameplay.c:977: if (player.reversed != prev_reversed) {
	ldhl	sp,	#15
	ld	c, (hl)
	ldhl	sp,	#59
	ld	a, (hl)
	sub	a, c
	jp	Z, 00139$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:981: const uint8_t* target_tiles = player.reversed
	ld	a, c
	or	a, a
	jr	Z, 00248$
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00250$
	ld	bc, #_chr_gb_cgb_tiles_rev
	jr	00251$
00250$:
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
00251$:
	ld	e, c
	ld	d, b
	jr	00249$
00248$:
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00249$:
;src/gameplay.c:984: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#42
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:987: uint16_t start_col = cam_px >> 4;
	ldhl	sp,	#78
	ld	a, (hl)
	ldhl	sp,	#75
	ld	(hl), a
	ldhl	sp,	#79
	ld	a, (hl)
	ldhl	sp,	#76
	ld	(hl), a
;src/gameplay.c:988: for (uint8_t i = 0; i < 16; i++) {
	ldhl	sp,	#81
	ld	(hl), #0x00
00241$:
;src/gameplay.c:989: uint16_t curr_col = start_col + i;
	ldhl	sp,	#75
	ld	a, (hl)
	ldhl	sp,	#79
	ld	(hl), a
	ldhl	sp,	#76
	ld	a, (hl)
	ldhl	sp,	#80
;src/gameplay.c:988: for (uint8_t i = 0; i < 16; i++) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00137$
;src/gameplay.c:989: uint16_t curr_col = start_col + i;
	ld	a, (hl-)
	ld	c, a
	ld	b, #0x00
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#78
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:990: if (curr_col < level_map_w) {
	ldhl	sp,	#78
	ld	e, l
	ld	d, h
	ldhl	sp,	#38
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00242$
;src/gameplay.c:991: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ldhl	sp,	#78
	ld	a, (hl+)
	inc	hl
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:915: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	b, (hl)
;src/gameplay.c:992: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, b
	or	a, a
	jr	Z, 00134$
	ldhl	sp,	#80
	xor	a, a
	sub	a, (hl)
	ld	c, a
	and	a, #0x0f
	ld	(hl), a
00134$:
;src/gameplay.c:993: prepare_mt_column(curr_col, level_map, level_map_bank, player.reversed);
	push	bc
	inc	sp
	ldhl	sp,	#44
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#80
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_prepare_mt_column
;src/gameplay.c:994: flush_mt_column(vram_slot);
	ldhl	sp,	#80
	ld	a, (hl)
	call	_flush_mt_column
00242$:
;src/gameplay.c:988: for (uint8_t i = 0; i < 16; i++) {
	ldhl	sp,	#81
	inc	(hl)
	jr	00241$
00137$:
;src/gameplay.c:998: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:999: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1000: set_sprite_data(12, 4, ball_tiles);
	ld	de, #_ball_tiles
	push	de
	ld	hl, #0x40c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1001: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x5c70
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:1004: loaded_r = start_col + 15;
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#50
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:1005: prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
00139$:
;src/gameplay.c:1008: uint16_t collision_col = cam_px >> 4;
	ldhl	sp,#82
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
;src/gameplay.c:1009: if (collision_col != cached_collision_col) {
	ldhl	sp,	#57
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00716$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	Z, 00141$
00716$:
;src/gameplay.c:1011: level_map_bank, collision_columns);
;src/gameplay.c:1010: load_collision_columns(collision_col, level_map, level_map_w,
	push	de
	ld	bc, #_collision_columns
	push	bc
	ldhl	sp,	#47
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_load_collision_columns
	pop	de
;src/gameplay.c:1012: cached_collision_col = collision_col;
	ldhl	sp,	#57
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00141$:
;src/gameplay.c:1015: died = player_update(&player, joy, collision_columns, level_map_h);
;src/gameplay.c:880: player_init(&player, 0, 240);
;src/gameplay.c:1015: died = player_update(&player, joy, collision_columns, level_map_h);
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #_collision_columns
	push	de
	ldhl	sp,	#81
	ld	a, (hl)
	ld	hl, #9
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ldhl	sp,	#70
	ld	(hl), a
;src/gameplay.c:1017: py = player_screen_y(&player, cam_py);
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #5
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:1018: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#80
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00717$
	bit	7, d
	jr	NZ, 00718$
	cp	a, a
	jr	00718$
00717$:
	bit	7, d
	jr	Z, 00718$
	scf
00718$:
	jr	NC, 00153$
;src/gameplay.c:1019: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x0014
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#81
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:1020: if (target_cam_py < 0) target_cam_py = 0;
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#81
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00143$
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00143$:
;src/gameplay.c:1021: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ldhl	sp,	#80
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00145$
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#80
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
00145$:
;src/gameplay.c:1022: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#80
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
	jr	00154$
00153$:
;src/gameplay.c:1024: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#80
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00154$
;src/gameplay.c:1025: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:1026: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00147$
	ld	bc, #0x0000
00147$:
;src/gameplay.c:1027: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ldhl	sp,	#48
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00149$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00149$:
;src/gameplay.c:1028: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#46
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00154$:
;src/gameplay.c:1033: if (player.reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
;src/gameplay.c:1035: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ldhl	sp,	#82
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	a, c
	add	a, #0x80
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ldhl	sp,	#71
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:1036: sprite_x_final = 128; // Mirrored player position
	ldhl	sp,	#81
	ld	(hl), #0x80
	jr	00157$
00156$:
;src/gameplay.c:1038: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ldhl	sp,	#82
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00252$
	ldhl	sp,#80
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	jr	00253$
00252$:
	xor	a, a
	ld	c, a
00253$:
	ldhl	sp,	#71
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:1039: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ldhl	sp,	#80
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00254$
	inc	hl
	ld	a, (hl)
	jr	00255$
00254$:
	ld	a, #0x20
00255$:
	ldhl	sp,	#81
	ld	(hl), a
00157$:
;src/gameplay.c:1041: int16_t final_py = player_screen_y(&player, cam_py);
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #5
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ldhl	sp,	#76
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:1043: uint8_t oam_index = draw_sprites(
	ldhl	sp,	#15
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#86
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_active_sp
	call	_draw_sprites
	ldhl	sp,	#73
	ld	(hl), a
;src/gameplay.c:1048: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl), a
;src/gameplay.c:915: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#79
	ld	(hl), a
;src/gameplay.c:1050: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ldhl	sp,	#76
	ld	a, (hl)
	ldhl	sp,	#80
;src/gameplay.c:1048: if (player.mode == MODE_SHIP) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	dec	a
	jp	NZ, 00189$
;src/gameplay.c:1049: if (player.gravity_flipped) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jp	Z, 00165$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	c, a
;src/gameplay.c:1050: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ldhl	sp,	#79
	ld	a, (hl)
	or	a, a
	jr	Z, 00159$
	inc	hl
	ld	a, (hl)
	add	a, #0x18
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	push	af
	ldhl	sp,	#75
	ld	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	pop	af
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), b
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	a, c
	or	a, a
	jr	Z, 00256$
	ld	de, #0x0010
	jr	00257$
00256$:
	ld	de, #0x0008
00257$:
	ldhl	sp,	#80
	ld	a, (hl+)
	sub	a, e
	ld	b, a
	ld	a, (hl-)
	dec	hl
	add	a, #0xf8
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:1050: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00159$:
;src/gameplay.c:1051: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ldhl	sp,	#80
	ld	a, (hl)
	add	a, #0x20
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	push	af
	ldhl	sp,	#75
	ld	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	pop	af
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), b
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ld	a, c
	or	a, a
	jr	Z, 00258$
	ld	de, #0x0010
	jr	00259$
00258$:
	ld	de, #0x0008
00259$:
	ldhl	sp,	#80
	ld	a, (hl+)
	sub	a, e
	ld	b, a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:1051: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00165$:
;src/gameplay.c:1053: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ldhl	sp,	#80
	ld	a, (hl-)
	add	a, #0x10
	ld	b, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00162$
	inc	hl
	inc	hl
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ldhl	sp,	#81
	ld	a, (hl)
	add	a, #0xf8
	ld	e, a
	ld	d, b
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:1053: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00162$:
;src/gameplay.c:1054: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#81
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
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
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1054: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00189$:
;src/gameplay.c:1056: } else if (player.mode == MODE_BALL) {
	ldhl	sp,	#78
	ld	a, (hl)
	sub	a, #0x02
	jp	NZ, 00186$
;src/gameplay.c:1057: if (player.gravity_flipped) {
	ldhl	sp,	#13
	ld	c, (hl)
;src/gameplay.c:1051: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ldhl	sp,	#81
	ld	a, (hl)
	add	a, #0x08
;src/gameplay.c:1053: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:1057: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00174$
;src/gameplay.c:1058: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	inc	hl
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	hl, #_ball_metasprites
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
	ld	hl, #___current_base_tile
	ld	(hl), #0x0c
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1058: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00168$:
;src/gameplay.c:1059: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#80
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	hl, #_ball_metasprites
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
	ld	hl, #___current_base_tile
	ld	(hl), #0x0c
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1059: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00174$:
;src/gameplay.c:1061: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#79
	ld	a, (hl)
	or	a, a
	jr	Z, 00171$
	inc	hl
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	hl, #_ball_metasprites
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
	ld	hl, #___current_base_tile
	ld	(hl), #0x0c
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1061: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00171$:
;src/gameplay.c:1062: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#80
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	hl, #_ball_metasprites + 1
	ld	a,	(hl-)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	e, (hl)
	ld	d, a
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x0c
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1062: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00186$:
;src/gameplay.c:1065: if (player.gravity_flipped) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jp	Z, 00183$
;src/gameplay.c:1066: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ldhl	sp,	#79
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
	inc	hl
	ld	a, (hl+)
	add	a, #0x20
	ld	c, a
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ldhl	sp,	#16
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ldhl	sp,	#75
	ld	a, (hl)
	ldhl	sp,	#82
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
	jr	Z, 00260$
	ld	de, #0x0010
	jr	00261$
00260$:
	ld	de, #0x0008
00261$:
	ld	a, c
	sub	a, e
	ld	b, a
	ldhl	sp,	#81
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:1066: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00177$:
;src/gameplay.c:1067: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ldhl	sp,	#80
	ld	a, (hl+)
	add	a, #0x10
	ld	c, a
	ld	a, (hl)
	add	a, #0x16
	ld	b, a
	ldhl	sp,	#16
	ld	l, (hl)
	xor	a, a
	ld	h, a
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
	ld	d, c
	ld	a, b
	add	a, #0xf8
	ld	e, a
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:1067: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jp	00190$
00183$:
;src/gameplay.c:1069: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ldhl	sp,	#79
	ld	a, (hl)
	or	a, a
	jp	Z, 00180$
	inc	hl
	ld	a, (hl+)
	add	a, #0x20
	ld	c, a
	ld	a, (hl)
	add	a, #0x0a
	ldhl	sp,	#74
	ld	(hl), a
	ldhl	sp,	#16
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ldhl	sp,	#75
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	pop	af
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
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
	jr	Z, 00262$
	ldhl	sp,	#76
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00263$
00262$:
	ldhl	sp,	#76
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00263$:
	ldhl	sp,	#78
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#76
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#81
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#74
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#77
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#80
	ld	(hl), a
	ldhl	sp,	#77
	ld	a, (hl)
	ldhl	sp,	#81
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#75
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:1069: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
	jr	00190$
00180$:
;src/gameplay.c:1070: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#80
	ld	a, (hl)
	add	a, #0x10
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_icon1_metasprites
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#80
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#79
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	(hl-), a
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#79
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#80
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#77
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#80
	ld	a, (hl)
	ldhl	sp,	#76
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#80
	ld	(hl), a
	ldhl	sp,	#76
	ld	a, (hl)
	ldhl	sp,	#81
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#73
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:1070: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#73
	add	a, (hl)
	ldhl	sp,	#81
	ld	(hl), a
00190$:
;src/gameplay.c:1075: if (oam_index < previous_oam_index) {
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#54
	sub	a, (hl)
	jr	NC, 00192$
;src/gameplay.c:1076: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ldhl	sp,	#81
	ld	a, (hl)
	call	_hide_sprites_range
00192$:
;src/gameplay.c:1078: previous_oam_index = oam_index;
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
;src/gameplay.c:1080: uint8_t vram_slot = 0;
	ldhl	sp,	#81
	ld	(hl), #0x00
;src/gameplay.c:1081: if (needs_render) {
	ldhl	sp,	#67
	ld	a, (hl)
	or	a, a
	jr	Z, 00196$
;src/gameplay.c:1082: loaded_r = need_col;
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#69
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
;src/gameplay.c:1083: vram_slot = (uint8_t)(need_col & 15);
	ldhl	sp,	#68
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#81
	ld	(hl), a
;src/gameplay.c:915: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#15
	ld	c, (hl)
;src/gameplay.c:1084: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, c
	or	a, a
	jr	Z, 00194$
	ldhl	sp,	#81
	xor	a, a
	sub	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00194$:
;src/gameplay.c:1087: prepare_mt_column(need_col, level_map, level_map_bank, player.reversed);
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#44
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_prepare_mt_column
00196$:
;src/gameplay.c:1090: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:1091: uint8_t apply_idx = target_bg_idx;
	ldhl	sp,	#0
	ld	e, (hl)
;src/gameplay.c:1092: if (reduce_flash && (apply_idx == 1 || apply_idx == 2)) {
	ldhl	sp,	#60
	ld	a, (hl)
	or	a, a
	jr	Z, 00198$
	ld	a, e
	dec	a
	jr	Z, 00197$
	ld	a, e
	sub	a, #0x02
	jr	NZ, 00198$
00197$:
;src/gameplay.c:1093: apply_idx = 0;
	ld	e, #0x00
00198$:
;src/gameplay.c:1095: BGP_REG = bg_pals[apply_idx];
	ld	d, #0x00
	ld	hl, #1
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:1096: OBP0_REG = bg_pals[apply_idx];
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:1097: OBP1_REG = bg_pals[apply_idx];
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:1098: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ldhl	sp,	#46
	ld	c, (hl)
	ldhl	sp,	#71
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:1100: if (needs_render) {
	ldhl	sp,	#67
	ld	a, (hl)
	or	a, a
	jr	Z, 00202$
;src/gameplay.c:1102: flush_mt_column(vram_slot);
	ldhl	sp,	#81
	ld	a, (hl)
	call	_flush_mt_column
00202$:
;src/gameplay.c:1105: if (died) {
	ldhl	sp,	#70
	ld	a, (hl)
	or	a, a
	jp	Z, 00211$
;src/gameplay.c:1106: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:1107: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:1108: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:1109: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:1110: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:1111: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:1112: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:1113: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:1114: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:1115: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00244$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00203$
	call	_wait_vbl_done
	inc	c
	jr	00244$
00203$:
;src/gameplay.c:1116: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:1117: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:1118: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:1119: if (level_songs[idx]) {
	ldhl	sp,#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00205$
;src/gameplay.c:1120: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#63
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
;src/gameplay.c:1121: current_song_bank = song_bank[idx];
	ldhl	sp,#65
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00205$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:1124: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:1131: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#42
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:1134: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1135: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1136: set_sprite_data(12, 4, ball_tiles);
	ld	de, #_ball_tiles
	push	de
	ld	hl, #0x40c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1137: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x5c70
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:1139: cam_px = 0;
	xor	a, a
	ldhl	sp,	#82
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:1140: cam_py = 112;
	ldhl	sp,	#46
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:1141: scroll_acc = 0;
	ldhl	sp,	#52
;src/gameplay.c:1142: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:1143: target_bg_idx = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/gameplay.c:1144: player_init(&player, 0, 240);
	ld	hl, #5
	add	hl, sp
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:1145: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #28
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	de, #_active_sp
	call	_sp_cache_reset
;src/gameplay.c:1146: sp_cache_col = 0xFFFF;
	ldhl	sp,	#55
;src/gameplay.c:1147: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:1148: cached_collision_col = 0xFFFF;
	ldhl	sp,	#57
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:1150: BGP_REG = bg_pals[0];
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:1151: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00207$
;src/gameplay.c:1155: famidash_reset_bg_palettes();
	call	_famidash_reset_bg_palettes
00207$:
;src/gameplay.c:1157: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#44
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:1158: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:1159: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:1160: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:1161: enable_interrupts();
	jp	00211$
00212$:
;src/gameplay.c:1165: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:1167: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:1169: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:1171: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:1172: }
	add	sp, #84
	ret
___str_3:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_4:
	.ascii "PRESS A TO EXIT"
	.db 0x00
	.area _CODE_10
	.area _INITIALIZER
	.area _CABS (ABS)
