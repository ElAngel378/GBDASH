;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module jumper_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _jumper_sp
	.globl b___func_jumper_sp
	.globl ___func_jumper_sp
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
;src/jumper_sprites.c:4: BANKREF(jumper_sp)
;	---------------------------------
; Function __func_jumper_sp
; ---------------------------------
	b___func_jumper_sp	= 123
___func_jumper_sp::
	.local b___func_jumper_sp 
	___bank_jumper_sp = b___func_jumper_sp 
	.globl ___bank_jumper_sp 
	.area _CODE_123
_jumper_sp:
	.dw #0x0000
	.db #0x02	; 2
	.db #0x77	; 119	'w'
	.dw #0x0031
	.db #0x00	; 0
	.db #0x0a	; 10
	.dw #0x004c
	.db #0x01	; 1
	.db #0x78	; 120	'x'
	.dw #0x0068
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x006c
	.db #0x03	; 3
	.db #0x0b	; 11
	.dw #0x0070
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x007a
	.db #0x07	; 7
	.db #0x8f	; 143
	.dw #0x00a4
	.db #0x06	; 6
	.db #0x08	; 8
	.dw #0x00ae
	.db #0x06	; 6
	.db #0x78	; 120	'x'
	.dw #0x00b5
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x00e0
	.db #0x05	; 5
	.db #0x01	; 1
	.dw #0x00ea
	.db #0x01	; 1
	.db #0x76	; 118	'v'
	.dw #0x00fb
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x0106
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x0117
	.db #0x05	; 5
	.db #0x08	; 8
	.dw #0x0122
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.dw #0x0130
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x013b
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x0150
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x0151
	.db #0x05	; 5
	.db #0x08	; 8
	.dw #0x015a
	.db #0x01	; 1
	.db #0x77	; 119	'w'
	.dw #0x01bc
	.db #0x01	; 1
	.db #0x78	; 120	'x'
	.dw #0x01be
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x01c9
	.db #0x01	; 1
	.db #0x7a	; 122	'z'
	.dw #0x01d7
	.db #0x05	; 5
	.db #0x08	; 8
	.dw #0x01eb
	.db #0x05	; 5
	.db #0x09	; 9
	.dw #0x01f8
	.db #0x05	; 5
	.db #0x08	; 8
	.dw #0x0216
	.db #0x01	; 1
	.db #0x79	; 121	'y'
	.dw #0x0228
	.db #0x02	; 2
	.db #0x78	; 120	'x'
	.dw #0x0230
	.db #0x05	; 5
	.db #0x01	; 1
	.dw #0x023a
	.db #0x01	; 1
	.db #0x76	; 118	'v'
	.dw #0x0248
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.dw #0x0256
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.dw #0x0264
	.db #0x00	; 0
	.db #0x79	; 121	'y'
	.dw #0x0272
	.db #0x00	; 0
	.db #0x7a	; 122	'z'
	.dw #0x0280
	.db #0x00	; 0
	.db #0x7b	; 123
	.dw #0x028e
	.db #0x00	; 0
	.db #0x8c	; 140
	.dw #0x029c
	.db #0x00	; 0
	.db #0x8d	; 141
	.dw #0x02a0
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x02aa
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x02b8
	.db #0x00	; 0
	.db #0x8f	; 143
	.dw #0x02c6
	.db #0x00	; 0
	.db #0x90	; 144
	.dw #0x02d4
	.db #0x00	; 0
	.db #0x75	; 117	'u'
	.dw #0x02d8
	.db #0x02	; 2
	.db #0x0b	; 11
	.dw #0x02e2
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.dw #0x02ed
	.db #0x03	; 3
	.db #0x0a	; 10
	.dw #0x02f0
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.dw #0x02fe
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.dw #0x0309
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x030c
	.db #0x01	; 1
	.db #0x79	; 121	'y'
	.dw #0x030d
	.db #0x01	; 1
	.db #0x0b	; 11
	.dw #0x030f
	.db #0x04	; 4
	.db #0x09	; 9
	.dw #0x031a
	.db #0x00	; 0
	.db #0x7a	; 122	'z'
	.dw #0x0328
	.db #0x00	; 0
	.db #0x7b	; 123
	.dw #0x0336
	.db #0x00	; 0
	.db #0x8c	; 140
	.dw #0x0344
	.db #0x00	; 0
	.db #0x8d	; 141
	.dw #0x0346
	.db #0x03	; 3
	.db #0x08	; 8
	.dw #0x0352
	.db #0x00	; 0
	.db #0x8e	; 142
	.dw #0x0360
	.db #0x00	; 0
	.db #0x8f	; 143
	.dw #0x036e
	.db #0x00	; 0
	.db #0x90	; 144
	.dw #0x0376
	.db #0x00	; 0
	.db #0x80	; 128
	.dw #0x037c
	.db #0x0a	; 10
	.db #0x0f	; 15
	.dw #0x037c
	.db #0x03	; 3
	.db #0x0f	; 15
	.dw #0x037d
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
