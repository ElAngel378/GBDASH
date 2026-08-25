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
	.globl _printf
	.globl _gotoxy
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
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
	.area _CODE_10
;src/gameplay.c:63: void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
;src/gameplay.c:65: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:66: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
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
;src/gameplay.c:67: }
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
;src/gameplay.c:69: void sp_cache_update(const Level *l, uint16_t cam_px,
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
;src/gameplay.c:73: uint8_t sp_bank = l->sp_bank;
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
;src/gameplay.c:74: const SpDef *sp_list = l->sp_list;
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
;src/gameplay.c:77: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
	ldhl	sp,	#17
	ld	(hl), #0x00
00115$:
;src/gameplay.c:78: if (!cache->active[i]) continue;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
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
	ld	c, a
;src/gameplay.c:79: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#24
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#23
	ld	(hl), a
;src/gameplay.c:78: if (!cache->active[i]) continue;
	ld	a, c
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:79: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
	ldhl	sp,	#17
	ld	a, (hl-)
	add	a, a
	ld	(hl), a
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#18
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00105$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00105$:
;src/gameplay.c:77: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#17
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:83: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
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
;src/gameplay.c:84: if (cache->active[i]) {
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
;src/gameplay.c:85: if (count != i) {
	ldhl	sp,	#22
	ld	a, (hl+)
	sub	a, (hl)
	jp	Z, 00108$
;src/gameplay.c:86: cache->obj[count] = cache->obj[i];
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
;src/gameplay.c:87: cache->px[count] = cache->px[i];
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
;src/gameplay.c:88: cache->py[count] = cache->py[i];
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
;src/gameplay.c:89: cache->active[count] = cache->active[i];
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
;src/gameplay.c:90: cache->activated[count] = cache->activated[i];
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
;src/gameplay.c:92: count++;
	ldhl	sp,	#22
	inc	(hl)
00117$:
;src/gameplay.c:83: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00116$
;src/gameplay.c:95: while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;
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
;src/gameplay.c:97: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
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
;src/gameplay.c:98: }
	add	sp, #24
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:104: static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x1
; ---------------------------------
_draw_oam_2x1:
	add	sp, #-19
	ldhl	sp,	#16
	ld	(hl), a
;src/gameplay.c:105: OAM_item_t *itm = &shadow_OAM[oam_idx];
	ldhl	sp,	#21
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:107: itm->y=sy; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	inc	sp
	inc	sp
	push	bc
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	push	de
	ld	hl, #0x0002
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
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	push	de
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:108: itm->y=sy; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props;
	ldhl	sp,	#22
;src/gameplay.c:106: if (!reversed) {
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	c, a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;src/gameplay.c:107: itm->y=sy; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	dec	hl
	pop	de
	push	de
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/gameplay.c:108: itm->y=sy; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props;
	ldhl	sp,	#23
	ld	a, (hl)
	ld	(de), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), c
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#16
	add	a, (hl)
	inc	hl
	ld	(bc), a
	inc	de
	inc	de
	inc	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	(de), a
	jr	00103$
00102$:
;src/gameplay.c:110: itm->y=sy; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	pop	de
	push	de
	ldhl	sp,	#23
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, #0x20
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:111: itm->y=sy; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX;
	ldhl	sp,	#23
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#16
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:113: return 2;
	ld	a, #0x02
;src/gameplay.c:114: }
	add	sp, #19
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:116: static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x3
; ---------------------------------
_draw_oam_2x3:
	add	sp, #-22
	ldhl	sp,	#19
	ld	(hl), a
;src/gameplay.c:117: OAM_item_t *itm = &shadow_OAM[oam_idx];
	ldhl	sp,	#24
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:119: itm->y=sy;    itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	inc	sp
	inc	sp
	push	bc
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	push	de
	ld	hl, #0x0002
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
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	push	de
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:120: itm->y=sy;    itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#25
;src/gameplay.c:121: itm->y=sy+16; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	a, (hl+)
	ld	c, (hl)
;src/gameplay.c:120: itm->y=sy;    itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	add	a, #0x08
	ldhl	sp,	#16
;src/gameplay.c:121: itm->y=sy+16; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	ld	a, c
	add	a, #0x10
;src/gameplay.c:123: itm->y=sy+32; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	ld	a, c
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:118: if (!reversed) {
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:119: itm->y=sy;    itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	dec	hl
	pop	de
	push	de
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#19
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:120: itm->y=sy;    itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#16
	ld	a, (hl-)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:121: itm->y=sy+16; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
;src/gameplay.c:122: itm->y=sy+16; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl-)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:123: itm->y=sy+32; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
;src/gameplay.c:124: itm->y=sy+32; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props;
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00103$
00102$:
;src/gameplay.c:126: itm->y=sy;    itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	pop	de
	push	de
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#19
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, #0x20
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:127: itm->y=sy;    itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#26
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:128: itm->y=sy+16; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#17
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
;src/gameplay.c:129: itm->y=sy+16; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:130: itm->y=sy+32; itm->x=sx+8; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
;src/gameplay.c:131: itm->y=sy+32; itm->x=sx;   itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX;
	ld	(hl+), a
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:133: return 6;
	ld	a, #0x06
;src/gameplay.c:134: }
	add	sp, #22
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:136: static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_3x3
; ---------------------------------
_draw_oam_3x3:
	add	sp, #-23
	ldhl	sp,	#20
	ld	(hl), a
