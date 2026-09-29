from PIL import Image, ImageDraw

# 1. Load exact tiles from menu_select_bg.c
with open('src/graphics/menu_select_bg.c') as f:
    text = f.read()

start = text.find('menu_select_bg_tiles[1040] = {')
end = text.find('};', start)
raw = text[start+30:end]
ms_tiles = [int(x.strip(), 16) for x in raw.replace('\n', '').split(',') if x.strip()]

def get_ms_tile(idx):
    return tuple(ms_tiles[idx*16 : (idx+1)*16])

# Corner tiles from new level select (menu_select_bg):
# 0x37: col 0, row 15
# 0x38: col 19, row 15
# 0x39: col 0, row 16
# 0x3a: col 19, row 16
# 0x3b: col 0, row 17
# 0x3c: col 1, row 17
# 0x3d: col 2, row 17
# 0x3e: col 17, row 17
# 0x3f: col 18, row 17
# 0x40: col 19, row 17
tile_corner_37 = get_ms_tile(0x37)
tile_corner_38 = get_ms_tile(0x38)
tile_corner_39 = get_ms_tile(0x39)
tile_corner_3a = get_ms_tile(0x3a)
tile_corner_3b = get_ms_tile(0x3b)
tile_corner_3c = get_ms_tile(0x3c)
tile_corner_3d = get_ms_tile(0x3d)
tile_corner_3e = get_ms_tile(0x3e)
tile_corner_3f = get_ms_tile(0x3f)
tile_corner_40 = get_ms_tile(0x40)

# Back button 2x2 tiles from menu_select_bg:
# 0x0a: (1, 1), 0x0b: (2, 1), 0x0e: (1, 2), 0x0f: (2, 2)
tile_back_0a = get_ms_tile(0x0a)
tile_back_0b = get_ms_tile(0x0b)
tile_back_0e = get_ms_tile(0x0e)
tile_back_0f = get_ms_tile(0x0f)

# 2. Frame tiles, drawn as ASCII art (8x8, one char per pixel = palette index).
# Design follows the "hanging box" of the Famidash sound test: gradient lime bars and
# gradient blue corner squares outlined in black + white, thin chains, black title plaque.
#
# Frame palettes are ordered by brightness so the DMG grey shades stay readable:
#   '.' = 0 white outline   'l' = 1 light (lime / light blue)
#   'g' = 2 dark (green / blue)   'k' = 3 black outline
def art(rows):
    assert len(rows) == 8 and all(len(r) == 8 for r in rows), rows
    m = {'.': 0, 'l': 1, 'g': 2, 'k': 3}
    out = []
    for r in rows:
        b0 = b1 = 0
        for ch in r:
            v = m[ch]
            b0 = (b0 << 1) | (v & 1)
            b1 = (b1 << 1) | ((v >> 1) & 1)
        out += [b0, b1]
    return tuple(out)


# Chain link (palette 4: sky, white, silver, black): digits are palette indices
def art_digits(rows):
    assert len(rows) == 8 and all(len(r) == 8 for r in rows), rows
    out = []
    for r in rows:
        b0 = b1 = 0
        for ch in r:
            v = 0 if ch == '.' else int(ch)
            b0 = (b0 << 1) | (v & 1)
            b1 = (b1 << 1) | ((v >> 1) & 1)
        out += [b0, b1]
    return tuple(out)


chain_tile_a = art_digits([
    "...11...",
    "..1..1..",
    "..1..1..",
    "..1..1..",
    "..1..1..",
    "..1..1..",
    "..1..1..",
    "...11...",
])

tile_top_lime = art([
    "........",
    "kkkkkkkk",
    "llllllll",
    "llllllll",
    "llllllll",
    "gggggggg",
    "gggggggg",
    "kkkkkkkk",
])

tile_bracket_tl = art([
    "........",
    ".kkkkkkk",
    ".klllllk",
    ".klllllk",
    ".klllllk",
    ".kgggggk",
    ".kgggggk",
    ".kkkkkkk",
])
tile_bracket_tr = art([
    "........",
    "kkkkkkk.",
    "klllllk.",
    "klllllk.",
    "klllllk.",
    "kgggggk.",
    "kgggggk.",
    "kkkkkkk.",
])

tile_pillar_l = art([".kllgggk"] * 8)
tile_pillar_r = art(["kgggllk."] * 8)

tile_bottom_lime = art([
    "kkkkkkkk",
    "llllllll",
    "llllllll",
    "llllllll",
    "gggggggg",
    "gggggggg",
    "kkkkkkkk",
    "........",
])

tile_bracket_bl = art([
    ".kkkkkkk",
    ".klllllk",
    ".klllllk",
    ".klllllk",
    ".kgggggk",
    ".kgggggk",
    ".kkkkkkk",
    "........",
])
tile_bracket_br = art([
    "kkkkkkk.",
    "klllllk.",
    "klllllk.",
    "klllllk.",
    "kgggggk.",
    "kgggggk.",
    "kkkkkkk.",
    "........",
])

