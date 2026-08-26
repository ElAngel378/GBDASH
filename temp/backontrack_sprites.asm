;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module backontrack_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _backontrack_sp
	.globl b___func_backontrack_sp
	.globl ___func_backontrack_sp
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
	.area _CODE_128
;src/backontrack_sprites.c:4: BANKREF(backontrack_sp)
;	---------------------------------
; Function __func_backontrack_sp
; ---------------------------------
	b___func_backontrack_sp	= 128
___func_backontrack_sp::
	.local b___func_backontrack_sp 
	___bank_backontrack_sp = b___func_backontrack_sp 
	.globl ___bank_backontrack_sp 
	.area _CODE_128
_backontrack_sp:
	.dw #0x000d
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0030
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0065
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0066
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0069
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x006b
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x006d
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x006f
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0071
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x008c
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0096
	.db #0x01	; 1
	.db #0x79	; 121	'y'
	.dw #0x00a7
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x00d6
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x00ec
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x00fb
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x00fd
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x012b
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x0157
	.db #0x00	; 0
	.db #0x0d	; 13
	.dw #0x015b
	.db #0x0a	; 10
	.db #0x11	; 17
	.dw #0x0160
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x0179
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x017a
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x0183
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x0186
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0189
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x018a
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x018e
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0191
	.db #0x02	; 2
	.db #0x7a	; 122	'z'
	.dw #0x019b
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x01a5
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x01af
	.db #0x01	; 1
	.db #0x78	; 120	'x'
	.dw #0x01b1
	.db #0x01	; 1
	.db #0x77	; 119	'w'
	.dw #0x022f
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x0239
	.db #0x01	; 1
	.db #0x78	; 120	'x'
	.dw #0x0251
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x0264
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x026b
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x027b
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x028a
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0291
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0298
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x02ae
	.db #0x01	; 1
	.db #0x2d	; 45
	.dw #0x02b1
	.db #0x01	; 1
	.db #0x2d	; 45
	.dw #0x02bd
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x02be
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x02c6
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x02c7
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x02c8
	.db #0x03	; 3
	.db #0x77	; 119	'w'
	.dw #0x02ca
	.db #0x05	; 5
	.db #0x75	; 117	'u'
	.dw #0x02e4
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x02e5
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x02f3
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x02f4
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x02f5
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x02f6
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x0305
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x030e
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0317
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x032d
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x032f
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x033f
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x034d
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
