;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module polargeist_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _polargeist_sp
	.globl b___func_polargeist_sp
	.globl ___func_polargeist_sp
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
	.area _CODE_122
;src/polargeist_sprites.c:4: BANKREF(polargeist_sp)
;	---------------------------------
; Function __func_polargeist_sp
; ---------------------------------
	b___func_polargeist_sp	= 122
___func_polargeist_sp::
	.local b___func_polargeist_sp 
	___bank_polargeist_sp = b___func_polargeist_sp 
	.globl ___bank_polargeist_sp 
	.area _CODE_122
_polargeist_sp:
	.dw #0x0011
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0020
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0030
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x003c
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0056
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x005c
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x007d
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00b4
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x00c5
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x00c7
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x00cb
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00cf
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x00d1
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x00d4
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00de
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00e2
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x00e7
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x00ed
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x00f6
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0104
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x013a
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x013e
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0141
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x014c
	.db #0x07	; 7
	.db #0x66	; 102	'f'
	.dw #0x014e
	.db #0x07	; 7
	.db #0x67	; 103	'g'
	.dw #0x01b2
	.db #0x01	; 1
	.db #0x66	; 102	'f'
	.dw #0x01bb
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x01bd
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x01c5
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x01c8
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x01cc
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x01d6
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x01f1
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x01f9
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0250
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0252
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x026c
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0290
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x02af
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x02c4
	.db #0x00	; 0
	.db #0x0d	; 13
	.dw #0x02ca
	.db #0x0f	; 15
	.db #0x10	; 16
	.dw #0x02cc
	.db #0x11	; 17
	.db #0x64	; 100	'd'
	.dw #0x02cc
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x02cd
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x02d8
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x02de
	.db #0x0c	; 12
	.db #0x65	; 101	'e'
	.dw #0x02de
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.dw #0x02e1
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x02ee
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.dw #0x02ff
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.dw #0x0327
	.db #0x01	; 1
	.db #0x66	; 102	'f'
	.dw #0x032e
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0335
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x033c
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0360
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x0374
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0378
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x03a5
	.db #0x0b	; 11
	.db #0x0f	; 15
	.dw #0x03a5
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
