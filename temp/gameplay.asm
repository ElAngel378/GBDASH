;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module gameplay
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_screen_y
	.globl _player_update
	.globl _player_init
	.globl _init_music_banked
	.globl _fill_scroll_bg
	.globl _draw_mt_column
	.globl _load_bkg_tileset
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
;src/gameplay.c:30: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 1
_setup_menu_font::
;src/gameplay.c:31: font_init();
	call	_font_init
;src/gameplay.c:32: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:33: }
	ret
;src/gameplay.c:35: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 1
_draw_menu::
;src/gameplay.c:36: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:37: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:38: printf("GBDASH DEMO 01\n\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:39: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:40: gotoxy(1, 2 + i);
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
;src/gameplay.c:41: if (i == selected) printf("0 %s", game_levels[i]->name);
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
;src/gameplay.c:42: else printf(" %s", game_levels[i]->name);
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
;src/gameplay.c:39: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:44: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:45: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:46: }
	ret
___str_1:
	.ascii "GBDASH DEMO 01"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "0 %s"
	.db 0x00
___str_3:
	.ascii " %s"
	.db 0x00
;src/gameplay.c:48: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 1
_play_level::
	add	sp, #-92
;src/gameplay.c:59: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ldhl	sp,	#98
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#90
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
	ldhl	sp,	#88
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:60: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#83
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:61: level_map = l->map;
	ldhl	sp,#88
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#57
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:62: level_tile_count = l->tile_count;
	ldhl	sp,#88
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
	ldhl	sp,	#85
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:63: level_map_w = l->map_width;
	ldhl	sp,#88
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
	ldhl	sp,	#59
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:64: level_map_h = l->map_height;
	ldhl	sp,#88
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
	ldhl	sp,	#61
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:65: level_tiles_bank = BANK(chr_gb);
	ldhl	sp,	#87
;src/gameplay.c:66: level_map_bank = l->map_bank;
	ld	a, #<(___bank_chr_gb)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#63
	ld	(hl), a
