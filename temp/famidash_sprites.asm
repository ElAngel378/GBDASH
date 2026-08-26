;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module famidash_sprites
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _famidash_sprite_table
	.globl _famidash_deco_45
	.globl _famidash_pink_orb
	.globl _famidash_blue_orb
	.globl _famidash_yellow_orb
	.globl _famidash_pink_pad
	.globl _famidash_blue_pad_up
	.globl _famidash_blue_pad
	.globl _famidash_yellow_pad_up
	.globl _famidash_yellow_pad
	.globl _famidash_gravity_up
	.globl _famidash_gravity_down
	.globl _famidash_portal_up_horiz_up
	.globl _famidash_portal_up_horiz_dn
	.globl _famidash_portal_dn_horiz_up
	.globl _famidash_portal_dn_horiz_dn
	.globl _famidash_ball_portal
	.globl _famidash_ship_portal
	.globl _famidash_cube_portal
	.globl b___func_famidash_sprites_tiles
	.globl ___func_famidash_sprites_tiles
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
	.area _CODE_10
;src/famidash_sprites.c:9: INCBIN(famidash_sprites_tiles, "levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin")
;	---------------------------------
; Function __func_famidash_sprites_tiles
; ---------------------------------
	b___func_famidash_sprites_tiles	= 10
___func_famidash_sprites_tiles::
_famidash_sprites_tiles::
1$:
	.incbin "levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin" 
2$:
	___size_famidash_sprites_tiles = (2$-1$) 
	.globl ___size_famidash_sprites_tiles 
	.local b___func_famidash_sprites_tiles 
	___bank_famidash_sprites_tiles = b___func_famidash_sprites_tiles 
	.globl ___bank_famidash_sprites_tiles 
	.area _CODE_10
_famidash_cube_portal:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_ship_portal:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x08	; 8
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0a	; 10
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x41	; 65	'A'
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_ball_portal:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x08	; 8
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0a	; 10
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x04	; 4
	.db #0x41	; 65	'A'
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_portal_dn_horiz_dn:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x20	; 32
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x20	; 32
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x24	; 36
	.db #0x20	; 32
	.db #0xf0	; -16
	.db #0xd8	; -40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x20	; 32
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2a	; 42
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_portal_dn_horiz_up:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x24	; 36
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x60	; 96
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x60	; 96
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x24	; 36
	.db #0x60	; 96
	.db #0x10	;  16
	.db #0xd8	; -40
	.db #0x2a	; 42
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x60	; 96
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2a	; 42
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_portal_up_horiz_dn:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x24	; 36
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x21	; 33
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x21	; 33
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x24	; 36
	.db #0x21	; 33
	.db #0xf0	; -16
	.db #0xd8	; -40
	.db #0x2a	; 42
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x21	; 33
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2a	; 42
	.db #0x21	; 33
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_portal_up_horiz_up:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x24	; 36
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x28	; 40
	.db #0x61	; 97	'a'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x26	; 38
	.db #0x61	; 97	'a'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x24	; 36
	.db #0x61	; 97	'a'
	.db #0x10	;  16
	.db #0xd8	; -40
	.db #0x2a	; 42
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2c	; 44
	.db #0x61	; 97	'a'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x2a	; 42
	.db #0x61	; 97	'a'
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_gravity_down:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x10	;  16
	.db #0xf8	; -8
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x10	;  16
	.db #0xf8	; -8
	.db #0x0c	; 12
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0e	; 14
	.db #0x40	; 64
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_gravity_up:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x0c	; 12
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf8	; -8
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x10	;  16
	.db #0xf8	; -8
	.db #0x0c	; 12
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0e	; 14
	.db #0x41	; 65	'A'
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_yellow_pad:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x16	; 22
	.db #0x21	; 33
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_yellow_pad_up:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x14	; 20
	.db #0x41	; 65	'A'
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x16	; 22
	.db #0x61	; 97	'a'
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_blue_pad:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x16	; 22
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_blue_pad_up:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x14	; 20
	.db #0x40	; 64
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x16	; 22
	.db #0x60	; 96
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_pink_pad:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x22	; 34
	.db #0x21	; 33
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_yellow_orb:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x18	; 24
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x1a	; 26
	.db #0x21	; 33
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_blue_orb:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x1a	; 26
	.db #0x20	; 32
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_pink_orb:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x1e	; 30
	.db #0x21	; 33
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_deco_45:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x54	; 84	'T'
	.db #0x03	; 3
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x56	; 86	'V'
	.db #0x03	; 3
	.db #0x10	;  16
	.db #0xf0	; -16
	.db #0x58	; 88	'X'
	.db #0x03	; 3
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x5a	; 90	'Z'
	.db #0x03	; 3
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_sprite_table:
	.dw _famidash_cube_portal
	.dw _famidash_ship_portal
	.dw _famidash_ball_portal
	.dw #0x0000
	.dw #0x0000
	.dw _famidash_blue_orb
	.dw _famidash_pink_orb
	.dw #0x0000
	.dw _famidash_gravity_down
	.dw _famidash_gravity_up
	.dw _famidash_yellow_pad
	.dw _famidash_yellow_orb
	.dw _famidash_yellow_pad_up
	.dw _famidash_blue_pad
	.dw _famidash_blue_pad_up
	.dw #0x0000
	.dw _famidash_portal_dn_horiz_dn
	.dw _famidash_portal_dn_horiz_up
	.dw _famidash_portal_up_horiz_dn
	.dw _famidash_portal_up_horiz_up
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw _famidash_pink_pad
	.area _INITIALIZER
	.area _CABS (ABS)
