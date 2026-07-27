;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module dryout_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _dryout_portals
	.globl b___func_dryout_portals
	.globl ___func_dryout_portals
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
	.area _CODE_125
;src/dryout_sprites.c:4: BANKREF(dryout_portals)
;	---------------------------------
; Function __func_dryout_portals
; ---------------------------------
	b___func_dryout_portals	= 125
___func_dryout_portals::
	.local b___func_dryout_portals 
	___bank_dryout_portals = b___func_dryout_portals 
	.globl ___bank_dryout_portals 
	.area _CODE_125
_dryout_portals:
	.dw #0x0026
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x002e
	.db #0x1a	; 26
	.db #0x66	; 102	'f'
	.dw #0x0034
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x0046
	.db #0x19	; 25
	.db #0x0a	; 10
	.dw #0x004e
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0059
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x005b
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0061
	.db #0x19	; 25
	.db #0x66	; 102	'f'
	.dw #0x006b
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x006d
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x006f
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x0070
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0072
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0074
	.db #0x17	; 23
	.db #0x0a	; 10
	.dw #0x0078
	.db #0x19	; 25
	.db #0x0a	; 10
	.dw #0x007b
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0082
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.dw #0x0090
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0091
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0093
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.dw #0x0094
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0095
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x0099
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x00a0
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x00a2
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.dw #0x00a8
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x00ad
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00b3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00b4
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00b6
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00b8
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00c2
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x00d2
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00d9
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00db
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x00dd
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x00de
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00e7
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00ea
	.db #0x0e	; 14
	.db #0x0b	; 11
	.dw #0x00ec
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x00ec
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00ee
	.db #0x10	; 16
	.db #0x0b	; 11
	.dw #0x00ef
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00f3
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00f7
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00fa
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00ff
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0103
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0108
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x010c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x010d
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x010f
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0111
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0113
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x011c
	.db #0x16	; 22
	.db #0x66	; 102	'f'
	.dw #0x011e
	.db #0x16	; 22
	.db #0x67	; 103	'g'
	.dw #0x0124
	.db #0x18	; 24
	.db #0x09	; 9
	.dw #0x0129
	.db #0x13	; 19
	.db #0x66	; 102	'f'
	.dw #0x012b
	.db #0x15	; 21
	.db #0x65	; 101	'e'
	.dw #0x012d
	.db #0x17	; 23
	.db #0x64	; 100	'd'
	.dw #0x013e
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x014d
	.db #0x13	; 19
	.db #0x0d	; 13
	.dw #0x0150
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x015e
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x0173
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x0175
	.db #0x13	; 19
	.db #0x0d	; 13
	.dw #0x0183
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x0194
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x0198
	.db #0x13	; 19
	.db #0x0d	; 13
	.dw #0x01a6
	.db #0x14	; 20
	.db #0x64	; 100	'd'
	.dw #0x01ad
	.db #0x16	; 22
	.db #0x08	; 8
	.dw #0x01b9
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x01bb
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x01c4
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x01d6
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x0210
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0217
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x021d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0220
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0227
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0234
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0236
	.db #0x15	; 21
	.db #0x01	; 1
	.dw #0x0240
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x0242
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x0252
	.db #0x1a	; 26
	.db #0x64	; 100	'd'
	.dw #0x0262
	.db #0x1a	; 26
	.db #0x64	; 100	'd'
	.dw #0x0279
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x027a
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x027d
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x027f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0284
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x0284
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0285
	.db #0x1a	; 26
	.db #0x64	; 100	'd'
	.dw #0x0287
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x0288
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x028d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0291
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x0293
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x0295
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0297
	.db #0x1a	; 26
	.db #0x64	; 100	'd'
	.dw #0x0298
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x0299
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02a3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02a7
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02ab
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x02ac
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02b1
	.db #0x11	; 17
	.db #0x0d	; 13
	.dw #0x02b2
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02b9
	.db #0x1a	; 26
	.db #0x64	; 100	'd'
	.dw #0x02c3
	.db #0x15	; 21
	.db #0x00	; 0
	.dw #0x02cc
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x02cd
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x02ce
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x02cf
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x02d0
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x02da
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x02db
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x02dd
	.db #0x19	; 25
	.db #0x0a	; 10
	.dw #0x02e0
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x02e2
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x02f3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02ff
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x0300
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0302
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x030e
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0310
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0325
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0326
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x032f
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0333
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0336
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
