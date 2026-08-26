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
	.dw #0x002a
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x004f
	.db #0x06	; 6
	.db #0x76	; 118	'v'
	.dw #0x0050
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x0051
	.db #0x06	; 6
	.db #0x77	; 119	'w'
	.dw #0x0052
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0062
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0066
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x0082
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x0092
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x0094
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0095
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x0096
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x0097
	.db #0x01	; 1
	.db #0x68	; 104	'h'
	.dw #0x0099
	.db #0x01	; 1
	.db #0x69	; 105	'i'
	.dw #0x009a
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x009e
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x00a4
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x00a9
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x00ae
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x00b3
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x00b5
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x00b6
	.db #0x08	; 8
	.db #0x2d	; 45
	.dw #0x00b8
	.db #0x03	; 3
	.db #0x2d	; 45
	.dw #0x00c1
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x00c3
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x00c8
	.db #0x01	; 1
	.db #0x2d	; 45
	.dw #0x00cb
	.db #0x01	; 1
	.db #0x2d	; 45
	.dw #0x00d2
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x00d8
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x00d9
	.db #0x06	; 6
	.db #0x2d	; 45
	.dw #0x00dd
	.db #0x07	; 7
	.db #0x2d	; 45
	.dw #0x00e5
	.db #0x06	; 6
	.db #0x2d	; 45
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
	.dw #0x0126
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x0128
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x012c
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x0136
	.db #0x01	; 1
	.db #0x73	; 115	's'
	.dw #0x015e
	.db #0x0a	; 10
	.db #0x2d	; 45
	.dw #0x0164
	.db #0x0a	; 10
	.db #0x2d	; 45
	.dw #0x0185
	.db #0x0e	; 14
	.db #0x2d	; 45
	.dw #0x018b
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x018d
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x0196
	.db #0x0e	; 14
	.db #0x2d	; 45
	.dw #0x0198
	.db #0x01	; 1
	.db #0x12	; 18
	.dw #0x01a4
	.db #0x10	; 16
	.db #0x11	; 17
	.dw #0x01ac
	.db #0x0d	; 13
	.db #0x2d	; 45
	.dw #0x01af
	.db #0x0c	; 12
	.db #0x2d	; 45
	.dw #0x01b2
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x01b9
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x01ba
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01bd
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x01bf
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01c1
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x01c4
	.db #0x06	; 6
	.db #0x0a	; 10
	.dw #0x01c5
	.db #0x0b	; 11
	.db #0x2d	; 45
	.dw #0x01c6
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x01ca
	.db #0x04	; 4
	.db #0x2d	; 45
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
	.dw #0x0268
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x026f
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x027a
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x0281
	.db #0x09	; 9
	.db #0x2d	; 45
	.dw #0x02e2
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x02ec
	.db #0x05	; 5
	.db #0x7a	; 122	'z'
	.dw #0x02ee
	.db #0x05	; 5
	.db #0x78	; 120	'x'
	.dw #0x02f6
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x02f8
	.db #0x04	; 4
	.db #0x2d	; 45
	.dw #0x030b
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0316
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x031c
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x0323
	.db #0x02	; 2
	.db #0x2d	; 45
	.dw #0x0329
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0331
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0338
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x033f
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0340
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0346
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0348
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x034c
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x034d
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0357
	.db #0x05	; 5
	.db #0x2d	; 45
	.dw #0x0363
	.db #0x05	; 5
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
