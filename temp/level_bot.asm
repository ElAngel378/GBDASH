;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module level_bot
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_backontrack_map
	.globl ___func_backontrack_map
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
	.area _CODE_31
;src/levels/level_bot.c:4: INCBIN(backontrack_map, "levels/level_data/backontrack_16high.bin")
;	---------------------------------
; Function __func_backontrack_map
; ---------------------------------
	b___func_backontrack_map	= 31
___func_backontrack_map::
_backontrack_map::
1$:
	.incbin "levels/level_data/backontrack_16high.bin" 
2$:
	___size_backontrack_map = (2$-1$) 
	.globl ___size_backontrack_map 
	.local b___func_backontrack_map 
	___bank_backontrack_map = b___func_backontrack_map 
	.globl ___bank_backontrack_map 
	.area _CODE_31
	.area _INITIALIZER
	.area _CABS (ABS)
