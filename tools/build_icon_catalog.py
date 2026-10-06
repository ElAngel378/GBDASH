"""Builds icon catalog and preview tile definitions for all 7 icons.
Generates:
  - include/icon_catalog.h
  - src/graphics/icon_catalog.c
"""
from pathlib import Path
from PIL import Image
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
MOCKUP = Path(r"C:/Users/soter/.gemini/antigravity/brain/5e74c28b-8bc8-4866-abd2-7e8be4ec6a0e/.user_uploaded/media_1791294618274.png")

def quantize(val):
    if val > 200: return 0  # White
    if val > 140: return 1  # Light grey (Secondary color)
    if val > 50: return 2   # Dark grey (Primary color)
    return 3               # Black (Outline)

def main():
    img = Image.open(MOCKUP).convert('L')
    arr = np.array(img)
    qarr = np.vectorize(quantize)(arr)

    # 1. Extract the 7 icons from the carousel (Y: 86..100, X: 18 + i*17)
    # Each is 15x15
    icons_15 = []
    for i in range(7):
        x0 = 18 + i * 17
        icon_crop = qarr[86:101, x0:x0+15]
        icons_15.append(icon_crop)

    # 2. Extract preview box from mockup for Icon 0 (Y: 17..54, X: 61..98 -> 38x38)
    # Preview box is at Cols 7..12, Rows 2..6 in 8x8 tiles (6 cols x 5 rows)
    # Let's inspect the 19 preview tiles used by Icon 0 in the mockup
    # Notice: the preview box in mockup spans:
    # y: 16..55 (5 rows: 2, 3, 4, 5, 6)
    # x: 56..103 (6 cols: 7, 8, 9, 10, 11, 12)
    # Top-left of the 38x38 box is at (x=61, y=17)
    # So relative to (x=56, y=16), it is offset by dx=5, dy=1!

    # For each icon, we can generate a 48x40 pixel canvas (6 cols x 5 rows of 8x8 tiles)
    # where the 38x38 preview box is placed at (dx=5, dy=1).
    # Inside the 38x38 box:
    # Outer frame: 2px black, 5px primary color, 2px black.
    # Center: 24x24 px.
    # For icon i: the center 24x24 can be the inner 12x12 of the icon scaled 2x,
    # OR the 15x15 icon scaled 2x to 30x30 inside a 34x34 window!

    # Let's create the 19 tiles for each icon!
    # For Icon 0, we can take the exact tiles from the mockup!
    # For Icons 1..6, we render their 2x scaled representation inside the exact same frame!
    preview_tile_sets = []

    # Get the exact 19 tiles of Icon 0 from the mockup:
    # We load them from icon_select_bg_tiles (tiles 1..19)
    # In icon_select_bg_map, the preview positions are:
    # rows 2..6, cols 7..12.
    # Let's find which tile ID is at each position for Icon 0:
    # We know the map IDs are:
    # Row 2: [ 1,  2,  3,  3,  3,  4]
    # Row 3: [ 5,  6,  7,  8,  9, 10]
    # Row 4: [ 5,  6, 11, 12, 13, 10]
    # Row 5: [ 5,  6, 14,  8, 15, 10]
    # Row 6: [16, 17, 18, 18, 18, 19]

    # Tile 0 is background (white).
    # Tiles 1..19 are the 19 preview tiles for Icon 0.
    # Notice:
    # Frame tiles (shared by all icons):
    # Top row: 1, 2, 3, 4
    # Bottom row: 16, 17, 18, 19
    # Left border: 5
    # Right border: 10
    # Left inner edge: 6
    # Center dynamic tiles (inner icon):
    # 7, 8, 9, 11, 12, 13, 14, 15!
    # Only 8 tiles in the center actually change between icons!
    # Or we can generate all 19 tiles for each icon.

    # Let's generate a full 48x40 canvas for each icon:
    all_icon_previews = []

    for idx, ic in enumerate(icons_15):
        canvas = np.zeros((40, 48), dtype=int) # all 0 (white)
        # 38x38 box at (x=5, y=1)
        # Draw outer 2px black border:
        canvas[1:39, 5:43] = 3 # black
        # Draw 5px primary border (shade 2):
        canvas[3:37, 7:41] = 2 # primary
        # Draw 2px inner black border:
        canvas[8:32, 12:36] = 3 # black
        # Inside center 24x24 at (x=14..37, y=10..33):
        # Scale the 12x12 inner region of icon (x: 1..13, y: 1..13) 2x:
        inner = ic[1:13, 1:13]
        inner_2x = np.repeat(np.repeat(inner, 2, axis=0), 2, axis=1) # 24x24
        canvas[9:33, 13:37] = inner_2x

        # If idx == 0, use the exact mockup pixels for 100% pixel fidelity
        if idx == 0:
            canvas = qarr[16:56, 56:104].copy()

        # Extract the 6 cols x 5 rows of 8x8 tiles:
        # And map them to the 19 unique tiles corresponding to the tile map:
        # Map:
        # r=0: [ 1,  2,  3,  3,  3,  4]
        # r=1: [ 5,  6,  7,  8,  9, 10]
        # r=2: [ 5,  6, 11, 12, 13, 10]
        # r=3: [ 5,  6, 14,  8, 15, 10]
        # r=4: [16, 17, 18, 18, 18, 19]
        tile_map_pos = [
            (0,0, 1), (0,1, 2), (0,2, 3), (0,5, 4),
            (1,0, 5), (1,1, 6), (1,2, 7), (1,3, 8), (1,4, 9), (1,5, 10),
            (2,2, 11), (2,3, 12), (2,4, 13),
            (3,2, 14), (3,4, 15),
            (4,0, 16), (4,1, 17), (4,2, 18), (4,5, 19)
        ]
        # We produce 19 tiles (1..19)
        icon_tiles = [None] * 20 # 1-indexed, 1..19
        for tr, tc, tid in tile_map_pos:
            t = canvas[tr*8:(tr+1)*8, tc*8:(tc+1)*8]
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
            icon_tiles[tid] = bytes(b)

        # Flatten tiles 1..19 into bytearray
        blob = bytearray()
        for tid in range(1, 20):
            blob.extend(icon_tiles[tid])
        all_icon_previews.append(blob)

    # 3. Generate Header and C file
    h_out = [
        "#ifndef ICON_CATALOG_H",
        "#define ICON_CATALOG_H",
        "",
        "#include <stdint.h>",
        "#include <gbdk/platform.h>",
        "#include <gb/cgb.h>",
        "",
        "#define NUM_CUBE_ICONS 7",
        "#define NUM_GAMEMODE_TABS 7",
        "#define NUM_PALETTE_COLORS 12",
        "#define PREVIEW_TILE_BASE 1",
        "#define PREVIEW_TILE_COUNT 19",
        "",
        "// Available colors in RGB555 for CGB",
        "extern const palette_color_t icon_palette_colors[NUM_PALETTE_COLORS];",
        "// Available colors in DMG shade index (0..3)",
        "extern const uint8_t icon_dmg_shades[NUM_PALETTE_COLORS];",
        "",
        "// Pre-rendered 19 preview tiles for each of the 7 icons",
        "BANKREF_EXTERN(icon_catalog)",
        "extern const uint8_t icon_preview_tiles[NUM_CUBE_ICONS][PREVIEW_TILE_COUNT * 16];",
        "",
        "#endif // ICON_CATALOG_H",
        ""
    ]
    (ROOT / "include" / "icon_catalog.h").write_text("\n".join(h_out))

    c_out = [
        "#pragma bank 24",
        "",
        '#include "icon_catalog.h"',
        "",
        "BANKREF(icon_catalog)",
        "",
        "const palette_color_t icon_palette_colors[NUM_PALETTE_COLORS] = {",
        "    RGB8(  0, 255,   0), // 0: Green",
        "    RGB8(  0, 240, 255), // 1: Cyan",
        "    RGB8(  0, 110, 255), // 2: Blue",
        "    RGB8(160,  30, 255), // 3: Purple",
        "    RGB8(255,   0, 200), // 4: Magenta / Pink",
        "    RGB8(255,  30,  30), // 5: Red",
        "    RGB8(255, 120,   0), // 6: Orange",
        "    RGB8(255, 230,   0), // 7: Yellow",
        "    RGB8(180, 255,   0), // 8: Lime",
        "    RGB8(255, 255, 255), // 9: White",
        "    RGB8(160, 160, 160), // 10: Light Gray",
        "    RGB8( 60,  60,  60)  // 11: Dark Gray",
        "};",
        "",
        "const uint8_t icon_dmg_shades[NUM_PALETTE_COLORS] = {",
        "    1, 1, 2, 2, 1, 2, 2, 0, 0, 0, 1, 2",
        "};",
        "",
        f"const uint8_t icon_preview_tiles[NUM_CUBE_ICONS][PREVIEW_TILE_COUNT * 16] = {{"
    ]

    for idx, blob in enumerate(all_icon_previews):
        c_out.append(f"    // Icon {idx} Preview Tiles")
        c_out.append("    {")
        # Format in 16-byte chunks (1 tile per line)
        for t in range(19):
            chunk = blob[t*16:(t+1)*16]
            hex_str = ", ".join(f"0x{b:02X}" for b in chunk)
            c_out.append(f"        {hex_str}, // Preview Tile {t+1}")
        c_out.append("    },")
    c_out.append("};")
    c_out.append("")

    (ROOT / "src" / "graphics" / "icon_catalog.c").write_text("\n".join(c_out))
    print("Successfully generated icon_catalog.h and icon_catalog.c")

if __name__ == "__main__":
    main()
