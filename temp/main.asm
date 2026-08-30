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
	.globl _update_play_level_state
	.globl _update_level_select_state
	.globl _update_menu_state
	.globl _init_music_banked
	.globl _hUGE_dosound
	.globl _cpu_fast
	.globl _set_interrupts
	.globl _add_TIM
	.globl _current_state
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
_cgb_music_tick:
	.ds 1
_current_state::
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
;src/main.c:19: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:20: if (music_ready) {
	ld	a, (#_music_ready)
	or	a, a
	ret	Z
;src/main.c:21: if ((_cpu == CGB_TYPE) && (cgb_music_tick++ & 1u)) return;
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
	ld	a, (_cgb_music_tick)
	ld	c, a
	ld	hl, #_cgb_music_tick
	inc	(hl)
	bit	0, c
	ret	NZ
00102$:
;src/main.c:22: uint8_t prev_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/main.c:23: SWITCH_ROM(current_song_bank);
	ld	hl, #_current_song_bank
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:24: hUGE_dosound();
	push	bc
	call	_hUGE_dosound
	pop	bc
;src/main.c:25: SWITCH_ROM(prev_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/main.c:27: }
	ret
;src/main.c:29: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:30: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:32: if (_cpu == CGB_TYPE) cpu_fast();
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
	call	_cpu_fast
00102$:
;src/main.c:35: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:36: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:37: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:39: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:40: add_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:41: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:44: init_music_banked(&menuloop, 1, 176);
	ld	a, #0xb0
	push	af
	inc	sp
	ld	a, #0x01
	ld	de, #_menuloop
	call	_init_music_banked
;src/main.c:45: music_ready = 1; // Explicitly ensure music starts
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/main.c:47: while (1) {
00108$:
;src/main.c:48: switch (current_state) {
	ld	a, (#_current_state)
	or	a, a
	jr	Z, 00103$
	ld	a, (#_current_state)
	dec	a
	jr	Z, 00104$
	ld	a, (#_current_state)
	sub	a, #0x02
	jr	Z, 00105$
	jr	00108$
;src/main.c:49: case STATE_MENU:
00103$:
;src/main.c:50: current_state = update_menu_state();
	call	_update_menu_state
	ld	(#_current_state),a
;src/main.c:51: break;
	jr	00108$
;src/main.c:52: case STATE_LEVEL_SELECT:
00104$:
;src/main.c:53: current_state = update_level_select_state();
	call	_update_level_select_state
	ld	(#_current_state),a
;src/main.c:54: break;
	jr	00108$
;src/main.c:55: case STATE_PLAY_LEVEL:
00105$:
;src/main.c:56: current_state = update_play_level_state();
	call	_update_play_level_state
	ld	(#_current_state),a
;src/main.c:58: }
;src/main.c:60: }
	jr	00108$
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
__xinit__cgb_music_tick:
	.db #0x00	; 0
__xinit__current_state:
	.db #0x00	; 0
	.area _CABS (ABS)
