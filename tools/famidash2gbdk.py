import argparse
import re
from pathlib import Path

from PIL import Image


METATILE_RE = re.compile(
    r'^Metatile\s+"([^"]+)",\s*'
    r'\$([0-9A-Fa-f]{2})\s*,\s*\$([0-9A-Fa-f]{2})\s*,\s*'
    r'\$([0-9A-Fa-f]{2})\s*,\s*\$([0-9A-Fa-f]{2})\s*,\s*'
    r'(PAL_\d+),\s*(COL_[A-Z0-9_]+)'
)


def parse_metatiles(path):
    metatiles = []
    for line_number, line in enumerate(path.read_text().splitlines(), start=1):
        match = METATILE_RE.match(line.strip())
        if not match:
            continue

        name, tl, tr, bl, br, palette, collision = match.groups()
        metatiles.append(
            {
                "name": name,
                "tiles": [int(tl, 16), int(tr, 16), int(bl, 16), int(br, 16)],
                "palette": int(palette[-1]),
                "collision": collision,
                "line": line_number,
            }
        )

    if len(metatiles) != 256:
        raise ValueError(f"expected 256 metatiles, got {len(metatiles)}")

    return metatiles


def c_name(name):
    out = []
    for char in name.lower():
        out.append(char if char.isalnum() else "_")
    return re.sub(r"_+", "_", "".join(out)).strip("_")


def write_metatile_files(metatiles, out_c, out_h):
    guard = "FAMIDASH_METATILES_H"
    out_h.write_text(
        "\n".join(
            [
                f"#ifndef {guard}",
                f"#define {guard}",
                "",
                "#include <stdint.h>",
                "",
                "#define FAMIDASH_NUM_METATILES 256",
                "#define NUM_METATILES FAMIDASH_NUM_METATILES",
                "",
                "extern const uint8_t metatiles[FAMIDASH_NUM_METATILES][4];",
                "extern const uint8_t famidash_metatile_palettes[FAMIDASH_NUM_METATILES];",
                "extern const uint8_t famidash_metatile_collision[FAMIDASH_NUM_METATILES];",
                "",
                "#endif /* FAMIDASH_METATILES_H */",
                "",
            ]
        ),
        newline="\n",
    )

    lines = ['#include "famidash_metatiles.h"', ""]

    for index, metatile in enumerate(metatiles):
        lines.append(f"#define FAMIDASH_MT_{c_name(metatile['name']).upper()} {index}")
    lines.append("")

    lines.append("const uint8_t metatiles[FAMIDASH_NUM_METATILES][4] = {")
    for metatile in metatiles:
        tiles = ", ".join(str(tile) for tile in metatile["tiles"])
        lines.append(f"    {{ {tiles} }}, /* {metatile['name']} */")
    lines.append("};")
    lines.append("")

    lines.append("const uint8_t famidash_metatile_palettes[FAMIDASH_NUM_METATILES] = {")
    for index in range(0, len(metatiles), 16):
        values = ", ".join(str(mt["palette"]) for mt in metatiles[index:index + 16])
        lines.append(f"    {values},")
    lines.append("};")
    lines.append("")

    lines.append("const uint8_t famidash_metatile_collision[FAMIDASH_NUM_METATILES] = {")
    for index in range(0, len(metatiles), 16):
        values = ", ".join(str(collision_value(mt["name"], mt["collision"], mt["tiles"])) for mt in metatiles[index:index + 16])
        lines.append(f"    {values},")
    lines.append("};")
    lines.append("")

    out_c.write_text("\n".join(lines), newline="\n")


