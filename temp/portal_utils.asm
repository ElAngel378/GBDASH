;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module portal_utils
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sp_cache_load
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
;src/portal_utils.c:23: void sp_cache_load(uint8_t sp_bank, const SpDef *sp_list, uint16_t cam_px,
;	---------------------------------
; Function sp_cache_load
; ---------------------------------
_sp_cache_load::
	add	sp, #-18
	ld	c, a
	ldhl	sp,	#15
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/portal_utils.c:26: uint8_t save_bank = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/portal_utils.c:28: if (sp_bank == 0 || sp_list == 0) return;
	ld	a, c
	or	a, a
	jp	Z, 00114$
	ldhl	sp,	#16
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00114$
;src/portal_utils.c:29: SWITCH_ROM(sp_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/portal_utils.c:30: while (count < MAX_ACTIVE_SP_OBJECTS && cache->active[count]) count++;
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0050
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#17
	ld	(hl), #0x00
00105$:
	ldhl	sp,	#17
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00123$
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00123$
	ldhl	sp,	#17
	inc	(hl)
	jr	00105$
;src/portal_utils.c:31: while (count < MAX_ACTIVE_SP_OBJECTS && sp_list[*stream_idx].c != 0xFFFF) {
00123$:
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	hl, #0x0010
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #0x0030
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ld	hl, #0x0060
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
00111$:
	ldhl	sp,	#17
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00113$
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	c, l
	ld	b, h
	ld	a, c
	and	a, b
	inc	a
	jp	Z, 00113$
;src/portal_utils.c:32: uint16_t object_x = (uint16_t)sp_list[*stream_idx].c << 4;
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
;src/portal_utils.c:33: if (object_x > cam_px + 176u) break;
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00b0
	add	hl, de
	ld	e, c
	ld	d, b
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jp	C, 00113$
;src/portal_utils.c:35: cache->obj[count] = sp_list[*stream_idx].obj;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/portal_utils.c:36: cache->px[count] = object_x;
	ldhl	sp,	#17
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#14
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;src/portal_utils.c:37: cache->py[count] = (uint16_t)(map_h - 1u - sp_list[*stream_idx].r) << 4;
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	l, a
	ld	a, b
	sbc	a, d
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/portal_utils.c:38: cache->active[count] = 1;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x01
;src/portal_utils.c:39: cache->activated[count] = 0;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/portal_utils.c:41: count++;
	ldhl	sp,	#17
	inc	(hl)
;src/portal_utils.c:42: (*stream_idx)++;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00111$
00113$:
;src/portal_utils.c:44: SWITCH_ROM(save_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
00114$:
;src/portal_utils.c:45: }
	add	sp, #18
	pop	hl
	add	sp, #8
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
