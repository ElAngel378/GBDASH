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

# 2. Continuous chain link tiles (8x8):
# Palette 4: Color 0: Sky, Color 1: Silver/White, Color 2: Dark Gray, Color 3: Black
# Chain Tile A (Row 0):
# Row 0: ...##... (b0=0x18, b1=0x18)
# Row 1: ..####.. (b0=0x3C, b1=0x3C)
# Row 2: .#WWWW#. (b0=0x7E, b1=0x42)
# Row 3: .#W..G#. (b0=0x66, b1=0x42)
# Row 4: .#W..G#. (b0=0x66, b1=0x42)
# Row 5: .#W..G#. (b0=0x66, b1=0x42)
# Row 6: .#WWWW#. (b0=0x7E, b1=0x42)
# Row 7: ..####.. (b0=0x3C, b1=0x3C)
chain_tile_a = (
    0x18, 0x18,
    0x3C, 0x3C,
    0x7E, 0x42,
    0x66, 0x42,
    0x66, 0x42,
    0x66, 0x42,
    0x7E, 0x42,
    0x3C, 0x3C
)

# Chain Tile B (Row 1): interlocking link
chain_tile_b = (
    0x18, 0x18,
    0x3C, 0x24,
    0x3C, 0x24,
    0x3C, 0x24,
    0x3C, 0x24,
    0x7E, 0x42,
    0x7E, 0x42,
    0x3C, 0x3C
)

# Top Bar Chain Bracket tile (Row 2, Col 4 & 15):
# Top has the chain anchor, bottom has the green lime bar
chain_tile_mount = (
    0x3C, 0x3C,
    0x3C, 0x24,
    0xFF, 0x80, # Lime bar with top black border
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x80  # Bottom black border
)

# 3. Top Banner and Frame tiles
# Lime Top Bar tile (Row 2, Cols 3, 5, 14, 16):
tile_top_lime = (
    0xFF, 0x80, # Black top border
    0xFF, 0x00, # Lime fill
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x80  # Black bottom border
)

# Corner Bracket Left (Row 2, Col 2):
# Cyan block with white corner highlight
tile_bracket_tl = (
    0xFF, 0xFF,
    0xFF, 0x81,
    0xFF, 0x01,
    0xFF, 0x01,
    0xFF, 0x01,
    0xFF, 0x01,
    0xFF, 0x81,
    0xFF, 0xFF
)

# Corner Bracket Right (Row 2, Col 17):
tile_bracket_tr = (
    0xFF, 0xFF,
    0xFF, 0x81,
    0xFF, 0x80,
    0xFF, 0x80,
    0xFF, 0x80,
    0xFF, 0x80,
    0xFF, 0x81,
    0xFF, 0xFF
)

# Side Pillar Left (Col 2, Rows 3..13):
# 1-tile wide pillar with highlight and shadow
tile_pillar_l = (
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81,
    0xBD, 0x81
)

# Side Pillar Right (Col 17, Rows 3..13):
tile_pillar_r = (
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81,
    0xDB, 0x81
)

# Bottom Bar Lime (Row 14, Cols 3..8, 11..16):
tile_bottom_lime = (
    0xFF, 0x80,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x00,
    0xFF, 0x80
)

# Bottom Bracket Left (Row 14, Col 2):
tile_bracket_bl = tile_bracket_tl
# Bottom Bracket Right (Row 14, Col 17):
tile_bracket_br = tile_bracket_tr

# Bottom Center Plate (Row 14, Col 9 & 10):
# Cyan plate with white center highlight
tile_bottom_plate_l = (
    0xFF, 0xFF,
    0xFF, 0x83,
    0xFF, 0x03,
    0xFF, 0x03,
    0xFF, 0x03,
    0xFF, 0x03,
    0xFF, 0x83,
    0xFF, 0xFF
)
tile_bottom_plate_r = (
    0xFF, 0xFF,
    0xFF, 0xC1,
    0xFF, 0xC0,
    0xFF, 0xC0,
    0xFF, 0xC0,
    0xFF, 0xC0,
    0xFF, 0xC1,
    0xFF, 0xFF
)

# SETTINGS banner uses authentic FontPusab tiles loaded at 0xD0
# 'S'=0xEF, 'E'=0xE1, 'T'=0xF0, 'I'=0xE5, 'N'=0xEA, 'G'=0xE3
settings_word_tiles = [0xEF, 0xE1, 0xF0, 0xF0, 0xE5, 0xEA, 0xE3, 0xEF]

# Blank tile (tile 0): all 0s (Sky on Pal 0, Board on Pal 2!)
tile_blank = tuple([0] * 16)

