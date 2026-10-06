"""Builds the graphics and tilemaps for the Icon Select screen from mockup image.
Generates:
  - include/icon_select_bg.h
  - src/graphics/icon_select_bg.c
"""
from pathlib import Path
from PIL import Image
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
MOCKUP = Path(r"C:/Users/soter/.gemini/antigravity/brain/5e74c28b-8bc8-4866-abd2-7e8be4ec6a0e/.user_uploaded/media_1791294618274.png")

def quantize(val):
    if val > 200: return 0  # White
    if val > 140: return 1  # Light grey
    if val > 50: return 2   # Dark grey
    return 3               # Black

def main():
    img = Image.open(MOCKUP).convert('L')
    arr = np.array(img)
    qarr = np.vectorize(quantize)(arr)

    # 1. Build Background Tiles & Map (20x18 grid)
    tile_dict = {}
    tile_list = []
    tile_map = np.zeros((18, 20), dtype=int)

    for r in range(18):
        for c in range(20):
            t = qarr[r*8:(r+1)*8, c*8:(c+1)*8]
            b = bytearray()
            for y in range(8):
                low = 0
                high = 0
                for x in range(8):
                    pix = t[y, x]
                    low = (low << 1) | (pix & 1)
                    high = (high << 1) | ((pix >> 1) & 1)
                b.append(low)
                b.append(high)
            tb = bytes(b)
            if tb not in tile_dict:
                tile_dict[tb] = len(tile_list)
                tile_list.append(tb)
            tile_map[r, c] = tile_dict[tb]

    num_bg_tiles = len(tile_list)
    print(f"Generated {num_bg_tiles} unique background tiles")

    # 2. Build CGB Attribute Map (20x18 grid)
    # Pal 0: General UI
    # Pal 1: Preview box (cols 7..12, rows 2..6)
    # Pal 2: Gamemode row (rows 8..9)
    # Pal 3: Carousel (rows 10..12)
    # Pal 4: Primary swatches (rows 14..15)
    # Pal 5: Secondary swatches (rows 16..17)
    attr_map = np.zeros((18, 20), dtype=int)
    for r in range(18):
        for c in range(20):
            if 2 <= r <= 6 and 7 <= c <= 12:
                attr_map[r, c] = 1
            elif 8 <= r <= 9:
                attr_map[r, c] = 2
            elif 10 <= r <= 12:
                attr_map[r, c] = 3
            elif 14 <= r <= 15:
                attr_map[r, c] = 4
            elif 16 <= r <= 17:
                attr_map[r, c] = 5
            else:
                attr_map[r, c] = 0

    # 3. Build Sprite Cursor Tiles
    spr_tiles = []
    # Tile 0: TL bracket
    tl = bytearray(16)
    tl_art = [0b11110000, 0b11110000, 0b11000000, 0b11000000, 0, 0, 0, 0]
    for y in range(8):
        tl[y*2] = tl_art[y]
        tl[y*2 + 1] = tl_art[y]
    spr_tiles.append(bytes(tl))

    # Tile 1: TR bracket
    tr = bytearray(16)
    tr_art = [0b00001111, 0b00001111, 0b00000011, 0b00000011, 0, 0, 0, 0]
    for y in range(8):
        tr[y*2] = tr_art[y]
        tr[y*2 + 1] = tr_art[y]
    spr_tiles.append(bytes(tr))

    # Tile 2: BL bracket
    bl = bytearray(16)
    bl_art = [0, 0, 0, 0, 0b11000000, 0b11000000, 0b11110000, 0b11110000]
    for y in range(8):
        bl[y*2] = bl_art[y]
        bl[y*2 + 1] = bl_art[y]
    spr_tiles.append(bytes(bl))

    # Tile 3: BR bracket
    br = bytearray(16)
    br_art = [0, 0, 0, 0, 0b00000011, 0b00000011, 0b00001111, 0b00001111]
    for y in range(8):
        br[y*2] = br_art[y]
        br[y*2 + 1] = br_art[y]
    spr_tiles.append(bytes(br))

    # Tile 4: Down-pointer arrow for Gamemode tabs (8x8)
    arr_down = bytearray(16)
    arr_down_art = [
        0b00000000,
        0b11111110,
        0b01111100,
        0b00111000,
        0b00010000,
        0b00000000,
        0b00000000,
        0b00000000,
    ]
    for y in range(8):
        arr_down[y*2] = arr_down_art[y]
        arr_down[y*2 + 1] = arr_down_art[y]
    spr_tiles.append(bytes(arr_down))

    # Write include/icon_select_bg.h
    h_bg = [
        "#ifndef ICON_SELECT_BG_H",
        "#define ICON_SELECT_BG_H",
        "",
        "#include <stdint.h>",
        "#include <gbdk/platform.h>",
        "",
        f"#define ICON_SELECT_BG_TILE_COUNT {num_bg_tiles}",
        "#define ICON_SELECT_BG_MAP_WIDTH 20",
        "#define ICON_SELECT_BG_MAP_HEIGHT 18",
        f"#define ICON_SELECT_SPR_TILE_COUNT {len(spr_tiles)}",
        "",
        "BANKREF_EXTERN(icon_select_bg)",
        "extern const uint8_t icon_select_bg_tiles[];",
        "extern const uint8_t icon_select_bg_map[];",
        "extern const uint8_t icon_select_bg_attrmap[];",
        "extern const uint8_t icon_select_spr_tiles[];",
        "",
        "#endif // ICON_SELECT_BG_H",
        ""
    ]
    (ROOT / "include" / "icon_select_bg.h").write_text("\n".join(h_bg))

    # Write src/graphics/icon_select_bg.c
    c_bg = [
        "#pragma bank 24",
        "",
        '#include "icon_select_bg.h"',
        "",
        "BANKREF(icon_select_bg)",
        "",
        f"const uint8_t icon_select_bg_tiles[{num_bg_tiles * 16}] = {{"
    ]
    for idx, tb in enumerate(tile_list):
        hex_vals = ", ".join(f"0x{b:02X}" for b in tb)
        c_bg.append(f"    {hex_vals}, // Tile {idx}")
    c_bg.append("};")
    c_bg.append("")

    c_bg.append(f"const uint8_t icon_select_bg_map[20 * 18] = {{")
    for r in range(18):
        hex_row = ", ".join(f"0x{tile_map[r, c]:02X}" for c in range(20))
        c_bg.append(f"    {hex_row}, // Row {r}")
    c_bg.append("};")
    c_bg.append("")

    c_bg.append(f"const uint8_t icon_select_bg_attrmap[20 * 18] = {{")
    for r in range(18):
        hex_row = ", ".join(f"0x{attr_map[r, c]:02X}" for c in range(20))
        c_bg.append(f"    {hex_row}, // Row {r}")
    c_bg.append("};")
    c_bg.append("")

    c_bg.append(f"const uint8_t icon_select_spr_tiles[{len(spr_tiles) * 16}] = {{")
    for idx, sb in enumerate(spr_tiles):
        hex_vals = ", ".join(f"0x{b:02X}" for b in sb)
        c_bg.append(f"    {hex_vals}, // Spr Tile {idx}")
    c_bg.append("};")
    c_bg.append("")
    (ROOT / "src" / "graphics" / "icon_select_bg.c").write_text("\n".join(c_bg))

    print("Successfully updated icon_select_bg.h and icon_select_bg.c with attribute map")

if __name__ == "__main__":
    main()
