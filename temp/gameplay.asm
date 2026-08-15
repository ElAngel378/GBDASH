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
	.area _CODE_10
;src/gameplay.c:55: void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
;src/gameplay.c:57: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:58: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
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
;src/gameplay.c:59: }
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
	add	sp, #-24
	ldhl	sp,	#20
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#18
	ld	a, c
	ld	(hl+), a
;src/gameplay.c:65: uint8_t sp_bank = l->sp_bank;
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
;src/gameplay.c:66: const SpDef *sp_list = l->sp_list;
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
;src/gameplay.c:69: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:70: if (!cache->active[i]) continue;
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
;src/gameplay.c:71: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
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
;src/gameplay.c:70: if (!cache->active[i]) continue;
	ld	a, c
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:71: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
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
;src/gameplay.c:69: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#17
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:75: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:76: if (cache->active[i]) {
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
;src/gameplay.c:77: if (count != i) {
	ldhl	sp,	#22
	ld	a, (hl+)
	sub	a, (hl)
	jp	Z, 00108$
;src/gameplay.c:78: cache->obj[count] = cache->obj[i];
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
;src/gameplay.c:79: cache->px[count] = cache->px[i];
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
;src/gameplay.c:80: cache->py[count] = cache->py[i];
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
;src/gameplay.c:81: cache->active[count] = cache->active[i];
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
;src/gameplay.c:82: cache->activated[count] = cache->activated[i];
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
;src/gameplay.c:84: count++;
	ldhl	sp,	#22
	inc	(hl)
00117$:
;src/gameplay.c:75: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00116$
;src/gameplay.c:87: while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;
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
;src/gameplay.c:89: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
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
;src/gameplay.c:90: }
	add	sp, #24
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:93: static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x1
; ---------------------------------
_draw_oam_2x1:
	add	sp, #-5
	push	de
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:94: uint8_t i = oam_idx;
;src/gameplay.c:95: if (!reversed) {
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:96: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	pop	de
	push	de
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(bc), a
	ldhl	sp,	#9
	ld	c, (hl)
	inc	c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:97: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, #0x08
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
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
;src/gameplay.c:99: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ldhl	sp,	#9
	ld	c, (hl)
	xor	a, a
	ld	b, a
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, #0x08
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	pop	de
	push	de
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	xor	a, #0x20
	ld	(bc), a
	ldhl	sp,	#9
	ld	c, (hl)
	inc	c
	pop	de
	push	de
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
;src/gameplay.c:100: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
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
;src/gameplay.c:102: return 2;
	ld	a, #0x02
;src/gameplay.c:103: }
	add	sp, #7
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:106: static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x3
; ---------------------------------
_draw_oam_2x3:
	add	sp, #-9
	ld	c, e
	ld	b, d
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:107: uint8_t i = oam_idx;
;src/gameplay.c:108: if (!reversed) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:109: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ldhl	sp,	#11
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	dec	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:110: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#5
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:111: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#4
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:112: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:113: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
	ld	a, (hl+)
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	a, (hl-)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#2
	ld	e, (hl)
	inc	e
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/gameplay.c:114: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
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
;src/gameplay.c:116: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ldhl	sp,	#11
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#4
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	dec	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:117: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#5
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:118: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#4
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:119: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:120: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
	ld	a, (hl+)
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	a, (hl-)
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#2
	ld	e, (hl)
	inc	e
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:121: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
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
;src/gameplay.c:123: return 6;
	ld	a, #0x06
;src/gameplay.c:124: }
	add	sp, #9
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:127: static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_3x3
; ---------------------------------
_draw_oam_3x3:
	add	sp, #-10
	ld	c, e
	ld	b, d
	ldhl	sp,	#7
	ld	(hl), a
;src/gameplay.c:128: uint8_t i = oam_idx;
;src/gameplay.c:129: if (!reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:130: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ldhl	sp,	#12
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	dec	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:131: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	add	a, #0x08
	ld	(hl), a
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#6
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:132: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#3
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#6
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:133: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#5
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:134: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#5
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:135: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:136: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl+)
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	a, (hl-)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#3
	ld	a, (hl+)
	inc	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:137: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#5
	ld	e, (hl)
	inc	e
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/gameplay.c:138: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props;
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(bc), a
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
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
;src/gameplay.c:140: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ldhl	sp,	#12
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#5
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	add	a, #0x10
	ld	(hl), a
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	dec	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:141: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#3
	ld	a, (hl-)
	add	a, #0x08
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#6
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:142: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#6
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:143: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#5
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:144: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#5
	inc	(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:145: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:146: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl+)
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	a, (hl-)
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#3
	ld	a, (hl+)
	inc	hl
	inc	a
	ld	(hl), a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/gameplay.c:147: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_shadow_OAM
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	de, #_shadow_OAM
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	xor	a, #0x20
	ld	(de), a
	ldhl	sp,	#5
	ld	e, (hl)
	inc	e
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/gameplay.c:148: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX;
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#7
	add	a, (hl)
	ld	(de), a
	ld	hl,#_shadow_OAM + 1
	add	hl,bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
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
;src/gameplay.c:150: return 9;
	ld	a, #0x09
