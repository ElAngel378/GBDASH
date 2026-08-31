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
	add	sp, #-24
	ld	c, a
	ldhl	sp,	#21
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
	jp	Z, 00125$
	ldhl	sp,	#22
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00125$
;src/portal_utils.c:29: SWITCH_ROM(sp_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/portal_utils.c:30: while (count < MAX_ACTIVE_SP_OBJECTS && cache->active[count]) count++;
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0050
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#23
	ld	(hl), #0x00
00105$:
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00134$
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00134$
	ldhl	sp,	#23
	inc	(hl)
	jr	00105$
;src/portal_utils.c:32: while (sp_list[*stream_idx].c != 0xFFFF) {
00134$:
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
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#20
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
00122$:
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x02
00234$:
	ldhl	sp,	#17
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00234$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#19
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	and	a, b
	inc	a
	jp	Z, 00124$
;src/portal_utils.c:33: uint16_t object_x = (uint16_t)sp_list[*stream_idx].c << 4;
	ld	a, #0x04
00236$:
	ldhl	sp,	#19
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00236$
;src/portal_utils.c:36: if (object_x > cam_px + 176u) break;
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x00b0
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jp	C, 00124$
;src/portal_utils.c:39: if (object_x + 32u < cam_px) {
	ld	hl, #0x0020
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#26
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00111$
;src/portal_utils.c:40: (*stream_idx)++;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/portal_utils.c:41: continue;
	jp	00122$
00111$:
;src/portal_utils.c:44: uint8_t obj_id = sp_list[*stream_idx].obj;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;src/portal_utils.c:48: if (_cpu != CGB_TYPE && obj_id >= 38 && obj_id < 64) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	Z, 00113$
	ld	a,c
	cp	a,#0x26
	jr	C, 00113$
	sub	a, #0x40
	jr	NC, 00113$
;src/portal_utils.c:49: (*stream_idx)++;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/portal_utils.c:50: continue;
	jp	00122$
00113$:
;src/portal_utils.c:54: if (count >= MAX_ACTIVE_SP_OBJECTS - 8 && obj_id >= 38 && obj_id < 64) {
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x08
	jr	C, 00117$
	ld	a,c
	cp	a,#0x26
	jr	C, 00117$
	sub	a, #0x40
	jr	NC, 00117$
;src/portal_utils.c:55: (*stream_idx)++;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/portal_utils.c:56: continue;
	jp	00122$
00117$:
;src/portal_utils.c:60: if (count >= MAX_ACTIVE_SP_OBJECTS) break;
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00124$
;src/portal_utils.c:62: cache->obj[count] = obj_id;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
;src/portal_utils.c:63: cache->px[count] = object_x;
	ldhl	sp,	#23
	ld	a, (hl)
	add	a, a
	ld	e, a
	push	de
	ld	d, #0x00
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/portal_utils.c:64: cache->py[count] = (uint16_t)(map_h - 1u - sp_list[*stream_idx].r) << 4;
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
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#16
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	sla	c
	adc	a, a
	sla	c
	adc	a, a
	ldhl	sp,	#19
	ld	(hl), c
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#20
	ld	(hl-), a
	ld	(hl), e
	ld	a, #0x04
00239$:
	ldhl	sp,	#19
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00239$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/portal_utils.c:65: cache->active[count] = 1;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x01
;src/portal_utils.c:66: cache->activated[count] = 0;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/portal_utils.c:68: count++;
	ldhl	sp,	#23
	inc	(hl)
;src/portal_utils.c:69: (*stream_idx)++;
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
	jp	00122$
00124$:
;src/portal_utils.c:71: SWITCH_ROM(save_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
00125$:
;src/portal_utils.c:72: }
	add	sp, #24
	pop	hl
	add	sp, #8
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
