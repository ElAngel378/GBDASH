;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module tileset
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_chr_gb_cgb_tiles_rev
	.globl ___func_chr_gb_cgb_tiles_rev
	.globl b___func_chr_gb_cgb_tiles
	.globl ___func_chr_gb_cgb_tiles
	.globl b___func_chr_gb_tiles_rev
	.globl ___func_chr_gb_tiles_rev
	.globl b___func_chr_gb_tiles
	.globl ___func_chr_gb_tiles
	.globl b___func_chr_gb
	.globl ___func_chr_gb
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
	.area _CODE_20
;src/tileset.c:5: BANKREF(chr_gb)
;	---------------------------------
; Function __func_chr_gb
; ---------------------------------
	b___func_chr_gb	= 20
___func_chr_gb::
	.local b___func_chr_gb 
	___bank_chr_gb = b___func_chr_gb 
	.globl ___bank_chr_gb 
;src/tileset.c:7: INCBIN(chr_gb_tiles, "levels/chr_data/chr_gb_dmg_tiles.bin")
;	---------------------------------
; Function __func_chr_gb_tiles
; ---------------------------------
	b___func_chr_gb_tiles	= 20
___func_chr_gb_tiles::
_chr_gb_tiles::
1$:
	.incbin "levels/chr_data/chr_gb_dmg_tiles.bin" 
2$:
	___size_chr_gb_tiles = (2$-1$) 
	.globl ___size_chr_gb_tiles 
	.local b___func_chr_gb_tiles 
	___bank_chr_gb_tiles = b___func_chr_gb_tiles 
	.globl ___bank_chr_gb_tiles 
;src/tileset.c:8: INCBIN(chr_gb_tiles_rev, "levels/chr_data/chr_gb_dmg_flipped_tiles.bin")
;	---------------------------------
; Function __func_chr_gb_tiles_rev
; ---------------------------------
	b___func_chr_gb_tiles_rev	= 20
___func_chr_gb_tiles_rev::
_chr_gb_tiles_rev::
1$:
	.incbin "levels/chr_data/chr_gb_dmg_flipped_tiles.bin" 
2$:
	___size_chr_gb_tiles_rev = (2$-1$) 
	.globl ___size_chr_gb_tiles_rev 
	.local b___func_chr_gb_tiles_rev 
	___bank_chr_gb_tiles_rev = b___func_chr_gb_tiles_rev 
	.globl ___bank_chr_gb_tiles_rev 
;src/tileset.c:13: INCBIN(chr_gb_cgb_tiles, "levels/chr_data/chr_gb_dmg_tiles.bin")
;	---------------------------------
; Function __func_chr_gb_cgb_tiles
; ---------------------------------
	b___func_chr_gb_cgb_tiles	= 20
___func_chr_gb_cgb_tiles::
_chr_gb_cgb_tiles::
1$:
	.incbin "levels/chr_data/chr_gb_dmg_tiles.bin" 
2$:
	___size_chr_gb_cgb_tiles = (2$-1$) 
	.globl ___size_chr_gb_cgb_tiles 
	.local b___func_chr_gb_cgb_tiles 
	___bank_chr_gb_cgb_tiles = b___func_chr_gb_cgb_tiles 
	.globl ___bank_chr_gb_cgb_tiles 
;src/tileset.c:14: INCBIN(chr_gb_cgb_tiles_rev, "levels/chr_data/chr_gb_dmg_flipped_tiles.bin")
;	---------------------------------
; Function __func_chr_gb_cgb_tiles_rev
; ---------------------------------
	b___func_chr_gb_cgb_tiles_rev	= 20
___func_chr_gb_cgb_tiles_rev::
_chr_gb_cgb_tiles_rev::
1$:
	.incbin "levels/chr_data/chr_gb_dmg_flipped_tiles.bin" 
2$:
	___size_chr_gb_cgb_tiles_rev = (2$-1$) 
	.globl ___size_chr_gb_cgb_tiles_rev 
	.local b___func_chr_gb_cgb_tiles_rev 
	___bank_chr_gb_cgb_tiles_rev = b___func_chr_gb_cgb_tiles_rev 
	.globl ___bank_chr_gb_cgb_tiles_rev 
	.area _CODE_20
	.area _INITIALIZER
	.area _CABS (ABS)
