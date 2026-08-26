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
;src/gameplay.c:137: void sp_cache_reset(SpCache *cache, uint16_t *stream_idx) {
;	---------------------------------
; Function sp_cache_reset
; ---------------------------------
_sp_cache_reset::
;src/gameplay.c:139: *stream_idx = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/gameplay.c:140: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) cache->active[i] = 0;
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
;src/gameplay.c:141: }
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
_gbc_bg_palettes:
	.dw #0x0000
	.dw #0x0842
	.dw #0x14a5
	.dw #0x294a
	.dw #0x0800
	.dw #0x1420
	.dw #0x2840
	.dw #0x3ca0
	.dw #0x0820
	.dw #0x1c60
	.dw #0x30c0
	.dw #0x4942
	.dw #0x0c01
	.dw #0x1c22
	.dw #0x3045
	.dw #0x48a7
	.dw #0x1402
	.dw #0x2825
	.dw #0x3c47
	.dw #0x50aa
	.dw #0x0c03
	.dw #0x1c27
	.dw #0x304c
	.dw #0x48b2
	.dw #0x0805
	.dw #0x142a
	.dw #0x1c4f
	.dw #0x28b6
	.dw #0x0005
	.dw #0x042a
	.dw #0x084f
	.dw #0x14b6
	.dw #0x0045
	.dw #0x04aa
	.dw #0x08ef
	.dw #0x1576
	.dw #0x00a5
	.dw #0x054a
	.dw #0x09ef
	.dw #0x16d6
	.dw #0x00a2
	.dw #0x0545
	.dw #0x09e7
	.dw #0x16ca
	.dw #0x00a0
	.dw #0x0541
	.dw #0x09e2
	.dw #0x16c5
	.dw #0x0ca0
	.dw #0x1d41
	.dw #0x31e2
	.dw #0x4ac5
	.dw #0x1440
	.dw #0x28a1
	.dw #0x3ce2
	.dw #0x5945
	.dw #0x294a
	.dw #0x3def
	.dw #0x5ad6
	.dw #0x7fff
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0842
	.dw #0x294a
	.dw #0x4a52
	.dw #0x6739
	.dw #0x1c40
	.dw #0x48e0
	.dw #0x6d82
	.dw #0x7e8a
	.dw #0x28a0
	.dw #0x5982
	.dw #0x7247
	.dw #0x7f2f
	.dw #0x2823
	.dw #0x58a7
	.dw #0x7d4c
	.dw #0x7e54
	.dw #0x3026
	.dw #0x58ab
	.dw #0x7d51
	.dw #0x7e37
	.dw #0x282a
	.dw #0x48b2
	.dw #0x6d5b
	.dw #0x7e3f
	.dw #0x182c
	.dw #0x30b6
	.dw #0x495f
	.dw #0x665f
	.dw #0x042c
	.dw #0x14b6
	.dw #0x295f
	.dw #0x4a5f
	.dw #0x04cc
	.dw #0x1596
	.dw #0x2a5f
	.dw #0x4b3f
	.dw #0x058c
	.dw #0x16d6
	.dw #0x2bff
	.dw #0x5bff
	.dw #0x0586
	.dw #0x16cc
	.dw #0x2bf2
	.dw #0x4bf9
	.dw #0x0581
	.dw #0x16c5
	.dw #0x2bea
	.dw #0x4bf2
	.dw #0x2981
	.dw #0x4ac5
	.dw #0x6fea
	.dw #0x7ff2
	.dw #0x30a1
	.dw #0x5945
	.dw #0x7dea
	.dw #0x7ed2
	.dw #0x4a52
	.dw #0x6739
	.dw #0x7fff
	.dw #0x7fff
	.dw #0x0842
	.dw #0x0421
	.dw #0x0000
	.dw #0x0000
	.dw #0x318c
	.dw #0x5ad6
	.dw #0x739c
	.dw #0x7fff
	.dw #0x5945
	.dw #0x7e2c
	.dw #0x7f34
	.dw #0x7fdb
	.dw #0x65e7
	.dw #0x7ecf
	.dw #0x7f76
	.dw #0x7ffc
	.dw #0x654c
	.dw #0x7e34
	.dw #0x7ed9
	.dw #0x7f7e
	.dw #0x6d51
	.dw #0x7e36
	.dw #0x7edb
	.dw #0x7f7f
	.dw #0x5956
	.dw #0x6e3b
	.dw #0x7edf
	.dw #0x7f9f
	.dw #0x4559
	.dw #0x5a3f
	.dw #0x6eff
	.dw #0x7fdf
	.dw #0x2959
	.dw #0x463f
	.dw #0x5eff
	.dw #0x7bdf
	.dw #0x29f9
	.dw #0x46df
	.dw #0x5f7f
	.dw #0x7bff
	.dw #0x2b39
	.dw #0x47ff
	.dw #0x5fff
	.dw #0x7bff
	.dw #0x2b31
	.dw #0x47f7
	.dw #0x5ffb
	.dw #0x7bff
	.dw #0x2b2a
	.dw #0x47f1
	.dw #0x5ff7
	.dw #0x7bfe
	.dw #0x5b2a
	.dw #0x73f1
	.dw #0x7bf7
	.dw #0x7ffe
	.dw #0x65ea
	.dw #0x7ed1
	.dw #0x7f77
	.dw #0x7fde
	.dw #0x7fff
	.dw #0x7fff
	.dw #0x7fff
	.dw #0x7fff
	.dw #0x18c6
	.dw #0x0c63
	.dw #0x0421
	.dw #0x0000
_gbc_sprite_palettes:
	.dw #0x7fff
	.dw #0x7fe0
	.dw #0x7e40
	.dw #0x0000
	.dw #0x7fff
	.dw #0x7d9f
	.dw #0x64d9
	.dw #0x0000
