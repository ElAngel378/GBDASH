;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module polargeist_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _polargeist_portals
	.globl b___func_polargeist_portals
	.globl ___func_polargeist_portals
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
	.area _CODE_123
;src/polargeist_sprites.c:4: BANKREF(polargeist_portals)
;	---------------------------------
; Function __func_polargeist_portals
; ---------------------------------
	b___func_polargeist_portals	= 123
___func_polargeist_portals::
	.local b___func_polargeist_portals 
	___bank_polargeist_portals = b___func_polargeist_portals 
	.globl ___bank_polargeist_portals 
	.area _CODE_123
_polargeist_portals:
	.dw #0x003d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0040
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0043
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0044
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0047
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0053
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0054
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0056
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x0058
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0059
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0060
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0064
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x006b
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x006d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x007c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0087
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0091
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0091
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0093
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x0097
	.db #0x18	; 24
	.db #0x0b	; 11
	.dw #0x0098
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00b4
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x00bd
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00c0
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00c2
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00c5
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x00c5
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x00cd
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00d1
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x00df
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00e4
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00ec
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x00f0
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x00f2
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x00f9
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00fc
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x00fe
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0102
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x010d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x011a
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x011e
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x0122
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x012e
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x013c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0141
	.db #0x14	; 20
	.db #0x01	; 1
	.dw #0x014c
	.db #0x13	; 19
	.db #0x66	; 102	'f'
	.dw #0x014e
	.db #0x13	; 19
	.db #0x67	; 103	'g'
	.dw #0x01b2
	.db #0x19	; 25
	.db #0x66	; 102	'f'
	.dw #0x01bb
	.db #0x15	; 21
	.db #0x00	; 0
	.dw #0x01bd
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x01c3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01c5
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x01c6
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01ce
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01d1
	.db #0x18	; 24
	.db #0x0a	; 10
	.dw #0x01d3
	.db #0x18	; 24
	.db #0x0a	; 10
	.dw #0x01d4
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01d9
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01dc
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x01dc
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x01de
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x01e0
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x01e2
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x01f8
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x01fb
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0202
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0209
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x020a
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x020e
	.db #0x10	; 16
	.db #0x0b	; 11
	.dw #0x020f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0212
	.db #0x0f	; 15
	.db #0x0b	; 11
	.dw #0x0216
	.db #0x0e	; 14
	.db #0x0b	; 11
	.dw #0x0218
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x021d
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x021f
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x0221
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0222
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0223
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0225
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x023f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0244
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0249
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0254
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0257
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x025b
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0263
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x028a
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x028f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0292
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0297
	.db #0x10	; 16
	.db #0x0b	; 11
	.dw #0x0299
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0299
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x029b
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x029d
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x029f
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x02a1
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x02a8
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x02af
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02b7
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02bd
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x02c3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02c5
	.db #0x19	; 25
	.db #0x0a	; 10
	.dw #0x02c6
	.db #0x0a	; 10
	.db #0x0b	; 11
	.dw #0x02c9
	.db #0x18	; 24
	.db #0x0a	; 10
	.dw #0x02cc
	.db #0x13	; 19
	.db #0x64	; 100	'd'
	.dw #0x02cc
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02d3
	.db #0x0a	; 10
	.db #0x0b	; 11
	.dw #0x02e3
	.db #0x15	; 21
	.db #0x65	; 101	'e'
	.dw #0x02f2
	.db #0x19	; 25
	.db #0x0a	; 10
	.dw #0x02f4
	.db #0x15	; 21
	.db #0x66	; 102	'f'
	.dw #0x02fc
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0301
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0304
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x030a
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0310
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0318
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x031e
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0327
	.db #0x19	; 25
	.db #0x66	; 102	'f'
	.dw #0x0328
	.db #0x11	; 17
	.db #0x0b	; 11
	.dw #0x0329
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x032e
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x0335
	.db #0x19	; 25
	.db #0x64	; 100	'd'
	.dw #0x034b
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x035c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x035e
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x036b
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x036f
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0371
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0372
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0388
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x038a
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x038e
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x038f
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0394
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0396
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
