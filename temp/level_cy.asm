;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_cy
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_cycles_map
	.globl ___func_cycles_map
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
	.area _CODE_38
;src/levels/level_cy.c:4: INCBIN(cycles_map, "levels/level_data/cycles_16high.bin")
;	---------------------------------
; Function __func_cycles_map
; ---------------------------------
	b___func_cycles_map	= 38
___func_cycles_map::
_cycles_map::
1$:
	.incbin "levels/level_data/cycles_16high.bin" 
2$:
	___size_cycles_map = (2$-1$) 
	.globl ___size_cycles_map 
	.local b___func_cycles_map 
	___bank_cycles_map = b___func_cycles_map 
	.globl ___bank_cycles_map 
	.area _CODE_38
	.area _INITIALIZER
	.area _CABS (ABS)