;src/gameplay.c:143: void sp_cache_update(const Level *l, uint16_t cam_px,
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
;src/gameplay.c:147: uint8_t sp_bank = l->sp_bank;
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
;src/gameplay.c:148: const SpDef *sp_list = l->sp_list;
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
;src/gameplay.c:151: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:152: if (!cache->active[i]) continue;
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
	or	a, a
	jr	Z, 00105$
;src/gameplay.c:153: if (cache->px[i] + 32u < cam_px) cache->active[i] = 0;
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	add	a, a
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00105$:
;src/gameplay.c:151: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00115$
;src/gameplay.c:157: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
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
;src/gameplay.c:158: if (cache->active[i]) {
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
;src/gameplay.c:159: if (count != i) {
	ldhl	sp,	#22
	ld	a, (hl+)
	sub	a, (hl)
	jp	Z, 00108$
;src/gameplay.c:160: cache->obj[count] = cache->obj[i];
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
;src/gameplay.c:161: cache->px[count] = cache->px[i];
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
;src/gameplay.c:162: cache->py[count] = cache->py[i];
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
;src/gameplay.c:163: cache->active[count] = cache->active[i];
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
;src/gameplay.c:164: cache->activated[count] = cache->activated[i];
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
;src/gameplay.c:166: count++;
	ldhl	sp,	#22
	inc	(hl)
00117$:
;src/gameplay.c:157: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#23
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00116$
;src/gameplay.c:169: while (count < MAX_ACTIVE_SP_OBJECTS) cache->active[count++] = 0;
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
;src/gameplay.c:171: sp_cache_load(sp_bank, sp_list, cam_px, cache, stream_idx, l->map_height);
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
;src/gameplay.c:172: }
	add	sp, #24
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:179: static uint8_t draw_oam_2x1(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x1
; ---------------------------------
_draw_oam_2x1:
	add	sp, #-8
	push	de
	ldhl	sp,	#9
	ld	(hl), a
;src/gameplay.c:181: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#12
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;src/gameplay.c:184: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c, e
	ld	b, d
	inc	bc
	push	de
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	ld	(hl-), a
	dec	hl
	dec	hl
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
;src/gameplay.c:185: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#8
	ld	(hl), a
;src/gameplay.c:183: if (!reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;src/gameplay.c:184: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl-)
	ld	(de), a
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
;src/gameplay.c:185: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
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
;src/gameplay.c:187: *oam++ = sy; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	xor	a, #0x20
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/gameplay.c:188: *oam++ = sy; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
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
;src/gameplay.c:190: return 2;
	ld	a, #0x02
;src/gameplay.c:191: }
	add	sp, #10
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:197: static uint8_t draw_oam_2x2(uint8_t tile_base, uint8_t oam_idx,
;	---------------------------------
; Function draw_oam_2x2
; ---------------------------------
_draw_oam_2x2:
;src/gameplay.c:329: __endasm;
;	Save the input bytes while building &shadow_OAM[oam_idx].
	push	de
	push	bc
	push	af
	xor	a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	pop	af
	pop	bc
	pop	de
;	D=sx, C=sy, B=reversed, A=tile_base.
	ld	e, a
	inc	e
	inc	e ; E=tile_base+2
	ld	a, b
	or	a
	jr	NZ, 00102$
;	Normal order: left/right, then bottom left/right.
	ld	(hl), c
	inc	hl
	ld	(hl), d
	inc	hl
	ld	a, e
	sub	#2
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	inc	hl
	ld	(hl), c
	inc	hl
	ld	a, d
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	(hl), d
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
	ld	a, d
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	add	#4
	ld	(hl), a
	inc	hl
	ld	(hl), #3
	jr	00103$
00102$:
;	Mirror order: swap columns and set HFLIP (palette 3 | 0x20).
	ld	(hl), c
	inc	hl
	ld	a, d
	add	#8
	ld	(hl), a
	inc	hl
	ld	a, e
	sub	#2
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
	inc	hl
	ld	(hl), c
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), e
	inc	hl
	ld	(hl), #0x23
	inc	hl
	ld	a, c
	add	#16
	ld	(hl), a
	inc	hl
	ld	a, d
	add	#8
	ld	(hl), a
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
	ld	(hl), d
	inc	hl
	ld	a, e
	add	#4
	ld	(hl), a
	inc	hl
	ld	(hl), #0x23
00103$:
	ld	a, #4
	ret
;src/gameplay.c:330: }
;src/gameplay.c:333: static uint8_t draw_oam_2x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_2x3
; ---------------------------------
_draw_oam_2x3:
	add	sp, #-10
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), a
;src/gameplay.c:334: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#12
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;src/gameplay.c:337: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c, e
	ld	b, d
	inc	bc
	push	de
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	pop	de
	inc	sp
	inc	sp
	push	hl
	push	de
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
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
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
;src/gameplay.c:338: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#13
;src/gameplay.c:339: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	a, (hl+)
	push	af
	ld	a, (hl)
	ldhl	sp,	#10
;src/gameplay.c:338: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl-), a
	dec	hl
	pop	af
	add	a, #0x08
;src/gameplay.c:339: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
;src/gameplay.c:341: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:336: if (!reversed) {
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:337: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl-)
	ld	(de), a
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
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
;src/gameplay.c:338: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#6
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
;src/gameplay.c:339: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#13
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
;src/gameplay.c:340: *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#7
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
;src/gameplay.c:341: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#13
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
;src/gameplay.c:342: *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#8
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
	ldhl	sp,	#9
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
;src/gameplay.c:344: *oam++ = sy;    *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
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
;src/gameplay.c:345: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
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
;src/gameplay.c:346: *oam++ = sy+16; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#7
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
;src/gameplay.c:347: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#13
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
;src/gameplay.c:348: *oam++ = sy+32; *oam++ = sx + 8; *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#8
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
	ldhl	sp,	#9
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
;src/gameplay.c:349: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#13
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
;src/gameplay.c:351: return 6;
	ld	a, #0x06
;src/gameplay.c:352: }
	add	sp, #10
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:355: static uint8_t draw_oam_3x3(const metasprite_t* meta, uint8_t tile_base, uint8_t oam_idx, uint8_t sx, uint8_t sy, uint8_t reversed) {
;	---------------------------------
; Function draw_oam_3x3
; ---------------------------------
_draw_oam_3x3:
	add	sp, #-11
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), a
;src/gameplay.c:356: uint8_t *oam = (uint8_t *)&shadow_OAM[oam_idx];
	ldhl	sp,	#13
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;src/gameplay.c:359: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	c, e
	ld	b, d
	inc	bc
	push	de
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	pop	de
	inc	sp
	inc	sp
	push	hl
	push	de
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
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
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
;src/gameplay.c:360: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;src/gameplay.c:363: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#9
;src/gameplay.c:360: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	add	a, #0x08
;src/gameplay.c:361: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
;src/gameplay.c:363: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
;src/gameplay.c:367: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:358: if (!reversed) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jp	NZ, 00102$
;src/gameplay.c:359: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	dec	hl
	ld	a, (hl-)
	ld	(de), a
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#10
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
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
;src/gameplay.c:360: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:361: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:363: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:364: *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#8
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
	ldhl	sp,	#10
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
;src/gameplay.c:365: *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#8
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
	ldhl	sp,	#10
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
;src/gameplay.c:367: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:368: *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props; meta++;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:369: *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props;
	ldhl	sp,	#9
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
	ldhl	sp,	#10
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
;src/gameplay.c:371: *oam++ = sy;    *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#10
	add	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,#2
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
;src/gameplay.c:372: *oam++ = sy;    *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:373: *oam++ = sy;    *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#15
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
	ldhl	sp,	#10
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
;src/gameplay.c:375: *oam++ = sy+16; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#8
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
	ldhl	sp,	#10
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
;src/gameplay.c:376: *oam++ = sy+16; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#8
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
	ldhl	sp,	#10
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
;src/gameplay.c:377: *oam++ = sy+16; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:379: *oam++ = sy+32; *oam++ = sx+16;  *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#9
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
	ldhl	sp,	#10
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
;src/gameplay.c:380: *oam++ = sy+32; *oam++ = sx+8;   *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX; meta++;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:381: *oam++ = sy+32; *oam++ = sx;     *oam++ = meta->dtile + tile_base; *oam++ = meta->props ^ S_FLIPX;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#10
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
;src/gameplay.c:383: return 9;
	ld	a, #0x09
