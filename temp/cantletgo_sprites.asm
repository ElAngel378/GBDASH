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
	.dw #0x003d
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0053
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x0058
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x005b
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0081
	.db #0x01	; 1
	.db #0x65	; 101	'e'
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
	.dw #0x00b6
	.db #0x08	; 8
	.db #0x0b	; 11
	.dw #0x00bf
	.db #0x06	; 6
	.db #0x0b	; 11
	.dw #0x00c3
	.db #0x07	; 7
	.db #0x0a	; 10
	.dw #0x00db
	.db #0x01	; 1
	.db #0x0a	; 10
	.dw #0x00e1
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x00e2
	.db #0x0f	; 15
	.db #0x65	; 101	'e'
	.dw #0x00e2
	.db #0x02	; 2
	.db #0x65	; 101	'e'
	.dw #0x00e7
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x00f4
	.db #0x09	; 9
	.db #0x66	; 102	'f'
	.dw #0x00f6
	.db #0x09	; 9
	.db #0x67	; 103	'g'
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
	.dw #0x02d8
	.db #0x02	; 2
	.db #0x66	; 102	'f'
	.dw #0x02da
	.db #0x02	; 2
	.db #0x65	; 101	'e'
	.dw #0x02de
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x0307
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x030b
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x031f
	.db #0x03	; 3
	.db #0x0b	; 11
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
