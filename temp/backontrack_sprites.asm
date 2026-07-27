;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module backontrack_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _backontrack_portals
	.globl b___func_backontrack_portals
	.globl ___func_backontrack_portals
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
;src/backontrack_sprites.c:4: BANKREF(backontrack_portals)
;	---------------------------------
; Function __func_backontrack_portals
; ---------------------------------
	b___func_backontrack_portals	= 128
___func_backontrack_portals::
	.local b___func_backontrack_portals 
	___bank_backontrack_portals = b___func_backontrack_portals 
	.globl ___bank_backontrack_portals 
	.area _CODE_128
_backontrack_portals:
	.dw #0x0044
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0065
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0069
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x006d
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0071
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0092
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0096
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x0098
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x009d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00a5
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00af
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00ba
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00c3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00d5
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00de
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00e2
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00f0
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x00fb
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x00fc
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x00fd
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0116
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0122
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0129
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0130
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0136
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0145
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x014a
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0151
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0179
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x017a
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x0186
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x0186
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0189
	.db #0x13	; 19
	.db #0x0b	; 11
	.dw #0x018a
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x018a
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x018c
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x018e
	.db #0x14	; 20
	.db #0x0b	; 11
	.dw #0x0191
	.db #0x18	; 24
	.db #0x65	; 101	'e'
	.dw #0x019d
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x019f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x01a4
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x01a5
	.db #0x14	; 20
	.db #0x01	; 1
	.dw #0x01af
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x01b1
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x01c4
	.db #0x16	; 22
	.db #0x0a	; 10
	.dw #0x01e1
	.db #0x14	; 20
	.db #0x0a	; 10
	.dw #0x01e4
	.db #0x14	; 20
	.db #0x0a	; 10
	.dw #0x01fa
	.db #0x15	; 21
	.db #0x0a	; 10
	.dw #0x01fd
	.db #0x15	; 21
	.db #0x0a	; 10
	.dw #0x0223
	.db #0x17	; 23
	.db #0x0a	; 10
	.dw #0x0225
	.db #0x17	; 23
	.db #0x0a	; 10
	.dw #0x0228
	.db #0x17	; 23
	.db #0x0a	; 10
	.dw #0x022a
	.db #0x17	; 23
	.db #0x0a	; 10
	.dw #0x022f
	.db #0x15	; 21
	.db #0x00	; 0
	.dw #0x0239
	.db #0x19	; 25
	.db #0x65	; 101	'e'
	.dw #0x0242
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0245
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x024e
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x0262
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0269
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0278
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x028a
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0291
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0298
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x029a
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x029b
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x029f
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x02a6
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x02ae
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x02ae
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x02b1
	.db #0x19	; 25
	.db #0x0b	; 11
	.dw #0x02b3
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02bb
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x02bd
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x02be
	.db #0x12	; 18
	.db #0x0b	; 11
	.dw #0x02c6
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x02c8
	.db #0x17	; 23
	.db #0x65	; 101	'e'
	.dw #0x02ca
	.db #0x15	; 21
	.db #0x65	; 101	'e'
	.dw #0x02e4
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x02e5
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x02f3
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x02f4
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x02f5
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x02f6
	.db #0x17	; 23
	.db #0x0b	; 11
	.dw #0x0305
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x030e
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x0317
	.db #0x15	; 21
	.db #0x0b	; 11
	.dw #0x031d
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0327
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0x032d
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x032f
	.db #0x16	; 22
	.db #0x0b	; 11
	.dw #0x032f
	.db #0x1a	; 26
	.db #0x0c	; 12
	.dw #0x0336
	.db #0x1a	; 26
	.db #0x0e	; 14
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
