;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module stereomadness_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _stereomadness_sp
	.globl b___func_stereomadness_sp
	.globl ___func_stereomadness_sp
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
	.area _CODE_121
;src/stereomadness_sprites.c:4: BANKREF(stereomadness_sp)
;	---------------------------------
; Function __func_stereomadness_sp
; ---------------------------------
	b___func_stereomadness_sp	= 121
___func_stereomadness_sp::
	.local b___func_stereomadness_sp 
	___bank_stereomadness_sp = b___func_stereomadness_sp 
	.globl ___bank_stereomadness_sp 
	.area _CODE_121
_stereomadness_sp:
	.dw #0x003c
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x006b
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0102
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0109
	.db #0x01	; 1
	.db #0x66	; 102	'f'
	.dw #0x010a
	.db #0x06	; 6
	.db #0x01	; 1
	.dw #0x010f
	.db #0x01	; 1
	.db #0x67	; 103	'g'
	.dw #0x0114
	.db #0x01	; 1
	.db #0x66	; 102	'f'
	.dw #0x0116
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x01a2
	.db #0x05	; 5
	.db #0x00	; 0
	.dw #0x01ac
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x01ae
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0209
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x020b
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x02fc
	.db #0x05	; 5
	.db #0x01	; 1
	.dw #0x0306
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x0308
	.db #0x01	; 1
	.db #0x65	; 101	'e'
	.dw #0x031c
	.db #0x0b	; 11
	.db #0x01	; 1
	.dw #0x032e
	.db #0x0d	; 13
	.db #0x65	; 101	'e'
	.dw #0x0330
	.db #0x0d	; 13
	.db #0x65	; 101	'e'
	.dw #0x037d
	.db #0x08	; 8
	.db #0x0f	; 15
	.dw #0xffff
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
