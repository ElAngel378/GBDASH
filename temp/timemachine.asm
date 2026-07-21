;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module timemachine
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _timemachine
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
	.area _CODE_248
	.area _CODE_248
_order_cnt:
	.db #0x01	; 1
_P0:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
_order1:
	.dw _P0
_order2:
	.dw _P0
_order3:
	.dw _P0
_order4:
	.dw _P0
_duty_instruments:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
_wave_instruments:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
_noise_instruments:
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_waves:
	.db #0x00	; 0
_timemachine:
	.db #0x06	; 6
	.dw _order_cnt
	.dw _order1
	.dw _order2
	.dw _order3
	.dw _order4
	.dw _duty_instruments
	.dw _wave_instruments
	.dw _noise_instruments
	.dw #0x0000
	.dw _waves
	.area _INITIALIZER
	.area _CABS (ABS)
