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
;src/gameplay.c:31: void setup_menu_font(void) BANKED {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
	b_setup_menu_font	= 1
_setup_menu_font::
;src/gameplay.c:32: font_init();
	call	_font_init
;src/gameplay.c:33: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/gameplay.c:34: }
	ret
;src/gameplay.c:36: void draw_menu(void) BANKED {
;	---------------------------------
; Function draw_menu
; ---------------------------------
	b_draw_menu	= 1
_draw_menu::
;src/gameplay.c:37: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:38: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/gameplay.c:39: printf("GBDASH DEMO 01\n");
	ld	de, #___str_1
	call	_puts
;src/gameplay.c:40: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/gameplay.c:41: gotoxy(1, 2 + i);
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
;src/gameplay.c:42: if (i == selected) printf("0 %s", game_levels[i]->name);
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
;src/gameplay.c:43: else printf("  %s", game_levels[i]->name);
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
;src/gameplay.c:40: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/gameplay.c:45: printf("\n\n\n\n\n\n\n\nSotospro24");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:46: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:47: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/gameplay.c:48: }
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
;src/gameplay.c:50: void play_level(uint8_t idx) BANKED {
;	---------------------------------
; Function play_level
; ---------------------------------
	b_play_level	= 1
_play_level::
	add	sp, #-98
;src/gameplay.c:60: l = game_levels[idx];
	ld	bc, #_game_levels+0
	ldhl	sp,	#104
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#96
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
	ldhl	sp,	#57
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:61: level_tiles = l->tiles;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#96
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#95
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#92
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:62: level_map = l->map;
	ldhl	sp,#57
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
	ldhl	sp,	#59
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:63: level_tile_count = l->tile_count;
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
	ldhl	sp,	#61
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:64: level_map_w = l->map_width;
	ldhl	sp,#57
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
	ldhl	sp,	#63
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/gameplay.c:65: level_map_h = l->map_height;
	ldhl	sp,#57
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
	ldhl	sp,	#65
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/gameplay.c:66: level_tiles_bank = BANK(chr_gb);
	ld	(hl+), a
	ld	(hl), #<(___bank_chr_gb)
;src/gameplay.c:67: level_map_bank = l->map_bank;
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#68
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
;src/gameplay.c:73: if (level_songs[idx]) {
	ld	de, #_level_songs
	ldhl	sp,	#96
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#71
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#70
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
;src/gameplay.c:74: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#97
	ld	(hl), a
	ld	de, #_song_bank+0
	ldhl	sp,	#104
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	de
	ldhl	sp,	#99
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, c
	ld	d, b
	call	_init_music_banked
	pop	de
;src/gameplay.c:75: current_song_bank = song_bank[idx];
	ld	a, (de)
	ld	(#_current_song_bank),a
;src/gameplay.c:76: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
00102$:
;src/gameplay.c:79: uint16_t cam_px = 0;
	xor	a, a
	ldhl	sp,	#96
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:80: uint16_t cam_py = 112;
	ldhl	sp,	#71
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:81: uint16_t cam_py_max = (level_map_h << 4);
	ldhl	sp,	#65
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
;src/gameplay.c:82: if (cam_py_max > 144u) cam_py_max -= 144u;
	ldhl	sp,	#90
	ld	(hl+), a
	ld	a, c
	ld	(hl-), a
	ld	a, #0x90
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00104$
	ldhl	sp,#90
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
	ldhl	sp,	#73
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00105$
00104$:
;src/gameplay.c:83: else cam_py_max = 0;
	xor	a, a
	ldhl	sp,	#73
	ld	(hl+), a
	ld	(hl), a
00105$:
;src/gameplay.c:84: uint16_t loaded_r = BKG_MT_W - 1;
	ldhl	sp,	#75
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:89: uint8_t target_bg_idx = 0;
	ldhl	sp,	#5
;src/gameplay.c:90: const uint8_t bg_pals[] = {
	xor	a, a
	ld	(hl+), a
	ld	a,#0xe4
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0xe4
	ld	(hl+), a
	ld	(hl), #0x1b
;src/gameplay.c:98: player_init(&player, 0, 240);
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
;src/gameplay.c:101: DISPLAY_OFF;
	call	_display_off
;src/gameplay.c:102: load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#67
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#93
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:103: set_sprite_data(0, 8, icon1_tiles);
	ld	de, #_icon1_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/gameplay.c:104: set_sprite_data(8, 4, ship_tiles);
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
;src/gameplay.c:106: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#69
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#65
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:107: BGP_REG = bg_pals[0];
	ldhl	sp,	#6
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:108: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/gameplay.c:109: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:110: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:111: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:112: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/gameplay.c:113: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:116: uint16_t scroll_acc = 0;
	ldhl	sp,	#77
;src/gameplay.c:117: uint8_t prev_joy = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:118: while (1) {
	ldhl	sp,	#94
	ld	a, (hl)
	ldhl	sp,	#79
	ld	(hl), a
	ldhl	sp,	#95
	ld	a, (hl)
	ldhl	sp,	#80
	ld	(hl), a
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#83
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#82
	ld	(hl), a
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#85
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#84
	ld	(hl), a
	ld	de, #_song_bank
	ldhl	sp,	#104
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#87
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#86
	ld	(hl), a
	ldhl	sp,	#94
	ld	a, (hl)
	ldhl	sp,	#87
	ld	(hl), a
	ldhl	sp,	#95
	ld	a, (hl)
	ldhl	sp,	#88
	ld	(hl), a
00178$:
;src/gameplay.c:119: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#90
	ld	(hl), a
;src/gameplay.c:120: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#92
	bit	7, (hl)
	pop	hl
	jp	NZ, 00179$
;src/gameplay.c:122: if ((joy & J_UP) || player.level_complete) {
	push	hl
	ldhl	sp,	#92
	bit	2, (hl)
	pop	hl
	jr	NZ, 00111$
	ldhl	sp,	#26
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
00111$:
;src/gameplay.c:123: HIDE_SPRITES;
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
;src/gameplay.c:126: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:128: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/gameplay.c:129: gotoxy(3, 6);
	ld	hl, #0x603
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:130: printf("LEVEL COMPLETE");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/gameplay.c:131: gotoxy(3, 12);
	ld	hl, #0xc03
	push	hl
	call	_gotoxy
	pop	hl
;src/gameplay.c:132: printf("Press A to exit");
	ld	de, #___str_6
	push	de
	call	_printf
	pop	de
;src/gameplay.c:133: waitpadup();
	call	_waitpadup
;src/gameplay.c:134: while (!(joypad() & J_A)) wait_vbl_done();
00108$:
	call	_joypad
	bit	4, a
	jp	NZ, 00179$
	call	_wait_vbl_done
	jr	00108$
;src/gameplay.c:135: break;
00112$:
;src/gameplay.c:138: if ((joy & J_B) && !(prev_joy & J_B)) player_noclip = !player_noclip;
	push	hl
	ldhl	sp,	#92
	bit	5, (hl)
	pop	hl
	jr	Z, 00115$
	push	hl
	ldhl	sp,	#80
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
;src/gameplay.c:139: prev_joy = joy;
	ldhl	sp,	#90
	ld	a, (hl)
	ldhl	sp,	#78
	ld	(hl), a
;src/gameplay.c:141: uint16_t px_prev = cam_px >> 4;
	ldhl	sp,	#96
	ld	a, (hl)
	ldhl	sp,	#91
	ld	(hl), a
	ldhl	sp,	#97
	ld	a, (hl)
	ldhl	sp,	#92
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
;src/gameplay.c:142: uint8_t needs_render = 0;
	ldhl	sp,	#2
;src/gameplay.c:143: uint16_t need_col = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:144: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#95
	ld	(hl), a
;src/gameplay.c:147: if (cam_px < ((level_map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#63
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
	ldhl	sp,	#96
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	NC, 00123$
;src/gameplay.c:148: scroll_acc += SCROLL_SPEED_FP;
	ldhl	sp,	#77
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x02ca
	add	hl, bc
	ld	c, l
;src/gameplay.c:149: cam_px += scroll_acc >> 8;
	ld	e, h
	ld	d, #0x00
	ldhl	sp,	#96
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#98
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#97
	ld	(hl), a
;src/gameplay.c:150: scroll_acc &= 0xFF;
	ldhl	sp,	#77
	ld	(hl), c
;src/gameplay.c:141: uint16_t px_prev = cam_px >> 4;
	ldhl	sp,	#96
	ld	a, (hl)
	ldhl	sp,	#91
	ld	(hl), a
	ldhl	sp,	#97
	ld	a, (hl)
	ldhl	sp,	#92
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
;src/gameplay.c:151: uint16_t px_curr = cam_px >> 4;
	ld	a, (hl+)
	ld	c, a
;src/gameplay.c:152: if (px_curr != px_prev) {
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00553$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00123$
00553$:
;src/gameplay.c:153: uint16_t need = px_curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/gameplay.c:154: if (need > loaded_r && need < level_map_w) {
	ldhl	sp,	#75
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00123$
	ldhl	sp,	#63
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00123$
;src/gameplay.c:155: needs_render = 1;
	ldhl	sp,	#2
;src/gameplay.c:156: need_col = need;
	ld	a, #0x01
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00123$:
;src/gameplay.c:161: player.world_x = cam_px;
	ldhl	sp,	#96
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#97
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;src/gameplay.c:162: process_sp_objects(l, &player, joy, &target_bg_idx);
	ldhl	sp,	#5
;src/gameplay.c:98: player_init(&player, 0, 240);
;src/gameplay.c:162: process_sp_objects(l, &player, joy, &target_bg_idx);
	push	hl
	ldhl	sp,	#92
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #13
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_process_sp_objects
;src/gameplay.c:164: if (player.reversed != prev_reversed) {
	ldhl	sp,	#20
	ld	c, (hl)
	ldhl	sp,	#95
	ld	a, (hl)
	sub	a, c
	jp	Z, 00130$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:168: const uint8_t* target_tiles = player.reversed ? l->tiles_rev : l->tiles;
	ld	a, c
	or	a, a
	jr	Z, 00211$
	ldhl	sp,#81
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	jr	00212$
00211$:
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
00212$:
	ld	e, c
;src/gameplay.c:169: load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,	#67
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#62
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	_load_bkg_tileset
;src/gameplay.c:172: uint16_t start_col = cam_px >> 4;
	ldhl	sp,	#91
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/gameplay.c:173: for (uint8_t i = 0; i < 16; i++) {
	ldhl	sp,	#95
	ld	(hl), #0x00
00204$:
;src/gameplay.c:174: uint16_t curr_col = start_col + i;
	ld	e, c
	ld	d, b
;src/gameplay.c:173: for (uint8_t i = 0; i < 16; i++) {
	ldhl	sp,	#95
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00128$
;src/gameplay.c:174: uint16_t curr_col = start_col + i;
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
	ldhl	sp,	#93
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gameplay.c:175: if (curr_col < level_map_w) {
	ldhl	sp,	#93
	ld	e, l
	ld	d, h
	ldhl	sp,	#63
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00205$
;src/gameplay.c:176: uint8_t vram_slot = (uint8_t)(curr_col & 15);
	ldhl	sp,	#93
	ld	a, (hl)
	and	a, #0x0f
;src/gameplay.c:144: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	h, (hl)
;src/gameplay.c:177: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	inc	h
	dec	h
	jr	Z, 00125$
	ld	e, a
	xor	a, a
	sub	a, e
	and	a, #0x0f
00125$:
;src/gameplay.c:178: draw_mt_column(vram_slot, curr_col, level_map, level_map_w, level_map_bank, player.reversed);
	push	bc
	push	hl
	inc	sp
	ldhl	sp,	#71
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#67
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#65
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#101
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
	pop	bc
00205$:
;src/gameplay.c:173: for (uint8_t i = 0; i < 16; i++) {
	ldhl	sp,	#95
	inc	(hl)
	jr	00204$
00128$:
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:183: loaded_r = start_col + 15;
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#75
	ld	(hl), c
	inc	hl
	ld	(hl), a
00130$:
;src/gameplay.c:186: died = player_update(&player, joy, level_map, level_map_w, level_map_h, level_map_bank);
	ldhl	sp,	#68
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#97
	ld	a, (hl)
	ld	hl, #17
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_update
	ldhl	sp,	#89
	ld	(hl), a
;src/gameplay.c:188: py = player_screen_y(&player, cam_py);
	ldhl	sp,	#71
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
;src/gameplay.c:189: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#92
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:192: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ldhl	sp,	#73
	ld	a, (hl)
	ldhl	sp,	#94
	ld	(hl), a
	ldhl	sp,	#74
	ld	a, (hl)
	ldhl	sp,	#95
	ld	(hl), a
;src/gameplay.c:189: if (py < CAM_Y_TOP_ZONE) {
	ldhl	sp,	#92
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00555$
	bit	7, d
	jr	NZ, 00556$
	cp	a, a
	jr	00556$
00555$:
	bit	7, d
	jr	Z, 00556$
	scf
00556$:
	jr	NC, 00142$
;src/gameplay.c:190: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
	ldhl	sp,	#13
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:191: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00132$
	ld	bc, #0x0000
00132$:
;src/gameplay.c:192: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ldhl	sp,	#73
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00134$
	ldhl	sp,	#94
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00134$:
;src/gameplay.c:193: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#71
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00143$
00142$:
;src/gameplay.c:195: else if (py > CAM_Y_BOTTOM_ZONE) {
	ldhl	sp,	#92
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00143$
;src/gameplay.c:196: int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
	ldhl	sp,	#13
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0x9c
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/gameplay.c:197: if (target_cam_py < 0) target_cam_py = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00136$
	ld	bc, #0x0000
00136$:
;src/gameplay.c:198: if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
	ld	e, c
	ld	d, b
	ldhl	sp,	#73
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00138$
	ldhl	sp,	#94
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00138$:
;src/gameplay.c:199: cam_py = (uint16_t)target_cam_py;
	ldhl	sp,	#71
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00143$:
;src/gameplay.c:204: if (player.reversed) {
	ldhl	sp,	#20
	ld	a, (hl)
	or	a, a
	jr	Z, 00145$
;src/gameplay.c:206: scroll_px = (uint16_t)(-(int16_t)cam_px - 128);
	ldhl	sp,	#96
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
	ldhl	sp,	#90
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/gameplay.c:207: sprite_x_final = 128; // Mirrored player position
	ldhl	sp,	#94
	ld	(hl), #0x80
	jr	00146$
00145$:
;src/gameplay.c:209: scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
	ldhl	sp,	#96
	ld	a, (hl)
	ldhl	sp,	#92
	ld	(hl), a
	ldhl	sp,	#97
	ld	a, (hl)
	ldhl	sp,	#93
	ld	(hl-), a
	ld	a, #0x20
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00213$
	ldhl	sp,#92
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#95
	ld	(hl-), a
	ld	(hl), e
	jr	00214$
00213$:
	xor	a, a
	ldhl	sp,	#94
	ld	(hl+), a
	ld	(hl), a
00214$:
	ldhl	sp,	#94
	ld	a, (hl)
	ldhl	sp,	#90
	ld	(hl), a
	ldhl	sp,	#95
	ld	a, (hl)
	ldhl	sp,	#91
;src/gameplay.c:210: sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
	ld	(hl+), a
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00215$
	ldhl	sp,	#96
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl)
	jr	00216$
00215$:
	ld	a, #0x20
00216$:
	ldhl	sp,	#94
	ld	(hl), a
00146$:
;src/gameplay.c:212: int16_t final_py = player_screen_y(&player, cam_py);
	ldhl	sp,	#71
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #10
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_screen_y
	ldhl	sp,	#92
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gameplay.c:214: wait_vbl_done();
	call	_wait_vbl_done
;src/gameplay.c:215: BGP_REG = bg_pals[target_bg_idx];
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
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:216: move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
	ldhl	sp,	#71
	ld	a, (hl)
	ldhl	sp,	#95
	ld	(hl), a
	ldhl	sp,	#90
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ldhl	sp,	#95
	ld	a, (hl)
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:218: if (needs_render) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00150$
;src/gameplay.c:219: loaded_r = need_col;
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#75
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#76
	ld	(hl), a
;src/gameplay.c:220: uint8_t vram_slot = (uint8_t)(need_col & 15);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#95
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
;src/gameplay.c:144: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#91
	ld	(hl), a
;src/gameplay.c:222: if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
	ld	a, (hl)
	or	a, a
	jr	Z, 00148$
	xor	a, a
	ldhl	sp,	#95
	sub	a, (hl)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x0f
	ld	(hl), a
00148$:
;src/gameplay.c:223: draw_mt_column(vram_slot, need_col, level_map, level_map_w, level_map_bank, player.reversed);
	ldhl	sp,	#91
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#69
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#65
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#63
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#101
	ld	a, (hl)
	call	_draw_mt_column
00150$:
;src/gameplay.c:226: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;src/gameplay.c:144: uint8_t prev_reversed = player.reversed;
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#90
;src/gameplay.c:228: if (player.reversed) move_metasprite_hvflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 24);
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#95
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#91
	ld	(hl), a
	ld	a, (hl+)
	add	a, #0x18
;src/gameplay.c:229: else move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 32);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
;src/gameplay.c:231: if (player.reversed) move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 16);
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
;src/gameplay.c:226: if (player.mode == MODE_SHIP) {
	ldhl	sp,	#4
	ld	a, (hl)
	dec	a
	jp	NZ, 00170$
;src/gameplay.c:227: if (player.gravity_flipped) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jp	Z, 00158$
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x04
	ldhl	sp,	#94
	ld	(hl), a
;src/gameplay.c:228: if (player.reversed) move_metasprite_hvflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 24);
	ldhl	sp,	#90
	ld	a, (hl)
	or	a, a
	jr	Z, 00152$
	ldhl	sp,	#95
	ld	a, (hl)
	add	a, #0x18
	ld	b, a
	ldhl	sp,	#91
	ld	a, (hl)
	add	a, #0x18
	ldhl	sp,	#95
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldhl	sp,	#94
	ld	a, (hl)
	or	a, a
	jr	Z, 00217$
	ld	de, #0x0010
	jr	00218$
00217$:
	ld	de, #0x0008
00218$:
	ld	a, b
	sub	a, e
	ld	b, a
	ldhl	sp,	#95
	ld	a, (hl)
	add	a, #0xf8
	ld	e, a
	ld	d, b
	xor	a, a
	call	___move_metasprite_hvflip
;src/gameplay.c:228: if (player.reversed) move_metasprite_hvflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 24);
	jp	00171$
00152$:
;src/gameplay.c:229: else move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 32);
	ldhl	sp,	#95
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
	ldhl	sp,	#91
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	(hl), a
	ld	hl, #_ship_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;c:\gbdk\include\gb\metasprites.h:250: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;c:\gbdk\include\gb\metasprites.h:251: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:252: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:253: return __move_metasprite_hflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	ldhl	sp,	#94
	ld	a, (hl)
	or	a, a
	jr	Z, 00219$
	ldhl	sp,	#91
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00220$
00219$:
	ldhl	sp,	#91
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00220$:
	ldhl	sp,	#95
	ld	e, (hl)
	ldhl	sp,	#91
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	b, a
	ldhl	sp,	#93
	ld	e, (hl)
	ld	d, b
	xor	a, a
	call	___move_metasprite_hflip
;src/gameplay.c:229: else move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 32);
	jp	00171$
00158$:
;src/gameplay.c:231: if (player.reversed) move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 16);
	ldhl	sp,	#90
	ld	a, (hl)
	or	a, a
	jr	Z, 00155$
	ldhl	sp,	#94
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
	xor	a, a
	call	___move_metasprite_vflip
;src/gameplay.c:231: if (player.reversed) move_metasprite_vflip(ship_metasprites[0], 0, 0, sprite_x_final + 24, final_py + 16);
	jp	00171$
00155$:
;src/gameplay.c:232: else move_metasprite(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#94
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
	xor	a, a
	call	___move_metasprite
;src/gameplay.c:232: else move_metasprite(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 16);
	jp	00171$
00170$:
;src/gameplay.c:235: if (player.gravity_flipped) {
	ldhl	sp,	#18
	ld	c, (hl)
;src/gameplay.c:229: else move_metasprite_hflip(ship_metasprites[0], 0, 0, sprite_x_final + 8, final_py + 32);
	ldhl	sp,	#95
	ld	a, (hl)
	add	a, #0x20
	ld	(hl), a
;src/gameplay.c:235: if (player.gravity_flipped) {
	ld	a, c
	or	a, a
	jr	Z, 00167$
;src/gameplay.c:236: if (player.reversed) move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 24, final_py + 32);
	ldhl	sp,	#90
	ld	a, (hl)
	or	a, a
	jr	Z, 00161$
	ldhl	sp,	#95
	ld	c, (hl)
	ldhl	sp,	#92
	ld	b, (hl)
	ldhl	sp,	#21
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
;c:\gbdk\include\gb\metasprites.h:290: __current_metasprite = metasprite;
	ld	e, a
	ld	d, l
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;c:\gbdk\include\gb\metasprites.h:291: __current_base_tile = base_tile;
;c:\gbdk\include\gb\metasprites.h:292: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;c:\gbdk\include\gb\metasprites.h:293: return __move_metasprite_hvflip(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00221$
	ld	hl, #0x0010
	jr	00222$
00221$:
	ld	hl, #0x0008
00222$:
	ld	a, c
	sub	a, l
	ld	d, a
	ld	a, b
	add	a, #0xf8
	ld	e, a
	xor	a, a
	call	___move_metasprite_hvflip
;src/gameplay.c:236: if (player.reversed) move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 24, final_py + 32);
	jp	00171$
00161$:
;src/gameplay.c:237: else move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 22, final_py + 16);
	ldhl	sp,	#94
	ld	b, (hl)
	ldhl	sp,	#91
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
	xor	a, a
	call	___move_metasprite_vflip
;src/gameplay.c:237: else move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 22, final_py + 16);
	jr	00171$
00167$:
;src/gameplay.c:239: if (player.reversed) move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 10, final_py + 32);
	ldhl	sp,	#90
	ld	a, (hl)
	or	a, a
	jr	Z, 00164$
	ldhl	sp,	#95
	ld	c, (hl)
	ldhl	sp,	#91
	ld	a, (hl)
	add	a, #0x0a
	ldhl	sp,	#95
	ld	(hl), a
	ldhl	sp,	#21
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_icon1_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
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
	jr	Z, 00223$
	ld	hl, #0x0010
	jr	00224$
00223$:
	ld	hl, #0x0008
00224$:
	ld	a, c
	sub	a, l
	ld	d, a
	ldhl	sp,	#95
	ld	e, (hl)
	xor	a, a
	call	___move_metasprite_hflip
;src/gameplay.c:239: if (player.reversed) move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 10, final_py + 32);
	jr	00171$
00164$:
;src/gameplay.c:240: else move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 8, final_py + 16);
	ldhl	sp,	#94
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
	xor	a, a
	call	___move_metasprite
;src/gameplay.c:240: else move_metasprite(icon1_metasprites[player.anim_frame], 0, 0, sprite_x_final + 8, final_py + 16);
00171$:
;src/gameplay.c:244: if (died) {
	ldhl	sp,	#89
	ld	a, (hl)
	or	a, a
	jp	Z, 00178$
;src/gameplay.c:245: TAC_REG = 0x00;
	xor	a, a
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:246: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:247: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:248: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:249: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:250: NR41_REG = 0x00;
	xor	a, a
	ldh	(_NR41_REG + 0), a
;src/gameplay.c:251: NR42_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR42_REG + 0), a
;src/gameplay.c:252: NR43_REG = 0x43;
	ld	a, #0x43
	ldh	(_NR43_REG + 0), a
;src/gameplay.c:253: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;src/gameplay.c:254: for (uint8_t i = 0; i < 60; i++) wait_vbl_done();
	ld	c, #0x00
00207$:
	ld	a, c
	sub	a, #0x3c
	jr	NC, 00172$
	call	_wait_vbl_done
	inc	c
	jr	00207$
00172$:
;src/gameplay.c:255: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/gameplay.c:256: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/gameplay.c:257: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/gameplay.c:258: if (level_songs[idx]) {
	ldhl	sp,#69
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00174$
;src/gameplay.c:259: init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
	ldhl	sp,#83
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
;src/gameplay.c:260: current_song_bank = song_bank[idx];
	ldhl	sp,#85
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_current_song_bank
	ld	(hl), a
00174$:
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:264: load_bkg_tileset(l->tiles, level_tile_count, level_tiles_bank);
	ldhl	sp,#87
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#96
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#67
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#97
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/gameplay.c:266: cam_px = 0;
	xor	a, a
	ldhl	sp,	#96
	ld	(hl+), a
	ld	(hl), a
;src/gameplay.c:267: cam_py = 112;
	ldhl	sp,	#71
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:268: scroll_acc = 0;
	ldhl	sp,	#77
;src/gameplay.c:269: loaded_r = BKG_MT_W - 1;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gameplay.c:270: target_bg_idx = 0;
	ldhl	sp,	#5
;src/gameplay.c:271: player_init(&player, 0, 240);
	ld	de, #0x00f0
	ld	(hl), d
	push	de
	ld	bc, #0x0000
	ld	hl, #12
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_player_init
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:273: BGP_REG = bg_pals[0];
	ldhl	sp,	#6
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;src/gameplay.c:274: fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#69
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#65
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/gameplay.c:275: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/gameplay.c:276: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:277: enable_interrupts();
	jp	00178$
00179$:
;src/gameplay.c:281: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/gameplay.c:283: waitpadup();
	call	_waitpadup
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/gameplay.c:285: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/gameplay.c:287: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/gameplay.c:288: }
	add	sp, #98
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
