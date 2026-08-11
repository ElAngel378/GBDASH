;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module gameplay
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hide_sprites_range
	.globl _player_screen_y
	.globl _player_update
	.globl _player_init
	.globl _load_collision_columns
	.globl _load_bkg_tileset
	.globl _fill_scroll_bg
	.globl _draw_mt_column
	.globl _init_music_banked
	.globl _process_sp_objects
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
;src/gameplay.c:40: static uint8_t render_level_sprites(const SpDef *visible, uint8_t visible_count,
;	---------------------------------
; Function render_level_sprites
; ---------------------------------
_render_level_sprites:
	add	sp, #-10
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/gameplay.c:43: for (uint8_t i = 0; i < visible_count && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jp	NC, 00115$
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x26
	jp	NC, 00115$
;src/gameplay.c:44: uint16_t object_x = visible[i].c << 4;
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, #0x00
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:45: uint16_t object_y = (uint16_t)(map_height - 1u - visible[i].r) << 4;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	l, a
	ld	a, b
	sbc	a, d
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
;src/gameplay.c:48: int16_t screen_x = (int16_t)(object_x - cam_px);
	pop	de
	push	de
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:51: if (reversed) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/gameplay.c:53: screen_x = 128 - screen_x + 8;
	ld	de, #0x0088
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	jr	00103$
00102$:
;src/gameplay.c:56: screen_x = screen_x + PLAYER_SCREEN_X + 8;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, (hl)
	add	a, #0x28
	ld	d, a
	ld	a, e
	adc	a, #0x00
	ldhl	sp,	#0
	ld	(hl), d
	inc	hl
	ld	(hl), a
00103$:
;src/gameplay.c:59: int16_t screen_y = (int16_t)(object_y - cam_py) + 16;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	c, e
	ld	b, a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:63: if (screen_x < -24 || screen_x > 160 || screen_y < -48 || screen_y > 144) continue;
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0xe8
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	ld	e, a
	bit	7, e
	jr	Z, 00205$
	bit	7, d
	jr	NZ, 00206$
	cp	a, a
	jr	00206$
00205$:
	bit	7, d
	jr	Z, 00206$
	scf
00206$:
	jp	C, 00114$
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jp	C, 00114$
	ld	a, c
	sub	a, #0xd0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jp	C, 00114$
	ld	l, c
	ld	h, b
	ld	e, h
	ld	d, #0x00
	ld	a, #0x90
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00209$
	bit	7, d
	jr	NZ, 00210$
	cp	a, a
	jr	00210$
00209$:
	bit	7, d
	jr	Z, 00210$
	scf
00210$:
	jp	C, 00114$
;src/gameplay.c:65: uint8_t cost = level_sprite_cost_table[visible[i].obj];
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #_level_sprite_cost_table
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
;src/gameplay.c:66: if (oam_start + cost > MAX_HARDWARE_SPRITES - 2) break;
	ldhl	sp,	#19
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
	ld	l, a
	add	hl, de
	ld	a, #0x26
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	C, 00115$
;src/gameplay.c:68: const metasprite_t *sprite = famidash_sprite_table[visible[i].obj];
	ldhl	sp,	#5
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	ld	de, #_famidash_sprite_table
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:73: (uint8_t)screen_y);
;src/gameplay.c:72: oam_start, (uint8_t)screen_x,
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;src/gameplay.c:70: if (reversed) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;src/gameplay.c:73: (uint8_t)screen_y);
;src/gameplay.c:72: oam_start, (uint8_t)screen_x,
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
;src/gameplay.c:73: (uint8_t)screen_y);
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x58
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldhl	sp,	#3
	ld	(hl), c
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00123$
	ldhl	sp,	#4
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00124$
00123$:
	ldhl	sp,	#4
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00124$:
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	b, a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:73: (uint8_t)screen_y);
	jr	00113$
00112$:
;src/gameplay.c:77: (uint8_t)screen_y);
;src/gameplay.c:76: oam_start, (uint8_t)screen_x,
	ldhl	sp,	#4
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x58
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, c
	ldhl	sp,	#5
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:77: (uint8_t)screen_y);
00113$:
;src/gameplay.c:79: oam_start += used;
	ldhl	sp,	#19
	add	a, (hl)
	ld	(hl), a
