;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module dryout_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _dryout_sp
	.globl b___func_dryout_sp
	.globl ___func_dryout_sp
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
	.area _CODE_124
;src/dryout_sprites.c:4: BANKREF(dryout_sp)
;	---------------------------------
; Function __func_dryout_sp
; ---------------------------------
	b___func_dryout_sp	= 124
___func_dryout_sp::
	.local b___func_dryout_sp 
	___bank_dryout_sp = b___func_dryout_sp 
	.globl ___bank_dryout_sp 
	.area _CODE_124
_dryout_sp:
	.dw #0x002e
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.dw #0x0034
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x004e
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x005b
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0061
	.db #0x01	; 1
	.db #0x69	; 105	'i'
	.dw #0x006d
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x006f
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x0082
	.db #0x02	; 2
	.db #0x68	; 104	'h'
	.dw #0x0091
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x0093
	.db #0x02	; 2
	.db #0x67	; 103	'g'
	.dw #0x0095
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x0099
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x00a0
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x00a2
	.db #0x02	; 2
	.db #0x65	; 101	'e'
	.dw #0x00a8
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x00b4
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x00b6
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x00c2
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x00db
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x00dd
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x00ea
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x00ec
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x00ee
	.db #0x0a	; 10
	.db #0x2d	; 45
	.dw #0x0108
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x010d
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x010f
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0111
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0113
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x011c
	.db #0x04	; 4
	.db #0x65	; 101	'e'
	.dw #0x011e
	.db #0x04	; 4
	.db #0x73	; 115	's'
	.dw #0x0124
	.db #0x02	; 2
	.db #0x09	; 9
	.dw #0x0129
	.db #0x07	; 7
	.db #0x6d	; 109	'm'
	.dw #0x012b
	.db #0x05	; 5
	.db #0x7d	; 125
	.dw #0x012d
	.db #0x03	; 3
	.db #0x8d	; 141
	.dw #0x013e
	.db #0x06	; 6
	.db #0x8f	; 143
	.dw #0x0150
	.db #0x06	; 6
	.db #0x8d	; 141
	.dw #0x015e
	.db #0x06	; 6
	.db #0x8f	; 143
	.dw #0x0173
	.db #0x06	; 6
	.db #0x8e	; 142
	.dw #0x0183
	.db #0x06	; 6
	.db #0x8d	; 141
	.dw #0x0194
	.db #0x06	; 6
	.db #0x8f	; 143
	.dw #0x01a6
	.db #0x06	; 6
	.db #0x8e	; 142
	.dw #0x01ad
	.db #0x04	; 4
	.db #0x08	; 8
	.dw #0x01b9
	.db #0x01	; 1
	.db #0x7c	; 124
	.dw #0x01bb
	.db #0x01	; 1
	.db #0x7a	; 122	'z'
	.dw #0x01d6
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x01e9
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x01ee
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x01f9
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0204
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0210
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0217
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0236
	.db #0x05	; 5
	.db #0x01	; 1
	.dw #0x0240
	.db #0x01	; 1
	.db #0x7c	; 124
	.dw #0x0242
	.db #0x01	; 1
	.db #0x8e	; 142
	.dw #0x0252
	.db #0x00	; 0
	.db #0x8f	; 143
	.dw #0x0262
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x0285
	.db #0x00	; 0
	.db #0x8d	; 141
	.dw #0x0297
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x02b9
	.db #0x00	; 0
	.db #0x8d	; 141
	.dw #0x02c3
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x02cc
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x02cd
	.db #0x01	; 1
	.db #0x7c	; 124
	.dw #0x02ce
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x02cf
	.db #0x01	; 1
	.db #0x78	; 120	'x'
	.dw #0x02d0
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x02da
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x02e0
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x02e2
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x02ff
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x0302
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0305
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x030e
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0310
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0326
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x032f
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x0336
	.db #0x01	; 1
	.db #0x77	; 119	'w'
	.dw #0x0339
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x0349
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
