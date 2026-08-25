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
	.globl _bg_upload_init
	.globl b_play_level
	.globl _play_level
	.globl b_draw_menu
	.globl _draw_menu
	.globl b_setup_menu_font
	.globl _setup_menu_font
	.globl _init_music_banked
	.globl _hUGE_dosound
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _add_low_priority_TIM
	.globl _prof_column_changed_count
	.globl _prof_mirror_transitions
	.globl _prof_tim_enter_count
	.globl _prof_vbl_enter_count
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
_prof_vbl_enter_count::
	.ds 2
_prof_tim_enter_count::
	.ds 2
_prof_mirror_transitions::
	.ds 2
_prof_column_changed_count::
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
	.area _CODE
;src/main.c:23: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:24: if (music_ready) {
	ld	a, (#_music_ready)
	or	a, a
	ret	Z
;src/main.c:25: prof_tim_enter_count++;
	ld	a, (_prof_tim_enter_count)
	ld	c, a
	ld	hl, #_prof_tim_enter_count + 1
	ld	b, (hl)
	dec	hl
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/main.c:26: uint8_t prev_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/main.c:27: SWITCH_ROM(current_song_bank);
	ld	hl, #_current_song_bank
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:28: hUGE_dosound();
	push	bc
	call	_hUGE_dosound
	pop	bc
;src/main.c:29: SWITCH_ROM(prev_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/main.c:30: prof_tim_enter_count++;
	ld	a, (_prof_tim_enter_count)
	ld	c, a
	ld	hl, #_prof_tim_enter_count + 1
	ld	a, (hl-)
	ld	b, a
	inc	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:32: }
	ret
;src/main.c:34: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:35: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:38: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:39: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:40: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:42: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:44: bg_upload_init();
	call	_bg_upload_init
;src/main.c:47: add_low_priority_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_low_priority_TIM
;src/main.c:54: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:57: setup_menu_font();
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;src/main.c:59: init_music_banked(&menuloop, 1, 176);
	ld	a, #0xb0
	push	af
	inc	sp
	ld	a, #0x01
	ld	de, #_menuloop
	call	_init_music_banked
;src/main.c:61: while (1) {
00116$:
;src/main.c:62: if (redraw) draw_menu();
	ld	hl, #_redraw
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	e, #b_draw_menu
	ld	hl, #_draw_menu
	call	___sdcc_bcall_ehl
00102$:
;src/main.c:64: uint8_t joy = joypad();
	call	_joypad
;src/main.c:67: if (joy & J_UP) {
	bit	2, a
	jr	Z, 00113$
;src/main.c:68: if (selected > 0) { selected--; redraw = 1; }
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	dec	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00104$:
;src/main.c:69: waitpadup();
	call	_waitpadup
	jp	00114$
00113$:
;src/main.c:70: } else if (joy & J_DOWN) {
	bit	3, a
	jr	Z, 00110$
;src/main.c:71: if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
	ld	a, (_MAX_LEVELS)
	ld	b, #0x00
	ld	c, a
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
	jr	Z, 00174$
	bit	7, d
	jr	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jr	Z, 00175$
	scf
00175$:
	jr	NC, 00106$
	ld	hl, #_selected
	inc	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00106$:
;src/main.c:72: waitpadup();
	call	_waitpadup
	jr	00114$
00110$:
;src/main.c:73: } else if (joy & J_A) {
	bit	4, a
	jr	Z, 00114$
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/main.c:75: play_level(selected);
	ld	a, (_selected)
	push	af
	inc	sp
	ld	e, #b_play_level
	ld	hl, #_play_level
	call	___sdcc_bcall_ehl
	inc	sp
;src/main.c:78: music_ready = 0;
;src/main.c:79: TAC_REG = 0x00;
	xor	a, a
	ld	(#_music_ready), a
	ldh	(_TAC_REG + 0), a
;src/main.c:80: NR52_REG = 0x00;
	xor	a, a
	ldh	(_NR52_REG + 0), a
;src/main.c:81: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:82: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:83: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:85: setup_menu_font(); // Re-setup font just in case
	ld	e, #b_setup_menu_font
	ld	hl, #_setup_menu_font
	call	___sdcc_bcall_ehl
;src/main.c:86: init_music_banked(&menuloop, 1, 176);
	ld	a, #0xb0
	push	af
	inc	sp
	ld	a, #0x01
	ld	de, #_menuloop
	call	_init_music_banked
;src/main.c:87: TAC_REG = 0x04;    // Start timer
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:89: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
00114$:
;src/main.c:92: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:94: }
	jp	00116$
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
__xinit__prof_vbl_enter_count:
	.dw #0x0000
__xinit__prof_tim_enter_count:
	.dw #0x0000
__xinit__prof_mirror_transitions:
	.dw #0x0000
__xinit__prof_column_changed_count:
	.dw #0x0000
	.area _CABS (ABS)
