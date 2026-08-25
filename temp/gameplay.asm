;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module gameplay
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _queue_tile_chunk
	.globl _hide_sprites_range
	.globl _sp_cache_load
	.globl _player_screen_y
	.globl _player_update
	.globl _player_init
	.globl _load_collision_columns
	.globl _load_bkg_tileset
	.globl _fill_scroll_bg
	.globl _prepare_mt_column
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
_mirror_state:
	.ds 1
_mirror_map_next:
	.ds 2
_mirror_map_target_end:
	.ds 2
_mirror_tiles_source:
	.ds 2
_mirror_tiles_bank:
	.ds 1
_mirror_tile_index:
	.ds 2
_mirror_tile_total:
	.ds 2
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
;src/gameplay.c:77: void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
;src/gameplay.c:79: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:80: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
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
;src/gameplay.c:81: }
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
;src/gameplay.c:83: void sp_cache_update(const Level *l, uint16_t cam_px,
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
;src/gameplay.c:87: uint8_t sp_bank = l->sp_bank;
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
;src/gameplay.c:88: const SpDef *sp_list = l->sp_list;
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
;src/gameplay.c:91: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:92: if (!cache->active[i]) continue;
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
;src/gameplay.c:93: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
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
;src/gameplay.c:92: if (!cache->active[i]) continue;
	ld	a, c
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:93: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
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
;src/gameplay.c:91: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#17
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:97: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:98: if (cache->active[i]) {
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
;src/gameplay.c:99: if (count != i) {
	ldhl	sp,	#22
	ld	a, (hl+)
	sub	a, (hl)
	jp	Z, 00108$
;src/gameplay.c:100: cache->obj[count] = cache->obj[i];
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
;src/gameplay.c:101: cache->px[count] = cache->px[i];
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
;src/gameplay.c:102: cache->py[count] = cache->py[i];
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
;src/gameplay.c:103: cache->active[count] = cache->active[i];
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
;src/gameplay.c:104: cache->activated[count] = cache->activated[i];
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
;src/gameplay.c:106: count++;
	ldhl	sp,	#22
	inc	(hl)
00117$:
;src/gameplay.c:97: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00116$
;src/gameplay.c:109: while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;
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
;src/gameplay.c:111: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
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
;src/gameplay.c:112: }
	add	sp, #24
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:115: static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x1
; ---------------------------------
_draw_oam_2x1:
	add	sp, #-5
	push	de
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:116: uint8_t i = oam_idx;
;src/gameplay.c:117: if (!reversed) {
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:118: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:119: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
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
;src/gameplay.c:121: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:122: shadow_OAM[i].y = sy; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
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
;src/gameplay.c:124: return 2;
	ld	a, #0x02
;src/gameplay.c:125: }
	add	sp, #7
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:128: static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x3
; ---------------------------------
_draw_oam_2x3:
	add	sp, #-9
	ld	c, e
	ld	b, d
	ldhl	sp,	#6
	ld	(hl), a
;src/gameplay.c:129: uint8_t i = oam_idx;
;src/gameplay.c:130: if (!reversed) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:131: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:132: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:133: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:134: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:135: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props; i++; meta++;
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
;src/gameplay.c:136: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props;
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
;src/gameplay.c:138: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:139: shadow_OAM[i].y = sy;    shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:140: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:141: shadow_OAM[i].y = sy+16; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:142: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx + 8; shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX; i++; meta++;
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
;src/gameplay.c:143: shadow_OAM[i].y = sy+32; shadow_OAM[i].x = sx;     shadow_OAM[i].tile = meta->dtile + tile_base; shadow_OAM[i].prop = meta->props ^ S_FLIPX;
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
;src/gameplay.c:145: return 6;
	ld	a, #0x06
;src/gameplay.c:146: }
	add	sp, #9
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:149: static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_3x3
; ---------------------------------
_draw_oam_3x3:
	add	sp, #-10
	ld	c, e
	ld	b, d
	ldhl	sp,	#7
	ld	(hl), a
;src/gameplay.c:150: uint8_t i = oam_idx;
;src/gameplay.c:151: if (!reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:152: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:153: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:154: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:155: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:156: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:157: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:158: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:159: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props; i++; meta++;
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
;src/gameplay.c:160: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props;
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
;src/gameplay.c:162: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:163: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:164: shadow_OAM[i].y=sy;    shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:165: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:166: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:167: shadow_OAM[i].y=sy+16; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:168: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+16; shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:169: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx+8;  shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX; i++; meta++;
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
;src/gameplay.c:170: shadow_OAM[i].y=sy+32; shadow_OAM[i].x=sx;    shadow_OAM[i].tile=meta->dtile+tile_base; shadow_OAM[i].prop=meta->props^S_FLIPX;
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
;src/gameplay.c:172: return 9;
	ld	a, #0x09
;src/gameplay.c:173: }
	add	sp, #10
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:175: static void process_sprite_logic(
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
;src/gameplay.c:180: uint16_t px = p->world_x;
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:181: uint16_t py = p->world_y.b.h;
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
;src/gameplay.c:184: uint16_t p_front = px + 15;
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
;src/gameplay.c:185: uint16_t p_bottom = py + PLAYER_SIZE;
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
;src/gameplay.c:186: uint16_t p_feet = py + PLAYER_SIZE;
	ld	(hl+), a
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:188: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:189: if (!cache->active[i]) break;
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
;src/gameplay.c:191: uint16_t obj_x = cache->px[i];
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
;src/gameplay.c:192: if (obj_x > cam_px + 176u) break;
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
;src/gameplay.c:194: uint8_t obj = cache->obj[i];
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
;src/gameplay.c:195: uint16_t obj_y = cache->py[i];
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
;src/gameplay.c:197: if (obj == OBJ_LEVEL_END) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:198: if (px >= (obj_x - 180)) p->level_complete = 1;
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
;src/gameplay.c:199: continue;
	jp	00201$
00108$:
;src/gameplay.c:202: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00198$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00198$
;src/gameplay.c:204: if (obj_x <= p_front && px <= obj_x + 48u) {
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
;src/gameplay.c:205: if (py <= obj_y + 14u && p_bottom >= obj_y) {
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
;src/gameplay.c:206: if (!cache->activated[i]) {
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
;src/gameplay.c:207: uint8_t target_flipped = (obj >= 18);
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x12
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	c, a
;src/gameplay.c:208: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, c
	jr	Z, 00110$
;src/gameplay.c:209: p->gravity_flipped = target_flipped;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/gameplay.c:210: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
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
;src/gameplay.c:212: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00201$
00198$:
;src/gameplay.c:216: } else if (obj_x + 2 <= p_front && px <= obj_x + 13) {
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
;src/gameplay.c:217: switch (obj) {
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
;src/gameplay.c:220: case OBJ_BALL_PORTAL:
00121$:
;src/gameplay.c:221: if (py <= obj_y + 32 && p_bottom >= obj_y) {
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
;src/gameplay.c:222: if (!cache->activated[i]) {
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
;src/gameplay.c:223: if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
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
;src/gameplay.c:224: else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
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
;src/gameplay.c:225: else p->mode = MODE_BALL;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
00127$:
;src/gameplay.c:226: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:229: break;
	jp	00201$
;src/gameplay.c:232: case OBJ_GRAVITY_UP:
00134$:
;src/gameplay.c:233: if (py <= obj_y + 32 && p_bottom >= obj_y) {
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
;src/gameplay.c:234: if (!cache->activated[i]) {
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
;src/gameplay.c:235: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00789$
	xor	a, a
00789$:
	ld	c, a
;src/gameplay.c:236: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, c
	jr	Z, 00136$
;src/gameplay.c:237: p->gravity_flipped = target_flipped;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/gameplay.c:238: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
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
;src/gameplay.c:240: cache->activated[i] = 1;
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:243: break;
	jp	00201$
;src/gameplay.c:249: case OBJ_PAD_BLUE_UP:
00146$:
;src/gameplay.c:251: uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
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
;src/gameplay.c:252: uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
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
;src/gameplay.c:253: uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);
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
;src/gameplay.c:255: if (py <= pad_bot && p_feet >= pad_top) {
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
;src/gameplay.c:256: if (!cache->activated[i]) {
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
;src/gameplay.c:257: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:258: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00150$
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00151$
00150$:
;src/gameplay.c:259: p->gravity_flipped = !p->gravity_flipped;
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
;src/gameplay.c:260: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
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
;src/gameplay.c:261: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00148$
;src/gameplay.c:262: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
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
;src/gameplay.c:263: p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
;src/gameplay.c:265: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
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
;src/gameplay.c:266: p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
;src/gameplay.c:268: p->on_ground = 0;
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
;src/gameplay.c:271: break;
	jp	00201$
;src/gameplay.c:276: case OBJ_ORB_BLUE:
00161$:
;src/gameplay.c:278: if (joy & J_A) {
	ldhl	sp,	#44
	ld	a, (hl)
	or	a, a
	jp	Z, 00201$
;src/gameplay.c:279: if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
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
;src/gameplay.c:280: if (!cache->activated[i]) {
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
;src/gameplay.c:281: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:282: p->orb_buffered = 0; // Clear buffer after hit
	ldhl	sp,	#42
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:283: if (obj == OBJ_ORB_BLUE) {
	ldhl	sp,	#62
	ld	a, (hl)
	or	a, a
	jr	Z, 00166$
;src/gameplay.c:284: p->gravity_flipped = !p->gravity_flipped;
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
;src/gameplay.c:285: int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
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
;src/gameplay.c:286: p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
;src/gameplay.c:287: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#55
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00163$
;src/gameplay.c:288: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
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
;src/gameplay.c:289: p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
;src/gameplay.c:291: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
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
;src/gameplay.c:292: p->vel_y.w = (p->gravity_flipped) ? -force : force;
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
;src/gameplay.c:294: p->on_ground = 0;
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
;src/gameplay.c:298: break;
	jp	00201$
;src/gameplay.c:301: case 100: case 101: case 102: case 103:
00180$:
;src/gameplay.c:302: if (!cache->activated[i]) {
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
;src/gameplay.c:303: *target_bg_idx = obj - 100;
	ldhl	sp,	#73
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#55
	ld	a, (hl)
	add	a, #0x9c
	ld	(de), a
;src/gameplay.c:304: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:306: continue;
	jr	00201$
;src/gameplay.c:309: case OBJ_MIRROR_EXIT:
00184$:
;src/gameplay.c:310: if (py <= obj_y + 32 && p_bottom >= obj_y) {
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
;src/gameplay.c:311: if (!cache->activated[i]) {
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
;src/gameplay.c:312: p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
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
;src/gameplay.c:313: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:317: }
	jr	00201$
00194$:
;src/gameplay.c:318: } else if (obj_x > p_front + 16) {
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
;src/gameplay.c:319: break;
00201$:
;src/gameplay.c:188: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#67
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00203$
00204$:
;src/gameplay.c:322: }
	add	sp, #68
	pop	hl
	add	sp, #5
	jp	(hl)
;src/gameplay.c:324: static uint8_t draw_sprites(
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
;src/gameplay.c:329: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
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
;src/gameplay.c:330: if (!cache->active[i]) break;
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
;src/gameplay.c:332: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#18
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:333: if (obj_x > cam_px + 176u) break;
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
;src/gameplay.c:335: uint8_t obj = cache->obj[i];
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
;src/gameplay.c:336: uint16_t obj_y = cache->py[i];
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:338: if (obj == OBJ_LEVEL_END || obj >= 100) continue;
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0f
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x64
	jp	NC, 00150$
;src/gameplay.c:340: int16_t rel_x = (int16_t)obj_x - (int16_t)cam_px;
	inc	hl
	ld	a, c
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;src/gameplay.c:341: if (rel_x < -64 || rel_x > 176) continue;
	ld	a, c
	sub	a, #0xc0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jp	C, 00150$
	ld	l, c
	ld	h, b
	ld	e, h
	ld	d, #0x00
	ld	a, #0xb0
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00373$
	bit	7, d
	jr	NZ, 00374$
	cp	a, a
	jr	00374$
00373$:
	bit	7, d
	jr	Z, 00374$
	scf
00374$:
	jp	C, 00150$
;src/gameplay.c:345: screen_x = 128 - (uint8_t)rel_x + 8;
	ldhl	sp,	#12
	ld	(hl), c
;src/gameplay.c:344: if (reversed) {
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;src/gameplay.c:345: screen_x = 128 - (uint8_t)rel_x + 8;
	ld	a, #0x88
	ldhl	sp,	#12
	sub	a, (hl)
	dec	hl
	ld	(hl), a
	jr	00113$
00112$:
;src/gameplay.c:347: screen_x = (uint8_t)rel_x + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#12
	ld	a, (hl-)
	add	a, #0x28
	ld	(hl), a
00113$:
;src/gameplay.c:350: uint8_t screen_y = ((uint8_t)obj_y - (uint8_t)cam_py) + 16;
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#21
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#12
;src/gameplay.c:352: if (screen_x > 160 && screen_x < 232) continue;
	ld	(hl-), a
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00115$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00150$
00115$:
;src/gameplay.c:353: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#12
	sub	a, (hl)
	jr	NC, 00118$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00150$
00118$:
;src/gameplay.c:355: if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
	ld	a, #0x1f
	ldhl	sp,	#24
	sub	a, (hl)
	jp	C, 00151$
;src/gameplay.c:356: if (obj >= 38 || famidash_sprite_table[obj] == 0) continue;
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
;src/gameplay.c:359: if (obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
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
;src/gameplay.c:360: obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
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
;src/gameplay.c:361: obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00150$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00150$
;src/gameplay.c:365: const metasprite_t *sprite = famidash_sprite_table[obj];
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:367: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00147$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00147$
;src/gameplay.c:368: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
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
;src/gameplay.c:368: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
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
;src/gameplay.c:369: else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#13
	add	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jp	00150$
00147$:
;src/gameplay.c:370: } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
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
;src/gameplay.c:371: oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
;src/gameplay.c:372: } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00137$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00138$
00137$:
;src/gameplay.c:373: oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
;src/gameplay.c:375: oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
;src/gameplay.c:329: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00156$
00151$:
;src/gameplay.c:378: return oam_start;
	ldhl	sp,	#24
	ld	a, (hl)
;src/gameplay.c:379: }
	add	sp, #19
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:381: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 10
_setup_menu_font::
;src/gameplay.c:382: font_init();
	call	_font_init
;src/gameplay.c:383: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:384: }
	ret
;src/gameplay.c:386: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 10
_draw_menu::
;src/gameplay.c:387: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:388: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:389: printf("GD POCKET DEMO 01\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:390: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:391: gotoxy(1, 2 + i);
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
;src/gameplay.c:392: if (i == selected) printf("0 %s", game_levels[i]->name);
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
;src/gameplay.c:393: else printf("  %s", game_levels[i]->name);
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
;src/gameplay.c:390: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:395: printf("\n\n\n\n\n\n\nSotospro24");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:396: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:397: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:398: }
	ret
___str_1:
	.ascii "GD POCKET DEMO 01"
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
	.ascii "Sotospro24"
	.db 0x00
;src/gameplay.c:400: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 10
_play_level::
	ld	hl, #-482
	add	hl, sp
	ld	sp, hl
;src/gameplay.c:410: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #488
	add	hl, sp
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ld	hl, #480
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
	ld	hl, #434
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:411: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #480
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #479
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #476
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:412: level_map = l->map;
	ld	hl,#0x1b2
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
	ld	hl, #436
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:413: level_tile_count = l->tile_count;
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
	ld	hl, #438
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:414: level_map_w = l->map_width;
	ld	hl,#0x1b2
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
	ld	hl, #440
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:415: level_map_h = l->map_height;
	ld	hl,#0x1b2
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
	ld	hl, #442
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:416: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:417: level_map_bank = l->map_bank;
	ld	hl,#0x1b2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #445
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:419: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:420: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:421: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:423: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #480
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #448
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #447
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
;src/gameplay.c:424: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0x1b2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #481
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #488
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #483
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:425: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:426: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:429: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #480
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:430: uint16_t cam_py = 112;
	ld	hl, #448
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:431: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #442
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
;src/gameplay.c:432: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #474
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
	ld	hl,#0x1da
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
	ld	hl, #450
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:433: else cam_py_max = 0;
	xor	a, a
	ld	hl, #450
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:434: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #452
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:439: uint8_t target_bg_idx = 0;
	ldhl	sp,	#4
;src/gameplay.c:440: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:448: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:451: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:452: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #444
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #439
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #477
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:453: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:454: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:455: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
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
;src/gameplay.c:457: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #446
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #442
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #438
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:458: BGP_REG = bg_pals[0];
	ldhl	sp,	#5
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:459: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:460: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:461: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:462: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:463: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:464: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:465: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:468: uint16_t scroll_acc = 0;
	ld	hl, #454
	add	hl, sp
;src/gameplay.c:469: uint8_t prev_joy = 0;
;src/gameplay.c:470: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:472: uint16_t sp_stream_idx = 0;
	xor	a, a
	ld	hl, #144
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:473: uint16_t sp_cache_col = 0xFFFF;
	ld	hl, #457
	add	hl, sp
;src/gameplay.c:475: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:476: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #461
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:477: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #144
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #32
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_sp_cache_reset
;src/gameplay.c:478: while (1) {
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #462
	add	hl, sp
	ld	(hl), a
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	ld	hl, #463
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x1b2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #466
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #465
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x1b2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #468
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #467
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank
	ld	hl, #488
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #470
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #469
	add	hl, sp
	ld	(hl), a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #470
	add	hl, sp
	ld	(hl), a
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	ld	hl, #471
	add	hl, sp
	ld	(hl), a
00196$:
;src/gameplay.c:479: uint8_t joy = joypad();
	call	_joypad
	ld	hl, #474
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:480: if (joy & J_START) break;
	push	hl
	ld	hl, #476
	add	hl, sp
	bit	7, (hl)
	pop	hl
	jp	NZ, 00197$
;src/gameplay.c:482: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ld	hl, #476
	add	hl, sp
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#27
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:483: HIDE_SPRITES;
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
;src/gameplay.c:486: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:488: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:489: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:490: printf("LEVEL COMPLETE");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:491: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:492: printf("Press A to exit");
	ld	de, #___str_6
	push	de
	call	_printf
	pop	de
;src/gameplay.c:493: waitpadup();
	call	_waitpadup
;src/gameplay.c:494: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00197$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:495: break;
00112$:
;src/gameplay.c:498: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ld	hl, #476
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ld	hl, #457
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
;src/gameplay.c:499: prev_joy = joy;
	ld	hl, #474
	add	hl, sp
	ld	a, (hl)
	ld	hl, #455
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:501: uint16_t px_prev = cam_px >> 4;
	ld	hl,#0x1e0
	add	hl,sp
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:502: uint8_t needs_render = 0;
	ld	a, (hl-)
	dec	hl
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	(hl), #0x00
;src/gameplay.c:503: uint16_t need_col = 0;
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:506: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #440
	add	hl, sp
	ld	a, (hl+)
	ld	e, (hl)
	add	a, #0xf6
	ld	l, a
	ld	a, e
	adc	a, #0xff
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #480
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	ld	hl, #481
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jp	NC, 00123$
;src/gameplay.c:507: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #454
	add	hl, sp
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x02ca
	add	hl, de
	ld	e, l
	ld	d, h
;src/gameplay.c:508: cam_px += scroll_acc >> 8;
	ld	hl, #477
	add	hl, sp
	ld	a, d
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ld	hl, #482
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #481
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:509: scroll_acc &= 0xFF;
	ld	hl, #454
	add	hl, sp
	ld	(hl), e
;src/gameplay.c:510: uint16_t px_curr = cam_px >> 4;
	ld	hl,#0x1e0
	add	hl,sp
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
;src/gameplay.c:511: if (px_curr != px_prev) {
	ld	a, e
	sub	a, c
	jr	NZ, 00634$
	ld	a, d
	sub	a, b
	jr	Z, 00123$
00634$:
;src/gameplay.c:512: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
;src/gameplay.c:513: if (need > loaded_r && need < level_map_w) {
	ld	hl, #452
	add	hl, sp
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00123$
	ld	hl, #440
	add	hl, sp
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:514: needs_render = 1;
	ld	hl, #479
	add	hl, sp
	ld	(hl), #0x01
;src/gameplay.c:515: need_col = need;
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:516: prof_column_changed_count++;
	ld	a, (_prof_column_changed_count)
	ld	c, a
	ld	hl, #_prof_column_changed_count + 1
	ld	a, (hl-)
	ld	b, a
	inc	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/gameplay.c:521: player.world_x = cam_px;
	ld	hl, #480
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ld	hl, #481
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
;src/gameplay.c:501: uint16_t px_prev = cam_px >> 4;
	ld	hl, #480
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	ld	hl, #481
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
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
;src/gameplay.c:524: if ((cam_px >> 4) != sp_cache_col) {
	ld	hl, #457
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00635$
	ld	hl, #458
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00125$
00635$:
;src/gameplay.c:525: sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
	ld	hl, #144
	add	hl, sp
	push	hl
	ld	hl, #34
	add	hl, sp
	push	hl
	ld	hl, #484
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #438
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:526: sp_cache_col = cam_px >> 4;
	ld	hl, #477
	add	hl, sp
	ld	a, (hl)
	ld	hl, #457
	add	hl, sp
	ld	(hl), a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #458
	add	hl, sp
	ld	(hl), a
00125$:
;src/gameplay.c:529: if (player.reversed != prev_reversed) {
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #476
	add	hl, sp
	ld	(hl), a
	ld	hl, #461
	add	hl, sp
	ld	a, (hl)
	ld	hl, #476
	add	hl, sp
	sub	a, (hl)
	jp	Z, 00127$
;src/gameplay.c:531: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00227$
	ld	hl,#0x1d0
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #477
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jr	00228$
00227$:
	ld	hl,#0x1ce
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #477
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
00228$:
	ld	hl, #477
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_tiles_source),a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_tiles_source + 1),a
;src/gameplay.c:533: mirror_tiles_bank = level_tiles_bank;
	ld	hl, #444
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_tiles_bank),a
;src/gameplay.c:534: mirror_tile_index = 0;
	xor	a, a
	ld	hl, #_mirror_tile_index
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:535: mirror_tile_total = level_tile_count;
	ld	hl, #438
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_tile_total),a
	ld	hl, #439
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_tile_total + 1),a
;src/gameplay.c:536: mirror_state = MIRROR_LOAD_TILES;
	ld	hl, #_mirror_state
	ld	(hl), #0x01
;src/gameplay.c:537: prof_mirror_transitions++;
	ld	a, (_prof_mirror_transitions)
	ld	c, a
	ld	hl, #_prof_mirror_transitions + 1
	ld	a, (hl-)
	ld	b, a
	inc	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:501: uint16_t px_prev = cam_px >> 4;
	ld	hl, #480
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	ld	hl, #481
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
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
;src/gameplay.c:539: uint16_t start_col = cam_px >> 4;
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl-)
	dec	hl
;src/gameplay.c:540: mirror_map_next = start_col;
	ld	(hl-), a
	ld	a, (hl)
	ld	(#_mirror_map_next),a
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_map_next + 1),a
;src/gameplay.c:541: mirror_map_target_end = start_col + 15;
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	ld	hl, #472
	add	hl, sp
	ld	(hl), a
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	ld	hl, #473
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #476
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	(#_mirror_map_target_end),a
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	ld	(#_mirror_map_target_end + 1),a
;src/gameplay.c:542: prev_reversed = player.reversed;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #461
	add	hl, sp
	ld	(hl), a
00127$:
;src/gameplay.c:545: uint16_t collision_col = cam_px >> 4;
;src/gameplay.c:546: if (collision_col != cached_collision_col) {
	ld	hl, #459
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00637$
	ld	hl, #460
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00129$
00637$:
;src/gameplay.c:548: level_map_bank, collision_columns);
;src/gameplay.c:547: load_collision_columns(collision_col, level_map, level_map_w,
	ld	hl, #146
	add	hl, sp
	push	hl
	ld	hl, #447
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #443
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #441
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #482
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:549: cached_collision_col = collision_col;
	ld	hl, #477
	add	hl, sp
	ld	a, (hl)
	ld	hl, #459
	add	hl, sp
	ld	(hl), a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #460
	add	hl, sp
	ld	(hl), a
00129$:
;src/gameplay.c:553: if (mirror_state == MIRROR_LOAD_TILES) {
	ld	a, (#_mirror_state)
	dec	a
	jp	NZ, 00145$
;src/gameplay.c:555: uint8_t chunk_tiles = (uint8_t)( (mirror_tile_total - mirror_tile_index) >= TILE_CHUNK_TILES ? TILE_CHUNK_TILES : (mirror_tile_total - mirror_tile_index) );
	ld	hl, #_mirror_tile_total
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_mirror_tile_index
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #478
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	sub	a, #0x10
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00229$
	ld	c, #0x10
	jr	00230$
00229$:
	ld	a, (_mirror_tile_total)
	ld	hl, #_mirror_tile_index
	ld	c, (hl)
	sub	a, c
	ld	c, a
00230$:
;src/gameplay.c:556: if (chunk_tiles > 0) {
	ld	a, c
	or	a, a
	jp	Z, 00132$
;src/gameplay.c:557: uint16_t chunk_bytes = (uint16_t)chunk_tiles * 16u; // 16 bytes per tile
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	b, h
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:560: uint8_t prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	hl, #473
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:561: SWITCH_ROM(mirror_tiles_bank);
	ld	a, (_mirror_tiles_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/gameplay.c:563: for (uint16_t i = 0; i < chunk_bytes; i++) {
	xor	a, a
	ld	hl, #477
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00220$:
	ld	hl, #477
	add	hl, sp
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00130$
;src/gameplay.c:564: tile_chunk[i] = mirror_tiles_source[(uint32_t)mirror_tile_index * 16u + i];
	push	hl
	ld	hl, #180
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ld	hl, #477
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #476
	add	hl, sp
	ld	(hl), a
	ld	a, (_mirror_tile_index)
	ld	l, a
	ld	a, (_mirror_tile_index + 1)
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	b, h
	ld	hl, #477
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	add	a, e
	ld	e, a
	ld	a, b
	adc	a, d
	ld	d, a
	ld	a, e
	ld	hl, #_mirror_tiles_source
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, d
	adc	a, (hl)
	ld	d, a
	ld	a, (de)
	ld	hl, #475
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:563: for (uint16_t i = 0; i < chunk_bytes; i++) {
	ld	hl, #477
	add	hl, sp
	inc	(hl)
	jr	NZ, 00220$
	inc	hl
	inc	(hl)
	jr	00220$
00130$:
;src/gameplay.c:566: SWITCH_ROM(prev);
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/gameplay.c:568: queue_tile_chunk(mirror_tile_index, chunk_tiles, tile_chunk);
	ld	hl, #178
	add	hl, sp
	push	bc
	push	hl
	ld	a, c
	ld	hl, #_mirror_tile_index
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_queue_tile_chunk
	pop	bc
;src/gameplay.c:569: mirror_tile_index += chunk_tiles;
	ld	b, #0x00
	ld	a, (_mirror_tile_index)
	ld	l, a
	ld	a, (_mirror_tile_index + 1)
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_mirror_tile_index
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00132$:
;src/gameplay.c:571: if (mirror_tile_index >= mirror_tile_total) {
	ld	de, #_mirror_tile_index
	ld	hl, #_mirror_tile_total
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00146$
;src/gameplay.c:572: mirror_state = MIRROR_REDRAW_MAP;
	ld	hl, #_mirror_state
	ld	(hl), #0x02
	jp	00146$
00145$:
;src/gameplay.c:574: } else if (mirror_state == MIRROR_REDRAW_MAP) {
	ld	a, (#_mirror_state)
	sub	a, #0x02
	jp	NZ, 00146$
;src/gameplay.c:575: if (mirror_map_next <= mirror_map_target_end) {
	ld	de, #_mirror_map_target_end
	ld	hl, #_mirror_map_next
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00140$
;src/gameplay.c:576: uint16_t curr_col = mirror_map_next;
	ld	a, (#_mirror_map_next)
	ld	hl, #475
	add	hl, sp
	ld	(hl), a
	ld	a, (#_mirror_map_next + 1)
	ld	hl, #476
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:577: mirror_map_next++;
	ld	hl, #_mirror_map_next
	inc	(hl)
	jr	NZ, 00643$
	inc	hl
	inc	(hl)
00643$:
;src/gameplay.c:578: if (curr_col < level_map_w) {
	ld	hl, #475
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #440
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00146$
;src/gameplay.c:579: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
	ld	hl, #478
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:476: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:580: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
	inc	hl
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00136$:
;src/gameplay.c:581: prepare_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	hl, #477
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #446
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #442
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #440
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #481
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	call	_prepare_mt_column
	jr	00146$
00140$:
;src/gameplay.c:584: mirror_state = MIRROR_IDLE;
	xor	a, a
	ld	(#_mirror_state),a
00146$:
;src/gameplay.c:591: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	ld	hl, #4
	add	hl, sp
;src/gameplay.c:448: player_init(&player, 0, 240);
;src/gameplay.c:477: sp_cache_reset(&active_sp, &sp_stream_idx);
;src/gameplay.c:591: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	push	hl
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #12
	add	hl, sp
	push	hl
	ld	hl, #485
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #37
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_process_sprite_logic
;src/gameplay.c:593: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #146
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #442
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	push	bc
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #13
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #472
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:595: py = player_screen_y(&player, cam_py);
	ld	hl, #448
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #9
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:596: if (py < CAM_Y_TOP_ZONE) {
	ld	hl, #475
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:599: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	hl, #450
	add	hl, sp
	ld	a, (hl)
	ld	hl, #477
	add	hl, sp
	ld	(hl), a
	ld	hl, #451
	add	hl, sp
	ld	a, (hl)
	ld	hl, #478
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:596: if (py < CAM_Y_TOP_ZONE) {
	ld	hl, #475
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00644$
	bit	7, d
	jr	NZ, 00645$
	cp	a, a
	jr	00645$
00644$:
	bit	7, d
	jr	Z, 00645$
	scf
00645$:
	jr	NC, 00158$
;src/gameplay.c:597: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#12
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:598: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00148$
	ld	bc, #0x0000
00148$:
;src/gameplay.c:599: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #450
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00150$
	ld	hl, #477
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00150$:
;src/gameplay.c:600: cam_py = (uint16_t)target_cam_py;
	ld	hl, #448
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00159$
00158$:
;src/gameplay.c:602: else if (py > CAM_Y_BOTTOM_ZONE) {
	ld	hl, #475
	add	hl, sp
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00159$
;src/gameplay.c:603: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#12
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:604: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00152$
	ld	bc, #0x0000
00152$:
;src/gameplay.c:605: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #450
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00154$
	ld	hl, #477
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00154$:
;src/gameplay.c:606: cam_py = (uint16_t)target_cam_py;
	ld	hl, #448
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00159$:
;src/gameplay.c:611: if (player.reversed) {
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jr	Z, 00161$
;src/gameplay.c:613: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ld	hl, #480
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
	ld	hl, #473
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:614: sprite_x_final = 128; // Mirrored player position
	ld	hl, #478
	add	hl, sp
	ld	(hl), #0x80
	jr	00162$
00161$:
;src/gameplay.c:616: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #480
	add	hl, sp
	ld	a, (hl)
	ld	hl, #475
	add	hl, sp
	ld	(hl), a
	ld	hl, #481
	add	hl, sp
	ld	a, (hl)
	ld	hl, #476
	add	hl, sp
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00231$
	ld	hl,#0x1db
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
	ld	hl, #478
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	jr	00232$
00231$:
	xor	a, a
	ld	hl, #477
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00232$:
	ld	hl, #477
	add	hl, sp
	ld	a, (hl)
	ld	hl, #473
	add	hl, sp
	ld	(hl), a
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	ld	hl, #474
	add	hl, sp
;src/gameplay.c:617: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	(hl+), a
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00233$
	ld	hl, #480
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	jr	00234$
00233$:
	ld	a, #0x20
00234$:
	ld	hl, #478
	add	hl, sp
	ld	(hl), a
00162$:
;src/gameplay.c:619: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #448
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #9
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ld	hl, #476
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:621: if (needs_render) {
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00166$
;src/gameplay.c:622: loaded_r = need_col;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #452
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #453
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:623: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:476: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #475
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:624: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00164$
	xor	a, a
	ld	hl, #479
	add	hl, sp
	sub	a, (hl)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00164$:
;src/gameplay.c:626: prepare_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #446
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #442
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #440
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #485
	add	hl, sp
	ld	a, (hl)
	call	_prepare_mt_column
00166$:
;src/gameplay.c:630: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:631: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #7
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#4
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
;src/gameplay.c:632: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #448
	add	hl, sp
	ld	c, (hl)
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:634: uint8_t oam_index = draw_sprites(
	ldhl	sp,	#19
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	hl, #450
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #484
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #36
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_draw_sprites
	ld	hl, #473
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:639: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:476: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	hl, #474
	add	hl, sp
;src/gameplay.c:641: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #475
	add	hl, sp
	ld	(hl), a
	ld	a, (hl+)
	add	a, #0x18
;src/gameplay.c:642: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
;src/gameplay.c:644: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:639: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#3
	ld	a, (hl)
	dec	a
	jp	NZ, 00186$
;src/gameplay.c:640: if (player.gravity_flipped) {
	ldhl	sp,	#17
	ld	a, (hl)
	or	a, a
	jp	Z, 00174$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #478
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:641: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #474
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #475
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x18
	ld	(hl), a
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	hl, #474
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	hl, #476
	add	hl, sp
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00235$
	ld	bc, #0x0010
	jr	00236$
00235$:
	ld	bc, #0x0008
00236$:
	ld	hl, #479
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
;src/gameplay.c:641: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00168$:
;src/gameplay.c:642: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	hl, #475
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	ld	hl, #476
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
	ld	hl, #478
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00237$
	ld	hl, #474
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00238$
00237$:
	ld	hl, #474
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00238$:
	ld	hl, #479
	add	hl, sp
	ld	e, (hl)
	ld	hl, #474
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #477
	add	hl, sp
	ld	a, (hl-)
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:642: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00174$:
;src/gameplay.c:644: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #474
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00171$
	ld	hl, #478
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
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:644: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00171$:
;src/gameplay.c:645: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #478
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ld	hl, #_ship_metasprites + 1
	ld	a,	(hl-)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	e, (hl)
	ld	d, a
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
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:645: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00186$:
;src/gameplay.c:648: if (player.gravity_flipped) {
	ldhl	sp,	#17
	ld	c, (hl)
;src/gameplay.c:642: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:648: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jp	Z, 00183$
;src/gameplay.c:649: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #474
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
	ld	hl, #479
	add	hl, sp
	ld	c, (hl)
	ld	hl, #476
	add	hl, sp
	ld	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#20
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	ld	hl, #480
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
	jr	Z, 00239$
	ld	hl, #0x0010
	jr	00240$
00239$:
	ld	hl, #0x0008
00240$:
	ld	a, c
	sub	a, l
	ld	d, a
	ld	hl, #479
	add	hl, sp
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:649: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00177$:
;src/gameplay.c:650: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #478
	add	hl, sp
	ld	b, (hl)
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	add	a, #0x16
	ld	c, a
	ldhl	sp,	#20
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
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:650: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jp	00187$
00183$:
;src/gameplay.c:652: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #474
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00180$
	inc	hl
	ld	a, (hl)
	add	a, #0x0a
	ld	hl, #478
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#20
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #473
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
	jr	Z, 00241$
	ld	hl, #476
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00242$
00241$:
	ld	hl, #476
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00242$:
	ld	hl, #479
	add	hl, sp
	ld	e, (hl)
	ld	hl, #476
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #478
	add	hl, sp
	ld	e, (hl)
	ld	d, b
	ld	hl, #475
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:652: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
	jr	00187$
00180$:
;src/gameplay.c:653: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #478
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ldhl	sp,	#20
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
	ld	hl, #473
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:653: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #473
	add	hl, sp
	add	a, (hl)
	ld	hl, #479
	add	hl, sp
	ld	(hl), a
00187$:
;src/gameplay.c:658: if (oam_index < previous_oam_index) {
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	ld	hl, #456
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00189$
;src/gameplay.c:659: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00189$:
;src/gameplay.c:661: previous_oam_index = oam_index;
	ld	hl, #479
	add	hl, sp
	ld	a, (hl)
	ld	hl, #456
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:663: if (died) {
	ld	hl, #472
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00196$
;src/gameplay.c:664: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:665: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:666: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:667: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:668: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:669: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:670: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:671: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:672: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:673: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00223$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00190$
	call	_wait_vbl_done
	inc	c
	jr	00223$
00190$:
;src/gameplay.c:674: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:675: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:676: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:677: if (level_songs[idx]) {
	ld	hl,#0x1be
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
	jr	Z, 00192$
;src/gameplay.c:678: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0x1d2
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #481
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x1d4
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #481
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
;src/gameplay.c:679: current_song_bank = song_bank[idx];
	ld	hl,#0x1d4
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00192$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:683: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0x1d6
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #480
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #444
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #439
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #481
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:691: cam_px = 0;
	xor	a, a
	ld	hl, #480
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:692: cam_py = 112;
	ld	hl, #448
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:693: scroll_acc = 0;
	ld	hl, #454
	add	hl, sp
;src/gameplay.c:694: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:695: target_bg_idx = 0;
	ldhl	sp,	#4
;src/gameplay.c:696: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:697: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #144
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #32
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_sp_cache_reset
;src/gameplay.c:698: sp_cache_col = 0xFFFF;
	ld	hl, #457
	add	hl, sp
;src/gameplay.c:699: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:700: cached_collision_col = 0xFFFF;
	ld	hl, #459
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:702: BGP_REG = bg_pals[0];
	ldhl	sp,	#5
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:703: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #446
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #442
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #438
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:704: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:705: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:706: enable_interrupts();
	jp	00196$
00197$:
;src/gameplay.c:710: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:712: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:714: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:716: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:717: }
	ld	hl, #482
	add	hl, sp
	ld	sp, hl
	ret
___str_5:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_6:
	.ascii "Press A to exit"
	.db 0x00
	.area _CODE_10
	.area _INITIALIZER
__xinit__mirror_state:
	.db #0x00	; 0
__xinit__mirror_map_next:
	.dw #0x0000
__xinit__mirror_map_target_end:
	.dw #0x0000
__xinit__mirror_tiles_source:
	.dw #0x0000
__xinit__mirror_tiles_bank:
	.db #0x00	; 0
__xinit__mirror_tile_index:
	.dw #0x0000
__xinit__mirror_tile_total:
	.dw #0x0000
	.area _CABS (ABS)
