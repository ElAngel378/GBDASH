;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_clg
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_cantletgo_map
	.globl ___func_cantletgo_map
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
	.area _CODE_7
;src/level_clg.c:4: INCBIN(cantletgo_map, "levels/level_data/cantletgo_16high.bin")
;	---------------------------------
; Function __func_cantletgo_map
; ---------------------------------
	b___func_cantletgo_map	= 7
___func_cantletgo_map::
_cantletgo_map::
1$:
	.incbin "levels/level_data/cantletgo_16high.bin" 
2$:
	___size_cantletgo_map = (2$-1$) 
	.globl ___size_cantletgo_map 
	.local b___func_cantletgo_map 
	___bank_cantletgo_map = b___func_cantletgo_map 
	.globl ___bank_cantletgo_map 
	.area _CODE_7
	.area _INITIALIZER
	.area _CABS (ABS)
