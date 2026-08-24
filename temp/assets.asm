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
	.globl _level_cy
	.globl _level_tm
	.globl _level_ju
	.globl _level_clg
	.globl _level_bab
	.globl _level_du
	.globl _level_pg
	.globl _level_bot
	.globl _level_sm
	.globl _song_bank
	.globl _level_songs
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
	.area _CODE
;src/assets.c:5: BANKREF(game_levels)
;	---------------------------------
; Function __func_game_levels
; ---------------------------------
	b___func_game_levels	= 0
___func_game_levels::
	.local b___func_game_levels 
	___bank_game_levels = b___func_game_levels 
	.globl ___bank_game_levels 
	.area _CODE
_level_songs:
	.dw _stereomadness
	.dw _backontrack
	.dw _polargeist
	.dw _dryout
	.dw _baseafterbase
	.dw _cantletgo
	.dw _jumper
	.dw _timemachine
	.dw #0x0000
_song_bank:
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xfc	; 252
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0xf9	; 249
	.db #0xf8	; 248
	.db #0x00	; 0
_level_sm:
	.dw __str_0
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _stereomadness_map
	.dw #0x0100
	.dw #0x037e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_stereomadness_map
	.db #0xbf	; 191
	.dw _stereomadness_sp
	.byte ___bank_stereomadness_sp
_level_bot:
	.dw __str_1
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _backontrack_map
	.dw #0x0100
	.dw #0x034e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_backontrack_map
	.db #0xb7	; 183
	.dw _backontrack_sp
	.byte ___bank_backontrack_sp
_level_pg:
	.dw __str_2
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _polargeist_map
	.dw #0x0100
	.dw #0x03a6
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_polargeist_map
	.db #0xc1	; 193
	.dw _polargeist_sp
	.byte ___bank_polargeist_sp
_level_du:
	.dw __str_3
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _dryout_map
	.dw #0x0100
	.dw #0x034a
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_dryout_map
	.db #0xb9	; 185
	.dw _dryout_sp
	.byte ___bank_dryout_sp
_level_bab:
	.dw __str_4
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _baseafterbase_map
	.dw #0x0100
	.dw #0x0365
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_baseafterbase_map
	.db #0xb7	; 183
	.dw _baseafterbase_sp
	.byte ___bank_baseafterbase_sp
_level_clg:
	.dw __str_5
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _cantletgo_map
	.dw #0x0100
	.dw #0x0345
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_cantletgo_map
	.db #0xc4	; 196
	.dw _cantletgo_sp
	.byte ___bank_cantletgo_sp
_level_ju:
	.dw __str_6
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _jumper_map
	.dw #0x0100
	.dw #0x0381
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_jumper_map
	.db #0x8d	; 141
	.dw _jumper_sp
	.byte ___bank_jumper_sp
_level_tm:
	.dw __str_7
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _timemachine_map
	.dw #0x0100
	.dw #0x03e5
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_timemachine_map
	.db #0x29	; 41
	.dw _timemachine_sp
	.byte ___bank_timemachine_sp
_level_cy:
	.dw __str_8
	.dw _chr_gb_tiles
	.dw _chr_gb_tiles_rev
	.dw _cycles_map
	.dw #0x0100
	.dw #0x0337
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_cycles_map
	.db #0xb4	; 180
	.dw _cycles_sp
	.byte ___bank_cycles_sp
_game_levels:
	.dw _level_sm
	.dw _level_bot
	.dw _level_pg
	.dw _level_du
	.dw _level_bab
	.dw _level_clg
	.dw _level_ju
	.dw _level_tm
	.dw _level_cy
_MAX_LEVELS:
	.db #0x09	; 9
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
__str_4:
	.ascii "BASE AFTER BASE"
	.db 0x00
__str_5:
	.ascii "CANT LET GO"
	.db 0x00
__str_6:
	.ascii "JUMPER"
	.db 0x00
__str_7:
	.ascii "TIME MACHINE"
	.db 0x00
__str_8:
	.ascii "CYCLES"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
