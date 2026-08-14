#pragma bank 10
#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

const palette_color_t icon1_palettes[4] = {
	RGB8(255,255,255), RGB8(  0,240,255), RGB8(  0,255,  0), RGB8(  0,  0,  0)
};

const uint8_t icon1_tiles[128] = {
	0x00,0x00,0x7f,0x7f,
	0x40,0x7f,0x40,0x7f,
	0x4f,0x7f,0x48,0x78,
	0x4b,0x7b,0x4b,0x7a,
	0x4b,0x7a,0x4b,0x7b,
	0x48,0x78,0x4f,0x7f,
	0x40,0x7f,0x40,0x7f,
	0x7f,0x7f,0x00,0x00,

    0x0e,0x0e,0x11,0x1f,
	0x10,0x1f,0x26,0x3f,
	0x25,0x3d,0x24,0x3c,
	0x4b,0x7b,0x4b,0x7a,
	0x4b,0x7a,0x93,0xf3,
	0x9c,0xfc,0x83,0xff,
	0x60,0x7f,0x1c,0x1f,
	0x03,0x03,0x00,0x00,

    0x0b,0x0f,0x08,0x0f,
	0x10,0x1f,0x13,0x1f,
	0x24,0x3c,0x24,0x3c,
	0x49,0x79,0x4b,0x7a,
	0x93,0xf2,0x91,0xf1,
	0x0c,0xfc,0xc3,0xff,
	0x30,0x3f,0x0c,0x0f,
	0x03,0x03,0x00,0x00,

    0x02,0x03,0x04,0x07,
	0x08,0x0f,0x11,0x1f,
	0x22,0x3e,0x44,0x7c,
	0x89,0xf9,0x13,0xf2,
	0x13,0xf2,0x89,0xf9,
	0x44,0x7c,0x22,0x3e,
	0x11,0x1f,0x08,0x0f,
	0x04,0x07,0x02,0x03
};

const metasprite_t icon1_metasprite0[] = {
	METASPR_ITEM(0, -1, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 0, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite1[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0)),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite2[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0)),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite3[] = {
	METASPR_ITEM(0, -1, 6, S_PAL(0)),
	METASPR_ITEM(0, 8, 6, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite4[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite5[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite6[] = {
	METASPR_ITEM(0, -1, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 0, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite7[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0)),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite8[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0)),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite9[] = {
	METASPR_ITEM(0, -1, 6, S_PAL(0)),
	METASPR_ITEM(0, 8, 6, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite10[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite11[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite12[] = {
	METASPR_ITEM(0, -1, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 0, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite13[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0)),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite14[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0)),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite15[] = {
	METASPR_ITEM(0, -1, 6, S_PAL(0)),
	METASPR_ITEM(0, 8, 6, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite16[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite17[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite18[] = {
	METASPR_ITEM(0, -1, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 0, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite19[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0)),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite20[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0)),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX | S_FLIPY),
	METASPR_TERM
};

const metasprite_t icon1_metasprite21[] = {
	METASPR_ITEM(0, -1, 6, S_PAL(0)),
	METASPR_ITEM(0, 8, 6, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite22[] = {
	METASPR_ITEM(0, -1, 4, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 4, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite23[] = {
	METASPR_ITEM(0, -1, 2, S_PAL(0) | S_FLIPY),
	METASPR_ITEM(0, 8, 2, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};

const metasprite_t icon1_metasprite24[] = {
	METASPR_ITEM(0, -1, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 0, S_PAL(0) | S_FLIPX),
	METASPR_TERM
};


const metasprite_t* const icon1_metasprites[25] = {
	icon1_metasprite0, icon1_metasprite1, icon1_metasprite2, icon1_metasprite3, icon1_metasprite4, icon1_metasprite5, icon1_metasprite6, icon1_metasprite7, icon1_metasprite8, icon1_metasprite9, icon1_metasprite10, icon1_metasprite11, icon1_metasprite12, icon1_metasprite13, icon1_metasprite14, icon1_metasprite15, icon1_metasprite16, icon1_metasprite17, icon1_metasprite18, icon1_metasprite19, icon1_metasprite20, icon1_metasprite21, icon1_metasprite22, icon1_metasprite23, icon1_metasprite24
};