tile_bottom_plate_l = art([
    "kkkkkkkk",
    "klllllll",
    "klllllll",
    "klllllll",
    "kggggggg",
    "kggggggg",
    "kkkkkkkk",
    "........",
])
tile_bottom_plate_r = art([
    "kkkkkkkk",
    "lllllllk",
    "lllllllk",
    "lllllllk",
    "gggggggk",
    "gggggggk",
    "kkkkkkkk",
    "........",
])

# SETTINGS banner uses authentic FontPusab tiles loaded at 0xD0
# 'S'=0xEF, 'E'=0xE1, 'T'=0xF0, 'I'=0xE5, 'N'=0xEA, 'G'=0xE3
settings_word_tiles = [0xEF, 0xE1, 0xF0, 0xF0, 0xE5, 0xEA, 0xE3, 0xEF]

# Blank tile (tile 0): all 0s (Board colour on palette 2)
tile_blank = tuple([0] * 16)

# Build unique tiles list:
unique_tiles = [
    tile_blank,           # 0
    chain_tile_a,         # 1
    tile_top_lime,        # 2
    tile_bracket_tl,      # 3
    tile_bracket_tr,      # 4
    tile_pillar_l,        # 5
    tile_pillar_r,        # 6
    tile_bottom_lime,     # 7
    tile_bottom_plate_l,  # 8
    tile_bottom_plate_r,  # 9
    tile_back_0a,         # 10
    tile_back_0b,         # 11
    tile_back_0e,         # 12
    tile_back_0f,         # 13
    tile_corner_37,       # 14
    tile_corner_38,       # 15
    tile_corner_39,       # 16
    tile_corner_3a,       # 17
    tile_corner_3b,       # 18
    tile_corner_3c,       # 19
    tile_corner_3d,       # 20
    tile_corner_3e,       # 21
    tile_corner_3f,       # 22
    tile_corner_40,       # 23
    tile_bracket_bl,      # 24
    tile_bracket_br,      # 25
]
T_BLANK, T_CHAIN, T_TOP, T_TL, T_TR, T_PIL_L, T_PIL_R, T_BOT, T_PLATE_L, T_PLATE_R = range(10)
T_BACK = 10
T_CORNER0 = 14
T_BL, T_BR = 24, 25

# Palette slots
P_STEPS, P_FRAME, P_BOARD, P_TITLE, P_CHAIN, P_BACK, P_UNUSED, P_BLUE = range(8)

# Build 20x18 map and attribute map
tile_map = [0] * 360
attr_map = [0] * 360


def set_tile(tx, ty, t_id, p_id):
    idx = ty * 20 + tx
    tile_map[idx] = t_id
    attr_map[idx] = p_id


# Sky everywhere (tile 0 with the sky-coloured palette), then the board interior
for ty in range(18):
    for tx in range(20):
        set_tile(tx, ty, T_BLANK, P_STEPS)
for ty in range(3, 14):
    for tx in range(3, 17):
        set_tile(tx, ty, T_BLANK, P_BOARD)

# Chains at col 4 and 15 (two links each, hanging into the top bar)
for col in (4, 15):
    set_tile(col, 0, T_CHAIN, P_CHAIN)
    set_tile(col, 1, T_CHAIN, P_CHAIN)

# Back button (pink arrow), left of the frame
set_tile(0, 1, T_BACK + 0, P_BACK)
set_tile(1, 1, T_BACK + 1, P_BACK)
set_tile(0, 2, T_BACK + 2, P_BACK)
set_tile(1, 2, T_BACK + 3, P_BACK)

# Top bar (row 2): blue corner squares, lime bar, black SETTINGS plaque
set_tile(2, 2, T_TL, P_BLUE)
for tx in (3, 4, 5, 14, 15, 16):
    set_tile(tx, 2, T_TOP, P_FRAME)
for i in range(8):
    set_tile(6 + i, 2, settings_word_tiles[i], P_TITLE)
set_tile(17, 2, T_TR, P_BLUE)

# Side pillars (rows 3..13)
for ty in range(3, 14):
    set_tile(2, ty, T_PIL_L, P_FRAME)
    set_tile(17, ty, T_PIL_R, P_FRAME)

# Bottom bar (row 14): blue corners, lime bar, blue centre plate
set_tile(2, 14, T_BL, P_BLUE)
for tx in range(3, 9):
    set_tile(tx, 14, T_BOT, P_FRAME)
set_tile(9, 14, T_PLATE_L, P_BLUE)
set_tile(10, 14, T_PLATE_R, P_BLUE)
for tx in range(11, 17):
    set_tile(tx, 14, T_BOT, P_FRAME)
set_tile(17, 14, T_BR, P_BLUE)

# Stepped corner blocks from the level select:
set_tile(0, 15, T_CORNER0 + 0, P_STEPS)
set_tile(19, 15, T_CORNER0 + 1, P_STEPS)
set_tile(0, 16, T_CORNER0 + 2, P_BACK)
set_tile(19, 16, T_CORNER0 + 3, P_BACK)
set_tile(0, 17, T_CORNER0 + 4, P_STEPS)
set_tile(1, 17, T_CORNER0 + 5, P_BACK)
set_tile(2, 17, T_CORNER0 + 6, P_STEPS)