00114$:
;src/gameplay.c:43: for (uint8_t i = 0; i < visible_count && oam_start < MAX_HARDWARE_SPRITES - 2; i++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	00120$
00115$:
;src/gameplay.c:81: return oam_start;
	ldhl	sp,	#19
	ld	a, (hl)
;src/gameplay.c:82: }
	add	sp, #10
	pop	hl
	add	sp, #8
	jp	(hl)
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
;src/gameplay.c:84: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 1
_setup_menu_font::
;src/gameplay.c:85: font_init();
	call	_font_init
;src/gameplay.c:86: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:87: }
	ret
;src/gameplay.c:89: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 1
_draw_menu::
;src/gameplay.c:90: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:91: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:92: printf("GBDASH DEMO 01\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:93: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:94: gotoxy(1, 2 + i);
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
;src/gameplay.c:95: if (i == selected) printf("0 %s", game_levels[i]->name);
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
;src/gameplay.c:96: else printf("  %s", game_levels[i]->name);
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
;src/gameplay.c:93: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:98: printf("\n\n\n\n\n\n\n\nSotospro24");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:99: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:100: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:101: }
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
;src/gameplay.c:103: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 1
_play_level::
	add	sp, #-128
	add	sp, #-57
;src/gameplay.c:113: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ld	hl, #191
	add	hl, sp
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ld	hl, #183
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
	ld	hl, #138
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:114: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #183
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #182
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #177
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:115: level_map = l->map;
	ld	hl,#0x8a
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
	ld	hl, #140
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:116: level_tile_count = l->tile_count;
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
	ld	hl, #142
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:117: level_map_w = l->map_width;
	ld	hl,#0x8a
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
	ld	hl, #144
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:118: level_map_h = l->map_height;
	ld	hl,#0x8a
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #180
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #146
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:119: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:120: level_map_bank = l->map_bank;
	ld	hl,#0x8a
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #149
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:122: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:123: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:124: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:126: if (level_songs[idx]) {
	ld	de, #_level_songs
	ld	hl, #183
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #152
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #151
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
;src/gameplay.c:127: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0x8a
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #184
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank+0
	ld	hl, #191
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ld	hl, #186
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:128: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:129: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:132: uint16_t cam_px = 0;
	xor	a, a
	ld	hl, #183
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:133: uint16_t cam_py = 112;
	ld	hl, #152
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:134: uint16_t cam_py_max = (level_map_h << 4);
	ld	hl, #146
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
;src/gameplay.c:135: if (cam_py_max > 144u) cam_py_max -= 144u;
	ld	hl, #175
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
	ld	hl,#0xaf
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
	ld	hl, #154
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:136: else cam_py_max = 0;
	xor	a, a
	ld	hl, #154
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:137: uint16_t loaded_r = BKG_MT_W - 1;
	ld	hl, #156
	add	hl, sp
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:142: uint8_t target_bg_idx = 0;
	ldhl	sp,	#5
;src/gameplay.c:143: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:151: player_init(&player, 0, 240);
	ld	de, #0x00f0
	push	de
	ld	bc, #0x0000
	ld	hl, #12
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:154: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:155: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #148
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #143
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #178
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:156: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:157: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:158: set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
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
;src/gameplay.c:160: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #150
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #146
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #142
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:161: BGP_REG = bg_pals[0];
	ldhl	sp,	#6
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:162: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:163: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:164: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/gameplay.c:165: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:166: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:167: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:168: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:171: uint16_t scroll_acc = 0;
	ld	hl, #158
	add	hl, sp
;src/gameplay.c:172: uint8_t prev_joy = 0;
;src/gameplay.c:173: uint8_t previous_oam_index = MAX_HARDWARE_SPRITES;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x28
;src/gameplay.c:175: uint8_t visible_level_sprite_count = 0;
	ldhl	sp,	#105
	ld	(hl), #0x00
;src/gameplay.c:177: uint16_t cached_collision_col = 0xFFFF;
	ld	hl, #161
	add	hl, sp
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/gameplay.c:178: while (1) {
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #163
	add	hl, sp
	ld	(hl), a
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	ld	hl, #164
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x8a
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #167
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #166
	add	hl, sp
	ld	(hl), a
	ld	hl, #179
	add	hl, sp
	ld	a, (hl)
	ld	hl, #167
	add	hl, sp
	ld	(hl), a
	ld	hl, #180
	add	hl, sp
	ld	a, (hl)
	ld	hl, #168
	add	hl, sp
	ld	(hl), a
	ld	hl,#0x8a
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #171
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #170
	add	hl, sp
	ld	(hl), a
	ld	de, #_song_bank
	ld	hl, #191
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #173
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #172
	add	hl, sp
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #173
	add	hl, sp
	ld	(hl), a
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	ld	hl, #174
	add	hl, sp
	ld	(hl), a
00182$:
;src/gameplay.c:179: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/gameplay.c:180: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#2
	bit	7, (hl)
	pop	hl
	jp	NZ, 00183$
;src/gameplay.c:182: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ldhl	sp,	#2
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:183: HIDE_SPRITES;
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
;src/gameplay.c:186: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:188: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:189: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:190: printf("LEVEL COMPLETE");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:191: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:192: printf("Press A to exit");
	ld	de, #___str_6
	push	de
	call	_printf
	pop	de
;src/gameplay.c:193: waitpadup();
	call	_waitpadup
;src/gameplay.c:194: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00183$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:195: break;
00112$:
;src/gameplay.c:198: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ldhl	sp,	#2
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ld	hl, #161
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
;src/gameplay.c:199: prev_joy = joy;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	hl, #159
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:201: uint16_t px_prev = cam_px >> 4;
	ld	hl, #183
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	hl, #184
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
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
;src/gameplay.c:202: uint8_t needs_render = 0;
	ld	hl, #182
	add	hl, sp
	ld	(hl), #0x00
;src/gameplay.c:203: uint16_t need_col = 0;
	xor	a, a
	ld	hl, #177
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:204: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	a, (hl)
	ld	hl, #179
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:207: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ld	hl, #144
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
	ld	hl, #181
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ld	hl, #175
	add	hl, sp
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #176
	add	hl, sp
	ld	(hl), a
	ld	a, #0x04
00571$:
	ld	hl, #175
	add	hl, sp
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00571$
	ld	hl, #183
	add	hl, sp
	ld	a, (hl)
	ld	hl, #180
	add	hl, sp
	ld	(hl), a
	ld	hl, #184
	add	hl, sp
	ld	a, (hl)
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
	ld	hl, #180
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #175
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00123$
;src/gameplay.c:208: scroll_acc += SCROLL_SPEED_FP;
	ld	hl, #158
	add	hl, sp
	ld	a, (hl)
	ld	hl, #175
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
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:209: cam_px += scroll_acc >> 8;
	ld	a, (hl)
	ld	hl, #175
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #183
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
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
;src/gameplay.c:210: scroll_acc &= 0xFF;
	ld	hl, #180
	add	hl, sp
	ld	a, (hl)
	ld	hl, #175
	add	hl, sp
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #176
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #180
	add	hl, sp
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #158
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:201: uint16_t px_prev = cam_px >> 4;
	ld	hl, #183
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	hl, #184
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
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
;src/gameplay.c:211: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:212: if (px_curr != px_prev) {
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00572$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00123$
00572$:
;src/gameplay.c:213: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #175
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
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:214: if (need > loaded_r && need < level_map_w) {
	ld	hl, #156
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #180
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
	ld	hl, #180
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #144
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:215: needs_render = 1;
	ld	hl, #182
	add	hl, sp
;src/gameplay.c:216: need_col = need;
	ld	a, #0x01
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	hl, #177
	add	hl, sp
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #178
	add	hl, sp
	ld	(hl), a
00123$:
;src/gameplay.c:221: player.world_x = cam_px;
	ld	hl, #183
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ld	hl, #184
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;src/gameplay.c:223: visible_level_sprites, &visible_level_sprite_count);
;src/gameplay.c:222: process_sp_objects(l, &player, joy, &target_bg_idx,
	ldhl	sp,	#5
	ld	c, l
	ld	e, h
;src/gameplay.c:151: player_init(&player, 0, 240);
;src/gameplay.c:222: process_sp_objects(l, &player, joy, &target_bg_idx,
	ld	hl, #105
	add	hl, sp
	push	hl
	ld	hl, #59
	add	hl, sp
	push	hl
	ld	b, e
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #17
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #145
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_process_sp_objects
;src/gameplay.c:225: if (player.reversed != prev_reversed) {
	ldhl	sp,	#20
	ld	c, (hl)
	ld	hl, #179
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jp	Z, 00130$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:229: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00215$
	ld	hl,#0xa5
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	jr	00216$
00215$:
	ld	hl,#0xa3
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
00216$:
	ld	e, c
;src/gameplay.c:230: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ld	hl, #148
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #143
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:233: uint16_t start_col = cam_px >> 4;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:234: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #181
	add	hl, sp
	ld	(hl), #0x00
00208$:
;src/gameplay.c:235: uint16_t curr_col = start_col + i;
	ld	e, c
	ld	d, b
;src/gameplay.c:234: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00128$
;src/gameplay.c:235: uint16_t curr_col = start_col + i;
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
	ld	hl, #179
	add	hl, sp
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:236: if (curr_col < level_map_w) {
	ld	hl, #179
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	hl, #144
	add	hl, sp
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00209$
;src/gameplay.c:237: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ld	hl, #179
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
;src/gameplay.c:204: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	h, (hl)
;src/gameplay.c:238: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	inc	h
	dec	h
	jr	Z, 00125$
	ld	e, a
	xor	a, a
	sub	a, e
	and	a, #0x0f
00125$:
;src/gameplay.c:239: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	push	hl
	inc	sp
	ld	hl, #152
	add	hl, sp
	ld	h, (hl)
	push	hl
	inc	sp
	ld	hl, #148
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #146
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #187
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
	pop	bc
00209$:
;src/gameplay.c:234: for (uint8_t i = 0; i < 16; i++) {
	ld	hl, #181
	add	hl, sp
	inc	(hl)
	jr	00208$
00128$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:244: loaded_r = start_col + 15;
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #156
	add	hl, sp
	ld	(hl), c
	inc	hl
	ld	(hl), a
00130$:
;src/gameplay.c:247: uint16_t collision_col = cam_px >> 4;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #180
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #181
	add	hl, sp
;src/gameplay.c:248: if (collision_col != cached_collision_col) {
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #161
	add	hl, sp
	sub	a, (hl)
	jr	NZ, 00574$
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #162
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00132$
00574$:
;src/gameplay.c:250: level_map_bank, collision_columns);
;src/gameplay.c:249: load_collision_columns(collision_col, level_map, level_map_w,
	ld	hl, #106
	add	hl, sp
	push	hl
	ld	hl, #151
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #147
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #145
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #185
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_collision_columns
;src/gameplay.c:251: cached_collision_col = collision_col;
	ld	hl, #180
	add	hl, sp
	ld	a, (hl)
	ld	hl, #161
	add	hl, sp
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ld	hl, #162
	add	hl, sp
	ld	(hl), a
00132$:
;src/gameplay.c:253: died = player_update(&player, joy, collision_columns, level_map_h);
	ld	hl, #146
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #108
	add	hl, sp
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	ld	hl, #14
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ld	hl, #175
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:255: py = player_screen_y(&player, cam_py);
	ld	hl, #152
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:256: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:259: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	hl, #154
	add	hl, sp
	ld	a, (hl)
	ld	hl, #180
	add	hl, sp
	ld	(hl), a
	ld	hl, #155
	add	hl, sp
	ld	a, (hl)
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:256: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#3
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00575$
	bit	7, d
	jr	NZ, 00576$
	cp	a, a
	jr	00576$
00575$:
	bit	7, d
	jr	Z, 00576$
	scf
00576$:
	jr	NC, 00144$
;src/gameplay.c:257: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#13
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:258: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00134$
	ld	bc, #0x0000
00134$:
;src/gameplay.c:259: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #154
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00136$
	ld	hl, #180
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00136$:
;src/gameplay.c:260: cam_py = (uint16_t)target_cam_py;
	ld	hl, #152
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00145$
00144$:
;src/gameplay.c:262: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#3
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00145$
;src/gameplay.c:263: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#13
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:264: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00138$
	ld	bc, #0x0000
00138$:
;src/gameplay.c:265: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ld	hl, #154
	add	hl, sp
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00140$
	ld	hl, #180
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00140$:
;src/gameplay.c:266: cam_py = (uint16_t)target_cam_py;
	ld	hl, #152
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00145$:
;src/gameplay.c:271: if (player.reversed) {
	ldhl	sp,	#20
	ld	a, (hl)
	or	a, a
	jr	Z, 00147$
;src/gameplay.c:273: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ld	hl, #183
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
	ldhl	sp,	#3
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:274: sprite_x_final = 128; // Mirrored player position
	ld	hl, #181
	add	hl, sp
	ld	(hl), #0x80
	jr	00148$
00147$:
;src/gameplay.c:276: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ld	hl, #183
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	hl, #184
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00217$
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #181
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
	jr	00218$
00217$:
	xor	a, a
	ld	hl, #180
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00218$:
	ld	hl, #180
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:277: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00219$
	ld	hl, #183
	add	hl, sp
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	jr	00220$
00219$:
	ld	a, #0x20
00220$:
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
00148$:
;src/gameplay.c:279: int16_t final_py = player_screen_y(&player, cam_py);
	ld	hl, #152
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ld	hl, #179
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:281: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:282: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:283: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ld	hl, #152
	add	hl, sp
	ld	a, (hl)
	ld	hl, #176
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:285: if (needs_render) {
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00152$
;src/gameplay.c:286: loaded_r = need_col;
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	ld	hl, #156
	add	hl, sp
	ld	(hl), a
	ld	hl, #178
	add	hl, sp
	ld	a, (hl)
	ld	hl, #157
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:287: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0f
	ld	c, a
;src/gameplay.c:204: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	b, (hl)
;src/gameplay.c:289: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, b
	or	a, a
	jr	Z, 00150$
	xor	a, a
	sub	a, c
	and	a, #0x0f
	ld	c, a
00150$:
;src/gameplay.c:290: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	inc	sp
	ld	hl, #150
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #146
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #144
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
	ld	a, c
	call	_draw_mt_column
00152$:
;src/gameplay.c:293: uint8_t oam_index = render_level_sprites(visible_level_sprites,
	ldhl	sp,	#20
	ld	b, (hl)
	ld	hl,#0xa7
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	h, #0x00
	ld	l, b
	push	hl
	ld	hl, #154
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	hl, #187
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	b, a
	push	bc
	ldhl	sp,	#113
	ld	a, (hl)
	ld	hl, #65
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_render_level_sprites
	ld	hl, #176
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:298: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:204: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	a, (hl)
	ld	hl, #177
	add	hl, sp
;src/gameplay.c:300: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl)
	ld	hl, #178
	add	hl, sp
	ld	(hl), a
	ld	a, (hl+)
	add	a, #0x18
;src/gameplay.c:301: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
;src/gameplay.c:303: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:298: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#4
	ld	a, (hl)
	dec	a
	jp	NZ, 00172$
;src/gameplay.c:299: if (player.gravity_flipped) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jp	Z, 00160$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:300: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00154$
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	add	a, #0x18
	ld	(hl), a
	ld	hl, #178
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x18
	ld	(hl), a
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	hl, #177
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	hl, #179
	add	hl, sp
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ld	hl, #178
	add	hl, sp
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00221$
	ld	bc, #0x0010
	jr	00222$
00221$:
	ld	bc, #0x0008
00222$:
	ld	hl, #182
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
;src/gameplay.c:300: if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00154$:
;src/gameplay.c:301: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ld	hl, #178
	add	hl, sp
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	ld	hl, #179
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
	ld	hl, #181
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00223$
	ld	hl, #177
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00224$
00223$:
	ld	hl, #177
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00224$:
	ld	hl, #182
	add	hl, sp
	ld	e, (hl)
	ld	hl, #177
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #180
	add	hl, sp
	ld	a, (hl-)
	ld	e, a
	ld	d, b
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:301: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00160$:
;src/gameplay.c:303: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00157$
	ld	hl, #181
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
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:303: if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00157$:
;src/gameplay.c:304: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #181
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
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:304: else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00172$:
;src/gameplay.c:307: if (player.gravity_flipped) {
	ldhl	sp,	#18
	ld	c, (hl)
;src/gameplay.c:301: else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:307: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jp	Z, 00169$
;src/gameplay.c:308: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00163$
	ld	hl, #182
	add	hl, sp
	ld	c, (hl)
	ld	hl, #179
	add	hl, sp
	ld	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#21
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	push	af
	ld	hl, #178
	add	hl, sp
	ld	a, (hl)
	ld	hl, #183
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
	jr	Z, 00225$
	ld	hl, #0x0010
	jr	00226$
00225$:
	ld	hl, #0x0008
00226$:
	ld	a, c
	sub	a, l
	ld	d, a
	ld	hl, #182
	add	hl, sp
	ld	a, (hl-)
	add	a, #0xf8
	ld	e, a
	ld	a, (hl)
	call	___move_metasprite_hvflip
;src/gameplay.c:308: if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00163$:
;src/gameplay.c:309: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #181
	add	hl, sp
	ld	b, (hl)
	ld	hl, #178
	add	hl, sp
	ld	a, (hl)
	add	a, #0x16
	ld	c, a
	ldhl	sp,	#21
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
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_vflip
;src/gameplay.c:309: else oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 22, final_py + 16);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jp	00173$
00169$:
;src/gameplay.c:311: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #177
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00166$
	inc	hl
	ld	a, (hl)
	add	a, #0x0a
	ld	hl, #181
	add	hl, sp
	ld	(hl), a
	ldhl	sp,	#21
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #176
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
	jr	Z, 00227$
	ld	hl, #179
	add	hl, sp
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00228$
00227$:
	ld	hl, #179
	add	hl, sp
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00228$:
	ld	hl, #182
	add	hl, sp
	ld	e, (hl)
	ld	hl, #179
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ld	hl, #181
	add	hl, sp
	ld	e, (hl)
	ld	d, b
	ld	hl, #178
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite_hflip
;src/gameplay.c:311: if (player.reversed) oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 10, final_py + 32);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
	jr	00173$
00166$:
;src/gameplay.c:312: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #181
	add	hl, sp
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ldhl	sp,	#21
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
	ld	hl, #176
	add	hl, sp
	ld	a, (hl)
	call	___move_metasprite
;src/gameplay.c:312: else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
	ld	hl, #176
	add	hl, sp
	add	a, (hl)
	ld	hl, #182
	add	hl, sp
	ld	(hl), a
00173$:
;src/gameplay.c:317: if (oam_index < previous_oam_index) {
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	ld	hl, #160
	add	hl, sp
	sub	a, (hl)
	jr	NC, 00175$
;src/gameplay.c:318: hide_sprites_range(oam_index, previous_oam_index);
	ld	e, (hl)
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	call	_hide_sprites_range
00175$:
;src/gameplay.c:320: previous_oam_index = oam_index;
	ld	hl, #182
	add	hl, sp
	ld	a, (hl)
	ld	hl, #160
	add	hl, sp
	ld	(hl), a
;src/gameplay.c:322: if (died) {
	ld	hl, #175
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z, 00182$
;src/gameplay.c:323: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:324: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:325: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:326: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:327: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:328: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:329: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:330: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:331: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:332: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00211$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00176$
	call	_wait_vbl_done
	inc	c
	jr	00211$
00176$:
;src/gameplay.c:333: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:334: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:335: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:336: if (level_songs[idx]) {
	ld	hl,#0x96
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
	jr	Z, 00178$
;src/gameplay.c:337: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ld	hl,#0xa9
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
;src/gameplay.c:338: current_song_bank = song_bank[idx];
	ld	hl,#0xab
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00178$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:342: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ld	hl,#0xad
	add	hl,sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #183
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #148
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #143
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #184
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:344: cam_px = 0;
	xor	a, a
	ld	hl, #183
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:345: cam_py = 112;
	ld	hl, #152
	add	hl, sp
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:346: scroll_acc = 0;
	ld	hl, #158
	add	hl, sp
;src/gameplay.c:347: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:348: target_bg_idx = 0;
	ldhl	sp,	#5
;src/gameplay.c:349: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #12
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;src/gameplay.c:350: previous_oam_index = MAX_HARDWARE_SPRITES;
	ld	hl, #160
	add	hl, sp
;src/gameplay.c:351: cached_collision_col = 0xFFFF;
	ld	a, #0x28
	ld	(hl+), a
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:353: BGP_REG = bg_pals[0];
	ldhl	sp,	#6
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:354: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #150
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #146
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #142
	add	hl, sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:355: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:356: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:357: enable_interrupts();
	jp	00182$
00183$:
;src/gameplay.c:361: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:363: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:365: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:367: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:368: }
	add	sp, #127
	add	sp, #58
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
