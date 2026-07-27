;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module cantletgo_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cantletgo_portals
	.globl b___func_cantletgo_portals
	.globl ___func_cantletgo_portals
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
;src/cantletgo_sprites.c:4: BANKREF(cantletgo_portals)
;	---------------------------------
; Function __func_cantletgo_portals
; ---------------------------------
	b___func_cantletgo_portals	= 126
___func_cantletgo_portals::
	.local b___func_cantletgo_portals 
	___bank_cantletgo_portals = b___func_cantletgo_portals 
	.globl ___bank_cantletgo_portals 
	.area _CODE_126
_cantletgo_portals:
	.dw #0x000d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0012
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0013
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x001b
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x001d
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x001f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0025
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0029
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x002c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0032
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x0032
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0034
	.db #0x10	; 16
	.db #0x0b	; 11
	.dw #0x0036
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0038
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x003b
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x003c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0040
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0045
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0047
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0064
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x006c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0072
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0073
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0074
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0075
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x007b
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x007d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0081
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x0087
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x008a
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0091
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x0094
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0098
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00a2
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00a6
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x00a9
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00aa
	.db #0x0e	; 14
	.db #0x0b	; 11
	.dw #0x00ac
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x00ad
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00ae
	.db #0x10	; 16
	.db #0x0b	; 11
	.dw #0x00b5
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00bc
	.db #0x0e	; 14
	.db #0x0b	; 11
	.dw #0x00bc
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00c1
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00c8
	.db #0x0c	; 12
	.db #0x0b	; 11
	.dw #0x00c8
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00ca
	.db #0x0d	; 13
	.db #0x0b	; 11
	.dw #0x00cc
	.db #0x0e	; 14
	.db #0x0b	; 11
	.dw #0x00cd
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00d4
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00da
	.db #0x0b	; 11
	.db #0x0b	; 11
	.dw #0x00db
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00dc
	.db #0x0c	; 12
	.db #0x0b	; 11
	.dw #0x00df
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00e2
	.db #0x0b	; 11
	.db #0x65	; 101	'e'
	.dw #0x00e2
	.db #0x18	; 24
	.db #0x65	; 101	'e'
	.dw #0x00e3
	.db #0x08	; 8
	.db #0x0b	; 11
	.dw #0x00e5
	.db #0x09	; 9
	.db #0x0b	; 11
	.dw #0x00e5
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00e7
	.db #0x0a	; 10
	.db #0x0b	; 11
	.dw #0x00e9
	.db #0x0b	; 11
	.db #0x0b	; 11
	.dw #0x00ec
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00f1
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00f4
	.db #0x11	; 17
	.db #0x66	; 102	'f'
	.dw #0x00f6
	.db #0x11	; 17
	.db #0x67	; 103	'g'
	.dw #0x0100
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x010a
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x010f
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0125
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x012b
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x0136
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x013c
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0166
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0179
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x017d
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0183
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x01a7
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x01c9
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x01df
	.db #0x14	; 20
	.db #0x01	; 1
	.dw #0x024d
	.db #0x15	; 21
	.db #0x00	; 0
	.dw #0x024e
	.db #0x15	; 21
	.db #0x09	; 9
	.dw #0x02ce
	.db #0x13	; 19
	.db #0x08	; 8
	.dw #0x02d4
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02d7
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x02d8
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.dw #0x02d9
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x02da
	.db #0x18	; 24
	.db #0x65	; 101	'e'
	.dw #0x02e1
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02e5
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x02e8
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02eb
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x030f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0313
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0315
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0317
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x031a
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x0337
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