def collision_value(mt_name, col_name, tiles):
    # Mapping for GBDK-specific collision IDs
    values = {
        "COL_NONE": 0x00,
        "COL_DEATH_RIGHT": 0x01,
        "COL_DEATH_LEFT": 0x02,
        "COL_DEATH_TOP": 0x03,
        "COL_DEATH_BOTTOM": 0x04,
        "COL_TOP": 0x05,
        "COL_BOTTOM": 0x06,
        "COL_ALL": 0x07,
        "COL_DEATH": 0x08,
        "COL_FLOOR_CEIL": 0x09,
        "COL_ORB": 0x0A,
        "COL_PAD": 0x0B,
        "COL_ORB_BLUE": 0x0C,
        "COL_ORB_MAGENTA": 0x0D,
        "COL_PAD_BLUE": 0x0E,
        "COL_DEATH_TOP_HALF": 0x10,
        "COL_DEATH_BOTTOM_HALF": 0x11,
    }

    mt_upper = mt_name.upper()

    # Half-tile detection: FamiDash often uses $00 (empty) for the other half
    is_bottom_half = (tiles[0] == 0 and tiles[1] == 0)
    is_top_half = (tiles[2] == 0 and tiles[3] == 0)

    # Custom overrides: FamiDash uses COL_NONE for orbs/pads because they are objects
    if "ORB_OUTLINE" in mt_upper:
        return values["COL_ORB"]
    if "PAD_UP_OUTLINE" in mt_upper:
        return values["COL_PAD"]
    if "PAD_DOWN_OUTLINE" in mt_upper:
        return values["COL_PAD"]
    if mt_upper == "FAMIDASH_MT_HALF_SPIKE_BACKGROUND":
        return values["COL_DEATH_TOP_HALF"]
    if mt_upper == "FAMIDASH_MT_HALF_SPIKE_BACKGROUND_TOP":
        return values["COL_DEATH_BOTTOM_HALF"]
    if mt_upper == "FAMIDASH_MT_PLATFORM_SPIKE":
        return values["COL_ALL"]

    if "SPIKE" in mt_upper or "SAW" in mt_upper:
        if is_bottom_half:
            return values["COL_DEATH_TOP_HALF"]
        if is_top_half:
            return values["COL_DEATH_BOTTOM_HALF"]

    if col_name in values:
        return values[col_name]
    if col_name.startswith("COL_"):
        return 0x80
    return 0


def reconstruct_chr_sheet(metatiles, source_image, out_image):
    source = Image.open(source_image).convert("RGBA")
    if source.size != (256, 256):
        raise ValueError(f"{source_image} must be 256x256")

    output = Image.new("RGBA", (128, 128), (255, 255, 255, 255))
    tile_sources = {}

    for metatile_id, metatile in enumerate(metatiles):
        mt_x = (metatile_id % 16) * 16
        mt_y = (metatile_id // 16) * 16
        boxes = [
            (mt_x, mt_y, mt_x + 8, mt_y + 8),
            (mt_x + 8, mt_y, mt_x + 16, mt_y + 8),
            (mt_x, mt_y + 8, mt_x + 8, mt_y + 16),
            (mt_x + 8, mt_y + 8, mt_x + 16, mt_y + 16),
        ]

        for tile_id, box in zip(metatile["tiles"], boxes):
            tile = source.crop(box)
            dst = ((tile_id % 16) * 8, (tile_id // 16) * 8)
            previous = tile_sources.get(tile_id)
            if previous is None:
                tile_sources[tile_id] = tile
                output.paste(tile, dst)
            elif list(previous.getdata()) != list(tile.getdata()):
                # FamiDash can reuse a tile index for different palette contexts.
                # Keep the first graphic so IDs remain stable.
                continue

    out_image.parent.mkdir(parents=True, exist_ok=True)
    output.save(out_image)

    gb_output = quantize_to_gameboy(output)
    gb_path = out_image.with_name(out_image.stem + "_gb.png")
    gb_output.save(gb_path)


def main():
    parser = argparse.ArgumentParser(description="Port FamiDash metatiles to GBDK data.")
    parser.add_argument("--metatiles", type=Path, default=Path("fd/famidash-main/METATILES/metatiles.inc"))
    parser.add_argument("--image", type=Path, default=Path("levels/famidash/graphics/famidash.bmp"))
    parser.add_argument("--out-c", type=Path, default=Path("include/famidash_metatiles.c"))
    parser.add_argument("--out-h", type=Path, default=Path("include/famidash_metatiles.h"))
    parser.add_argument("--out-image", type=Path, default=Path("levels/famidash/famidash_chr.png"))
    args = parser.parse_args()

    metatiles = parse_metatiles(args.metatiles)
    write_metatile_files(metatiles, args.out_c, args.out_h)
    reconstruct_chr_sheet(metatiles, args.image, args.out_image)

    print(f"Generated {len(metatiles)} metatiles")
    print(f"- {args.out_h}")
    print(f"- {args.out_c}")
    print(f"- {args.out_image}")
    print(f"- {args.out_image.with_name(args.out_image.stem + '_gb.png')}")


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


if __name__ == "__main__":
    main()