;src/gameplay.c:137: OAM_item_t *itm = &shadow_OAM[oam_idx];
	ldhl	sp,	#25
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:139: itm->y=sy;    itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	inc	sp
	inc	sp
	push	bc
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	push	de
	ld	hl, #0x0002
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
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	push	de
	ld	hl, #0x0003
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:140: itm->y=sy;    itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#26
;src/gameplay.c:142: itm->y=sy+16; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
;src/gameplay.c:140: itm->y=sy;    itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#16
;src/gameplay.c:141: itm->y=sy;    itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	ld	a, b
	add	a, #0x10
;src/gameplay.c:142: itm->y=sy+16; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	ld	a, c
	add	a, #0x10
;src/gameplay.c:145: itm->y=sy+32; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ld	(hl+), a
	ld	a, c
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:138: if (!reversed) {
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:139: itm->y=sy;    itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	dec	hl
	pop	de
	push	de
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#20
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:140: itm->y=sy;    itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#27
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#16
	ld	a, (hl-)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:141: itm->y=sy;    itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#27
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:142: itm->y=sy+16; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:143: itm->y=sy+16; itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:144: itm->y=sy+16; itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:145: itm->y=sy+32; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:146: itm->y=sy+32; itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props; itm++; meta++;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#16
	ld	a, (hl-)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#23
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#22
	ld	(hl), a
;src/gameplay.c:147: itm->y=sy+32; itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props;
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	jp	00103$
00102$:
;src/gameplay.c:149: itm->y=sy;    itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	pop	de
	push	de
	ldhl	sp,	#27
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#20
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, #0x20
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:150: itm->y=sy;    itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#27
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#16
	ld	a, (hl-)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:151: itm->y=sy;    itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#27
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:152: itm->y=sy+16; itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl-)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:153: itm->y=sy+16; itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;src/gameplay.c:154: itm->y=sy+16; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:155: itm->y=sy+32; itm->x=sx+16; itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
;src/gameplay.c:156: itm->y=sy+32; itm->x=sx+8;  itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX; itm++; meta++;
	ld	(hl+), a
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
;src/gameplay.c:157: itm->y=sy+32; itm->x=sx;    itm->tile=meta->dtile+tile_base; itm->prop=meta->props^S_FLIPX;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#20
	add	a, (hl)
	ld	(de), a
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
00103$:
;src/gameplay.c:159: return 9;
	ld	a, #0x09
