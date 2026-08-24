;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module timemachine_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _timemachine_sp
	.globl b___func_timemachine_sp
	.globl ___func_timemachine_sp
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
	.area _CODE_119
;src/timemachine_sprites.c:4: BANKREF(timemachine_sp)
;	---------------------------------
; Function __func_timemachine_sp
; ---------------------------------
	b___func_timemachine_sp	= 119
___func_timemachine_sp::
	.local b___func_timemachine_sp 
	___bank_timemachine_sp = b___func_timemachine_sp 
	.globl ___bank_timemachine_sp 
	.area _CODE_119
_timemachine_sp:
	.dw #0x0011
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x001c
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x002c
	.db #0x03	; 3
	.db #0x09	; 9
	.dw #0x004f
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x0064
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x0068
	.db #0x03	; 3
	.db #0x09	; 9
	.dw #0x0072
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x00a4
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x00a6
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x00bf
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x00c3
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00c7
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x00cc
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00f4
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x0101
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x010d
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x011b
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0126
	.db #0x04	; 4
	.db #0x7e	; 126
	.dw #0x012a
	.db #0x0b	; 11
	.db #0x79	; 121	'y'
	.dw #0x012d
	.db #0x05	; 5
	.db #0x65	; 101	'e'
	.dw #0x012f
	.db #0x06	; 6
	.db #0x65	; 101	'e'
	.dw #0x014f
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0153
	.db #0x04	; 4
	.db #0x0b	; 11
	.dw #0x0157
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x015d
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x0162
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x01b1
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x01b6
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x01ba
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x01be
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x01ce
	.db #0x07	; 7
	.db #0x0a	; 10
	.dw #0x01dd
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x01e0
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x01e1
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x01f1
	.db #0x07	; 7
	.db #0x0a	; 10
	.dw #0x01fb
	.db #0x09	; 9
	.db #0x0b	; 11
	.dw #0x01ff
	.db #0x09	; 9
	.db #0x0b	; 11
	.dw #0x0204
	.db #0x09	; 9
	.db #0x0b	; 11
	.dw #0x0209
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.dw #0x020b
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x020c
	.db #0x05	; 5
	.db #0x0a	; 10
	.dw #0x0211
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x0217
	.db #0x05	; 5
	.db #0x0b	; 11
	.dw #0x0219
	.db #0x07	; 7
	.db #0x66	; 102	'f'
	.dw #0x0227
	.db #0x04	; 4
	.db #0x0a	; 10
	.dw #0x0229
	.db #0x06	; 6
	.db #0x66	; 102	'f'
	.dw #0x0239
	.db #0x06	; 6
	.db #0x67	; 103	'g'
	.dw #0x023b
	.db #0x05	; 5
	.db #0x79	; 121	'y'
	.dw #0x0270
	.db #0x02	; 2
	.db #0x0a	; 10
	.dw #0x027e
	.db #0x03	; 3
	.db #0x09	; 9
	.dw #0x0297
	.db #0x08	; 8
	.db #0x0c	; 12
	.dw #0x02a1
	.db #0x06	; 6
	.db #0x0c	; 12
	.dw #0x02aa
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x02ab
	.db #0x0f	; 15
	.db #0x10	; 16
	.dw #0x02ab
	.db #0x05	; 5
	.db #0x66	; 102	'f'
	.dw #0x02b1
	.db #0x0a	; 10
	.db #0x06	; 6
	.dw #0x02b5
	.db #0x08	; 8
	.db #0x06	; 6
	.dw #0x02c3
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x02c7
	.db #0x04	; 4
	.db #0x7e	; 126
	.dw #0x02d0
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x02d2
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0300
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x030a
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x030d
	.db #0x04	; 4
	.db #0x79	; 121	'y'
	.dw #0x0316
	.db #0x05	; 5
	.db #0x65	; 101	'e'
	.dw #0x0318
	.db #0x05	; 5
	.db #0x64	; 100	'd'
	.dw #0x0340
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x034d
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x034e
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x0351
	.db #0x08	; 8
	.db #0x7e	; 126
	.dw #0x0352
	.db #0x08	; 8
	.db #0x09	; 9
	.dw #0x035c
	.db #0x05	; 5
	.db #0x65	; 101	'e'
	.dw #0x035e
	.db #0x05	; 5
	.db #0x65	; 101	'e'
	.dw #0x0370
	.db #0x09	; 9
	.db #0x0c	; 12
	.dw #0x0375
	.db #0x06	; 6
	.db #0x0c	; 12
	.dw #0x0377
	.db #0x03	; 3
	.db #0x79	; 121	'y'
	.dw #0x0381
	.db #0x03	; 3
	.db #0x65	; 101	'e'
	.dw #0x0383
	.db #0x03	; 3
	.db #0x64	; 100	'd'
	.dw #0x0395
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x0396
	.db #0x06	; 6
	.db #0x08	; 8
	.dw #0x03b1
	.db #0x01	; 1
	.db #0x64	; 100	'd'
	.dw #0x03b7
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x03c2
	.db #0x02	; 2
	.db #0x64	; 100	'd'
	.dw #0x03d2
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x03e3
	.db #0x07	; 7
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
