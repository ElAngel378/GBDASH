;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module icon1
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _icon1_metasprites
	.globl _icon1_metasprite24
	.globl _icon1_metasprite23
	.globl _icon1_metasprite22
	.globl _icon1_metasprite21
	.globl _icon1_metasprite20
	.globl _icon1_metasprite19
	.globl _icon1_metasprite18
	.globl _icon1_metasprite17
	.globl _icon1_metasprite16
	.globl _icon1_metasprite15
	.globl _icon1_metasprite14
	.globl _icon1_metasprite13
	.globl _icon1_metasprite12
	.globl _icon1_metasprite11
	.globl _icon1_metasprite10
	.globl _icon1_metasprite9
	.globl _icon1_metasprite8
	.globl _icon1_metasprite7
	.globl _icon1_metasprite6
	.globl _icon1_metasprite5
	.globl _icon1_metasprite4
	.globl _icon1_metasprite3
	.globl _icon1_metasprite2
	.globl _icon1_metasprite1
	.globl _icon1_metasprite0
	.globl _icon1_tiles
	.globl _icon1_palettes
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
_icon1_palettes:
	.dw #0x7fff
	.dw #0x7fc0
	.dw #0x03e0
	.dw #0x0000
_icon1_tiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x4f	; 79	'O'
	.db #0x7f	; 127
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x4b	; 75	'K'
	.db #0x7b	; 123
	.db #0x4b	; 75	'K'
	.db #0x7a	; 122	'z'
	.db #0x4b	; 75	'K'
	.db #0x7a	; 122	'z'
	.db #0x4b	; 75	'K'
	.db #0x7b	; 123
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x4f	; 79	'O'
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x26	; 38
	.db #0x3f	; 63
	.db #0x25	; 37
	.db #0x3d	; 61
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x4b	; 75	'K'
	.db #0x7b	; 123
	.db #0x4b	; 75	'K'
	.db #0x7a	; 122	'z'
	.db #0x4b	; 75	'K'
	.db #0x7a	; 122	'z'
	.db #0x93	; 147
	.db #0xf3	; 243
	.db #0x9c	; 156
	.db #0xfc	; 252
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1f	; 31
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x49	; 73	'I'
	.db #0x79	; 121	'y'
	.db #0x4b	; 75	'K'
	.db #0x7a	; 122	'z'
	.db #0x93	; 147
	.db #0xf2	; 242
	.db #0x91	; 145
	.db #0xf1	; 241
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x89	; 137
	.db #0xf9	; 249
	.db #0x13	; 19
	.db #0xf2	; 242
	.db #0x13	; 19
	.db #0xf2	; 242
	.db #0x89	; 137
	.db #0xf9	; 249
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
_icon1_metasprite0:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite1:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite2:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite3:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x06	; 6
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite4:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite5:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite6:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite7:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite8:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite9:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x06	; 6
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite10:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite11:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite12:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite13:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite14:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite15:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x06	; 6
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite16:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite17:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite18:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite19:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite20:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite21:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x06	; 6
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite22:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite23:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x02	; 2
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprite24:
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_icon1_metasprites:
	.dw _icon1_metasprite0
	.dw _icon1_metasprite1
	.dw _icon1_metasprite2
	.dw _icon1_metasprite3
	.dw _icon1_metasprite4
	.dw _icon1_metasprite5
	.dw _icon1_metasprite6
	.dw _icon1_metasprite7
	.dw _icon1_metasprite8
	.dw _icon1_metasprite9
	.dw _icon1_metasprite10
	.dw _icon1_metasprite11
	.dw _icon1_metasprite12
	.dw _icon1_metasprite13
	.dw _icon1_metasprite14
	.dw _icon1_metasprite15
	.dw _icon1_metasprite16
	.dw _icon1_metasprite17
	.dw _icon1_metasprite18
	.dw _icon1_metasprite19
	.dw _icon1_metasprite20
	.dw _icon1_metasprite21
	.dw _icon1_metasprite22
	.dw _icon1_metasprite23
	.dw _icon1_metasprite24
	.area _INITIALIZER
	.area _CABS (ABS)