set_tile(17, 17, T_CORNER0 + 7, P_STEPS)
set_tile(18, 17, T_CORNER0 + 8, P_BACK)
set_tile(19, 17, T_CORNER0 + 9, P_STEPS)

# Palettes (CGB)
C_SKY = (36, 111, 238)
C_BOARD = (153, 78, 0)
C_BOARD_DARK = (96, 48, 0)
C_LIME_LIGHT = (208, 240, 152)
C_GREEN = (88, 216, 48)
C_BLUE_LIGHT = (188, 216, 255)
C_BLUE = (96, 168, 255)
C_LIME_DARK = (67, 156, 24)
C_CYAN = (60, 245, 230)
C_CYAN_DARK = (15, 110, 115)
C_LIME = (189, 242, 71)
C_WHITE = (255, 255, 255)
C_BLACK = (0, 0, 0)
C_PINK = (255, 110, 190)
C_SILVER = (180, 195, 215)

palettes = [
    # Pal 0: Sky, Cyan, Deep Cyan, Black (stepped corner blocks)
    [C_SKY, C_CYAN, C_CYAN_DARK, C_BLACK],
    # Pal 1: white outline, light lime, green, black (bars + pillars)
    [C_WHITE, C_LIME_LIGHT, C_GREEN, C_BLACK],
    # Pal 2: Board Brown, Board Shadow, Black outline, PURE WHITE text!
    [C_BOARD, C_BOARD_DARK, C_BLACK, C_WHITE],
    # Pal 3: Black placard, Lime shadow, Black outline, Pure White text! (SETTINGS Banner)
    [C_BLACK, C_BLACK, C_BLACK, C_WHITE],
    # Pal 4: Sky, White highlight, Silver link, Black outline (Chains)
    [C_SKY, C_WHITE, C_SILVER, C_BLACK],
    # Pal 5: Sky, White, Pink, Black (Back button & stepped blocks)
    [C_SKY, C_WHITE, C_PINK, C_BLACK],
    # Pal 6: Reserved
    [C_SKY, C_CYAN, C_LIME, C_BLACK],
    # Pal 7: white outline, light blue, blue, black (corner squares, centre plate)
    [C_WHITE, C_BLUE_LIGHT, C_BLUE, C_BLACK],
]

# Write include/settings_bg.h
h_code = f"""#ifndef SETTINGS_BG_H
#define SETTINGS_BG_H

#include <stdint.h>
#include <gb/gb.h>
#include <gb/cgb.h>

#define SETTINGS_BG_TILE_COUNT {len(unique_tiles)}
#define SETTINGS_BG_WIDTH 20
#define SETTINGS_BG_HEIGHT 18
#define SETTINGS_BOARD_BLANK_TILE 0

extern const palette_color_t settings_bg_palettes[32];
extern const uint8_t settings_bg_tiles[{len(unique_tiles) * 16}];
extern const unsigned char settings_bg_map[360];
extern const unsigned char settings_bg_attributes[360];

#endif
"""
with open('include/settings_bg.h', 'w') as f:
    f.write(h_code)

# Write src/graphics/settings_bg.c
c_lines = []
c_lines.append('#pragma bank 28\n')
c_lines.append('#include "settings_bg.h"\n')
c_lines.append('BANKREF(settings_bg)\n')

c_lines.append('const palette_color_t settings_bg_palettes[32] = {')
for p in palettes:
    c_lines.append('    ' + ', '.join(f'RGB8({c[0]}, {c[1]}, {c[2]})' for c in p) + ',')
c_lines.append('};\n')

c_lines.append(f'const uint8_t settings_bg_tiles[{len(unique_tiles) * 16}] = {{')
for i, t in enumerate(unique_tiles):
    hex_str = ', '.join(f'0x{b:02X}' for b in t)
    c_lines.append(f'    {hex_str}, // Tile {i}')
c_lines.append('};\n')

c_lines.append('const unsigned char settings_bg_map[360] = {')
for r in range(18):
    row_bytes = tile_map[r*20 : (r+1)*20]
    hex_str = ', '.join(f'0x{b:02X}' for b in row_bytes)
    c_lines.append(f'    {hex_str}, // Row {r}')
c_lines.append('};\n')

c_lines.append('const unsigned char settings_bg_attributes[360] = {')
for r in range(18):
    row_attrs = attr_map[r*20 : (r+1)*20]
    hex_str = ', '.join(f'0x{b:02X}' for b in row_attrs)
    c_lines.append(f'    {hex_str}, // Row {r}')
c_lines.append('};\n')

with open('src/graphics/settings_bg.c', 'w') as f:
    f.write('\n'.join(c_lines))

print('Wrote settings_bg.h and settings_bg.c successfully!')
