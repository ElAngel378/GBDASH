# fd/famidash-main/SPRITES/famidash_sprites2gbdk.py
import argparse
import struct
from pathlib import Path
from PIL import Image

NES_TILE_SIZE = 8
GB_TILE_SIZE = 8
NES_CHR_BANK_SIZE = 8192  # 256 tiles * 32 bytes


def quantize_to_gameboy(image):
    palette = [
        (255, 255, 255),
        (170, 170, 170),
        (85, 85, 85),
        (0, 0, 0),
    ]
    out = Image.new("RGBA", image.size)
    pixels = []
    for red, green, blue, alpha in image.getdata():
        if alpha == 0:
            pixels.append((*palette[0], 255))
            continue
        luminance = int((red * 299 + green * 587 + blue * 114) / 1000)
        if luminance >= 213:
            color = palette[0]
        elif luminance >= 128:
            color = palette[1]
        elif luminance >= 43:
            color = palette[2]
        else:
            color = palette[3]
        pixels.append((*color, 255))
    out.putdata(pixels)
    return out


def load_chr_sheet(path):
    """Load a NES .chr file or PNG into a list of 8x8 tile pixel arrays."""
    path = Path(path)
    if path.suffix.lower() == ".chr":
        data = path.read_bytes()
        if len(data) % 32 != 0:
            raise ValueError(f"{path}: .chr size must be multiple of 32 bytes")
        tiles = []
        for i in range(0, len(data), 32):
            tile_data = data[i:i+32]
            pixels = []
            for y in range(8):
                low = tile_data[y]
                high = tile_data[y + 8]
                for x in range(8):
                    bit = 7 - x
                    lo = (low >> bit) & 1
                    hi = (high >> bit) & 1
                    pixels.append(lo | (hi << 1))
            tiles.append(pixels)
        return tiles
    else:
        # PNG: assume 128x128 or 256x256 sprite sheet
        img = Image.open(path).convert("RGBA")
        w, h = img.size
        if w % NES_TILE_SIZE != 0 or h % NES_TILE_SIZE != 0:
            raise ValueError(f"{path}: dimensions must be multiples of 8")
        tiles = []
        for ty in range(0, h, NES_TILE_SIZE):
            for tx in range(0, w, NES_TILE_SIZE):
                tile = img.crop((tx, ty, tx + NES_TILE_SIZE, ty + NES_TILE_SIZE))
                pixels = []
                for y in range(NES_TILE_SIZE):
                    for x in range(NES_TILE_SIZE):
                        r, g, b, a = tile.getpixel((x, y))
                        if a < 128:
                            pixels.append(0)
                        else:
                            lum = (r * 299 + g * 587 + b * 114) // 1000
                            if lum >= 213:
                                pixels.append(3)
                            elif lum >= 128:
                                pixels.append(2)
                            elif lum >= 43:
                                pixels.append(1)
                            else:
                                pixels.append(0)
                tiles.append(pixels)
        return tiles


def tiles_to_gbdk_chr(tiles):
    """Convert list of 2bpp pixel lists to GBDK 2bpp tile bytes."""
    out = bytearray()
    for pixels in tiles:
        for y in range(8):
            low = 0
            high = 0
            for x in range(8):
                val = pixels[y * 8 + x] & 3
                bit = 7 - x
                low |= (val & 1) << bit
                high |= ((val >> 1) & 1) << bit
            out.append(low)
            out.append(high)
    return out


def write_c_header(tiles, out_c, out_h, array_name="sprite_tiles"):
    guard = f"{array_name.upper()}_H"
    num_tiles = len(tiles)
    out_h.write_text(
        "\n".join([
            f"#ifndef {guard}",
            f"#define {guard}",
            "",
            '#include <stdint.h>',
            "",
            f"#define {array_name.upper()}_COUNT {num_tiles}",
            f"extern const uint8_t {array_name}[{num_tiles}][16];",
            "",
            f"#endif /* {guard} */",
            "",
        ]),
        newline="\n",
    )
    lines = [f'#include "{out_h.name}"', ""]
    lines.append(f"const uint8_t {array_name}[{num_tiles}][16] = {{")
    for i, pixels in enumerate(tiles):
        hex_bytes = ", ".join(f"0x{b:02X}" for b in tiles_to_gbdk_chr([pixels])[0:16])
        lines.append(f"    {{ {hex_bytes} }}, /* tile {i} */")
    lines.append("};")
    lines.append("")
    out_c.write_text("\n".join(lines), newline="\n")


def write_bin(tiles, out_bin):
    data = tiles_to_gbdk_chr(tiles)
    Path(out_bin).write_bytes(data)


def main():
    parser = argparse.ArgumentParser(description="Port FamiDash sprites to GBDK.")
    parser.add_argument("--input", type=Path, required=True, help="Input .chr or PNG sprite sheet")
    parser.add_argument("--out-c", type=Path, default=Path("include/famidash_sprites.c"))
    parser.add_argument("--out-h", type=Path, default=Path("include/famidash_sprites.h"))
    parser.add_argument("--out-bin", type=Path, default=Path("bin/famidash_sprites.chr"))
    parser.add_argument("--out-png", type=Path, default=Path("levels/famidash/famidash_sprites_gb.png"))
    parser.add_argument("--array-name", default="sprite_tiles")
    args = parser.parse_args()

    tiles = load_chr_sheet(args.input)

    # Create output directories
    args.out_c.parent.mkdir(parents=True, exist_ok=True)
    args.out_h.parent.mkdir(parents=True, exist_ok=True)
    args.out_bin.parent.mkdir(parents=True, exist_ok=True)
    args.out_png.parent.mkdir(parents=True, exist_ok=True)

    write_c_header(tiles, args.out_c, args.out_h, args.array_name)
    write_bin(tiles, args.out_bin)

    # Preview PNG (quantized)
    preview = Image.new("RGBA", (128, 128), (255, 255, 255, 255))
    for i, pixels in enumerate(tiles):
        tile_img = Image.new("RGBA", (8, 8), (255, 255, 255, 255))
        for y in range(8):
            for x in range(8):
                val = pixels[y * 8 + x]
                palette = [(255,255,255), (170,170,170), (85,85,85), (0,0,0)]
                tile_img.putpixel((x, y), palette[val])
        tx = (i % 16) * 8
        ty = (i // 16) * 8
        preview.paste(tile_img, (tx, ty))
    preview.save(args.out_png)

    print(f"Converted {len(tiles)} sprite tiles")
    print(f"- {args.out_c}")
    print(f"- {args.out_h}")
    print(f"- {args.out_bin}")
    print(f"- {args.out_png}")

if __name__ == "__main__":
    main()