;src/gameplay.c:384: }
	add	sp, #11
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:386: static void process_sprite_logic(
;	---------------------------------
; Function process_sprite_logic
; ---------------------------------
_process_sprite_logic:
	add	sp, #-73
	ldhl	sp,	#70
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#68
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:391: uint16_t px = p->world_x;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:392: uint16_t py = p->world_y.b.h;
	ldhl	sp,	#75
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;src/gameplay.c:395: uint16_t p_front = px + 15;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:396: uint16_t p_bottom = py + PLAYER_SIZE;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#12
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
	ldhl	sp,	#14
	ld	(hl), c
	inc	hl
;src/gameplay.c:397: uint16_t p_feet = py + PLAYER_SIZE;
	ld	(hl+), a
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:399: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0060
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#24
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#38
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#42
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#41
	ld	(hl), a
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#44
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#77
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#50
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#51
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#52
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#53
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#56
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,	#72
	ld	(hl), #0x00
00216$:
;src/gameplay.c:400: if (!cache->active[i]) break;
	ldhl	sp,#59
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#67
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00217$
;src/gameplay.c:402: uint16_t obj_x = cache->px[i];
	ldhl	sp,	#72
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#67
	ld	(hl), a
	ldhl	sp,#40
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
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:403: if (obj_x > cam_px + 176u) break;
	ldhl	sp,	#68
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#69
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00b0
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#64
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#65
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#62
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00217$
;src/gameplay.c:405: uint8_t obj = cache->obj[i];
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
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
	ldhl	sp,	#61
	ld	(hl), a
;src/gameplay.c:406: uint16_t obj_y = cache->py[i];
	ldhl	sp,#42
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#67
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:408: if (obj == OBJ_LEVEL_END) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00108$
;src/gameplay.c:409: if (px >= (obj_x - 180)) p->level_complete = 1;
	ldhl	sp,#62
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
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	C, 00214$
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;src/gameplay.c:410: continue;
	jp	00214$
00108$:
;src/gameplay.c:420: if (obj >= 100 && obj <= 147 && obj != OBJ_MIRROR_EXIT && obj != OBJ_MIRROR_PORTAL) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x64
	jp	C, 00124$
	ld	a, #0x93
	sub	a, (hl)
	jp	C, 00124$
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00124$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00124$
;src/gameplay.c:421: if (!cache->activated[i]) {
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00120$
;src/gameplay.c:422: uint16_t trig_x = (obj_x > BG_TRIGGER_LEAD_PX)
	ldhl	sp,	#64
	ld	a, #0xb0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00219$
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00b0
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
	jr	00220$
00219$:
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
00220$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:424: if (px >= trig_x) {
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00120$
;src/gameplay.c:425: uint8_t pal_idx = obj - 100;
	ldhl	sp,	#61
	ld	a, (hl+)
	inc	hl
	add	a, #0x9c
	ld	(hl), a
;src/gameplay.c:426: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00110$
;src/gameplay.c:427: set_bkg_palette(0, 1, &gbc_bg_palettes[pal_idx << 2]);
	ldhl	sp,	#63
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_gbc_bg_palettes
	add	hl, de
	push	hl
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
00110$:
;src/gameplay.c:433: uint8_t row = pal_idx >> 4;
	ldhl	sp,	#63
	ld	a, (hl-)
	dec	hl
	swap	a
	and	a, #0x0f
	ld	(hl), a
	ld	a, (hl+)
;src/gameplay.c:434: if (row == 0)      *target_bg_idx = ((pal_idx & 15) == 15) ? 3 : 2;
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00115$
	ldhl	sp,	#78
	ld	a, (hl)
	ldhl	sp,	#61
	ld	(hl), a
	ldhl	sp,	#79
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl+), a
	ld	a, (hl)
	and	a, #0x0f
	sub	a, #0x0f
	ld	a, #0x03
	jr	Z, 00222$
	ld	a, #0x02
00222$:
	ldhl	sp,	#61
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00116$
00115$:
;src/gameplay.c:435: else if (row == 1) *target_bg_idx = 1;
	ldhl	sp,	#62
	ld	a, (hl)
	dec	a
	jr	NZ, 00112$
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x01
	ld	(bc), a
	jr	00116$
00112$:
;src/gameplay.c:436: else               *target_bg_idx = 0;
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	(bc), a
00116$:
;src/gameplay.c:438: cache->activated[i] = 1;
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00120$:
;src/gameplay.c:441: if (obj_x > p_front + 16) break;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#64
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#63
	ld	(hl+), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#62
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00214$
	jp	00217$
;src/gameplay.c:442: continue;
00124$:
;src/gameplay.c:445: if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00211$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00211$
;src/gameplay.c:447: if (obj_x <= p_front && px <= obj_x + 48u) {
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#64
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#64
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#63
	ld	(hl), a
	ldhl	sp,	#62
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:448: if (py <= obj_y + 14u && p_bottom >= obj_y) {
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#64
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:449: if (!cache->activated[i]) {
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00214$
;src/gameplay.c:450: uint8_t target_flipped = (obj >= 18);
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x12
	ld	a, #0x00
	rla
	xor	a, #0x01
	ldhl	sp,	#65
	ld	(hl), a
;src/gameplay.c:451: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#65
	ld	a, (hl)
	sub	a, c
	jr	Z, 00129$
;src/gameplay.c:452: p->gravity_flipped = target_flipped;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#65
	ld	a, (hl)
	ld	(de), a
;src/gameplay.c:453: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#75
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
	ldhl	sp,	#64
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#65
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#64
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#65
	ld	a, (hl-)
	dec	hl
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
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl-), a
	pop	de
	push	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00129$:
;src/gameplay.c:455: cache->activated[i] = 1;
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jp	00214$
00211$:
;src/gameplay.c:459: } else if (obj_x + 2 <= p_front && px <= obj_x + 15) {
	ldhl	sp,	#64
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#65
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#64
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00207$
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00207$
;src/gameplay.c:460: switch (obj) {
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	Z, 00140$
	ldhl	sp,	#61
	ld	a, (hl)
	dec	a
	jr	Z, 00140$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00140$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00843$
	xor	a, a
00843$:
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00180$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00180$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x08
	jp	Z, 00153$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x09
	jp	Z, 00153$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00180$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x79
	jp	Z, 00197$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x7e
	jp	Z, 00197$
	jp	00214$
;src/gameplay.c:463: case OBJ_BALL_PORTAL:
00140$:
;src/gameplay.c:464: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#64
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:465: if (!cache->activated[i]) {
	ldhl	sp,#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00214$
;src/gameplay.c:466: if (obj == OBJ_CUBE_PORTAL) p->mode = MODE_CUBE;
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00146$
00145$:
;src/gameplay.c:467: else if (obj == OBJ_SHIP_PORTAL) p->mode = MODE_SHIP;
	ldhl	sp,	#61
	ld	a, (hl)
	dec	a
	jr	NZ, 00142$
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00146$
00142$:
;src/gameplay.c:468: else p->mode = MODE_BALL;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
00146$:
;src/gameplay.c:469: cache->activated[i] = 1;
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/gameplay.c:472: break;
	jp	00214$
;src/gameplay.c:475: case OBJ_GRAVITY_UP:
00153$:
;src/gameplay.c:476: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#64
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:477: if (!cache->activated[i]) {
	ldhl	sp,#53
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00214$
;src/gameplay.c:478: uint8_t target_flipped = (obj == OBJ_GRAVITY_UP);
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x09
	ld	a, #0x01
	jr	Z, 00858$
	xor	a, a
00858$:
;src/gameplay.c:479: if (p->gravity_flipped != target_flipped) {
	ldhl	sp,#22
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	cp	a, l
	jr	Z, 00155$
;src/gameplay.c:480: p->gravity_flipped = target_flipped;
	ldhl	sp,	#22
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:481: p->vel_y.w = (p->vel_y.w >> 1) + (p->vel_y.w >> 3);
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#64
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#66
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#67
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
	ldhl	sp,	#64
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl), a
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00155$:
;src/gameplay.c:483: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:486: break;
	jp	00214$
;src/gameplay.c:492: case OBJ_PAD_BLUE_UP:
00165$:
;src/gameplay.c:494: uint8_t is_ceiling = (obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE_UP);
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0c
	jr	Z, 00224$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0e
	jr	Z, 00224$
	xor	a, a
	jr	00225$
00224$:
	ld	a, #0x01
00225$:
	ldhl	sp,	#65
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:495: uint16_t pad_top = is_ceiling ? obj_y : (obj_y + 13);
	ldhl	sp,	#65
	ld	a, (hl)
	or	a, a
	jr	Z, 00226$
	inc	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	jr	00227$
00226$:
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
00227$:
	ldhl	sp,	#64
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#65
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/gameplay.c:496: uint16_t pad_bot = is_ceiling ? (obj_y + 3) : (obj_y + 16);
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	Z, 00228$
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	jr	00229$
00228$:
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
00229$:
	ldhl	sp,	#64
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/gameplay.c:498: if (py <= pad_bot && p_bottom >= pad_top) {
	ldhl	sp,	#66
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#62
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:499: if (!cache->activated[i]) {
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00214$
;src/gameplay.c:500: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:501: if (obj == OBJ_PAD_BLUE || obj == OBJ_PAD_BLUE_UP) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0d
	jr	Z, 00169$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00170$
00169$:
;src/gameplay.c:502: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#22
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
;src/gameplay.c:503: p->vel_y.w = (p->gravity_flipped) ? -BLUE_PAD_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	or	a, a
	jr	Z, 00230$
	ld	bc, #0xfc60
	jr	00231$
00230$:
	ld	bc, #0x03a0
00231$:
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	jp	00171$
00170$:
;src/gameplay.c:504: } else if (obj == OBJ_PAD_PINK) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ, 00167$
;src/gameplay.c:505: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_PAD : PINK_PAD_FORCE;
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00232$
	ld	bc, #0xfca0
	jr	00233$
00232$:
	ld	bc, #0xfaf0
00233$:
	ldhl	sp,	#62
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:506: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00234$
	ld	de, #0x0000
	ldhl	sp,	#62
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	(hl), e
	jr	00235$
00234$:
	ldhl	sp,	#62
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#63
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
00235$:
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00171$
00167$:
;src/gameplay.c:508: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_PAD : PAD_JUMP_FORCE;
	ldhl	sp,#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00236$
	ldhl	sp,	#66
	ld	a, #0x10
	ld	(hl+), a
	ld	(hl), #0xfb
	jr	00237$
00236$:
	ldhl	sp,	#66
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0xf8
00237$:
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl), a
;src/gameplay.c:509: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00238$
	ld	de, #0x0000
	ldhl	sp,	#62
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	(hl), e
	jr	00239$
00238$:
	ldhl	sp,	#62
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#63
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
00239$:
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00171$:
;src/gameplay.c:511: p->on_ground = 0;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:514: break;
	jp	00214$
;src/gameplay.c:519: case OBJ_ORB_BLUE:
00180$:
;src/gameplay.c:521: if (joy & J_A) {
	ldhl	sp,	#50
	ld	a, (hl)
	or	a, a
	jp	Z, 00214$
;src/gameplay.c:522: if ((!(p->last_joy & J_A) || p->orb_buffered) && py <= obj_y + 16 && p_feet >= obj_y) {
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	bit	4, a
	jr	Z, 00192$
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00214$
00192$:
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#64
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
	ldhl	sp,	#16
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00214$
;src/gameplay.c:523: if (!cache->activated[i]) {
	ldhl	sp,#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	NZ, 00214$
;src/gameplay.c:524: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:525: p->orb_buffered = 0; // Clear buffer after hit
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/gameplay.c:526: if (obj == OBJ_ORB_BLUE) {
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	Z, 00185$
;src/gameplay.c:527: p->gravity_flipped = !p->gravity_flipped;
	ldhl	sp,#22
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
;src/gameplay.c:528: int16_t force = (p->mode == MODE_BALL) ? BLUE_ORB_FORCE : BLUE_PAD_FORCE;
	ldhl	sp,#30
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00240$
	ld	bc, #0x01a0
	jr	00241$
00240$:
	ld	bc, #0x03a0
00241$:
;src/gameplay.c:529: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl), a
	ldhl	sp,#22
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
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00186$
00185$:
;src/gameplay.c:530: } else if (obj == OBJ_ORB_PINK) {
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00182$
;src/gameplay.c:531: int16_t force = (p->mode == MODE_BALL) ? BALL_PINK_ORB : MAGENTA_JUMP_FORCE;
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00244$
	ld	bc, #0xfcd0
	jr	00245$
00244$:
	ld	bc, #0xfc30
00245$:
	ldhl	sp,	#62
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:532: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00246$
	ld	de, #0x0000
	ldhl	sp,	#62
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	(hl), e
	jr	00247$
00246$:
	ldhl	sp,	#62
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#63
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
00247$:
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00186$
00182$:
;src/gameplay.c:534: int16_t force = (p->mode == MODE_BALL) ? BALL_YELLOW_ORB : JUMP_FORCE;
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00248$
	ldhl	sp,	#66
	ld	a, #0xf0
	ld	(hl+), a
	ld	(hl), #0xfb
	jr	00249$
00248$:
	ldhl	sp,	#66
	ld	(hl), #0x70
	inc	hl
	ld	(hl), #0xfa
00249$:
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl), a
;src/gameplay.c:535: p->vel_y.w = (p->gravity_flipped) ? -force : force;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#67
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00250$
	ld	de, #0x0000
	ldhl	sp,	#62
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#67
	ld	(hl-), a
	ld	(hl), e
	jr	00251$
00250$:
	ldhl	sp,	#62
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#63
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
00251$:
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00186$:
;src/gameplay.c:537: p->on_ground = 0;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/gameplay.c:541: break;
	jp	00214$
;src/gameplay.c:546: case OBJ_MIRROR_EXIT:
00197$:
;src/gameplay.c:547: if (py <= obj_y + 32 && p_bottom >= obj_y) {
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#62
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	ldhl	sp,	#63
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#66
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#65
	ld	(hl), a
	ldhl	sp,	#64
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00214$
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#66
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00214$
;src/gameplay.c:548: if (!cache->activated[i]) {
	ldhl	sp,#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00214$
;src/gameplay.c:549: p->reversed = (obj == OBJ_MIRROR_PORTAL) ? 1 : 0;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl), a
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x7e
	ld	a, #0x01
	jr	Z, 00253$
	xor	a, a
00253$:
	ldhl	sp,	#66
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/gameplay.c:550: cache->activated[i] = 1;
	ld	a, #0x01
	ld	(bc), a
;src/gameplay.c:554: }
	jr	00214$
00207$:
;src/gameplay.c:555: } else if (obj_x > p_front + 16) {
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#64
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#65
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl), a
	ldhl	sp,	#66
	ld	e, l
	ld	d, h
	ldhl	sp,	#62
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00217$
;src/gameplay.c:556: break;
00214$:
;src/gameplay.c:399: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS; i++) {
	ldhl	sp,	#72
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00216$
00217$:
;src/gameplay.c:559: }
	add	sp, #73
	pop	hl
	add	sp, #5
	jp	(hl)
;src/gameplay.c:561: static uint8_t draw_sprites(
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
;src/gameplay.c:568: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
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
00160$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00155$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00155$
;src/gameplay.c:569: if (!cache->active[i]) break;
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
	jp	Z, 00155$
;src/gameplay.c:571: uint16_t obj_x = cache->px[i];
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
;src/gameplay.c:572: if (obj_x > cam_px + 176u) break;
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
	jp	C, 00155$
;src/gameplay.c:574: uint8_t obj = cache->obj[i];
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
;src/gameplay.c:575: if (obj == OBJ_LEVEL_END || obj >= 100) continue;
	ld	a, (hl)
	sub	a, #0x0f
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x64
	jp	NC, 00154$
;src/gameplay.c:580: dist_x = (uint8_t)obj_x - (uint8_t)cam_px;
	inc	hl
	ld	a, c
	ld	c, (hl)
	sub	a, c
;src/gameplay.c:583: if (dist_x > 176 && dist_x < 224) continue;
	cp	a, #0xb1
	jr	C, 00109$
	cp	a, #0xe0
	jp	C, 00154$
00109$:
;src/gameplay.c:586: screen_x = 128 - dist_x + 8;
	ldhl	sp,	#12
	ld	(hl), a
;src/gameplay.c:585: if (reversed) {
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;src/gameplay.c:586: screen_x = 128 - dist_x + 8;
	ld	a, #0x88
	ldhl	sp,	#12
	sub	a, (hl)
	dec	hl
	ld	(hl), a
	jr	00113$
00112$:
;src/gameplay.c:588: screen_x = dist_x + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#12
	ld	a, (hl-)
	add	a, #0x28
	ld	(hl), a
00113$:
;src/gameplay.c:591: screen_y = ((uint8_t)cache->py[i] - (uint8_t)cam_py) + 16;
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
;src/gameplay.c:593: if (screen_x > 160 && screen_x < 232) continue;
	ld	(hl-), a
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00115$
	ld	a, (hl)
	sub	a, #0xe8
	jp	C, 00154$
00115$:
;src/gameplay.c:594: if (screen_y > 160 && screen_y < 208) continue;
	ld	a, #0xa0
	ldhl	sp,	#12
	sub	a, (hl)
	jr	NC, 00118$
	ld	a, (hl)
	sub	a, #0xd0
	jp	C, 00154$
00118$:
;src/gameplay.c:596: if (oam_start > MAX_HARDWARE_SPRITES - 9) break;
	ld	a, #0x1f
	ldhl	sp,	#24
	sub	a, (hl)
	jp	C, 00155$
;src/gameplay.c:597: if (obj >= 46) continue;
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x2e
	jp	NC, 00154$
;src/gameplay.c:598: const metasprite_t *sprite = (obj == 45)
	ld	a, (hl)
	sub	a, #0x2d
	ld	a, #0x01
	jr	Z, 00396$
	xor	a, a
00396$:
	ld	c, a
	or	a, a
	jr	Z, 00163$
	ld	de, #_famidash_deco_45
	jr	00164$
00163$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x26
	jr	NC, 00165$
	ld	b, (hl)
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	ld	de, #_famidash_sprite_table
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	jr	00166$
00165$:
	xor	a, a
	ld	b, a
00166$:
	ld	e, a
	ld	d, b
00164$:
	ldhl	sp,	#9
	ld	a, e
;src/gameplay.c:601: if (sprite == 0) continue;
	ld	(hl+), a
	ld	(hl), d
	or	a, d
	jp	Z, 00154$
;src/gameplay.c:604: if (obj == OBJ_ORB_BLUE || obj == OBJ_ORB_PINK || obj == OBJ_ORB_YELLOW ||
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x05
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x06
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0b
	jp	Z, 00154$
;src/gameplay.c:605: obj == OBJ_PAD_YELLOW || obj == OBJ_PAD_YELLOW_UP || obj == OBJ_PAD_BLUE ||
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0a
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0c
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0d
	jp	Z, 00154$
;src/gameplay.c:606: obj == OBJ_PAD_BLUE_UP || obj == OBJ_PAD_PINK) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0e
	jp	Z, 00154$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x25
	jp	Z, 00154$
;src/gameplay.c:610: if (obj == 45) {
	ld	a, c
	or	a, a
	jr	Z, 00152$
;src/gameplay.c:612: oam_start, screen_x, screen_y - 8, reversed);
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, #0xf8
;src/gameplay.c:611: oam_start += draw_oam_2x2(FAMIDASH_SPRITE_TILE_BASE + CHAIN_BLOCK_TILE,
	ldhl	sp,	#23
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#27
	ld	e, (hl)
	ld	a, #0xc4
	call	_draw_oam_2x2
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jp	00154$
00152$:
;src/gameplay.c:613: } else if (obj >= 16 && obj <= 19) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x10
	jp	C, 00148$
	ld	a, #0x13
	sub	a, (hl)
	jp	C, 00148$
;src/gameplay.c:614: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	or	a, a
	jp	Z, 00136$
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
	ld	(hl), #0x70
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldhl	sp,	#12
	ld	c, (hl)
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00167$
	ldhl	sp,	#8
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00168$
00167$:
	ldhl	sp,	#8
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00168$:
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
;src/gameplay.c:614: if (reversed) oam_start += move_metasprite_hflip(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jp	00154$
00136$:
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x70
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
;src/gameplay.c:615: else oam_start += move_metasprite(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y);
	ldhl	sp,	#13
	add	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	jp	00154$
00148$:
;src/gameplay.c:616: } else if (obj == OBJ_CUBE_PORTAL || obj == OBJ_SHIP_PORTAL || obj == OBJ_BALL_PORTAL) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jr	Z, 00142$
	ld	a, (hl)
	dec	a
	jr	Z, 00142$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00143$
00142$:
;src/gameplay.c:617: oam_start += draw_oam_3x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
	ld	a, #0x70
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_3x3
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jr	00154$
00143$:
;src/gameplay.c:618: } else if (obj == OBJ_GRAVITY_DOWN || obj == OBJ_GRAVITY_UP) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00138$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00139$
00138$:
;src/gameplay.c:619: oam_start += draw_oam_2x3(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
	ld	a, #0x70
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x3
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
	jr	00154$
00139$:
;src/gameplay.c:621: oam_start += draw_oam_2x1(sprite, FAMIDASH_SPRITE_TILE_BASE, oam_start, screen_x, screen_y, reversed);
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
	ld	a, #0x70
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_oam_2x1
	ldhl	sp,#13
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#24
	add	a, (hl)
	ld	(hl), a
00154$:
;src/gameplay.c:568: for (i = 0; i < MAX_ACTIVE_SP_OBJECTS && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00160$
00155$:
;src/gameplay.c:624: return oam_start;
	ldhl	sp,	#24
	ld	a, (hl)
;src/gameplay.c:625: }
	add	sp, #19
	pop	hl
	add	sp, #4
	jp	(hl)
;src/gameplay.c:627: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 10
_setup_menu_font::
;src/gameplay.c:628: set_bkg_data(FONT_PUSAB_START, 39, FontPusab);
	ld	de, #_FontPusab
	push	de
	ld	hl, #0x27d0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/gameplay.c:629: }
	ret
;src/gameplay.c:631: static void draw_text(uint8_t x, uint8_t y, const char *str) {
;	---------------------------------
; Function draw_text
; ---------------------------------
_draw_text:
	add	sp, #-3
	ldhl	sp,	#2
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:633: while (*str) {
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00122$:
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl), a
	or	a, a
	jr	Z, 00125$
;src/gameplay.c:634: char c = *str;
	ld	l, (hl)
;src/gameplay.c:635: if (c == ' ') tile = 0;
	ld	a, l
	sub	a, #0x20
	jr	NZ, 00120$
	xor	a, a
	jr	00121$
00120$:
;src/gameplay.c:636: else if (c == '%') tile = 1;
	ld	a, l
	sub	a, #0x25
	jr	NZ, 00117$
	ld	a, #0x01
	jr	00121$
00117$:
;src/gameplay.c:637: else if (c == '/') tile = 2;
	ld	a, l
	sub	a, #0x2f
	jr	NZ, 00114$
	ld	a, #0x02
	jr	00121$
00114$:
;src/gameplay.c:638: else if (c >= '0' && c <= '9') tile = (c - '0') + 3;
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
;src/gameplay.c:639: else if (c >= 'A' && c <= 'Z') tile = (c - 'A') + 13;
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
;src/gameplay.c:640: else if (c >= 'a' && c <= 'z') tile = (c - 'a') + 13;
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
;src/gameplay.c:641: else tile = 0;
	xor	a, a
00121$:
;src/gameplay.c:642: set_bkg_tile_xy(x++, y, FONT_PUSAB_START + tile);
	add	a, #0xd0
	ldhl	sp,	#2
	ld	d, (hl)
	inc	(hl)
	dec	hl
	push	bc
	push	af
	inc	sp
	ld	e, (hl)
	ld	a, d
	call	_set_bkg_tile_xy
	pop	bc
;src/gameplay.c:643: str++;
	inc	bc
	jr	00122$
00125$:
;src/gameplay.c:645: }
	add	sp, #3
	pop	hl
	pop	af
	jp	(hl)
;src/gameplay.c:647: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 10
_draw_menu::
	dec	sp
;src/gameplay.c:648: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
;src/gameplay.c:653: set_bkg_palette(0, 1, menu_pal);
	ld	de, #_draw_menu_menu_pal_30000_367
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
00102$:
;src/gameplay.c:655: BGP_REG = 0x2F; // Inverted Palette: White=00, Light Gray=Dark Gray(10), Dark Gray=Black(11), Black=Black(11)
	ld	a, #0x2f
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:656: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:657: draw_text(0, 0, "GD POCKET DEMO 02");
	ld	de, #___str_0
	push	de
	xor	a, a
	ld	e, a
	call	_draw_text
;src/gameplay.c:658: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00108$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:660: draw_text(1, 2 + i, "0"); // cursor icon
	ld	a,c
	cp	a,b
	jr	NC, 00106$
;src/gameplay.c:661: draw_text(3, 2 + i, game_levels[i]->name);
	ld	e, c
	ld	d, #0x00
;src/gameplay.c:660: draw_text(1, 2 + i, "0"); // cursor icon
	add	a, #0x02
	ldhl	sp,	#0
	ld	(hl), a
;src/gameplay.c:661: draw_text(3, 2 + i, game_levels[i]->name);
	sla	e
	rl	d
;src/gameplay.c:659: if (i == selected) {
	ld	a, (#_selected)
	sub	a, c
	jr	NZ, 00104$
;src/gameplay.c:660: draw_text(1, 2 + i, "0"); // cursor icon
	push	bc
	push	de
	ld	hl, #___str_1
	push	hl
	ldhl	sp,	#6
	ld	e, (hl)
	ld	a, #0x01
	call	_draw_text
	pop	de
	pop	bc
;src/gameplay.c:661: draw_text(3, 2 + i, game_levels[i]->name);
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
	jr	00109$
00104$:
;src/gameplay.c:663: draw_text(3, 2 + i, game_levels[i]->name);
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
00109$:
;src/gameplay.c:658: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00108$
00106$:
;src/gameplay.c:666: draw_text(0, 16, "SOTOSPRO24");
	ld	de, #___str_2
	push	de
	ld	e, #0x10
	xor	a, a
	call	_draw_text
;src/gameplay.c:667: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:668: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:669: }
	inc	sp
	ret
_draw_menu_menu_pal_30000_367:
	.dw #0x1442
	.dw #0x498c
	.dw #0x7f39
	.dw #0x7fff
___str_0:
	.ascii "GD POCKET DEMO 02"
	.db 0x00
___str_1:
	.ascii "0"
	.db 0x00
___str_2:
	.ascii "SOTOSPRO24"
	.db 0x00
;src/gameplay.c:671: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 10
_play_level::
	ld	hl, #-224
	add	hl, sp
	ld	sp, hl
;src/gameplay.c:681: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #230
	add	hl, sp
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	ld	hl, #222
	add	hl, sp
	ld	a, e
	ld	(hl+), a
	ld	a, d
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
	ld	hl, #177
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:682: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #221
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #220
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #217
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:683: level_map = l->map;
	ld	hl,#0xb1
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
	ld	hl, #179
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:684: level_tile_count = l->tile_count;
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
	ld	hl, #181
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:685: level_map_w = l->map_width;
	ld	hl,#0xb1
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
	ld	hl, #183
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:686: level_map_h = l->map_height;
	ld	hl,#0xb1
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
	ld	hl, #185
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:687: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:688: level_map_bank = l->map_bank;
	ld	hl,#0xb1
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #188
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:690: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:691: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:692: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:694: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #222
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
;src/gameplay.c:695: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xb1
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #223
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #230
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #225
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:696: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:697: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:700: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #222
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:701: uint16_t cam_py = 112;
	ld	hl, #191
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:702: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #185
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
;src/gameplay.c:703: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #215
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
	ld	hl,#0xd7
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
	ld	hl, #193
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:704: else cam_py_max = 0;
	xor	a, a
	ld	hl, #193
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:705: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #195
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:710: uint8_t target_bg_idx = 0;
	ld	hl, #221
	add	hl, sp
	ld	(hl), #0x00
;src/gameplay.c:711: const uint8_t bg_pals[] = {
	ldhl	sp,	#4
	ld	a, #0xe4
	ld	(hl+), a
	ld	a, #0x39
	ld	(hl+), a
	ld	a, #0x3e
	ld	(hl+), a
	ld	(hl), #0x3f
;src/gameplay.c:719: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:722: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:723: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #187
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #182
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #218
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:724: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:725: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:726: set_sprite_data(12, 4, ball_tiles);
	ld	de, #_ball_tiles
	push	de
	ld	hl, #0x40c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:727: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
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
;src/gameplay.c:729: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #189
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #181
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:731: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00107$
;src/gameplay.c:735: set_bkg_palette(0, 1, &gbc_bg_palettes[GBC_DEFAULT_BG_PAL << 2]);
	ld	de, #(_gbc_bg_palettes + 256)
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/gameplay.c:736: set_sprite_palette(0, 2, gbc_sprite_palettes);
	ld	de, #_gbc_sprite_palettes
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_palette
	add	sp, #4
00107$:
;src/gameplay.c:739: BGP_REG = bg_pals[0];
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:740: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:741: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:742: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:743: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:744: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:745: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:746: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:749: uint16_t scroll_acc = 0;
	ld	hl, #197
	add	hl, sp
;src/gameplay.c:750: uint8_t prev_joy = 0;
;src/gameplay.c:751: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:753: uint16_t sp_stream_idx = 0;
	xor	a, a
	ld	hl, #143
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:754: uint16_t sp_cache_col = 0xFFFF;
	ld	hl, #200
	add	hl, sp
;src/gameplay.c:756: uint16_t cached_collision_col = 0xFFFF;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:757: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:758: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #143
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #31
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_sp_cache_reset
;src/gameplay.c:759: while (1) {
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	ld	hl, #205
	add	hl, sp
	ld	(hl), a
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #206
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xb1
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #209
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #208
	add	hl, sp
	ld	(hl), a
	ld	hl,#0xb1
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #211
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #210
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank
	ld	hl, #230
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #213
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #212
	add	hl, sp
	ld	(hl), a
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	ld	hl, #213
	add	hl, sp
	ld	(hl), a
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #214
	add	hl, sp
	ld	(hl), a
00207$:
;src/gameplay.c:760: uint8_t joy = joypad();
	call	_joypad
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:761: if (joy & J_START) break;
	push	hl
	ld	hl, #222
	add	hl, sp
	bit	7, (hl)
	pop	hl
	jp	NZ, 00208$
;src/gameplay.c:763: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ld	hl, #222
	add	hl, sp
	bit	2, (hl)
	pop	hl
	jr	NZ, 00113$
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
00113$:
;src/gameplay.c:764: HIDE_SPRITES;
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
;src/gameplay.c:767: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:769: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:770: draw_text(3, 6, "LEVEL COMPLETE");
	ld	de, #___str_3
	push	de
	ld	e, #0x06
	ld	a, #0x03
	call	_draw_text
;src/gameplay.c:771: draw_text(3, 12, "PRESS A TO EXIT");
	ld	de, #___str_4
	push	de
	ld	e, #0x0c
	ld	a, #0x03
	call	_draw_text
;src/gameplay.c:772: waitpadup();
	call	_waitpadup
;src/gameplay.c:773: while (!(joypad() & J_A)) wait_vbl_done();
00110$:
	call	_joypad
	bit	4, a
	jp	NZ, 00208$
	call	_wait_vbl_done
	jr	00110$
;src/gameplay.c:774: break;
00114$:
;src/gameplay.c:778: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ld	hl, #222
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	Z, 00117$
	push	hl
	ld	hl, #200
	add	hl, sp
	bit	5, (hl)
	pop	hl
	jr	NZ, 00117$
	ld	hl, #_player_noclip
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00117$:
;src/gameplay.c:780: if ((joy & J_SELECT) && !(prev_joy & J_SELECT)) {
	push	hl
	ld	hl, #222
	add	hl, sp
	bit	6, (hl)
	pop	hl
	jr	Z, 00124$
	push	hl
	ld	hl, #200
	add	hl, sp
	bit	6, (hl)
	pop	hl
	jr	NZ, 00124$
;src/gameplay.c:781: target_bg_idx++;
	ld	hl, #221
	add	hl, sp
	inc	(hl)
;src/gameplay.c:782: if (target_bg_idx > 3) target_bg_idx = 0;
	ld	a, #0x03
	sub	a, (hl)
	jr	NC, 00120$
	ld	(hl), #0x00
00120$:
;src/gameplay.c:783: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00124$
;src/gameplay.c:786: set_bkg_palette(0, 1, &gbc_bg_palettes[dbg_pals[target_bg_idx] << 2]);
	ld	de, #_play_level_dbg_pals_60003_392
	ld	hl, #221
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_gbc_bg_palettes
	add	hl, de
	push	hl
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
00124$:
;src/gameplay.c:790: prev_joy = joy;
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #198
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:792: uint16_t px_prev = cam_px >> 4;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #216
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
	ldhl	sp,	#2
	ld	(hl), a
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:793: uint8_t needs_render = 0;
	ld	hl, #219
	add	hl, sp
;src/gameplay.c:794: uint16_t need_col = 0;
	xor	a, a
	ld	(hl-), a
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:797: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xf6
	ld	l, a
	ld	a, b
	adc	a, #0xff
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #222
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	NC, 00132$
;src/gameplay.c:798: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #197
	add	hl, sp
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x02ca
	add	hl, bc
	ld	c, l
;src/gameplay.c:799: cam_px += scroll_acc >> 8;
	ld	e, h
	ld	d, #0x00
	ld	hl, #222
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ld	(hl), a
;src/gameplay.c:800: scroll_acc &= 0xFF;
	ld	hl, #197
	add	hl, sp
	ld	(hl), c
;src/gameplay.c:792: uint16_t px_prev = cam_px >> 4;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #216
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
;src/gameplay.c:801: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:802: if (px_curr != px_prev) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00684$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00132$
00684$:
;src/gameplay.c:803: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:804: if (need > loaded_r && need < level_map_w) {
	ld	hl, #195
	add	hl, sp
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00132$
	ld	hl, #183
	add	hl, sp
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00132$
;src/gameplay.c:805: needs_render = 1;
	ld	hl, #219
	add	hl, sp
;src/gameplay.c:806: need_col = need;
	ld	a, #0x01
	ld	(hl-), a
	dec	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00132$:
;src/gameplay.c:811: player.world_x = cam_px;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
;src/gameplay.c:758: sp_cache_reset(&active_sp, &sp_stream_idx);
;src/gameplay.c:814: if ((cam_px >> 4) != sp_cache_col) {
	ld	hl, #215
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00685$
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00134$
00685$:
;src/gameplay.c:815: sp_cache_update(l, cam_px, &active_sp, &sp_stream_idx);
	ld	hl, #143
	add	hl, sp
	push	hl
	ld	hl, #33
	add	hl, sp
	push	hl
	ld	hl, #226
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #181
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_sp_cache_update
;src/gameplay.c:816: sp_cache_col = cam_px >> 4;
	ld	hl, #215
	add	hl, sp
	ld	a, (hl)
	ld	hl, #200
	add	hl, sp
	ld	(hl), a
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	ld	hl, #201
	add	hl, sp
	ld	(hl), a
00134$:
;src/gameplay.c:821: process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
	ld	hl, #221
	add	hl, sp
	push	hl
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #11
	add	hl, sp
	push	hl
	ld	hl, #227
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #36
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_process_sprite_logic
;src/gameplay.c:823: if (player.reversed != prev_reversed) {
	ldhl	sp,	#18
	ld	c, (hl)
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jp	Z, 00141$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:827: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00244$
	ld	hl,#0xcf
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	jr	00245$
00244$:
	ld	hl,#0xcd
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
00245$:
	ld	e, c
;src/gameplay.c:828: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #187
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #182
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:831: uint16_t start_col = cam_px >> 4;
	ld	hl, #215
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:832: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #216
	add	hl, sp
	ld	(hl), #0x00
00237$:
;src/gameplay.c:833: uint16_t curr_col = start_col + i;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #195
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:832: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00139$
;src/gameplay.c:833: uint16_t curr_col = start_col + i;
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #195
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #195
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:834: if (curr_col < level_map_w) {
	ld	hl, #195
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #183
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00238$
;src/gameplay.c:835: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #195
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
	ld	c, a
;src/gameplay.c:757: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:836: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
	ld	hl, #215
	add	hl, sp
	ld	(hl), c
	xor	a, a
	sub	a, (hl)
	and	a, #0x0f
	ld	c, a
00136$:
;src/gameplay.c:837: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	hl, #204
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #189
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #201
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_draw_mt_column
00238$:
;src/gameplay.c:832: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #216
	add	hl, sp
	inc	(hl)
	jp	00237$
00139$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:842: loaded_r = start_col + 15;
	ld	hl,#0xc3
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #195
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:843: prev_reversed = player.reversed;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	hl, #204
	add	hl, sp
	ld	(hl), a
00141$:
;src/gameplay.c:846: uint16_t collision_col = cam_px >> 4;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
	ld	hl, #223
	add	hl, sp
	ld	a, (hl)
	ld	hl, #216
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
;src/gameplay.c:847: if (collision_col != cached_collision_col) {
	ld	hl, #202
	add	hl, sp
	ld	a, (hl)
	ld	hl, #215
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00687$
	ld	hl, #203
	add	hl, sp
	ld	a, (hl)
	ld	hl, #216
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00143$
00687$:
;src/gameplay.c:849: level_map_bank, collision_columns);
;src/gameplay.c:848: load_collision_columns(collision_col, level_map, level_map_w,
	ld	hl, #145
	add	hl, sp
	push	hl
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
	ld	c, a
	ld	b, (hl)
	ld	hl, #220
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:850: cached_collision_col = collision_col;
	ld	hl, #215
	add	hl, sp
	ld	a, (hl)
	ld	hl, #202
	add	hl, sp
	ld	(hl), a
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	ld	hl, #203
	add	hl, sp
	ld	(hl), a
00143$:
;src/gameplay.c:853: died = player_update(&player, joy, collision_columns, level_map_h);
;src/gameplay.c:719: player_init(&player, 0, 240);
;src/gameplay.c:853: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #147
	add	hl, sp
	push	hl
	ld	hl, #224
	add	hl, sp
	ld	a, (hl)
	ld	hl, #12
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #215
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:855: py = player_screen_y(&player, cam_py);
	ld	hl, #191
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:856: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#2
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
	jr	Z, 00688$
	bit	7, d
	jr	NZ, 00689$
	cp	a, a
	jr	00689$
00688$:
	bit	7, d
	jr	Z, 00689$
	scf
00689$:
	jr	NC, 00155$
;src/gameplay.c:857: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	l, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, l
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:858: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00145$
	ld	bc, #0x0000
00145$:
;src/gameplay.c:859: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #193
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00147$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00147$:
;src/gameplay.c:860: cam_py = (uint16_t)target_cam_py;
	ld	hl, #191
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00156$
00155$:
;src/gameplay.c:862: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#2
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00156$
;src/gameplay.c:863: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	l, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, l
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:864: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00149$
	ld	bc, #0x0000
00149$:
;src/gameplay.c:865: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #193
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00151$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00151$:
;src/gameplay.c:866: cam_py = (uint16_t)target_cam_py;
	ld	hl, #191
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00156$:
;src/gameplay.c:871: if (player.reversed) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
;src/gameplay.c:873: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ld	hl, #222
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
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:874: sprite_x_final = 128; // Mirrored player position
	ld	hl, #220
	add	hl, sp
	ld	(hl), #0x80
	jr	00159$
00158$:
;src/gameplay.c:876: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #222
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x20
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00246$
	ld	a, c
	add	a, #0xe0
	ld	e, a
	ld	a, b
	adc	a, #0xff
	jr	00247$
00246$:
	xor	a, a
	ld	e, a
00247$:
	ldhl	sp,	#0
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:877: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	a, c
	sub	a, #0x20
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00248$
	ld	hl, #222
	add	hl, sp
	ld	a, (hl)
	jr	00249$
00248$:
	ld	a, #0x20
00249$:
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
00159$:
;src/gameplay.c:879: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #191
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:881: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:882: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ld	hl, #221
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:883: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #191
	add	hl, sp
	ld	c, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:885: if (needs_render) {
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00163$
;src/gameplay.c:886: loaded_r = need_col;
	dec	hl
	dec	hl
	ld	a, (hl)
	ld	hl, #195
	add	hl, sp
	ld	(hl), a
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	ld	hl, #196
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:887: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ld	hl, #217
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:757: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#18
	ld	c, (hl)
;src/gameplay.c:889: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, c
	or	a, a
	jr	Z, 00161$
	ld	hl, #219
	add	hl, sp
	xor	a, a
	sub	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00161$:
;src/gameplay.c:890: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	ld	a, c
	push	af
	inc	sp
	ld	hl, #189
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #183
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #223
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	call	_draw_mt_column
00163$:
;src/gameplay.c:893: uint8_t oam_index = draw_sprites(
	ldhl	sp,	#18
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	hl, #193
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #226
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #35
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_draw_sprites
	ld	hl, #216
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:898: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#17
	ld	a, (hl)
	ld	hl, #217
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:757: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	hl, #218
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:900: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #219
	add	hl, sp
;src/gameplay.c:898: if (player.mode == MODE_SHIP) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	dec	a
	jp	NZ, 00195$
;src/gameplay.c:899: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jp	Z, 00171$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #217
	add	hl, sp
;src/gameplay.c:900: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
	inc	hl
	ld	a, (hl)
	add	a, #0x18
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #216
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00250$
	ldhl	sp,	#2
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00251$
00250$:
	ldhl	sp,	#2
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00251$:
	ld	hl, #219
	add	hl, sp
	ld	e, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #220
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	add	a, #0xf8
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:900: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00165$:
;src/gameplay.c:901: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #219
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #216
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
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00252$
	ldhl	sp,	#2
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00253$
00252$:
	ldhl	sp,	#2
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00253$:
	ld	hl, #219
	add	hl, sp
	ld	e, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #220
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:901: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00171$:
;src/gameplay.c:903: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #219
	add	hl, sp
	ld	a, (hl-)
	add	a, #0x10
	ld	c, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
	inc	hl
	inc	hl
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a,	(hl+)
	ld	b, (hl)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	e, a
	ld	d, b
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
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	add	a, #0xf8
	ld	e, a
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:903: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00168$:
;src/gameplay.c:904: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	b, c
	ld	hl, #220
	add	hl, sp
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:904: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00195$:
;src/gameplay.c:906: } else if (player.mode == MODE_BALL) {
	ld	hl, #217
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x02
	jp	NZ, 00192$
;src/gameplay.c:907: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	c, (hl)
;src/gameplay.c:901: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	add	a, #0x08
;src/gameplay.c:903: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:907: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00180$
;src/gameplay.c:908: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00174$
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:908: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00174$:
;src/gameplay.c:909: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #219
	add	hl, sp
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:909: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00180$:
;src/gameplay.c:911: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:911: if (player.reversed) oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00177$:
;src/gameplay.c:912: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #219
	add	hl, sp
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:912: else oam_index += move_metasprite(ball_metasprites[0], 12, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00192$:
;src/gameplay.c:915: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jp	Z, 00189$
;src/gameplay.c:916: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00183$
	inc	hl
	ld	a, (hl)
	add	a, #0x20
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #216
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
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
	jr	Z, 00254$
	ldhl	sp,	#2
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00255$
00254$:
	ldhl	sp,	#2
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00255$:
	ld	hl, #219
	add	hl, sp
	ld	c, (hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	(hl-), a
	ld	(hl), #0x00
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #219
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:916: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00183$:
;src/gameplay.c:917: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #219
	add	hl, sp
	ld	a, (hl+)
	add	a, #0x10
	ld	c, a
	ld	a, (hl)
	add	a, #0x16
	ld	(hl), a
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), b
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ld	b, c
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	add	a, #0xf8
	ld	e, a
	ld	d, b
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:917: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jp	00196$
00189$:
;src/gameplay.c:919: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #218
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00186$
	inc	hl
	ld	a, (hl)
	add	a, #0x20
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #216
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
	jr	Z, 00256$
	ldhl	sp,	#2
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00257$
00256$:
	ldhl	sp,	#2
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00257$:
	ld	hl, #219
	add	hl, sp
	ld	c, (hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	(hl-), a
	ld	(hl), #0x00
	ld	hl, #220
	add	hl, sp
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #219
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:919: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
	jr	00196$
00186$:
;src/gameplay.c:920: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #219
	add	hl, sp
	ld	a, (hl+)
	add	a, #0x10
	ld	b, a
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
	ldhl	sp,	#19
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
	ld	hl, #216
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:920: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #216
	add	hl, sp
	add	a, (hl)
	ld	hl, #220
	add	hl, sp
	ld	(hl), a
00196$:
;src/gameplay.c:925: if (oam_index < previous_oam_index) {
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #199
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00198$
;src/gameplay.c:926: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00198$:
;src/gameplay.c:928: previous_oam_index = oam_index;
	ld	hl, #220
	add	hl, sp
	ld	a, (hl)
	ld	hl, #199
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:930: if (died) {
	ld	hl, #215
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00207$
;src/gameplay.c:931: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:932: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:933: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:934: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:935: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:936: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:937: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:938: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:939: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:940: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00240$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00199$
	call	_wait_vbl_done
	inc	c
	jr	00240$
00199$:
;src/gameplay.c:941: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:942: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:943: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:944: if (level_songs[idx]) {
	ld	hl,#0xbd
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
	jr	Z, 00201$
;src/gameplay.c:945: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xd1
	add	hl,sp
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
;src/gameplay.c:946: current_song_bank = song_bank[idx];
	ld	hl,#0xd3
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00201$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:949: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:956: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0xd5
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #222
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #187
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #182
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #223
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:960: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:961: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:962: set_sprite_data(12, 4, ball_tiles);
	ld	de, #_ball_tiles
	push	de
	ld	hl, #0x40c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:963: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
	ld	de, #_famidash_sprites_tiles
	push	de
	ld	hl, #0x5c70
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:965: cam_px = 0;
	xor	a, a
	ld	hl, #222
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:966: cam_py = 112;
	ld	hl, #191
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:967: scroll_acc = 0;
	ld	hl, #197
	add	hl, sp
;src/gameplay.c:968: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:969: target_bg_idx = 0;
	ld	hl, #221
	add	hl, sp
	ld	(hl), #0x00
;src/gameplay.c:970: player_init(&player, 0, 240);
	ld	hl, #8
	add	hl, sp
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:971: sp_cache_reset(&active_sp, &sp_stream_idx);
	ld	hl, #143
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #31
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_sp_cache_reset
;src/gameplay.c:972: sp_cache_col = 0xFFFF;
	ld	hl, #200
	add	hl, sp
;src/gameplay.c:973: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	a,#0xff
	ld	(hl+),a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x28
;src/gameplay.c:974: cached_collision_col = 0xFFFF;
	ld	hl, #202
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:976: BGP_REG = bg_pals[0];
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:977: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00203$
;src/gameplay.c:981: set_bkg_palette(0, 1, &gbc_bg_palettes[GBC_DEFAULT_BG_PAL << 2]);
	ld	de, #(_gbc_bg_palettes + 256)
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
00203$:
;src/gameplay.c:983: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #189
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #181
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:984: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:985: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:986: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:987: enable_interrupts();
	jp	00207$
00208$:
;src/gameplay.c:991: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:993: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:995: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:997: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:998: }
	ld	hl, #224
	add	hl, sp
	ld	sp, hl
	ret
_play_level_dbg_pals_60003_392:
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x0f	; 15
___str_3:
	.ascii "LEVEL COMPLETE"
	.db 0x00
___str_4:
	.ascii "PRESS A TO EXIT"
	.db 0x00
	.area _CODE_10
	.area _INITIALIZER
	.area _CABS (ABS)
