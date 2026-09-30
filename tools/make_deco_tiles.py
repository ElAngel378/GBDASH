"""Builds the CGB level-deco sprite tile bins from Famidash's sprite CHR banks.

Famidash picks the look of the level decorations (chains, lights, ground spikes,
diamonds ...) per level via a "deco type": DECO1 = bankblank.chr, DECOCLOUD =
bankblankcloud.chr (ground "spikes" become round bushes). Pocket Dash ships one
bin per deco type; gameplay loads the one the level uses.

usage: python tools/make_deco_tiles.py [--famidash PATH]
       (no other arguments: rewrites both bins; DECO1 must match the existing bin)
"""
import argparse
from pathlib import Path

# Sprite tile numbers of the deco objects, in the order of include/famidash_sprites.h
# (D_CF = 0, D_C9 = 2, ...). Each is an 8x16 sprite: NES tiles (n-1, n) of the bank
# that sits at tile numbers 0xC0..0xFF.
DECO_SPRITES = [0xCF, 0xC9, 0xCB, 0xCD, 0xD5, 0xD7, 0xD9, 0xDB, 0xDD, 0xDF,
                0xE1, 0xE3, 0xE5, 0xE7, 0xED, 0xF5, 0xF1, 0xF7]


def nes_to_gb_tile(chr_data, tile):
    out = bytearray()
    base = tile * 16
    for row in range(8):
        out.append(chr_data[base + row])
        out.append(chr_data[base + 8 + row])
    return bytes(out)


def build(chr_path):
    data = Path(chr_path).read_bytes()
    assert len(data) == 1024, chr_path
    out = bytearray()
    for n in DECO_SPRITES:
        top = n - 1 - 0xC0
        bottom = n - 0xC0
        out += nes_to_gb_tile(data, top)
        out += nes_to_gb_tile(data, bottom)
    return bytes(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--famidash", default=r"C:\Users\soter\Source\Repos\famidash-main")
    args = ap.parse_args()
    root = Path(__file__).resolve().parent.parent
    sprites = Path(args.famidash) / "GRAPHICS" / "Level Sprites"
    out_dir = root / "levels" / "chr_data" / "famidash"

    deco1 = build(sprites / "bankblank.chr")
    existing = (out_dir / "famidash_deco_cgb_tiles.bin").read_bytes()
    if deco1 != existing:
        diff = [i for i in range(len(existing)) if existing[i] != deco1[i]]
        print("WARNING: DECO1 rebuild differs from the existing bin in", len(diff), "bytes (tiles",
              sorted({i // 16 for i in diff}), ") - left the existing bin untouched")
    cloud = build(sprites / "bankblankcloud.chr")
    (out_dir / "famidash_deco_cloud_cgb_tiles.bin").write_bytes(cloud)
    print("wrote famidash_deco_cloud_cgb_tiles.bin,", len(cloud), "bytes")


if __name__ == "__main__":
    main()
