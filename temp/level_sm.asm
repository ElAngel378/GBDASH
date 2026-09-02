;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_sm
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_stereomadness_map
	.globl ___func_stereomadness_map
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
	.area _CODE_30
;src/levels/level_sm.c:4: INCBIN(stereomadness_map, "levels/level_data/stereomadness_16high.bin")
;	---------------------------------
; Function __func_stereomadness_map
; ---------------------------------
	b___func_stereomadness_map	= 30
___func_stereomadness_map::
_stereomadness_map::
1$:
	.incbin "levels/level_data/stereomadness_16high.bin" 
2$:
	___size_stereomadness_map = (2$-1$) 
	.globl ___size_stereomadness_map 
	.local b___func_stereomadness_map 
	___bank_stereomadness_map = b___func_stereomadness_map 
	.globl ___bank_stereomadness_map 
	.area _CODE_30
	.area _INITIALIZER
	.area _CABS (ABS)