# Build unique tiles list:
unique_tiles = [
    tile_blank,           # 0
    chain_tile_a,         # 1
    chain_tile_b,         # 2
    chain_tile_mount,     # 3
    tile_top_lime,        # 4
    tile_bracket_tl,      # 5
    tile_bracket_tr,      # 6
    tile_pillar_l,        # 7
    tile_pillar_r,        # 8
    tile_bottom_lime,     # 9
    tile_bottom_plate_l,  # 10
    tile_bottom_plate_r,  # 11
    tile_back_0a,         # 12
    tile_back_0b,         # 13
    tile_back_0e,         # 14
    tile_back_0f,         # 15
    tile_corner_37,       # 16
    tile_corner_38,       # 17
    tile_corner_39,       # 18
    tile_corner_3a,       # 19
    tile_corner_3b,       # 20
    tile_corner_3c,       # 21
    tile_corner_3d,       # 22
    tile_corner_3e,       # 23
    tile_corner_3f,       # 24
    tile_corner_40,       # 25
]

# Build 20x18 map and attribute map
tile_map = [0] * 360
attr_map = [0] * 360

def set_tile(tx, ty, t_id, p_id):
    idx = ty * 20 + tx
    tile_map[idx] = t_id
    attr_map[idx] = p_id

# Initialize all interior to board (tile 0, pal 2)
for ty in range(3, 14):
    for tx in range(3, 17):
        set_tile(tx, ty, 0, 2)

# Chains at col 4 and 15
set_tile(4, 0, 1, 4)
set_tile(4, 1, 2, 4)
set_tile(4, 2, 3, 1)

set_tile(15, 0, 1, 4)
set_tile(15, 1, 2, 4)
set_tile(15, 2, 3, 1)

# Back button 2x2 at (1, 1), (2, 1), (1, 2), (2, 2)
set_tile(1, 1, 12, 5)
set_tile(2, 1, 13, 5)
set_tile(1, 2, 14, 5)
set_tile(2, 2, 15, 5)

# Top Bar (Row 2)
set_tile(2, 2, 5, 0) # bracket TL
set_tile(3, 2, 4, 1) # lime
set_tile(5, 2, 4, 1) # lime
# SETTINGS badge (cols 6..13) using Pusab font on black placard
for i in range(8):
    set_tile(6 + i, 2, settings_word_tiles[i], 3)
set_tile(14, 2, 4, 1) # lime
set_tile(16, 2, 4, 1) # lime
set_tile(17, 2, 6, 0) # bracket TR

# Side pillars (Rows 3..13)
for ty in range(3, 14):
    set_tile(2, ty, 7, 1)
    set_tile(17, ty, 8, 1)

# Bottom Bar (Row 14)
set_tile(2, 14, 5, 0) # bracket BL
for tx in range(3, 9):
    set_tile(tx, 14, 9, 1)
set_tile(9, 14, 10, 0) # center plate left
set_tile(10, 14, 11, 0) # center plate right
for tx in range(11, 17):
    set_tile(tx, 14, 9, 1)
set_tile(17, 14, 6, 0) # bracket BR

# Stepped Corner blocks from new level select:
# Row 15:
set_tile(0, 15, 16, 0)
set_tile(19, 15, 17, 0)
# Row 16:
set_tile(0, 16, 18, 5)
set_tile(19, 16, 19, 5)
# Row 17:
set_tile(0, 17, 20, 0)
set_tile(1, 17, 21, 5)
set_tile(2, 17, 22, 0)

set_tile(17, 17, 23, 0)
set_tile(18, 17, 24, 5)
set_tile(19, 17, 25, 0)

# Palettes (CGB)
C_SKY = (36, 111, 238)
C_BOARD = (138, 70, 0)
C_BOARD_DARK = (90, 45, 0)
C_LIME = (189, 242, 71)
C_LIME_DARK = (67, 156, 24)
C_CYAN = (60, 245, 230)
C_CYAN_DARK = (15, 110, 115)
C_WHITE = (255, 255, 255)
C_BLACK = (0, 0, 0)
C_PINK = (255, 110, 190)
C_SILVER = (180, 195, 215)

palettes = [
    # Pal 0: Sky, Cyan, Deep Cyan, Black (Brackets, Stepped Cyan Blocks)
    [C_SKY, C_CYAN, C_CYAN_DARK, C_BLACK],
    # Pal 1: Sky, Lime, Dark Green, Black (Frame, Pillars)
    [C_SKY, C_LIME, C_LIME_DARK, C_BLACK],
    # Pal 2: Board Brown, Board Shadow, Black outline, PURE WHITE text!
    [C_BOARD, C_BOARD_DARK, C_BLACK, C_WHITE],
    # Pal 3: Black placard, Lime shadow, Black outline, Pure White text! (SETTINGS Banner)
    [C_BLACK, C_LIME_DARK, C_BLACK, C_WHITE],
    # Pal 4: Sky, White highlight, Silver link, Black outline (Chains)
    [C_SKY, C_WHITE, C_SILVER, C_BLACK],
    # Pal 5: Sky, White, Pink, Black (Back button & Stepped green blocks)
    [C_SKY, C_WHITE, C_PINK, C_BLACK],
    # Pal 6: Sky, Cyan, Lime, Black (Bottom plate)
    [C_SKY, C_CYAN, C_LIME, C_BLACK],
    # Pal 7: Reserved
    [C_SKY, C_WHITE, C_CYAN, C_BLACK]
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
