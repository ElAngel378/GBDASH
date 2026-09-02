;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_pg
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_polargeist_map
	.globl ___func_polargeist_map
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
	.area _CODE_32
;src/levels/level_pg.c:4: INCBIN(polargeist_map, "levels/level_data/polargeist_16high.bin")
;	---------------------------------
; Function __func_polargeist_map
; ---------------------------------
	b___func_polargeist_map	= 32
___func_polargeist_map::
_polargeist_map::
1$:
	.incbin "levels/level_data/polargeist_16high.bin" 
2$:
	___size_polargeist_map = (2$-1$) 
	.globl ___size_polargeist_map 
	.local b___func_polargeist_map 
	___bank_polargeist_map = b___func_polargeist_map 
	.globl ___bank_polargeist_map 
	.area _CODE_32
	.area _INITIALIZER
	.area _CABS (ABS)
