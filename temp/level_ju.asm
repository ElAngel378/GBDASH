;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_ju
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_jumper_map
	.globl ___func_jumper_map
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
	.area _CODE_8
;src/level_ju.c:4: INCBIN(jumper_map, "levels/level_data/jumper_16high.bin")
;	---------------------------------
; Function __func_jumper_map
; ---------------------------------
	b___func_jumper_map	= 8
___func_jumper_map::
_jumper_map::
1$:
	.incbin "levels/level_data/jumper_16high.bin" 
2$:
	___size_jumper_map = (2$-1$) 
	.globl ___size_jumper_map 
	.local b___func_jumper_map 
	___bank_jumper_map = b___func_jumper_map 
	.globl ___bank_jumper_map 
	.area _CODE_8
	.area _INITIALIZER
	.area _CABS (ABS)
