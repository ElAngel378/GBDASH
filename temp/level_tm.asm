;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_tm
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_timemachine_map
	.globl ___func_timemachine_map
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
	.area _CODE_9
;src/level_tm.c:4: INCBIN(timemachine_map, "levels/level_data/timemachine_16high.bin")
;	---------------------------------
; Function __func_timemachine_map
; ---------------------------------
	b___func_timemachine_map	= 9
___func_timemachine_map::
_timemachine_map::
1$:
	.incbin "levels/level_data/timemachine_16high.bin" 
2$:
	___size_timemachine_map = (2$-1$) 
	.globl ___size_timemachine_map 
	.local b___func_timemachine_map 
	___bank_timemachine_map = b___func_timemachine_map 
	.globl ___bank_timemachine_map 
	.area _CODE_9
	.area _INITIALIZER
	.area _CABS (ABS)
