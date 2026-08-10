"""Convert NES 2bpp CHR tiles to Game Boy 2bpp tile data."""

from pathlib import Path
import argparse


def convert_chr(path: Path) -> bytes:
    data = path.read_bytes()
    if len(data) % 16:
        raise ValueError(f"{path} is not aligned to complete NES tiles")

    output = bytearray()
    for tile in range(len(data) // 16):
        base = tile * 16
        for row in range(8):
            # NES stores both bitplanes separately; GB interleaves them per row.
            output.append(data[base + row])
            output.append(data[base + 8 + row])
    return bytes(output)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("portals", type=Path)
    parser.add_argument("main", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()

    portals = convert_chr(args.portals)
    main_bank = convert_chr(args.main)
    if len(portals) != 1024 or len(main_bank) != 1024:
        raise ValueError("level sprite CHR banks must each contain 64 tiles")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(portals + main_bank)


if __name__ == "__main__":
    main()
