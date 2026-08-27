;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _play_music_safe
	.globl b_play_level
	.globl _play_level
	.globl b_draw_menu
	.globl _draw_menu
	.globl b_setup_menu_font
	.globl _setup_menu_font
	.globl _init_music_banked
	.globl _hUGE_dosound
	.globl _cpu_fast
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _add_TIM
	.globl _current_song_bank
	.globl _selected
	.globl _redraw
	.globl _music_ready
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
_music_ready::
	.ds 1
_redraw::
	.ds 1
_selected::
	.ds 1
_current_song_bank::
	.ds 1
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
;src/main.c:16: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:17: if (music_ready) {
	ld	a, (#_music_ready)
	or	a, a
	ret	Z
;src/main.c:18: uint8_t prev_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/main.c:19: SWITCH_ROM(current_song_bank);
	ld	hl, #_current_song_bank
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:20: hUGE_dosound();
	push	bc
	call	_hUGE_dosound
	pop	bc
;src/main.c:21: SWITCH_ROM(prev_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/main.c:23: }
	ret
;src/main.c:25: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;src/main.c:26: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:30: if (_cpu == CGB_TYPE) cpu_fast();
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
	call	_cpu_fast
00102$:
;src/main.c:33: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:34: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:35: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:37: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:38: add_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:39: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:42: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;src/main.c:44: init_music_banked(&menuloop, 1, 176);
	ld	a, #0xb0
	push	af
	inc	sp
	ld	a, #0x01
	ld	de, #_menuloop
	call	_init_music_banked
;src/main.c:46: while (1) {
00118$:
;src/main.c:47: if (redraw) draw_menu();
	ld	hl, #_redraw
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	ld	e, #b_draw_menu
	ld	hl, #_draw_menu
	call	___sdcc_bcall_ehl
00104$:
;src/main.c:49: uint8_t joy = joypad();
	call	_joypad
;src/main.c:52: if (joy & J_UP) {
	bit	2, a
	jr	Z, 00115$
;src/main.c:53: if (selected > 0) { selected--; redraw = 1; }
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	dec	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00106$:
;src/main.c:54: waitpadup();
	call	_waitpadup
	jp	00116$
00115$:
;src/main.c:55: } else if (joy & J_DOWN) {
	bit	3, a
	jr	Z, 00112$
;src/main.c:56: if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
	ld	a, (#_MAX_LEVELS)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	bc
	push	bc
	dec	bc
	ld	a, (_selected)
	ld	l, a
	ld	h, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00185$
	bit	7, d
	jr	NZ, 00186$
	cp	a, a
	jr	00186$
00185$:
	bit	7, d
	jr	Z, 00186$
	scf
00186$:
	jr	NC, 00108$
	ld	hl, #_selected
	inc	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00108$:
;src/main.c:57: waitpadup();
	call	_waitpadup
	jr	00116$
00112$:
;src/main.c:58: } else if (joy & J_A) {
	bit	4, a
	jr	Z, 00116$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/main.c:60: play_level(selected);
	ld	a, (_selected)
	push	af
	inc	sp
	ld	e, #b_play_level
	ld	hl, #_play_level
	call	___sdcc_bcall_ehl
	inc	sp
;src/main.c:63: music_ready = 0;
;src/main.c:64: TAC_REG = 0x00;
	xor	a, a
	ld	(#_music_ready), a
	ldh	(_TAC_REG + 0), a
;src/main.c:65: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/main.c:66: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:67: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:68: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:70: setup_menu_font(); // Re-setup font just in case
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;src/main.c:71: init_music_banked(&menuloop, 1, 176);
	ld	a, #0xb0
	push	af
	inc	sp
	ld	a, #0x01
	ld	de, #_menuloop
	call	_init_music_banked
;src/main.c:72: TAC_REG = 0x04;    // Start timer
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:74: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
00116$:
;src/main.c:77: wait_vbl_done();
	call	_wait_vbl_done
	jp	00118$
;src/main.c:79: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__music_ready:
	.db #0x00	; 0
__xinit__redraw:
	.db #0x01	; 1
__xinit__selected:
	.db #0x00	; 0
__xinit__current_song_bank:
	.db #0x00	; 0
	.area _CABS (ABS)