;src/gameplay.c:160: }
	add	sp, #23
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:162: static void process_sprite_logic(
;	---------------------------------
; Function process_sprite_logic
; ---------------------------------
_process_sprite_logic:
	add	sp, #-68
	ldhl	sp,	#65
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#63
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:167: uint16_t px = p->world_x;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:168: uint16_t py = p->world_y.b.h;
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
	ldhl	sp,	#0
	ld	(hl+), a
;src/gameplay.c:171: uint16_t p_front = px + 15;
	xor	a, a
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
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:172: uint16_t p_bottom = py + PLAYER_SIZE;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#6
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
	ldhl	sp,	#8
	ld	(hl), c
	inc	hl
;src/gameplay.c:173: uint16_t p_feet = py + PLAYER_SIZE;
	ld	(hl+), a
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:175: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,#65
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
	ldhl	sp,#65
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,#65
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0060
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,#70
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
	ldhl	sp,	#72
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#52
	ld	(hl), a
	ldhl	sp,#65
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#67
	ld	(hl), #0x00
00203$:
;src/gameplay.c:176: if (!cache->active[i]) break;
	ldhl	sp,#53
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	or	a, a
	jp	Z, 00204$
;src/gameplay.c:178: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#67
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#60
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#61
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:179: if (obj_x > cam_px + 176u) break;
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x00b0
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00204$
;src/gameplay.c:181: uint8_t obj = cache->obj[i];
	ldhl	sp,#65
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#55
	ld	(hl), a
;src/gameplay.c:182: uint16_t obj_y = cache->py[i];
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#60
	ld	l, (hl)
	ld	h, #0x00
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
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#56
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:184: if (obj == OBJ_LEVEL_END) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:185: if (px >= (obj_x - 180)) p->level_complete = 1;
	ld	a, c
	add	a, #0x4c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00201$
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;src/gameplay.c:186: continue;
	jp	00201$
00108$:
;src/gameplay.c:189: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00198$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00198$
;src/gameplay.c:191: if (obj_x <= p_front && px <= obj_x + 48u) {
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#61
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00201$
	ld	hl, #0x0030
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00201$
;src/gameplay.c:192: if (py <= obj_y + 14u && p_bottom >= obj_y) {
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000e
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00201$
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#56
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00201$
;src/gameplay.c:193: if (!cache->activated[i]) {
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
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
	jp	NZ, 00201$
;src/gameplay.c:194: uint8_t target_flipped = (obj >= 18);
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x12
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	c, a
;src/gameplay.c:195: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, c
	jr	Z, 00110$
;src/gameplay.c:196: p->gravity_flipped = target_flipped;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/gameplay.c:197: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#70
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
00110$:
;src/gameplay.c:199: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00201$
00198$:
;src/gameplay.c:203: } else if (obj_x + 2 <= p_front && px <= obj_x + 13) {
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00194$
	ldhl	sp,#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00194$
;src/gameplay.c:204: switch (obj) {
	ldhl	sp,	#55
	ld	a, (hl)
	or	a, a
	jp	Z, 00121$
	ldhl	sp,	#55
	ld	a, (hl)
	dec	a
	jp	Z, 00121$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x02
	jp	Z, 00121$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00770$
	xor	a, a
00770$:
	ldhl	sp,	#62
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00161$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00161$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00134$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00134$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00146$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00161$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00146$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00146$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00146$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00146$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x64
	jp	Z, 00180$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x65
	jp	Z, 00180$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x66
	jp	Z, 00180$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x67
	jp	Z, 00180$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00184$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00184$
	jp	00201$
;src/gameplay.c:207: case OBJ_BALL_PORTAL:
00121$:
;src/gameplay.c:208: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00201$
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#56
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00201$
;src/gameplay.c:209: if (!cache->activated[i]) {
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00201$
;src/gameplay.c:210: if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
	ldhl	sp,	#55
	ld	a, (hl)
	or	a, a
	jr	NZ, 00126$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00127$
00126$:
;src/gameplay.c:211: else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
	ldhl	sp,	#55
	ld	a, (hl)
	dec	a
	jr	NZ, 00123$
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00127$
00123$:
;src/gameplay.c:212: else p->mode = MODE_BALL;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
00127$:
;src/gameplay.c:213: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:216: break;
	jp	00201$
;src/gameplay.c:219: case OBJ_GRAVITY_UP:
00134$:
;src/gameplay.c:220: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00201$
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#56
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00201$
;src/gameplay.c:221: if (!cache->activated[i]) {
	ldhl	sp,#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
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
	jp	NZ, 00201$
;src/gameplay.c:222: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00789$
	xor	a, a
00789$:
	ld	c, a
;src/gameplay.c:223: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, c
	jr	Z, 00136$
;src/gameplay.c:224: p->gravity_flipped = target_flipped;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/gameplay.c:225: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#70
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
00136$:
;src/gameplay.c:227: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:230: break;
	jp	00201$
;src/gameplay.c:236: case OBJ_PAD_BLUE_UP:
00146$:
;src/gameplay.c:238: uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00207$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00207$
	ldhl	sp,	#62
	ld	(hl), #0x00
	jr	00208$
00207$:
	ldhl	sp,	#62
	ld	(hl), #0x01
00208$:
	ldhl	sp,	#62
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl), a
;src/gameplay.c:239: uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
	ldhl	sp,	#62
	ld	a, (hl)
	or	a, a
	jr	Z, 00209$
	ldhl	sp,	#56
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
	jr	00210$
00209$:
	ldhl	sp,	#56
	ld	a, (hl)
	ldhl	sp,	#61
	ld	(hl), a
	ldhl	sp,	#57
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl), a
00210$:
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:240: uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);
	ld	a, (hl-)
	dec	hl
	ld	b, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00211$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	jr	00212$
00211$:
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00212$:
;src/gameplay.c:242: if (py <= pad_bot && p_feet >= pad_top) {
	ldhl	sp,	#0
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00201$
	ldhl	sp,	#10
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00201$
;src/gameplay.c:243: if (!cache->activated[i]) {
	ldhl	sp,#45
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00201$
;src/gameplay.c:244: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:245: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00150$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00151$
00150$:
;src/gameplay.c:246: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#14
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
;src/gameplay.c:247: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00213$
	ld	bc, #0xfc60
	jr	00214$
00213$:
	ld	bc, #0x03a0
00214$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jp	00152$
00151$:
;src/gameplay.c:248: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00148$
;src/gameplay.c:249: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00215$
	ld	bc, #0xfca0
	jr	00216$
00215$:
	ld	bc, #0xfaf0
00216$:
	ldhl	sp,	#59
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:250: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00217$
	ld	de, #0x0000
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	(hl), e
	jr	00218$
00217$:
	ldhl	sp,	#59
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00218$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
	jr	00152$
00148$:
;src/gameplay.c:252: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00219$
	ld	bc, #0xfb10
	jr	00220$
00219$:
	ld	bc, #0xf840
00220$:
	ldhl	sp,	#59
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:253: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00221$
	ld	de, #0x0000
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	(hl), e
	jr	00222$
00221$:
	ldhl	sp,	#59
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00222$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
00152$:
;src/gameplay.c:255: p->on_ground = 0;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:258: break;
	jp	00201$
;src/gameplay.c:263: case OBJ_ORB_BLUE:
00161$:
;src/gameplay.c:265: if (joy & J_A) {
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jp	Z, 00201$
;src/gameplay.c:266: if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	bit	4, a
	jr	Z, 00173$
	ldhl	sp,#42
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00201$
00173$:
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00201$
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#56
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00201$
;src/gameplay.c:267: if (!cache->activated[i]) {
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00201$
;src/gameplay.c:268: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:269: p->orb_buffered = 0; // Clear buffer after hit
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:270: if (obj == OBJ_ORB_BLUE) {
	ldhl	sp,	#62
	ld	a, (hl)
	or	a, a
	jr	Z, 00166$
;src/gameplay.c:271: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#14
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
;src/gameplay.c:272: int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00223$
	ld	bc, #0x01a0
	jr	00224$
00223$:
	ld	bc, #0x03a0
00224$:
;src/gameplay.c:273: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#70
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
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00225$
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00225$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00167$
00166$:
;src/gameplay.c:274: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00163$
;src/gameplay.c:275: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
	ldhl	sp,#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00227$
	ld	bc, #0xfcd0
	jr	00228$
00227$:
	ld	bc, #0xfc30
00228$:
	ldhl	sp,	#57
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:276: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#70
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
	ld	(hl), a
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00229$
	ld	de, #0x0000
	ldhl	sp,	#57
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	(hl), e
	jr	00230$
00229$:
	ldhl	sp,	#57
	ld	a, (hl)
	ldhl	sp,	#61
	ld	(hl), a
	ldhl	sp,	#58
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
00230$:
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00167$
00163$:
;src/gameplay.c:278: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00231$
	ldhl	sp,	#61
	ld	a, #0xf0
	ld	(hl+), a
	ld	(hl), #0xfb
	jr	00232$
00231$:
	ldhl	sp,	#61
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00232$:
	ldhl	sp,	#61
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#62
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/gameplay.c:279: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00233$
	ld	de, #0x0000
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#62
	ld	(hl-), a
	ld	(hl), e
	jr	00234$
00233$:
	ldhl	sp,	#59
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00234$:
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
00167$:
;src/gameplay.c:281: p->on_ground = 0;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:285: break;
	jp	00201$
;src/gameplay.c:288: case 100: case 101: case 102: case 103:
00180$:
;src/gameplay.c:289: if (!cache->activated[i]) {
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00201$
;src/gameplay.c:290: *target_bg_idx = obj - 100;
	ldhl	sp,	#73
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#55
	ld	a, (hl)
	add	a, #0x9c
	ld	(de), a
;src/gameplay.c:291: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:293: continue;
	jr	00201$
;src/gameplay.c:296: case OBJ_MIRROR_EXIT:
00184$:
;src/gameplay.c:297: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00201$
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#56
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00201$
;src/gameplay.c:298: if (!cache->activated[i]) {
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00201$
;src/gameplay.c:299: p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#63
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x7e
	ld	a, #0x01
	jr	Z, 00236$
	xor	a, a
00236$:
	ldhl	sp,	#61
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:300: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:304: }
	jr	00201$
00194$:
;src/gameplay.c:305: } else if (obj_x > p_front + 16) {
	ldhl	sp,	#4
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
	jr	C, 00204$
;src/gameplay.c:306: break;
00201$:
;src/gameplay.c:175: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#67
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00203$
00204$:
;src/gameplay.c:309: }
	add	sp, #68
	pop	hl
	add	sp, #5
	jp	(hl)
;src/gameplay.c:311: static uint8_t draw_sprites(
;	---------------------------------
; Function draw_sprites
; ---------------------------------
_draw_sprites:
	add	sp, #-19
	ldhl	sp,	#16
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#14
	ld	a, c
	ld	(hl+), a
;src/gameplay.c:318: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#18
	ld	(hl), #0x00
00156$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00151$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00151$
;src/gameplay.c:319: if (!cache->active[i]) break;
	pop	de
	push	de
	ldhl	sp,	#18
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00151$
;src/gameplay.c:321: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#18
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:322: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#14
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
	jp	C, 00151$
;src/gameplay.c:324: uint8_t obj = cache->obj[i];
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl), a
;src/gameplay.c:325: if (obj == OBJ_LEVEL_END || obj >= 100) continue;
	ld	a, (hl)
	sub	a, #0x0f
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x64
	jp	NC, 00150$
;src/gameplay.c:330: dist_x = (uint8_t)obj_x - (uint8_t)cam_px;
	inc	hl
	ld	a, c
	ld	c, (hl)
	sub	a, c
;src/gameplay.c:333: if (dist_x > 176 && dist_x < 224) continue;
	cp	a, #0xb1
	jr	C, 00109$
	cp	a, #0xe0
	jp	C, 00150$
00109$:
;src/gameplay.c:336: screen_x = 128 - dist_x + 8;
	ldhl	sp,	#12
	ld	(hl), a
;src/gameplay.c:335: if (reversed) {
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;src/gameplay.c:336: screen_x = 128 - dist_x + 8;
	ld	a, #0x88
	ldhl	sp,	#12
	sub	a, (hl)
	dec	hl
	ld	(hl), a
	jr	00113$
00112$:
;src/gameplay.c:338: screen_x = dist_x + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#12
	ld	a, (hl-)
	add	a, #0x28
	ld	(hl), a
00113$:
;src/gameplay.c:341: screen_y = ((uint8_t)cache->py[i] - (uint8_t)cam_py) + 16;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#21
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#12
;src/gameplay.c:343: if (screen_x > 160 && screen_x < 232) continue;
	ld	(hl-), a
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00115$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00150$
00115$:
;src/gameplay.c:344: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#12
	sub	a, (hl)
	jr	NC, 00118$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00150$
00118$:
;src/gameplay.c:346: if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
	ld	a, #0x1f
	ldhl	sp,	#24
	sub	a, (hl)
	jp	C, 00151$
;src/gameplay.c:347: if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00150$
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	ld	de, #_famidash_sprite_table
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, b
	or	a, c
	jp	Z, 00150$
;src/gameplay.c:350: if (obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00150$
;src/gameplay.c:351: obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00150$
;src/gameplay.c:352: obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00150$
;src/gameplay.c:356: const metasprite_t *sprite = famidash_sprite_table[obj];
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:358: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00147$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00147$
;src/gameplay.c:359: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jp	Z, 00135$
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x68
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldhl	sp,	#12
	ld	c, (hl)
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00159$
	ldhl	sp,	#8
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00160$
00159$:
	ldhl	sp,	#8
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00160$:
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:359: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jp	00150$
00135$:
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x68
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:360: else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#13
	add	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jp	00150$
00147$:
;src/gameplay.c:361: } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jr	Z, 00141$
	ld	a, (hl)
	dec	a
	jr	Z, 00141$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00142$
00141$:
;src/gameplay.c:362: oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#23
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	ldhl	sp,	#27
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x68
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_3x3
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jr	00150$
00142$:
;src/gameplay.c:363: } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00137$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00138$
00137$:
;src/gameplay.c:364: oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#23
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	ldhl	sp,	#27
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x68
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x3
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jr	00150$
00138$:
;src/gameplay.c:366: oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#23
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	ldhl	sp,	#27
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x68
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x1
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
00150$:
;src/gameplay.c:318: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00156$
00151$:
;src/gameplay.c:369: return oam_start;
	ldhl	sp,	#24
	ld	a, (hl)
;src/gameplay.c:370: }
	add	sp, #19
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:372: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 10
_setup_menu_font::
;src/gameplay.c:373: set_bkg_data(FONT_PUSAB_START, 39, FontPusab);
	ld	de, #_FontPusab
	push	de
	ld	hl, #0x27d0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/gameplay.c:374: }
	ret
;src/gameplay.c:376: static void draw_text(uint8_t x, uint8_t y, const char *str) {
;	---------------------------------
; Function draw_text
; ---------------------------------
_draw_text:
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:378: while (*str) {
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00122$:
	ld	a, (bc)
	or	a, a
	jr	Z, 00125$
;src/gameplay.c:379: char c = *str;
;src/gameplay.c:380: if (c == ' ') tile = 0;
	ld	l, a
	sub	a, #0x20
	jr	NZ, 00120$
	xor	a, a
	jr	00121$
00120$:
;src/gameplay.c:381: else if (c == '%') tile = 1;
	ld	a, l
	sub	a, #0x25
	jr	NZ, 00117$
	ld	a, #0x01
	jr	00121$
00117$:
;src/gameplay.c:382: else if (c == '/') tile = 2;
	ld	a, l
	sub	a, #0x2f
	jr	NZ, 00114$
	ld	a, #0x02
	jr	00121$
00114$:
;src/gameplay.c:383: else if (c >= '0' && c <= '9') tile = (c - '0') + 3;
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
;src/gameplay.c:384: else if (c >= 'A' && c <= 'Z') tile = (c - 'A') + 13;
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
;src/gameplay.c:385: else if (c >= 'a' && c <= 'z') tile = (c - 'a') + 13;
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
;src/gameplay.c:386: else tile = 0;
	xor	a, a
00121$:
;src/gameplay.c:387: set_bkg_tile_xy(x++, y, FONT_PUSAB_START + tile);
	add	a, #0xd0
	ld	d, a
	ldhl	sp,	#1
	ld	a, (hl)
	inc	(hl)
	dec	hl
	push	bc
	push	de
	inc	sp
	ld	e, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;src/gameplay.c:388: str++;
	inc	bc
	jr	00122$
00125$:
;src/gameplay.c:390: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/gameplay.c:392: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 10
_draw_menu::
	dec	sp
;src/gameplay.c:393: BGP_REG = 0x2F; // Inverted Palette: White=00, Light Gray=Dark Gray(10), Dark Gray=Black(11), Black=Black(11)
	ld	a, #0x2f
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:394: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:395: draw_text(0, 0, "GD POCKET DEMO 02");
	ld	de, #___str_0
	push	de
	xor	a, a
	ld	e, a
	call	_draw_text
;src/gameplay.c:396: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:398: draw_text(1, 2 + i, "0"); // cursor icon
	ld	a,c
	cp	a,b
	jr	NC, 00104$
;src/gameplay.c:399: draw_text(3, 2 + i, game_levels[i]->name);
	ld	e, c
	ld	d, #0x00
;src/gameplay.c:398: draw_text(1, 2 + i, "0"); // cursor icon
	add	a, #0x02
	ldhl	sp,	#0
	ld	(hl), a
;src/gameplay.c:399: draw_text(3, 2 + i, game_levels[i]->name);
	sla	e
	rl	d
;src/gameplay.c:397: if (i == selected) {
	ld	a, (#_selected)
	sub	a, c
	jr	NZ, 00102$
;src/gameplay.c:398: draw_text(1, 2 + i, "0"); // cursor icon
	ld	hl, #___str_1
	push	bc
	push	de
	push	hl
	ldhl	sp,	#6
	ld	e, (hl)
	ld	a, #0x01
	call	_draw_text
	pop	de
	pop	bc
;src/gameplay.c:399: draw_text(3, 2 + i, game_levels[i]->name);
	ld	hl, #_game_levels
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ldhl	sp,	#4
	ld	e, (hl)
	ld	a, #0x03
	call	_draw_text
	pop	bc
	jr	00107$
00102$:
;src/gameplay.c:401: draw_text(3, 2 + i, game_levels[i]->name);
	ld	hl, #_game_levels
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ldhl	sp,	#4
	ld	e, (hl)
	ld	a, #0x03
	call	_draw_text
	pop	bc
00107$:
;src/gameplay.c:396: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:404: draw_text(0, 16, "SOTOSPRO24");
	ld	de, #___str_2
	push	de
	ld	e, #0x10
	xor	a, a
	call	_draw_text
;src/gameplay.c:405: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:406: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:407: }
	inc	sp
	ret
___str_0:
	.ascii "GD POCKET DEMO 02"
	.db 0x00
___str_1:
	.ascii "0"
	.db 0x00
___str_2:
	.ascii "SOTOSPRO24"
	.db 0x00
;src/gameplay.c:409: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 10
_play_level::
	add	sp, #-128
	add	sp, #-102
;src/gameplay.c:419: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #236
	add	hl, sp
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ld	hl, #228
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
	ld	hl, #182
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:420: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #224
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:421: level_map = l->map;
	ld	hl,#0xb6
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
	ld	hl, #184
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:422: level_tile_count = l->tile_count;
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
	ld	hl, #186
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:423: level_map_w = l->map_width;
	ld	hl,#0xb6
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
	ld	hl, #188
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:424: level_map_h = l->map_height;
	ld	hl,#0xb6
	add	hl,sp
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
	ld	hl, #190
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:425: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:426: level_map_bank = l->map_bank;
	ld	hl,#0xb6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #193
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:428: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:429: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:430: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:432: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #228
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #195
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
;src/gameplay.c:433: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xb6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #229
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #236
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #231
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:434: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:435: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:438: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #228
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:439: uint16_t cam_py = 112;
	ld	hl, #196
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:440: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #190
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
;src/gameplay.c:441: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #221
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
	ld	hl,#0xdd
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
	ld	hl, #198
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:442: else cam_py_max = 0;
	xor	a, a
	ld	hl, #198
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:443: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #200
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:448: uint8_t target_bg_idx = 0;
	ldhl	sp,	#8
;src/gameplay.c:449: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:457: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #15
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:460: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:461: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #192
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #187
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #227
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:462: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:463: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:464: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x5468
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:466: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #194
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:467: BGP_REG = bg_pals[0];
	ldhl	sp,	#9
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:468: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:469: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:470: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:471: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:472: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:473: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:474: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:477: uint16_t scroll_acc = 0;
	ld	hl, #202
	add	hl, sp
;src/gameplay.c:478: uint8_t prev_joy = 0;
;src/gameplay.c:479: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:481: uint16_t sp_stream_idx = 0;
	xor	a, a
	ld	hl, #148
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:482: uint16_t sp_cache_col = 0xFFFF;
	ld	hl, #205
	add	hl, sp
;src/gameplay.c:484: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:485: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#23
	ld	a, (hl)
	ld	hl, #209
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:486: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #148
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
	ld	hl, #36
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:487: while (1) {
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xb6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
	ld	hl,#0xb6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #216
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank
	ld	hl, #236
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #218
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #217
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #218
	add	hl, sp
	ld	(hl), a
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #219
	add	hl, sp
	ld	(hl), a
00184$:
;src/gameplay.c:488: uint8_t joy = joypad();
	call	_joypad
	ld	hl, #224
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:489: if (joy & J_START) break;
	push	hl
	ld	hl, #226
	add	hl, sp
	bit	7, (hl)
	pop	hl
	jp	NZ, 00185$
;src/gameplay.c:491: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ld	hl, #226
	add	hl, sp
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:492: HIDE_SPRITES;
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
;src/gameplay.c:495: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:497: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:498: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:499: printf("LEVEL COMPLETE");
	ld	de, #___str_3
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:500: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:501: printf("Press A to exit");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	de
;src/gameplay.c:502: waitpadup();
	call	_waitpadup
;src/gameplay.c:503: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00185$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:504: break;
00112$:
;src/gameplay.c:507: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ld	hl, #226
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ld	hl, #205
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
;src/gameplay.c:508: prev_joy = joy;
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #203
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:510: uint16_t px_prev = cam_px >> 4;
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #229
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
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
;src/gameplay.c:511: uint8_t needs_render = 0;
	ld	hl, #227
	add	hl, sp
	ld	(hl), #0x00
;src/gameplay.c:512: uint16_t need_col = 0;
	xor	a, a
	ld	hl, #222
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:515: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #188
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #189
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #221
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, #0x04
00580$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00580$
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	ld	hl, #229
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	ld	hl, #220
	add	hl, sp
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00123$
;src/gameplay.c:516: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #202
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#4
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
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:517: cam_px += scroll_acc >> 8;
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #228
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #230
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #229
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:518: scroll_acc &= 0xFF;
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:510: uint16_t px_prev = cam_px >> 4;
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #229
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
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
;src/gameplay.c:519: uint16_t px_curr = cam_px >> 4;
;src/gameplay.c:520: if (px_curr != px_prev) {
	inc	hl
	inc	hl
	pop	bc
	push	bc
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00581$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00123$
00581$:
;src/gameplay.c:521: uint16_t need = px_curr + VIEW_MT_W;
	ldhl	sp,	#4
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
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:522: if (need > loaded_r && need < level_map_w) {
	ld	hl, #200
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #220
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
	ld	hl, #220
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #188
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:523: needs_render = 1;
	ld	hl, #227
	add	hl, sp
	ld	(hl), #0x01
;src/gameplay.c:524: need_col = need;
	ld	hl, #220
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00123$:
;src/gameplay.c:529: player.world_x = cam_px;
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	hl, #229
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
;src/gameplay.c:532: if ((cam_px >> 4) != sp_cache_col) {
	ld	hl, #205
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NZ, 00582$
	ld	hl, #206
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
	sub	a, (hl)
	jr	Z, 00125$
00582$:
;src/gameplay.c:533: sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #232
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:534: sp_cache_col = cam_px >> 4;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #206
	add	hl, sp
	ld	(hl), a
00125$:
;src/gameplay.c:537: if (player.reversed != prev_reversed) {
	ldhl	sp,	#23
	ld	c, (hl)
	ld	hl, #209
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jp	Z, 00132$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:541: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00217$
	ld	hl,#0xd4
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
	ld	hl,#0xd2
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
;src/gameplay.c:542: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #192
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #187
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:545: uint16_t start_col = cam_px >> 4;
	pop	bc
	push	bc
;src/gameplay.c:546: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #226
	add	hl, sp
	ld	(hl), #0x00
00210$:
;src/gameplay.c:547: uint16_t curr_col = start_col + i;
	ld	e, c
	ld	d, b
;src/gameplay.c:546: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00130$
;src/gameplay.c:547: uint16_t curr_col = start_col + i;
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	a, h
	ld	hl, #220
	add	hl, sp
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:548: if (curr_col < level_map_w) {
	ld	hl, #220
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #188
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00211$
;src/gameplay.c:549: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
;src/gameplay.c:485: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#23
	ld	h, (hl)
;src/gameplay.c:550: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	inc	h
	dec	h
	jr	Z, 00127$
	ld	e, a
	xor	a, a
	sub	a, e
	and	a, #0x0f
00127$:
;src/gameplay.c:551: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	push	hl
	inc	sp
	ld	hl, #196
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #192
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #190
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #228
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
	pop	bc
00211$:
;src/gameplay.c:546: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #226
	add	hl, sp
	inc	(hl)
	jr	00210$
00130$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:556: loaded_r = start_col + 15;
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #200
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:557: prev_reversed = player.reversed;
	ldhl	sp,	#23
	ld	a, (hl)
	ld	hl, #209
	add	hl, sp
	ld	(hl), a
00132$:
;src/gameplay.c:560: uint16_t collision_col = cam_px >> 4;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #226
	add	hl, sp
;src/gameplay.c:561: if (collision_col != cached_collision_col) {
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00584$
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00134$
00584$:
;src/gameplay.c:563: level_map_bank, collision_columns);
;src/gameplay.c:562: load_collision_columns(collision_col, level_map, level_map_w,
	ld	hl, #150
	add	hl, sp
	push	hl
	ld	hl, #195
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #191
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #189
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #230
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:564: cached_collision_col = collision_col;
	ld	hl, #225
	add	hl, sp
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	ld	hl, #208
	add	hl, sp
	ld	(hl), a
00134$:
;src/gameplay.c:568: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	ld	hl, #8
	add	hl, sp
;src/gameplay.c:457: player_init(&player, 0, 240);
;src/gameplay.c:568: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	push	hl
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #16
	add	hl, sp
	push	hl
	ld	hl, #233
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_process_sprite_logic
;src/gameplay.c:570: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #190
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #152
	add	hl, sp
	push	hl
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ld	hl, #17
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:572: py = player_screen_y(&player, cam_py);
	ld	hl, #196
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #13
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:573: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:576: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	hl, #198
	add	hl, sp
	ld	a, (hl)
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
	ld	hl, #199
	add	hl, sp
	ld	a, (hl)
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:573: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#4
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
;src/gameplay.c:574: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#16
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:575: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00136$
	ld	bc, #0x0000
00136$:
;src/gameplay.c:576: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #198
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00138$
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00138$:
;src/gameplay.c:577: cam_py = (uint16_t)target_cam_py;
	ld	hl, #196
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00147$
00146$:
;src/gameplay.c:579: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#4
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00147$
;src/gameplay.c:580: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#16
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:581: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00140$
	ld	bc, #0x0000
00140$:
;src/gameplay.c:582: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #198
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00142$
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00142$:
;src/gameplay.c:583: cam_py = (uint16_t)target_cam_py;
	ld	hl, #196
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00147$:
;src/gameplay.c:588: if (player.reversed) {
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/gameplay.c:590: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ld	hl, #228
	add	hl, sp
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
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:591: sprite_x_final = 128; // Mirrored player position
	ld	hl, #226
	add	hl, sp
	ld	(hl), #0x80
	jr	00150$
00149$:
;src/gameplay.c:593: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #228
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	hl, #229
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00219$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #226
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	jr	00220$
00219$:
	xor	a, a
	ld	hl, #225
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00220$:
	ld	hl, #225
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;src/gameplay.c:594: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00221$
	ld	hl, #228
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	jr	00222$
00221$:
	ld	a, #0x20
00222$:
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
00150$:
;src/gameplay.c:596: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #196
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #13
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ld	hl, #224
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:598: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:599: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#8
	ld	l, (hl)
	ld	h, #0x00
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
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:600: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #196
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:602: if (needs_render) {
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00154$
;src/gameplay.c:603: loaded_r = need_col;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:604: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
	ld	c, a
;src/gameplay.c:485: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#23
	ld	b, (hl)
;src/gameplay.c:606: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, b
	or	a, a
	jr	Z, 00152$
	xor	a, a
	sub	a, c
	and	a, #0x0f
	ld	c, a
00152$:
;src/gameplay.c:607: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	inc	sp
	ld	hl, #194
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #188
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #228
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_draw_mt_column
00154$:
;src/gameplay.c:610: uint8_t oam_index = draw_sprites(
	ldhl	sp,	#23
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	hl, #198
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #232
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_draw_sprites
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:615: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;src/gameplay.c:485: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#23
	ld	a, (hl)
	ld	hl, #222
	add	hl, sp
;src/gameplay.c:617: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	ld	a, (hl+)
	add	a, #0x18
;src/gameplay.c:618: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
;src/gameplay.c:620: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:615: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	jp	NZ, 00174$
;src/gameplay.c:616: if (player.gravity_flipped) {
	ldhl	sp,	#21
	ld	a, (hl)
	or	a, a
	jp	Z, 00162$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:617: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x18
	ld	(hl), a
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	hl, #222
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	hl, #224
	add	hl, sp
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00223$
	ld	bc, #0x0010
	jr	00224$
00223$:
	ld	bc, #0x0008
00224$:
	ld	hl, #227
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	sub	a, c
	ld	d, a
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:617: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00156$:
;src/gameplay.c:618: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ld	hl, #224
	add	hl, sp
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
	ld	hl, #226
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00225$
	ld	hl, #222
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00226$
00225$:
	ld	hl, #222
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00226$:
	ld	hl, #227
	add	hl, sp
	ld	e, (hl)
	ld	hl, #222
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #225
	add	hl, sp
	ld	a, (hl-)
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:618: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00162$:
;src/gameplay.c:620: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00159$
	ld	hl, #226
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	b, a
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
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:620: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00159$:
;src/gameplay.c:621: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #226
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
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
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:621: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00174$:
;src/gameplay.c:624: if (player.gravity_flipped) {
	ldhl	sp,	#21
	ld	c, (hl)
;src/gameplay.c:618: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:624: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jp	Z, 00171$
;src/gameplay.c:625: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
	ld	hl, #227
	add	hl, sp
	ld	c, (hl)
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#24
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #228
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
	ld	hl, #227
	add	hl, sp
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:625: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00165$:
;src/gameplay.c:626: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #226
	add	hl, sp
	ld	b, (hl)
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	add	a, #0x16
	ld	c, a
	ldhl	sp,	#24
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
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:626: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jp	00175$
00171$:
;src/gameplay.c:628: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	inc	hl
	ld	a, (hl)
	add	a, #0x0a
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#24
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #221
	add	hl, sp
	ld	a, (hl+)
	inc	hl
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
	ld	hl, #224
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00230$
00229$:
	ld	hl, #224
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00230$:
	ld	hl, #227
	add	hl, sp
	ld	e, (hl)
	ld	hl, #224
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #226
	add	hl, sp
	ld	e, (hl)
	ld	d, b
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:628: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	jr	00175$
00168$:
;src/gameplay.c:629: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #226
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ldhl	sp,	#24
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
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:629: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #221
	add	hl, sp
	add	a, (hl)
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
00175$:
;src/gameplay.c:634: if (oam_index < previous_oam_index) {
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00177$
;src/gameplay.c:635: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00177$:
;src/gameplay.c:637: previous_oam_index = oam_index;
	ld	hl, #227
	add	hl, sp
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:486: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #148
	add	hl, sp
	push	hl
	ld	a, l
	ld	hl, #227
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
	ld	hl, #36
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/gameplay.c:639: if (died) {
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00184$
;src/gameplay.c:640: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:641: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:642: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:643: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:644: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:645: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:646: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:647: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:648: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:649: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00213$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00178$
	call	_wait_vbl_done
	inc	c
	jr	00213$
00178$:
;src/gameplay.c:650: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:651: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:652: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:653: if (level_songs[idx]) {
	ld	hl,#0xc2
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
;src/gameplay.c:654: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xd6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #229
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xd8
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #229
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
;src/gameplay.c:655: current_song_bank = song_bank[idx];
	ld	hl,#0xd8
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
;src/gameplay.c:659: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0xda
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #228
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #192
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #187
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #229
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:667: cam_px = 0;
	xor	a, a
	ld	hl, #228
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:668: cam_py = 112;
	ld	hl, #196
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:669: scroll_acc = 0;
	ld	hl, #202
	add	hl, sp
;src/gameplay.c:670: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:671: target_bg_idx = 0;
	ldhl	sp,	#8
;src/gameplay.c:672: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #15
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:673: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:674: sp_cache_col = 0xFFFF;
	ld	hl, #205
	add	hl, sp
;src/gameplay.c:675: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:676: cached_collision_col = 0xFFFF;
	ld	hl, #207
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:678: BGP_REG = bg_pals[0];
	ldhl	sp,	#9
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:679: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #194
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:680: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:681: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:682: enable_interrupts();
	jp	00184$
00185$:
;src/gameplay.c:686: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:688: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:690: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:692: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:693: }
	add	sp, #127
	add	sp, #103
	ret
___str_3:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_4:
	.ascii "Press A to exit"
	.db 0x00
	.area _CODE_10
	.area _INITIALIZER
	.area _CABS (ABS)
