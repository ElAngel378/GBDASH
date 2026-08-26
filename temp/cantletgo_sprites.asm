;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module cantletgo_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cantletgo_sp
	.globl b___func_cantletgo_sp
	.globl ___func_cantletgo_sp
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
	.area _CODE_126
;src/cantletgo_sprites.c:4: BANKREF(cantletgo_sp)
;	---------------------------------
; Function __func_cantletgo_sp
; ---------------------------------
	b___func_cantletgo_sp	= 126
___func_cantletgo_sp::
	.local b___func_cantletgo_sp 
	___bank_cantletgo_sp = b___func_cantletgo_sp 
	.globl ___bank_cantletgo_sp 
	.area _CODE_126
_cantletgo_sp:
	.dw #0x001b
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x001d
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0029
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x0032
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x0034
	.db #0x0a	; 10
	.db #0x2d	; 45
	.dw #0x0036
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x0038
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x003d
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0045
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0047
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0053
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0058
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x005b
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0064
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0073
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0075
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0081
	.db #0x01	; 1
	.db #0x79	; 121	'y'
	.dw #0x0087
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0091
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x0096
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x009d
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x00a2
	.db #0x07	; 7
	.db #0x0b	; 11
	.dw #0x00a3
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x00a5
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x00a6
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x00aa
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x00ac
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x00ae
	.db #0x0a	; 10
	.db #0x2d	; 45
	.dw #0x00b6
	.db #0x08	; 8
	.db #0x0b	; 11
	.dw #0x00bc
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x00bf
	.db #0x06	; 6
	.db #0x0b	; 11
	.dw #0x00c3
	.db #0x07	; 7
	.db #0x0a	; 10
	.dw #0x00c8
	.db #0x0e	; 14
	.db #0x2d	; 45
	.dw #0x00ca
	.db #0x0d	; 13
	.db #0x2d	; 45
	.dw #0x00cc
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x00da
	.db #0x0f	; 15
	.db #0x2d	; 45
	.dw #0x00db
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x00dc
	.db #0x0e	; 14
	.db #0x2d	; 45
	.dw #0x00e1
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x00e2
	.db #0x0f	; 15
	.db #0x7a	; 122	'z'
	.dw #0x00e2
	.db #0x02	; 2
	.db #0x7a	; 122	'z'
	.dw #0x00e3
	.db #0x12	; 18
	.db #0x2d	; 45
	.dw #0x00e5
	.db #0x11	; 17
	.db #0x2d	; 45
	.dw #0x00e7
	.db #0x10	; 16
	.db #0x2d	; 45
	.dw #0x00e7
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x00e9
	.db #0x0f	; 15
	.db #0x2d	; 45
	.dw #0x00f4
	.db #0x09	; 9
	.db #0x6a	; 106	'j'
	.dw #0x00f6
	.db #0x09	; 9
	.db #0x73	; 115	's'
	.dw #0x0100
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x010a
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x010f
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0125
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x012b
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x0136
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x013c
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x0166
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0179
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x017d
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0183
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x018b
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x018e
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0192
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0196
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x01a7
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x01b3
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x01b7
	.db #0x06	; 6
	.db #0x0b	; 11
	.dw #0x01bd
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x01c2
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x01c9
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x01db
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x01df
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x024d
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x024e
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x025c
	.db #0x0a	; 10
	.db #0x0b	; 11
	.dw #0x0264
	.db #0x0b	; 11
	.db #0x0b	; 11
	.dw #0x0267
	.db #0x09	; 9
	.db #0x0c	; 12
	.dw #0x026c
	.db #0x06	; 6
	.db #0x0b	; 11
	.dw #0x027d
	.db #0x13	; 19
	.db #0x0c	; 12
	.dw #0x0281
	.db #0x0f	; 15
	.db #0x0c	; 12
	.dw #0x0285
	.db #0x0b	; 11
	.db #0x0c	; 12
	.dw #0x0297
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x029e
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x02c1
	.db #0x07	; 7
	.db #0x0b	; 11
	.dw #0x02ce
	.db #0x07	; 7
	.db #0x08	; 8
	.dw #0x02d7
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x02d8
	.db #0x02	; 2
	.db #0x69	; 105	'i'
	.dw #0x02d9
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x02da
	.db #0x02	; 2
	.db #0x79	; 121	'y'
	.dw #0x02de
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x02eb
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0307
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x030b
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0313
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x031a
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x031f
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0337
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0343
	.db #0x0b	; 11
	.db #0x0f	; 15
	.dw #0x0343
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
