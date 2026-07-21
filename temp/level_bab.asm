;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_bab
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_baseafterbase_map
	.globl ___func_baseafterbase_map
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
	.area _CODE_6
;src/level_bab.c:4: INCBIN(baseafterbase_map, "levels/level_data/baseafterbase_16high.bin")
;	---------------------------------
; Function __func_baseafterbase_map
; ---------------------------------
	b___func_baseafterbase_map	= 6
___func_baseafterbase_map::
_baseafterbase_map::
1$:
	.incbin "levels/level_data/baseafterbase_16high.bin" 
2$:
	___size_baseafterbase_map = (2$-1$) 
	.globl ___size_baseafterbase_map 
	.local b___func_baseafterbase_map 
	___bank_baseafterbase_map = b___func_baseafterbase_map 
	.globl ___bank_baseafterbase_map 
	.area _CODE_6
	.area _INITIALIZER
	.area _CABS (ABS)
