;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module baseafterbase_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _baseafterbase_sp
	.globl b___func_baseafterbase_sp
	.globl ___func_baseafterbase_sp
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
	.area _CODE_127
;src/baseafterbase_sprites.c:4: BANKREF(baseafterbase_sp)
;	---------------------------------
; Function __func_baseafterbase_sp
; ---------------------------------
	b___func_baseafterbase_sp	= 127
___func_baseafterbase_sp::
	.local b___func_baseafterbase_sp 
	___bank_baseafterbase_sp = b___func_baseafterbase_sp 
	.globl ___bank_baseafterbase_sp 
	.area _CODE_127
_baseafterbase_sp:
	.dw #0x0000
	.db #0x02	; 2
	.db #0x85	; 133
	.dw #0x004f
	.db #0x06	; 6
	.db #0x76	; 118	'v'
	.dw #0x0051
	.db #0x06	; 6
	.db #0x77	; 119	'w'
	.dw #0x0062
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0066
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x0097
	.db #0x01	; 1
	.db #0x68	; 104	'h'
	.dw #0x0099
	.db #0x01	; 1
	.db #0x69	; 105	'i'
	.dw #0x00ae
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x00c1
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x00c3
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x00f2
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0102
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x011d
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0121
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x012c
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0136
	.db #0x01	; 1
	.db #0x73	; 115	's'
	.dw #0x0198
	.db #0x01	; 1
	.db #0x12	; 18
	.dw #0x01a4
	.db #0x10	; 16
	.db #0x11	; 17
	.dw #0x01ba
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01bf
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01c4
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01cb
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x01d5
	.db #0x05	; 5
	.db #0x6b	; 107	'k'
	.dw #0x01d7
	.db #0x05	; 5
	.db #0x68	; 104	'h'
	.dw #0x0257
	.db #0x07	; 7
	.db #0x00	; 0
	.dw #0x0260
	.db #0x07	; 7
	.db #0x7c	; 124
	.dw #0x0262
	.db #0x07	; 7
	.db #0x8d	; 141
	.dw #0x0267
	.db #0x06	; 6
	.db #0x09	; 9
	.dw #0x02e2
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x02ec
	.db #0x05	; 5
	.db #0x7a	; 122	'z'
	.dw #0x02ee
	.db #0x05	; 5
	.db #0x78	; 120	'x'
	.dw #0x0363
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