;src/gameplay.c:69: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:70: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:71: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:74: if (level_songs[idx]) {
	ld	de, #_level_songs
	ldhl	sp,	#90
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
;src/gameplay.c:75: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#88
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#91
	ld	(hl), a
	ld	de, #_song_bank+0
	ldhl	sp,	#98
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ldhl	sp,	#93
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:76: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:77: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:80: uint16_t cam_px = 0;
	xor	a, a
	ldhl	sp,	#90
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:81: uint16_t cam_py = 112;
	ldhl	sp,	#66
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:82: uint16_t cam_py_max = (level_map_h << 4);
	ldhl	sp,	#61
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
;src/gameplay.c:83: if (cam_py_max > 144u) cam_py_max -= 144u;
	ldhl	sp,	#81
	ld	(hl+), a
	ld	a, c
	ld	(hl-), a
	ld	a, #0x90
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00104$
	ldhl	sp,#81
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
	ldhl	sp,	#68
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:84: else cam_py_max = 0;
	xor	a, a
	ldhl	sp,	#68
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:85: uint16_t loaded_r = BKG_MT_W - 1;
	ldhl	sp,	#70
	ld	a, #0x0f
	ld	(hl+), a
;src/gameplay.c:90: uint8_t target_bg_idx = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:97: const uint8_t bg_pals[] = {
	ldhl	sp,	#4
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:105: player_init(&player, 0, 240);
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
;src/gameplay.c:109: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:110: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#87
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#84
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:112: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:113: set_sprite_data(8, 4, ship_tiles);
	ld	de, #_ship_tiles
	push	de
	ld	hl, #0x408
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:116: fill_scroll_bg(level_map, level_map_w, level_map_h, level_map_bank);
	ldhl	sp,	#63
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:118: BGP_REG = bg_pals[0];
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:119: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:120: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:122: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:123: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:124: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:126: TAC_REG = 0x04; // Start the timer metronome
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:131: uint16_t scroll_acc = 0;
	ldhl	sp,	#73
;src/gameplay.c:132: uint8_t prev_joy = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:133: while (1) {
	ldhl	sp,#88
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#77
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#76
	ld	(hl), a
	ldhl	sp,#88
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#79
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#78
	ld	(hl), a
	ld	de, #_song_bank
	ldhl	sp,	#98
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#81
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#80
	ld	(hl), a
00172$:
;src/gameplay.c:134: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#85
	ld	(hl), a
;src/gameplay.c:135: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#87
	bit	7, (hl)
	pop	hl
	jp	NZ, 00173$
;src/gameplay.c:138: if ((joy & J_B) && !(prev_joy & J_B)) {
	push	hl
	ldhl	sp,	#87
	bit	5, (hl)
	pop	hl
	jr	Z, 00109$
	push	hl
	ldhl	sp,	#76
	bit	5, (hl)
	pop	hl
	jr	NZ, 00109$
;src/gameplay.c:139: player_noclip = !player_noclip;
	ld	hl, #_player_noclip
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00109$:
;src/gameplay.c:141: prev_joy = joy;
	ldhl	sp,	#85
	ld	a, (hl)
	ldhl	sp,	#74
	ld	(hl), a
;src/gameplay.c:144: uint16_t px_prev = cam_px >> 4;
	ldhl	sp,#90
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
;src/gameplay.c:145: uint8_t needs_render = 0;
	ldhl	sp,	#81
;src/gameplay.c:146: uint16_t need_col = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:148: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#59
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
	ldhl	sp,	#90
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#91
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00117$
;src/gameplay.c:149: scroll_acc += SCROLL_SPEED_FP;
	ldhl	sp,	#73
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x035c
	add	hl, de
	ld	e, l
	ld	d, h
;src/gameplay.c:150: cam_px += scroll_acc >> 8;
	ldhl	sp,	#88
	ld	a, d
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#92
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#91
	ld	(hl), a
;src/gameplay.c:151: scroll_acc &= 0xFF;
	ldhl	sp,	#73
	ld	(hl), e
;src/gameplay.c:152: uint16_t px_curr = cam_px >> 4;
	ldhl	sp,#90
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
;src/gameplay.c:153: if (px_curr != px_prev) {
	ld	a, e
	sub	a, c
	jr	NZ, 00465$
	ld	a, d
	sub	a, b
	jr	Z, 00117$
00465$:
;src/gameplay.c:154: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
;src/gameplay.c:155: if (need > loaded_r && need < level_map_w) {
	ldhl	sp,	#70
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00117$
	ldhl	sp,	#59
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00117$
;src/gameplay.c:156: needs_render = 1;
	ldhl	sp,	#81
;src/gameplay.c:157: need_col = need;
	ld	a, #0x01
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00117$:
;src/gameplay.c:162: player.world_x = cam_px;
	ldhl	sp,	#90
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#91
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
;src/gameplay.c:148: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#90
	ld	a, (hl)
	ldhl	sp,	#86
	ld	(hl), a
	ldhl	sp,	#91
	ld	a, (hl)
	ldhl	sp,	#87
;src/gameplay.c:164: uint16_t col = (player.world_x + 8) >> 4;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/gameplay.c:165: const PortalDef *p_ptr = l->portals;
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#88
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:166: while (p_ptr->x != 0xFFFF) {
00139$:
	ldhl	sp,#88
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
	ld	a, e
	and	a, d
	inc	a
	jr	Z, 00141$
;src/gameplay.c:167: if (col == p_ptr->x) {
	ld	a, l
	sub	a, c
	jr	NZ, 00138$
	ld	a, h
	sub	a, b
	jr	NZ, 00138$
;src/gameplay.c:168: uint8_t obj = p_ptr->obj;
	ldhl	sp,	#88
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
;src/gameplay.c:169: if (obj == 0) player.mode = MODE_CUBE;
	ld	a, e
	or	a, a
	jr	NZ, 00135$
	ldhl	sp,	#17
	ld	(hl), #0x00
	jr	00138$
00135$:
;src/gameplay.c:170: else if (obj == 1) player.mode = MODE_SHIP;
	ld	a, e
	dec	a
	jr	NZ, 00132$
	ldhl	sp,	#17
	ld	(hl), #0x01
	jr	00138$
00132$:
;src/gameplay.c:174: player.vel_y = 20; // Snappy nudge down
;src/gameplay.c:171: else if (obj == 8) {
	ld	a, e
	sub	a, #0x08
	jr	NZ, 00129$
;src/gameplay.c:172: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
;src/gameplay.c:173: player.gravity_flipped = 0;
	ld	(hl), #0x00
;src/gameplay.c:174: player.vel_y = 20; // Snappy nudge down
	ldhl	sp,	#12
	ld	a, #0x14
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00138$
00129$:
;src/gameplay.c:177: else if (obj == 9) {
	ld	a, e
	sub	a, #0x09
	jr	NZ, 00126$
;src/gameplay.c:178: if (!player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jr	NZ, 00138$
;src/gameplay.c:179: player.gravity_flipped = 1;
	ld	(hl), #0x01
;src/gameplay.c:180: player.vel_y = -20; // Snappy nudge up
	ldhl	sp,	#12
	ld	a, #0xec
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00138$
00126$:
;src/gameplay.c:183: else if (obj >= 10 && obj <= 13) target_bg_idx = obj - 10;
	ld	a, e
	sub	a, #0x0a
	jr	C, 00138$
	ld	a, #0x0d
	sub	a, e
	jr	C, 00138$
	ld	a, e
	add	a, #0xf6
	ldhl	sp,	#72
	ld	(hl), a
00138$:
;src/gameplay.c:185: p_ptr++;
	ldhl	sp,#88
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#90
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#89
	ld	(hl), a
	jp	00139$
00141$:
;src/gameplay.c:105: player_init(&player, 0, 240);
;src/gameplay.c:189: died = player_update(&player, joy, level_map, level_map_w, level_map_h, level_map_bank);
	ldhl	sp,	#63
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#92
	ld	a, (hl)
	ld	hl, #15
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ldhl	sp,	#84
	ld	(hl), a
;src/gameplay.c:192: py = player_screen_y(&player, cam_py);
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:193: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#88
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:196: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ldhl	sp,	#68
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#69
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/gameplay.c:193: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#88
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00475$
	bit	7, d
	jr	NZ, 00476$
	cp	a, a
	jr	00476$
00475$:
	bit	7, d
	jr	Z, 00476$
	scf
00476$:
	jr	NC, 00153$
;src/gameplay.c:194: int16_t target_cam_py = player.world_y - CAM_Y_TOP_ZONE;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#89
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:195: if (target_cam_py < 0) target_cam_py = 0;
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00143$
	xor	a, a
	ldhl	sp,	#88
	ld	(hl+), a
	ld	(hl), a
00143$:
;src/gameplay.c:196: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ldhl	sp,	#88
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#68
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00145$
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl), a
00145$:
;src/gameplay.c:197: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#88
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
	jr	00154$
00153$:
;src/gameplay.c:198: } else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#88
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00154$
;src/gameplay.c:199: int16_t target_cam_py = player.world_y - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0064
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#89
	ld	(hl-), a
	ld	(hl), e
;src/gameplay.c:200: if (target_cam_py < 0) target_cam_py = 0;
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00147$
	xor	a, a
	ldhl	sp,	#88
	ld	(hl+), a
	ld	(hl), a
00147$:
;src/gameplay.c:201: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ldhl	sp,	#88
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#68
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00149$
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl), a
00149$:
;src/gameplay.c:202: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#88
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl), a
00154$:
;src/gameplay.c:206: uint16_t scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ldhl	sp,	#86
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00193$
	ldhl	sp,#86
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#89
	ld	(hl-), a
	ld	(hl), e
	jr	00194$
00193$:
	xor	a, a
	ldhl	sp,	#88
	ld	(hl+), a
	ld	(hl), a
00194$:
	ldhl	sp,	#88
	ld	a, (hl)
	ldhl	sp,	#85
;src/gameplay.c:207: uint8_t sprite_x = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	(hl+), a
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00195$
	ldhl	sp,	#90
	ld	a, (hl)
	jr	00196$
00195$:
	ld	a, #0x20
00196$:
	ldhl	sp,	#86
	ld	(hl), a
;src/gameplay.c:208: int16_t final_py = player_screen_y(&player, cam_py);
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ldhl	sp,	#87
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:211: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:214: BGP_REG = bg_pals[target_bg_idx];
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#72
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
;src/gameplay.c:215: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ldhl	sp,	#66
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl), a
	ldhl	sp,	#85
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ldhl	sp,	#89
	ld	a, (hl)
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:217: if (needs_render) {
	ldhl	sp,	#81
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
;src/gameplay.c:218: loaded_r = need_col;
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#70
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#71
	ld	(hl), a
;src/gameplay.c:219: draw_mt_column((uint8_t)(need_col % BKG_MT_W), need_col, level_map, level_map_w, level_map_h, level_map_bank);
	ldhl	sp,	#82
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	and	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#63
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#62
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#89
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
00156$:
;src/gameplay.c:222: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#85
;src/gameplay.c:224: move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#86
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl-), a
	ld	a, (hl-)
	add	a, #0x08
;src/gameplay.c:222: if (player.mode == MODE_SHIP) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	dec	a
	jp	NZ, 00164$
;src/gameplay.c:223: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
;src/gameplay.c:224: move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	de, #_ship_metasprites
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	(hl-), a
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#87
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#86
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	add	a, #0xf8
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#82
	ld	(hl), a
	ldhl	sp,	#87
	ld	a, (hl)
	ldhl	sp,	#83
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	xor	a, a
	call	___move_metasprite_vflip
;src/gameplay.c:224: move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
	jp	00165$
00158$:
;src/gameplay.c:226: move_metasprite(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
	ldhl	sp,	#89
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
;c:\gbdk\include\gb\metasprites.h:169: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), b
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#82
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#87
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#89
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#82
	ld	(hl), a
	ldhl	sp,	#87
	ld	a, (hl)
	ldhl	sp,	#83
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	xor	a, a
	call	___move_metasprite
;src/gameplay.c:226: move_metasprite(ship_metasprites[0], 0, 0, sprite_x + 8, final_py + 16);
	jp	00165$
00164$:
;src/gameplay.c:229: if (player.gravity_flipped) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jr	Z, 00161$
;src/gameplay.c:230: move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 22, final_py + 16);
	ldhl	sp,	#88
	ld	a, (hl)
	add	a, #0x16
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#87
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#82
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
	ldhl	sp,	#88
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#87
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;c:\gbdk\include\gb\metasprites.h:209: __current_metasprite = metasprite;
	ld	(hl-), a
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#87
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:210: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:211: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:212: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#86
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	add	a, #0xf8
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#82
	ld	(hl), a
	ldhl	sp,	#87
	ld	a, (hl)
	ldhl	sp,	#83
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
	ldhl	sp,	#83
	ld	a, (hl)
	ldhl	sp,	#89
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	xor	a, a
	call	___move_metasprite_vflip
;src/gameplay.c:230: move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 22, final_py + 16);
	jr	00165$
00161$:
;src/gameplay.c:232: move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 8, final_py + 16);
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#87
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#82
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
	ldhl	sp,	#88
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#87
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
	ldhl	sp,	#87
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\gbdk\include\gb\metasprites.h:170: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#89
	ld	a, (hl)
	ldhl	sp,	#86
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	(hl-), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#82
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	xor	a, a
	call	___move_metasprite
;src/gameplay.c:232: move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x + 8, final_py + 16);
00165$:
;src/gameplay.c:236: if (died) {
	ldhl	sp,	#84
	ld	a, (hl)
	or	a, a
	jp	Z, 00172$
;src/gameplay.c:237: TAC_REG = 0x00;   // Stop music timer immediately
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:239: NR52_REG = 0x00; // Silence
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:241: NR52_REG = 0x80; // Turn sound back ON
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:242: NR51_REG = 0xFF; // Route all channels to left and right
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:243: NR50_REG = 0x77; // Set master volume to max
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:245: NR41_REG = 0x00; // Length
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:246: NR42_REG = 0xF2; // Volume
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:247: NR43_REG = 0x43; // Note
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:248: NR44_REG = 0x80; // Trigger
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:250: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ldhl	sp,	#91
	ld	(hl), #0x00
00189$:
	ldhl	sp,	#91
	ld	a, (hl)
	sub	a, #0x3c
	jr	NC, 00166$
	call	_wait_vbl_done
	ldhl	sp,	#91
	inc	(hl)
	jr	00189$
00166$:
;src/gameplay.c:251: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:252: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:253: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:255: if (level_songs[idx]) {
	ldhl	sp,#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#90
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00168$
;src/gameplay.c:256: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#77
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	ldhl	sp,	#91
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_init_music_banked
;src/gameplay.c:257: current_song_bank = song_bank[idx];
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00168$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:261: cam_px = 0;
	xor	a, a
	ldhl	sp,	#90
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:262: cam_py = 112;
	ldhl	sp,	#66
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:263: scroll_acc = 0;
	ldhl	sp,	#73
	ld	(hl), #0x00
;src/gameplay.c:264: loaded_r = BKG_MT_W - 1;
	ldhl	sp,	#70
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
;src/gameplay.c:265: target_bg_idx = 0;
	ld	(hl+), a
;src/gameplay.c:266: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:268: BGP_REG = bg_pals[0];
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:269: fill_scroll_bg(level_map, level_map_w, level_map_h, level_map_bank);
	ldhl	sp,	#63
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:271: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:272: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:273: enable_interrupts();
	jp	00172$
00173$:
;src/gameplay.c:278: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:280: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:282: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:284: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:285: }
	add	sp, #92
	ret
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