;src/gameplay.c:151: }
	add	sp, #10
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:153: static uint8_t draw_oam_deco(const FamidashDeco *deco, uint8_t tile_base,
;	---------------------------------
; Function draw_oam_deco
; ---------------------------------
_draw_oam_deco:
	add	sp, #-20
	ldhl	sp,	#17
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;src/gameplay.c:157: for (i = 0; i < deco->count; i++) {
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#17
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
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#19
	ld	(hl), #0x00
00103$:
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#15
	sub	a, (hl)
	jp	NC, 00101$
;src/gameplay.c:158: shadow_OAM[oam_idx + i].x = reversed
	ld	bc, #_shadow_OAM+0
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#19
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
;src/gameplay.c:159: ? (uint8_t)(sx + deco->width - 8 - deco->x[i])
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#23
	add	a, (hl)
	add	a, #0xf8
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, e
	jr	00108$
00107$:
;src/gameplay.c:160: : (uint8_t)(sx + deco->x[i]);
	pop	de
	push	de
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#23
	ld	e, (hl)
	add	a, e
00108$:
	ld	(bc), a
;src/gameplay.c:161: shadow_OAM[oam_idx + i].y = (uint8_t)(sy + deco->y[i]);
	ld	bc, #_shadow_OAM+0
	ldhl	sp,	#19
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	a, h
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#14
	ld	(hl), e
	inc	hl
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#24
	ld	e, (hl)
	add	a, e
	ld	(bc), a
;src/gameplay.c:162: shadow_OAM[oam_idx + i].tile = deco->tile[i] + tile_base;
	ld	bc, #_shadow_OAM+0
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#16
	add	a, (hl)
;src/gameplay.c:163: shadow_OAM[oam_idx + i].prop = deco->props[i] ^ (reversed ? S_FLIPX : 0);
	dec	hl
	ld	(bc), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	ld	c, #0x20
	jr	NZ, 00110$
	ld	c, #0x00
00110$:
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, c
	ldhl	sp,	#12
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:157: for (i = 0; i < deco->count; i++) {
	ldhl	sp,	#19
	inc	(hl)
	jp	00103$
00101$:
;src/gameplay.c:165: return deco->count;
	ldhl	sp,	#15
	ld	a, (hl)
;src/gameplay.c:166: }
	add	sp, #20
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:168: static uint8_t process_and_draw_sprites(
;	---------------------------------
; Function process_and_draw_sprites
; ---------------------------------
_process_and_draw_sprites:
	add	sp, #-60
	ldhl	sp,	#57
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#55
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:173: uint16_t px = p->world_x;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:174: uint16_t py = p->world_y.b.h;
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
	ld	(hl), #0x00
;src/gameplay.c:175: uint8_t reversed = p->reversed;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
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
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
;src/gameplay.c:178: uint16_t p_front = px + 15;
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
;src/gameplay.c:179: uint16_t p_bottom = py + PLAYER_SIZE + 16;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x001f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), c
	inc	hl
;src/gameplay.c:180: uint16_t p_feet = py + PLAYER_SIZE;
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:182: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#23
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#22
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0060
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#66
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#59
	ld	(hl), #0x00
00216$:
	ldhl	sp,	#59
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00213$
	ldhl	sp,	#69
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00213$
;src/gameplay.c:183: if (!cache->active[i]) break; // Early out
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00213$
;src/gameplay.c:185: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#59
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#54
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#44
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:186: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x00b0
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	C, 00213$
;src/gameplay.c:188: uint8_t obj = cache->obj[i];
	ldhl	sp,#57
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
	ldhl	sp,	#46
	ld	(hl), a
;src/gameplay.c:189: uint16_t obj_y = cache->py[i];
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#54
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#47
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:194: if (obj == OBJ_LEVEL_END) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:195: if (px >= (obj_x - 180)) p->level_complete = 1;
	ld	a, c
	add	a, #0x4c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#5
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00212$
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;src/gameplay.c:196: continue;
	jp	00212$
00108$:
;src/gameplay.c:199: if (obj_x <= p_front) {
	ldhl	sp,	#7
	ld	e, l
	ld	d, h
	ldhl	sp,	#44
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:200: switch (obj) {
	ldhl	sp,	#46
	ld	a, (hl)
	or	a, a
	jp	Z, 00110$
	ldhl	sp,	#46
	ld	a, (hl)
	dec	a
	jp	Z, 00110$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00782$
	xor	a, a
00782$:
	ld	c, a
	or	a, a
	jp	NZ, 00144$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00144$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00117$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00117$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00129$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00144$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00129$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00129$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00129$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00129$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x64
	jp	Z, 00161$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x65
	jp	Z, 00161$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x66
	jp	Z, 00161$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x67
	jp	Z, 00161$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00170$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00164$
	jp	00178$
;src/gameplay.c:202: case OBJ_SHIP_PORTAL:
00110$:
;src/gameplay.c:203: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
	ldhl	sp,	#11
	ld	e, l
	ld	d, h
	ldhl	sp,	#47
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:204: if (!cache->activated[i]) {
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:205: p->mode = (obj == OBJ_CUBE_PORTAL) ? MODE_CUBE : MODE_SHIP;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl)
	or	a,a
	jr	Z, 00220$
	ld	a, #0x01
00220$:
	ldhl	sp,	#53
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:206: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:209: break;
	jp	00178$
;src/gameplay.c:212: case OBJ_GRAVITY_UP:
00117$:
;src/gameplay.c:213: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00178$
	ldhl	sp,	#11
	ld	e, l
	ld	d, h
	ldhl	sp,	#47
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:214: if (!cache->activated[i]) {
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:215: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00799$
	xor	a, a
00799$:
;src/gameplay.c:216: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#21
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	cp	a, l
	jr	Z, 00119$
;src/gameplay.c:217: p->gravity_flipped = target_flipped;
	ldhl	sp,	#21
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:218: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#51
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#50
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#53
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#54
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	ldhl	sp,	#51
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#53
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00119$:
;src/gameplay.c:220: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:223: break;
	jp	00178$
;src/gameplay.c:229: case OBJ_PAD_BLUE_UP:
00129$:
;src/gameplay.c:231: uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00222$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00222$
	xor	a, a
	jr	00223$
00222$:
	ld	a, #0x01
00223$:
	ld	e, a
;src/gameplay.c:232: uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 12);
	or	a, a
	jr	Z, 00224$
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jr	00225$
00224$:
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
00225$:
;src/gameplay.c:233: uint16_t pad_bot = is_ceiling ? (obj_y + 4) : (obj_y + 16);
	ld	a, e
	or	a, a
	jr	Z, 00226$
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	inc	de
	jr	00227$
00226$:
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
00227$:
;src/gameplay.c:235: if (py <= pad_bot && p_feet >= pad_top) {
	ldhl	sp,	#0
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	C, 00178$
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00178$
;src/gameplay.c:236: if (!cache->activated[i]) {
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:237: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:238: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00133$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00134$
00133$:
;src/gameplay.c:239: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#21
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
;src/gameplay.c:240: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00228$
	ld	bc, #0xfc60
	jr	00229$
00228$:
	ld	bc, #0x03a0
00229$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jr	00135$
00134$:
;src/gameplay.c:241: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00131$
;src/gameplay.c:242: p->vel_y.w = (p->gravity_flipped) ? -PINK_PAD_FORCE : PINK_PAD_FORCE;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00230$
	ld	de, #0x04e8
	jr	00231$
00230$:
	ld	de, #0xfb18
00231$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00135$
00131$:
;src/gameplay.c:244: p->vel_y.w = (p->gravity_flipped) ? -PAD_JUMP_FORCE : PAD_JUMP_FORCE;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00232$
	ld	de, #0x0762
	jr	00233$
00232$:
	ld	de, #0xf89e
00233$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00135$:
;src/gameplay.c:246: p->on_ground = 0;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:249: break;
	jp	00178$
;src/gameplay.c:254: case OBJ_ORB_BLUE:
00144$:
;src/gameplay.c:256: if (joy & J_A) {
	ldhl	sp,	#35
	ld	a, (hl)
	or	a, a
	jp	Z, 00178$
;src/gameplay.c:257: if (py <= obj_y + 16 && p_feet >= obj_y) {
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	b, l
	ld	e, h
	ldhl	sp,	#9
	ld	a, b
	sub	a, (hl)
	inc	hl
	ld	a, e
	sbc	a, (hl)
	jp	C, 00178$
	ldhl	sp,	#13
	ld	e, l
	ld	d, h
	ldhl	sp,	#47
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00178$
;src/gameplay.c:258: if (!cache->activated[i]) {
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jp	NZ, 00178$
;src/gameplay.c:259: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(de), a
;src/gameplay.c:260: if (obj == OBJ_ORB_BLUE) {
	ld	a, c
	or	a, a
	jr	Z, 00149$
;src/gameplay.c:261: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#21
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
;src/gameplay.c:262: p->vel_y.w = (p->gravity_flipped) ? -BLUE_ORB_FORCE : BLUE_ORB_FORCE;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00234$
	ld	bc, #0xfe60
	jr	00235$
00234$:
	ld	bc, #0x01a0
00235$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jr	00150$
00149$:
;src/gameplay.c:263: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00146$
;src/gameplay.c:264: p->vel_y.w = (p->gravity_flipped) ? -MAGENTA_JUMP_FORCE : MAGENTA_JUMP_FORCE;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#53
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#52
	ld	(hl), a
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00236$
	ldhl	sp,	#53
	ld	a, #0xd0
	ld	(hl+), a
	ld	(hl), #0x03
	jr	00237$
00236$:
	ldhl	sp,	#53
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0xfc
00237$:
	ldhl	sp,	#53
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00150$
00146$:
;src/gameplay.c:266: p->vel_y.w = (p->gravity_flipped) ? -JUMP_FORCE + 120 : JUMP_FORCE - 120;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00238$
	ld	de, #0x0574
	jr	00239$
00238$:
	ld	de, #0xfa8c
00239$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00150$:
;src/gameplay.c:268: p->on_ground = 0;
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:272: break;
	jp	00178$
;src/gameplay.c:275: case 100: case 101: case 102: case 103:
00161$:
;src/gameplay.c:276: if (!cache->activated[i]) {
	ldhl	sp,#42
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00212$
;src/gameplay.c:277: *target_bg_idx = obj - 100;
	ldhl	sp,	#67
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#46
	ld	a, (hl)
	add	a, #0x9c
	ld	(de), a
;src/gameplay.c:278: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:280: continue;
	jp	00212$
;src/gameplay.c:282: case OBJ_MIRROR_PORTAL:
00164$:
;src/gameplay.c:283: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00178$
	ldhl	sp,	#11
	ld	e, l
	ld	d, h
	ldhl	sp,	#47
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00178$
;src/gameplay.c:284: if (!cache->activated[i]) {
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00178$
;src/gameplay.c:285: p->reversed = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:286: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:289: break;
	jr	00178$
;src/gameplay.c:291: case OBJ_MIRROR_EXIT:
00170$:
;src/gameplay.c:292: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#47
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00178$
	ldhl	sp,	#11
	ld	e, l
	ld	d, h
	ldhl	sp,	#47
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00178$
;src/gameplay.c:293: if (!cache->activated[i]) {
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00178$
;src/gameplay.c:294: p->reversed = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:295: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:299: }
00178$:
;src/gameplay.c:305: if (obj >= 38) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x26
	jp	C, 00190$
;src/gameplay.c:306: const FamidashDeco *deco = (obj < 64) ? famidash_deco_table[obj] : 0;
	ld	a, (hl)
	sub	a, #0x40
	jr	NC, 00240$
	ld	a, (hl)
	ldhl	sp,	#53
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
	ld	hl, #_famidash_deco_table
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#49
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jr	00241$
00240$:
	xor	a, a
	ldhl	sp,	#49
	ld	(hl+), a
	ld	(hl), a
00241$:
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#52
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#53
	ld	(hl), a
;src/gameplay.c:307: if (!deco) continue;
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00212$
;src/gameplay.c:308: if (oam_start > MAX_HARDWARE_SPRITES - deco->count) break;
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ld	a, #0x28
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ldhl	sp,	#69
	ld	a, (hl)
	ldhl	sp,	#50
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
	jr	Z, 00811$
	bit	7, d
	jr	NZ, 00812$
	cp	a, a
	jr	00812$
00811$:
	bit	7, d
	jr	Z, 00812$
	scf
00812$:
	jp	C, 00213$
;src/gameplay.c:310: uint8_t deco_screen_x = reversed
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00242$
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
	ldhl	sp,	#54
	ld	a, (hl)
	ldhl	sp,	#51
	sub	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
	ld	a, #0x88
	sub	a, (hl)
	jr	00243$
00242$:
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
	ldhl	sp,	#54
	ld	a, (hl)
	ldhl	sp,	#51
	sub	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x28
00243$:
	ld	b, a
;src/gameplay.c:313: uint8_t deco_screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;
	ldhl	sp,	#47
	ld	a, (hl)
	ldhl	sp,	#62
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ld	d, a
;src/gameplay.c:314: if (deco_screen_x > 160 && deco_screen_x < 232) continue;
	ld	a, #0xa0
	sub	a, b
	jr	NC, 00184$
	ld	a, b
	sub	a, #0xe8
	jp	C, 00212$
00184$:
;src/gameplay.c:315: if (deco_screen_y > 160 && deco_screen_y < 208) continue;
	ld	a, #0xa0
	sub	a, d
	jr	NC, 00187$
	ld	a, d
	sub	a, #0xd0
	jp	C, 00212$
00187$:
;src/gameplay.c:316: oam_start += draw_oam_deco(deco, FAMIDASH_SPRITE_TILE_BASE,
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, b
	push	de
	ldhl	sp,	#72
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x58
	ldhl	sp,	#56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_deco
	ldhl	sp,	#69
	add	a, (hl)
	ld	(hl), a
;src/gameplay.c:318: continue;
	jp	00212$
00190$:
;src/gameplay.c:321: if (famidash_sprite_table[obj] == 0) continue;
	ldhl	sp,	#46
	ld	a, (hl)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, #<(_famidash_sprite_table)
	ld	c, a
	ld	a, b
	adc	a, #>(_famidash_sprite_table)
	ld	b, a
	ld	l, c
	ld	h, b
	inc	hl
	ld	a,	(hl-)
	ld	l, (hl)
	or	a, l
	jp	Z, 00212$
;src/gameplay.c:324: if (reversed) {
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00194$
;src/gameplay.c:325: screen_x = 128 - ((uint8_t)obj_x - (uint8_t)cam_px) + 8;
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#55
	ld	e, (hl)
	dec	hl
	sub	a, e
	ld	e, a
	ld	a, #0x88
	sub	a, e
	ld	(hl), a
	jr	00195$
00194$:
;src/gameplay.c:327: screen_x = ((uint8_t)obj_x - (uint8_t)cam_px) + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#55
	ld	e, (hl)
	dec	hl
	sub	a, e
	add	a, #0x28
	ld	(hl), a
00195$:
;src/gameplay.c:330: uint8_t screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;
	ldhl	sp,	#47
	ld	a, (hl)
	ldhl	sp,	#62
	ld	e, (hl)
	sub	a, e
	add	a, #0x10
	ldhl	sp,	#51
	ld	(hl), a
;src/gameplay.c:332: if (screen_x > 160 && screen_x < 232) continue;
	ld	a, #0xa0
	ldhl	sp,	#54
	sub	a, (hl)
	jr	NC, 00197$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00212$
00197$:
;src/gameplay.c:333: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#51
	sub	a, (hl)
	jr	NC, 00200$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00212$
00200$:
;src/gameplay.c:335: if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
	ld	a, #0x1f
	ldhl	sp,	#69
	sub	a, (hl)
	jp	C, 00213$
;src/gameplay.c:337: const metasprite_t *sprite = famidash_sprite_table[obj];
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#52
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:339: if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL) {
	ldhl	sp,	#46
	ld	a, (hl)
	or	a, a
	jr	Z, 00208$
	ld	a, (hl)
	dec	a
	jr	NZ, 00209$
00208$:
;src/gameplay.c:340: oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#52
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#56
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#72
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x58
	ldhl	sp,	#56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_3x3
	ldhl	sp,	#69
	add	a, (hl)
	ld	(hl), a
	jr	00212$
00209$:
;src/gameplay.c:341: } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00204$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00205$
00204$:
;src/gameplay.c:342: oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#52
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#56
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#72
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x58
	ldhl	sp,	#56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x3
	ldhl	sp,	#69
	add	a, (hl)
	ld	(hl), a
	jr	00212$
00205$:
;src/gameplay.c:344: oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#52
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#56
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#72
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, #0x58
	ldhl	sp,	#56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x1
	ldhl	sp,	#69
	add	a, (hl)
	ld	(hl), a
00212$:
;src/gameplay.c:182: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#59
	inc	(hl)
	jp	00216$
00213$:
;src/gameplay.c:347: return oam_start;
	ldhl	sp,	#69
	ld	a, (hl)
;src/gameplay.c:348: }
	add	sp, #60
	pop	hl
	add	sp, #8
	jp	(hl)
;src/gameplay.c:350: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 10
_setup_menu_font::
;src/gameplay.c:351: font_init();
	call	_font_init
;src/gameplay.c:352: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:353: }
	ret
;src/gameplay.c:355: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 10
_draw_menu::
;src/gameplay.c:356: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:357: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:358: printf("GBDASH DEMO 01\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:359: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:360: gotoxy(1, 2 + i);
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
;src/gameplay.c:361: if (i == selected) printf("0 %s", game_levels[i]->name);
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
;src/gameplay.c:362: else printf("  %s", game_levels[i]->name);
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
;src/gameplay.c:359: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:364: printf("\n\n\n\n\n\n\n\nSotospro24");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:365: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:366: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:367: }
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
;src/gameplay.c:369: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 10
_play_level::
	add	sp, #-128
	add	sp, #-98
;src/gameplay.c:379: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #232
	add	hl, sp
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ld	hl, #224
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
	ld	hl, #178
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:380: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #224
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #223
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #220
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:381: level_map = l->map;
	ld	hl,#0xb2
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
	ld	hl, #180
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:382: level_tile_count = l->tile_count;
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
	ld	hl, #182
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:383: level_map_w = l->map_width;
	ld	hl,#0xb2
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
	ld	hl, #184
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:384: level_map_h = l->map_height;
	ld	hl,#0xb2
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
	ld	hl, #186
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:385: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:386: level_map_bank = l->map_bank;
	ld	hl,#0xb2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #189
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:388: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:389: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:390: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:392: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #224
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #192
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #191
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
;src/gameplay.c:393: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xb2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #232
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #227
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:394: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:395: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:398: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #224
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:399: uint16_t cam_py = 112;
	ld	hl, #192
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:400: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #186
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
;src/gameplay.c:401: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #218
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
	ld	hl,#0xda
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
	ld	hl, #194
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:402: else cam_py_max = 0;
	xor	a, a
	ld	hl, #194
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:403: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #196
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:408: uint8_t target_bg_idx = 0;
	ldhl	sp,	#6
;src/gameplay.c:409: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:417: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #13
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:420: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:421: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #188
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #221
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:422: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:423: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:424: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x4858
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:426: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #182
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:427: BGP_REG = bg_pals[0];
	ldhl	sp,	#7
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:428: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:429: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:430: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:431: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:432: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:433: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:434: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:437: uint16_t scroll_acc = 0;
	ld	hl, #198
	add	hl, sp
;src/gameplay.c:438: uint8_t prev_joy = 0;
;src/gameplay.c:439: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:441: uint16_t sp_stream_idx = 0;
	xor	a, a
	ld	hl, #144
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:442: uint16_t sp_cache_col = 0xFFFF;
	ld	hl, #201
	add	hl, sp
;src/gameplay.c:444: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:445: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#21
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:446: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #144
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #32
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:447: while (1) {
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #206
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #207
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xb2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
	ld	(hl), a
	ld	hl,#0xb2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
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
	ld	de, #_song_bank
	ld	hl, #232
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
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
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #214
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
00184$:
;src/gameplay.c:448: uint8_t joy = joypad();
	call	_joypad
	ld	hl, #217
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:449: if (joy & J_START) break;
	push	hl
	ld	hl, #219
	add	hl, sp
	bit	7, (hl)
	pop	hl
	jp	NZ, 00185$
;src/gameplay.c:451: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ld	hl, #219
	add	hl, sp
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:452: HIDE_SPRITES;
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
;src/gameplay.c:455: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:457: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:458: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:459: printf("LEVEL COMPLETE");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:460: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:461: printf("Press A to exit");
	ld	de, #___str_6
	push	de
	call	_printf
	pop	de
;src/gameplay.c:462: waitpadup();
	call	_waitpadup
;src/gameplay.c:463: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00185$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:464: break;
00112$:
;src/gameplay.c:467: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ld	hl, #219
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ld	hl, #201
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
;src/gameplay.c:468: prev_joy = joy;
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	ld	hl, #199
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:470: uint16_t px_prev = cam_px >> 4;
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	ld	hl, #225
	add	hl, sp
	ld	a, (hl)
	ld	hl, #222
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
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/gameplay.c:471: uint8_t needs_render = 0;
	ld	hl, #223
	add	hl, sp
	ld	(hl), #0x00
;src/gameplay.c:472: uint16_t need_col = 0;
	xor	a, a
	ld	hl, #218
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:475: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #184
	add	hl, sp
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
	ld	hl, #224
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	NC, 00123$
;src/gameplay.c:476: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #198
	add	hl, sp
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x02ca
	add	hl, bc
	ld	c, l
;src/gameplay.c:477: cam_px += scroll_acc >> 8;
	ld	e, h
	ld	d, #0x00
	ld	hl, #224
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #226
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:478: scroll_acc &= 0xFF;
	ld	hl, #198
	add	hl, sp
	ld	(hl), c
;src/gameplay.c:470: uint16_t px_prev = cam_px >> 4;
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	ld	hl, #225
	add	hl, sp
	ld	a, (hl)
	ld	hl, #222
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
;src/gameplay.c:479: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:480: if (px_curr != px_prev) {
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00580$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00123$
00580$:
;src/gameplay.c:481: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:482: if (need > loaded_r && need < level_map_w) {
	ld	hl, #196
	add	hl, sp
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00123$
	ld	hl, #184
	add	hl, sp
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:483: needs_render = 1;
	ld	hl, #223
	add	hl, sp
	ld	(hl), #0x01
;src/gameplay.c:484: need_col = need;
	ld	hl, #218
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/gameplay.c:489: player.world_x = cam_px;
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #225
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;src/gameplay.c:492: if ((cam_px >> 4) != sp_cache_col) {
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00581$
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00125$
00581$:
;src/gameplay.c:493: sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #228
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #182
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:494: sp_cache_col = cam_px >> 4;
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	ld	(hl), a
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
00125$:
;src/gameplay.c:497: if (player.reversed != prev_reversed) {
	ldhl	sp,	#21
	ld	c, (hl)
	ld	hl, #205
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jp	Z, 00132$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:501: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00217$
	ld	hl,#0xd0
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
	ld	hl,#0xce
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
;src/gameplay.c:502: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #188
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #183
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:505: uint16_t start_col = cam_px >> 4;
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:506: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #220
	add	hl, sp
	ld	(hl), #0x00
00210$:
;src/gameplay.c:507: uint16_t curr_col = start_col + i;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #197
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:506: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00130$
;src/gameplay.c:507: uint16_t curr_col = start_col + i;
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #196
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #196
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:508: if (curr_col < level_map_w) {
	ld	hl, #196
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #184
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00211$
;src/gameplay.c:509: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #196
	add	hl, sp
	ld	a, (hl)
	ld	hl, #216
	add	hl, sp
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:445: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#21
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:510: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00127$
	xor	a, a
	ld	hl, #216
	add	hl, sp
	sub	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00127$:
;src/gameplay.c:511: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	hl, #205
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #184
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #202
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	call	_draw_mt_column
00211$:
;src/gameplay.c:506: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #220
	add	hl, sp
	inc	(hl)
	jp	00210$
00130$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:516: loaded_r = start_col + 15;
	ld	hl,#0xc4
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #196
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:517: prev_reversed = player.reversed;
	ldhl	sp,	#21
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
00132$:
;src/gameplay.c:520: uint16_t collision_col = cam_px >> 4;
;src/gameplay.c:521: if (collision_col != cached_collision_col) {
	ld	hl, #203
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00583$
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	ld	hl, #222
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00134$
00583$:
;src/gameplay.c:523: level_map_bank, collision_columns);
;src/gameplay.c:522: load_collision_columns(collision_col, level_map, level_map_w,
	ld	hl, #146
	add	hl, sp
	push	hl
	ld	hl, #191
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #187
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #226
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:524: cached_collision_col = collision_col;
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ld	hl, #203
	add	hl, sp
	ld	(hl), a
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
00134$:
;src/gameplay.c:526: died = player_update(&player, joy, collision_columns, level_map_h);
;src/gameplay.c:417: player_init(&player, 0, 240);
;src/gameplay.c:526: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #148
	add	hl, sp
	push	hl
	ld	hl, #221
	add	hl, sp
	ld	a, (hl)
	ld	hl, #15
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #216
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:528: py = player_screen_y(&player, cam_py);
	ld	hl, #192
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:529: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:532: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	hl, #194
	add	hl, sp
	ld	a, (hl)
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	ld	hl, #195
	add	hl, sp
	ld	a, (hl)
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:529: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00584$
	bit	7, d
	jr	NZ, 00585$
	cp	a, a
	jr	00585$
00584$:
	bit	7, d
	jr	Z, 00585$
	scf
00585$:
	jr	NC, 00146$
;src/gameplay.c:530: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:531: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00136$
	ld	bc, #0x0000
00136$:
;src/gameplay.c:532: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #194
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00138$
	ld	hl, #221
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00138$:
;src/gameplay.c:533: cam_py = (uint16_t)target_cam_py;
	ld	hl, #192
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00147$
00146$:
;src/gameplay.c:535: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#2
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00147$
;src/gameplay.c:536: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:537: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00140$
	ld	bc, #0x0000
00140$:
;src/gameplay.c:538: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #194
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00142$
	ld	hl, #221
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00142$:
;src/gameplay.c:539: cam_py = (uint16_t)target_cam_py;
	ld	hl, #192
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00147$:
;src/gameplay.c:544: if (player.reversed) {
	ldhl	sp,	#21
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/gameplay.c:546: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ld	hl, #224
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
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:547: sprite_x_final = 128; // Mirrored player position
	ld	hl, #222
	add	hl, sp
	ld	(hl), #0x80
	jr	00150$
00149$:
;src/gameplay.c:549: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #224
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x20
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00219$
	ld	a, c
	add	a, #0xe0
	ld	e, a
	ld	a, b
	adc	a, #0xff
	jr	00220$
00219$:
	xor	a, a
	ld	e, a
00220$:
	ldhl	sp,	#2
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:550: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	a, c
	sub	a, #0x20
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00221$
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	jr	00222$
00221$:
	ld	a, #0x20
00222$:
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
00150$:
;src/gameplay.c:552: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #192
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ld	hl, #220
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:554: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:555: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #9
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#6
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:556: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #192
	add	hl, sp
	ld	c, (hl)
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:558: if (needs_render) {
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00154$
;src/gameplay.c:559: loaded_r = need_col;
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	ld	hl, #197
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:560: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
;src/gameplay.c:445: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#21
	ld	b, (hl)
;src/gameplay.c:562: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	inc	b
	dec	b
	jr	Z, 00152$
	ld	c, a
	xor	a, a
	sub	a, c
	ld	c, a
	and	a, #0x0f
00152$:
;src/gameplay.c:563: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #186
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #184
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #224
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
00154$:
;src/gameplay.c:566: uint8_t oam_index = process_and_draw_sprites(
	ld	hl, #6
	add	hl, sp
	xor	a, a
	push	af
	inc	sp
	push	hl
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #15
	add	hl, sp
	push	hl
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
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_process_and_draw_sprites
	ld	hl, #217
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:571: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#20
;src/gameplay.c:445: uint8_t prev_reversed = player.reversed;
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	hl, #218
	add	hl, sp
;src/gameplay.c:573: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #219
	add	hl, sp
	ld	(hl), a
	ld	a, (hl+)
	add	a, #0x18
;src/gameplay.c:574: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
;src/gameplay.c:576: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:571: if (player.mode == MODE_SHIP) {
	dec	c
	jp	NZ, 00174$
;src/gameplay.c:572: if (player.gravity_flipped) {
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jp	Z, 00162$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:573: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #219
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x18
	ld	(hl), a
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	hl, #218
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00223$
	ld	bc, #0x0010
	jr	00224$
00223$:
	ld	bc, #0x0008
00224$:
	ld	hl, #223
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
;src/gameplay.c:573: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00156$:
;src/gameplay.c:574: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	hl, #219
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	ld	hl, #220
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
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00225$
	ld	hl, #218
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00226$
00225$:
	ld	hl, #218
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00226$:
	ld	hl, #223
	add	hl, sp
	ld	e, (hl)
	ld	hl, #218
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #221
	add	hl, sp
	ld	a, (hl-)
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:574: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00162$:
;src/gameplay.c:576: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00159$
	ld	hl, #222
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
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:576: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00159$:
;src/gameplay.c:577: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #222
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
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:577: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00174$:
;src/gameplay.c:580: if (player.gravity_flipped) {
	ldhl	sp,	#19
	ld	c, (hl)
;src/gameplay.c:574: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:580: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jp	Z, 00171$
;src/gameplay.c:581: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
	ld	hl, #223
	add	hl, sp
	ld	c, (hl)
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	ld	hl, #224
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
	ld	hl, #223
	add	hl, sp
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:581: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00165$:
;src/gameplay.c:582: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #222
	add	hl, sp
	ld	b, (hl)
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	add	a, #0x16
	ld	c, a
	ldhl	sp,	#22
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
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:582: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jp	00175$
00171$:
;src/gameplay.c:584: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	inc	hl
	ld	a, (hl)
	add	a, #0x0a
	ld	hl, #222
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #217
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
	ld	hl, #220
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00230$
00229$:
	ld	hl, #220
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00230$:
	ld	hl, #223
	add	hl, sp
	ld	e, (hl)
	ld	hl, #220
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #222
	add	hl, sp
	ld	e, (hl)
	ld	d, b
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:584: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	jr	00175$
00168$:
;src/gameplay.c:585: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #222
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ldhl	sp,	#22
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
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:585: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #217
	add	hl, sp
	add	a, (hl)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
00175$:
;src/gameplay.c:590: if (oam_index < previous_oam_index) {
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00177$
;src/gameplay.c:591: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00177$:
;src/gameplay.c:593: previous_oam_index = oam_index;
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:446: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #144
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #32
	add	hl, sp
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/gameplay.c:595: if (died) {
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00184$
;src/gameplay.c:596: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:597: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:598: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:599: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:600: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:601: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:602: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:603: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:604: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:605: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00213$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00178$
	call	_wait_vbl_done
	inc	c
	jr	00213$
00178$:
;src/gameplay.c:606: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:607: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:608: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:609: if (level_songs[idx]) {
	ld	hl,#0xbe
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
;src/gameplay.c:610: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xd2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #225
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xd4
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #225
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
;src/gameplay.c:611: current_song_bank = song_bank[idx];
	ld	hl,#0xd4
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
;src/gameplay.c:615: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0xd6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #224
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #188
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #225
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:617: cam_px = 0;
	xor	a, a
	ld	hl, #224
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:618: cam_py = 112;
	ld	hl, #192
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:619: scroll_acc = 0;
	ld	hl, #198
	add	hl, sp
;src/gameplay.c:620: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:621: target_bg_idx = 0;
	ldhl	sp,	#6
;src/gameplay.c:622: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #13
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:623: sp_cache_reset(&active_sp, &sp_stream_idx);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_reset
;src/gameplay.c:624: sp_cache_col = 0xFFFF;
	ld	hl, #201
	add	hl, sp
;src/gameplay.c:625: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:626: cached_collision_col = 0xFFFF;
	ld	hl, #203
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:628: BGP_REG = bg_pals[0];
	ldhl	sp,	#7
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:629: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #190
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #186
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #182
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:630: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:631: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:632: enable_interrupts();
	jp	00184$
00185$:
;src/gameplay.c:636: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:638: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:640: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:642: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:643: }
	add	sp, #127
	add	sp, #99
	ret
___str_5:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_6:
	.ascii "Press A to exit"
	.db 0x00
	.area _CODE_10
	.area _INITIALIZER
	.area _CABS (ABS)
