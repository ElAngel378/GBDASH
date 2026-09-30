"""Builds the sprite tile bins for Famidash 1.4 objects from Famidash's CHR banks.

levels/chr_data/famidash/mini_player_tiles.bin  (10 tiles, VRAM bank 0 tiles 116..125)
    8x16 pairs, image in the top 8x8 tile:
    cube 0deg, cube 22deg, cube 45deg (67deg = 22deg mirrored), ship, ball
    Colours remapped from Famidash's icon palette (1 = outline, 2 = colour 1,
    3 = colour 2) to the Pocket Dash player palette (3 = black, 2 = lime, 1 = cyan).
levels/chr_data/famidash/mini_portal_tiles.bin  (10 tiles, VRAM bank 0: 126,127, 248..255)
    Mini / growth portal, bankmain.chr tiles 0x00..0x09 (NES 8x16 pairs $81..$89).
levels/chr_data/famidash/coin_tiles.bin         (16 tiles, CGB VRAM bank 1 tiles 200..215)
    Coin spin frames (bankmain $AF,$B1,$B3,$B5) then the "already collected" coin
    frames (deco bank $C1,$C3,$C5,$C7).

usage: python tools/make_mini_tiles.py [--famidash PATH]
"""
import argparse
from pathlib import Path


def nes_tile(chr_data, t):
    """-> list of 8 rows of 8 colour indices"""
    return [[((chr_data[t * 16 + r] >> (7 - x)) & 1) | (((chr_data[t * 16 + 8 + r] >> (7 - x)) & 1) << 1)
             for x in range(8)] for r in range(8)]


def gb_bytes(rows):
    out = bytearray()
    for row in rows:
        b0 = b1 = 0
        for v in row:
            b0 = (b0 << 1) | (v & 1)
            b1 = (b1 << 1) | ((v >> 1) & 1)
        out += bytes([b0, b1])
    return bytes(out)


BLANK = [[0] * 8 for _ in range(8)]
PLAYER_REMAP = [0, 3, 2, 1]


def remap(rows, m):
    return [[m[v] for v in row] for row in rows]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--famidash", default=r"C:\Users\soter\Source\Repos\famidash-main")
    args = ap.parse_args()
    g = Path(args.famidash) / "GRAPHICS"
    icon = (g / "Icons" / "bankicon00.chr").read_bytes()
    gm_a = (g / "Gamemode" / "bankgamemodesA.chr").read_bytes()
    gm_b = (g / "Gamemode" / "bankgamemodesB.chr").read_bytes()
    main_chr = (g / "Level Sprites" / "bankmain.chr").read_bytes()
    deco_chr = (g / "Level Sprites" / "bankblank.chr").read_bytes()
    out_dir = Path(__file__).resolve().parent.parent / "levels" / "chr_data" / "famidash"

    player = bytearray()
    for src, t, vflip in ((icon, 0x35, False), (icon, 0x37, False), (icon, 0x39, False),
                          (gm_b, 0x01, False), (gm_a, 0x3D, True)):
        img = remap(nes_tile(src, t), PLAYER_REMAP)
        if vflip:  # Famidash draws the mini ball with OAM_FLIP_V
            img = img[::-1]
        player += gb_bytes(img) + gb_bytes(BLANK)
    (out_dir / "mini_player_tiles.bin").write_bytes(player)

    portal = bytearray()
    for t in range(10):
        portal += gb_bytes(nes_tile(main_chr, t))
    (out_dir / "mini_portal_tiles.bin").write_bytes(portal)

    coins = bytearray()
    for t in range(0x2E, 0x36):
        coins += gb_bytes(nes_tile(main_chr, t))
    for t in range(0x00, 0x08):
        coins += gb_bytes(nes_tile(deco_chr, t))
    (out_dir / "coin_tiles.bin").write_bytes(coins)
    print("wrote mini_player_tiles.bin (%d), mini_portal_tiles.bin (%d), coin_tiles.bin (%d)"
          % (len(player), len(portal), len(coins)))


if __name__ == "__main__":
    main()
