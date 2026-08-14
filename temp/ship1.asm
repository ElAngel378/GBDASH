;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module ship1
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ship_metasprites
	.globl _ship_metasprite0
	.globl _ship_tiles
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
	.area _CODE_10
_ship_tiles:
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x3b	; 59
	.db #0x3f	; 63
	.db #0x3b	; 59
	.db #0x2e	; 46
	.db #0x3b	; 59
	.db #0x2e	; 46
	.db #0x3b	; 59
	.db #0x2f	; 47
	.db #0x78	; 120	'x'
	.db #0x6f	; 111	'o'
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0xe2	; 226
	.db #0xff	; 255
	.db #0xe2	; 226
	.db #0xbf	; 191
	.db #0xe2	; 226
	.db #0xbf	; 191
	.db #0xe2	; 226
	.db #0xff	; 255
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xd0	; 208
	.db #0x70	; 112	'p'
	.db #0xd0	; 208
	.db #0x70	; 112	'p'
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x8a	; 138
	.db #0xfe	; 254
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x8a	; 138
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
_ship_metasprite0:
	.db #0xff	; -1
	.db #0xff	; -1
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_ship_metasprites:
	.dw _ship_metasprite0
	.area _INITIALIZER
	.area _CABS (ABS)
