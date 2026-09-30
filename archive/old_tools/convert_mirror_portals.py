import os
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
INPUT_CHR = REPO_ROOT / "archive" / "raw_assets" / "time machine portals.chr"
OUTPUT_BIN = REPO_ROOT / "levels" / "chr_data" / "mirror_portals.bin"

def nes_to_gb_tile(tile_bytes, remap_3_to_2=False):
    gb_tile = bytearray(16)
    for y in range(8):
        b1 = tile_bytes[y]
        b2 = tile_bytes[y + 8]
        if remap_3_to_2:
            b1 = b1 & ~b2
        gb_tile[y * 2] = b1
        gb_tile[y * 2 + 1] = b2
    return bytes(gb_tile)

def convert_portals(chr_path=INPUT_CHR, out_bin=OUTPUT_BIN):
    if not os.path.exists(chr_path):
        print(f"Error: {chr_path} not found.")
        sys.exit(1)

    with open(chr_path, 'rb') as f:
        chr_data = f.read()

    def get_tile(ty, tx, remap=False):
        idx = ty * 16 + tx
        return nes_to_gb_tile(chr_data[idx * 16 : (idx + 1) * 16], remap_3_to_2=remap)

    # Portal 1 (Entrance, Blue) - 8 8x16 sprites = 16 8x8 tiles (256 bytes)
    p1_tiles = bytearray()
    for tx in range(3, 7): # Top row of 8x16 sprites
        p1_tiles.extend(get_tile(5, tx, remap=False))
        p1_tiles.extend(get_tile(6, tx, remap=False))
    for tx in range(3, 7): # Bottom row of 8x16 sprites
        p1_tiles.extend(get_tile(7, tx, remap=False))
        p1_tiles.extend(get_tile(8, tx, remap=False))

    # Portal 2 (Exit, Gold) - 8 8x16 sprites = 16 8x8 tiles (256 bytes)
    p2_tiles = bytearray()
    for tx in range(8, 12): # Top row of 8x16 sprites
        p2_tiles.extend(get_tile(5, tx, remap=True))
        p2_tiles.extend(get_tile(6, tx, remap=True))
    for tx in range(8, 12): # Bottom row of 8x16 sprites
        p2_tiles.extend(get_tile(7, tx, remap=True))
        p2_tiles.extend(get_tile(8, tx, remap=True))

    out_data = p1_tiles + p2_tiles
    os.makedirs(out_bin.parent, exist_ok=True)
    with open(out_bin, 'wb') as f:
        f.write(out_data)

    print(f"Successfully converted {chr_path} -> {out_bin} ({len(out_data)} bytes, {len(out_data)//16} tiles)")

if __name__ == "__main__":
    convert_portals()
