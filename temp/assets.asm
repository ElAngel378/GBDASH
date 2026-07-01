;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module assets
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _MAX_LEVELS
	.globl _game_levels
	.globl _level_du
	.globl _level_pg
	.globl _level_bot
	.globl _level_sm
	.globl _song_bank
	.globl _level_songs
	.globl b___func_chr_gb_tiles
	.globl ___func_chr_gb_tiles
	.globl b___func_chr_gb
	.globl ___func_chr_gb
	.globl b___func_game_levels
	.globl ___func_game_levels
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
	.area _CODE_1
;src/assets.c:7: BANKREF(game_levels)
;	---------------------------------
; Function __func_game_levels
; ---------------------------------
	b___func_game_levels	= 1
___func_game_levels::
	.local b___func_game_levels 
	___bank_game_levels = b___func_game_levels 
	.globl ___bank_game_levels 
;src/assets.c:8: BANKREF(chr_gb)
;	---------------------------------
; Function __func_chr_gb
; ---------------------------------
	b___func_chr_gb	= 1
___func_chr_gb::
	.local b___func_chr_gb 
	___bank_chr_gb = b___func_chr_gb 
	.globl ___bank_chr_gb 
;src/assets.c:11: INCBIN(chr_gb_tiles, "levels/chr_data/chr_gb_tiles.bin")
;	---------------------------------
; Function __func_chr_gb_tiles
; ---------------------------------
	b___func_chr_gb_tiles	= 1
___func_chr_gb_tiles::
_chr_gb_tiles::
1$:
	.incbin "levels/chr_data/chr_gb_tiles.bin" 
2$:
	___size_chr_gb_tiles = (2$-1$) 
	.globl ___size_chr_gb_tiles 
	.local b___func_chr_gb_tiles 
	___bank_chr_gb_tiles = b___func_chr_gb_tiles 
	.globl ___bank_chr_gb_tiles 
	.area _CODE_1
_level_songs:
	.dw _stereomadness
	.dw _backontrack
	.dw _polargeist
	.dw _dryout
_song_bank:
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x07	; 7
_level_sm:
	.dw __str_0
	.dw _chr_gb_tiles
	.dw _stereomadness_map
	.dw _stereomadness_sprites_placements
	.dw #0x00d4
	.dw #0x0100
	.dw #0x037e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_stereomadness_map
	.db #0xc0	; 192
_level_bot:
	.dw __str_1
	.dw _chr_gb_tiles
	.dw _backontrack_map
	.dw #0x0000
	.dw #0x0000
	.dw #0x0100
	.dw #0x034e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_backontrack_map
	.db #0xb8	; 184
_level_pg:
	.dw __str_2
	.dw _chr_gb_tiles
	.dw _polargeist_map
	.dw #0x0000
	.dw #0x0000
	.dw #0x0100
	.dw #0x03a6
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_polargeist_map
	.db #0xc1	; 193
_level_du:
	.dw __str_3
	.dw _chr_gb_tiles
	.dw _dryout_map
	.dw #0x0000
	.dw #0x0000
	.dw #0x0100
	.dw #0x034a
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_dryout_map
	.db #0xb9	; 185
_game_levels:
	.dw _level_sm
	.dw _level_bot
	.dw _level_pg
	.dw _level_du
_MAX_LEVELS:
	.db #0x04	; 4
__str_0:
	.ascii "STEREO MADNESS"
	.db 0x00
__str_1:
	.ascii "BACK ON TRACK"
	.db 0x00
__str_2:
	.ascii "POLARGEIST"
	.db 0x00
__str_3:
	.ascii "DRY OUT"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
