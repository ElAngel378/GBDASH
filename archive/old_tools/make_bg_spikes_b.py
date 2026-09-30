"""Builds levels/chr_data/famidash/xstep_bgspikes_b_tiles.bin: Famidash's SPIKESB art for the
background-spike metatiles (BOTTOM_/TOP_BACKGROUND_SPIKES) in Pocket Dash's tile numbering.

Famidash lets every level pick a spike set (A/B/C). Xstep uses B, where the background
spikes are round bushes; Pocket Dash only has set A's silhouettes. The raw NES colour
indices are used as they are: with the metatiles' palette 2 they mean
0 = sky, 1 = darker sky, 2 = black, 3 = green, the same as on the NES.

Output order (tile id in the GB tile sheet <- NES tile of SpikesB.chr):
  0  <- 0x0C (BOTTOM_BACKGROUND_SPIKES top-left; the GB sheet has it as blank tile 12)
  1  <- 0x1E (TOP_BACKGROUND_SPIKES bottom-left; also blank tile 12 in the GB sheet)
  23 <- 0x0D    24 <- 0x0E    25 <- 0x0F
  37 <- 0x1C    38 <- 0x1D    39 <- 0x1F
"""
from pathlib import Path
import argparse

ORDER = [0x0C, 0x1E, 0x0D, 0x0E, 0x0F, 0x1C, 0x1D, 0x1F]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--famidash", default=r"C:\Users\soter\Source\Repos\famidash-main")
    args = ap.parse_args()
    chr_data = (Path(args.famidash) / "GRAPHICS" / "Level Tiles" / "SpikesB.chr").read_bytes()
    out = bytearray()
    for t in ORDER:  # first 1KB bank (frame 0) of the set
        for row in range(8):
            out.append(chr_data[t * 16 + row])
            out.append(chr_data[t * 16 + 8 + row])
    dst = Path(__file__).resolve().parent.parent / "levels/chr_data/famidash/xstep_bgspikes_b_tiles.bin"
    dst.write_bytes(out)
    print("wrote", dst, len(out), "bytes")


if __name__ == "__main__":
    main()
