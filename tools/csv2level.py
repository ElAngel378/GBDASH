import argparse
import csv
import xml.etree.ElementTree as ET
from pathlib import Path


def parse_csv(path):
    rows = []
    with path.open(newline="") as csv_file:
        reader = csv.reader(csv_file)
        for row_number, row in enumerate(reader, start=1):
            values = [cell.strip() for cell in row if cell.strip() != ""]
            if not values:
                continue
            try:
                rows.append([int(value, 0) for value in values])
            except ValueError as exc:
                raise ValueError(f"{path}:{row_number}: CSV contains a non-integer tile id") from exc

    if not rows:
        raise ValueError(f"{path}: CSV is empty")

    width = len(rows[0])
    for row_number, row in enumerate(rows, start=1):
        if len(row) != width:
            raise ValueError(
                f"{path}:{row_number}: row has {len(row)} values, expected {width}"
            )

    return rows


def parse_tmx(path, layer_name):
    tree = ET.parse(path)
    root = tree.getroot()

    tileset_firstgids = [
        int(tileset.attrib["firstgid"])
        for tileset in root.findall("tileset")
    ]
    if not tileset_firstgids:
        raise ValueError(f"{path}: TMX contains no tilesets")

    all_layers = root.findall("layer")
    if not all_layers:
        raise ValueError(f"{path}: TMX contains no tile layers")

    selected_layer = None
    if layer_name == "":
        selected_layer = all_layers[0]
    else:
        for layer in all_layers:
            if layer.attrib.get("name", "") == layer_name:
                selected_layer = layer
                break

    if selected_layer is None:
        raise ValueError(f"{path}: could not find layer {layer_name}")

    data = selected_layer.find("data")
    if data is None or data.attrib.get("encoding") != "csv":
        raise ValueError(f"{path}: selected layer must use CSV-encoded data")

    lines = data.text.strip().splitlines()
    rows = []
    for row in csv.reader(lines):
        values = [cell.strip() for cell in row if cell.strip() != ""]
        rows.append([int(value, 0) for value in values])

    width = int(selected_layer.attrib["width"])
    height = int(selected_layer.attrib["height"])
    if len(rows) != height:
        raise ValueError(f"{path}: layer has {len(rows)} CSV rows, expected {height}")
    for row_number, row in enumerate(rows, start=1):
        if len(row) != width:
            raise ValueError(
                f"{path}:{row_number}: row has {len(row)} values, expected {width}"
            )

    local_rows = []
    for row in rows:
        local_row = []
        for gid in row:
            # TMX files use 0 for empty.
            if gid == 0:
                local_row.append(0)
                continue

            # Identify which tileset this GID belongs to.
            # (Assumes standard Tiled behavior where firstgid 1 is often the first tileset).
            # The user noted TMX GIDs are +1 compared to their desired CSV values.
            # gid - firstgid handles this mapping.
            firstgid = tileset_firstgids[0]
            for candidate in tileset_firstgids:
                if candidate <= gid:
                    firstgid = candidate
                else:
                    break
            local_row.append(gid - firstgid)
        local_rows.append(local_row)

    return local_rows


def normalize_tiles(rows, firstgid):
    normalized = []
    for row in rows:
        out_row = []
        for tile_id in row:
            # Tiled CSV export often uses -1 for empty.
            # User wants -1 to become 0, and others to stay the same if firstgid is 0,
            # or offset them if firstgid is > 0.
            if tile_id == -1 or tile_id == 0:
                out_row.append(0)
            else:
                out_row.append(tile_id - firstgid)
        normalized.append(out_row)
    return normalized


def validate_byte_values(rows):
    for y, row in enumerate(rows):
        for x, value in enumerate(row):
            if value < 0 or value > 255:
                raise ValueError(
                    f"tile at x={x}, y={y} became {value}; level maps must fit in 0..255"
                )


def count_nonzero_tiles(rows):
    return sum(1 for row in rows for value in row if value != 0)


def crop_rows(rows, width, height, x, y, bottom=False):
    if width is None and height is None and x == 0 and y == 0 and not bottom:
        return rows

    map_height = len(rows)
    map_width = len(rows[0])

    crop_height = height if height is not None else map_height
    crop_width = width if width is not None else map_width

    if crop_width <= 0 or crop_height <= 0 or x < 0 or y < 0:
        raise ValueError("crop dimensions must be positive and offsets must be non-negative")

    actual_y = y
    if bottom:
        actual_y = max(0, map_height - crop_height)

    if actual_y + crop_height > map_height or x + crop_width > map_width:
        raise ValueError(
            f"crop {crop_width}x{crop_height} at {x},{actual_y} is outside map {map_width}x{map_height}"
        )

    return [row[x:x + crop_width] for row in rows[actual_y:actual_y + crop_height]]


def find_first_nonempty_crop(rows, crop_width, crop_height):
    if crop_width is None or crop_height is None:
        raise ValueError("auto-crop requires both --crop-width and --crop-height")

    if crop_width > len(rows[0]) or crop_height > len(rows):
        raise ValueError(
            f"crop {crop_width}x{crop_height} is larger than map {len(rows[0])}x{len(rows)}"
        )

    for y in range(0, len(rows) - crop_height + 1):
        for x in range(0, len(rows[0]) - crop_width + 1):
            if any(
                rows[row_y][row_x] != 0
                for row_y in range(y, y + crop_height)
                for row_x in range(x, x + crop_width)
            ):
                return x, y

    return None


def c_identifier(name):
    cleaned = []
    for char in name:
        if char.isalnum() or char == "_":
            cleaned.append(char)
        else:
            cleaned.append("_")
    result = "".join(cleaned).strip("_")
    if not result:
        result = "level"
    if result[0].isdigit():
        result = "_" + result
    return result


def write_outputs(rows, name, array_name, out_dir, skip_c=False, skip_h=False):
    width = len(rows[0])
    height = len(rows)
    stem = c_identifier(name)
    guard = f"{stem.upper()}_H"
    macro = stem.upper()

    out_dir.mkdir(parents=True, exist_ok=True)
    header_path = out_dir / f"{stem}.h"
    source_path = out_dir / f"{stem}.c"
    binary_path = out_dir / f"{stem}.bin"

    flat = []
    if height == 16:
        # Column-major for height 16
        for x in range(width):
            for y in range(16):
                flat.append(rows[y][x])
    else:
        # Row-major fallback
        flat = [value for row in rows for value in row]

    if not skip_h:
        with header_path.open("w", newline="\n") as header:
            header.write(f"#ifndef {guard}\n")
            header.write(f"#define {guard}\n\n")
            header.write("#include <stdint.h>\n\n")
            header.write(f"#define {macro}_WIDTH {width}\n")
            header.write(f"#define {macro}_HEIGHT {height}\n")
            header.write(f"#define {macro}_TILE_WIDTH ({macro}_WIDTH * 2)\n")
            header.write(f"#define {macro}_TILE_HEIGHT ({macro}_HEIGHT * 2)\n\n")
            header.write(f"extern const uint8_t {array_name}[];\n\n")
            header.write(f"#endif /* {guard} */\n")

    if not skip_c:
        with source_path.open("w", newline="\n") as source:
            source.write(f'#include "{stem}.h"\n\n')
            source.write(f"const uint8_t {array_name}[] = {{\n")
            for index in range(0, len(flat), 16):
                line = flat[index:index + 16]
                source.write("    " + ", ".join(str(value) for value in line))
                source.write(",\n" if index + 16 < len(flat) else "\n")
            source.write("};\n")

    binary_path.write_bytes(bytes(flat))

    return header_path, source_path, binary_path, width, height


def main():
    parser = argparse.ArgumentParser(
        description="Convert a Tiled/FamiDash CSV layer into GBDK C and binary level data."
    )
    parser.add_argument("input", type=Path, help="Input CSV exported from Tiled, or TMX map")
    parser.add_argument(
        "-o",
        "--out-dir",
        type=Path,
        default=Path("include"),
        help="Output directory for .c/.h/.bin files",
    )
    parser.add_argument(
        "-n",
        "--name",
        help="Output file stem and macro prefix; defaults to the CSV filename",
    )
    parser.add_argument(
        "-a",
        "--array-name",
        default="level_map",
        help="C array name to generate",
    )
    parser.add_argument(
        "--firstgid",
        type=int,
        default=0,
        help="Offset to subtract from non-zero tile IDs (default 0 for CSV pass-through, TMX uses tileset firstgid)",
    )
    parser.add_argument(
        "--no-gid-offset",
        action="store_true",
        help="Keep CSV tile IDs exactly as written",
    )
    parser.add_argument(
        "--layer",
        default="",
        help="TMX layer name to extract; defaults to the unnamed background layer",
    )
    parser.add_argument(
        "--crop-width",
        type=int,
        help="Optional output crop width in metatiles",
    )
    parser.add_argument(
        "--crop-height",
        type=int,
        help="Optional output crop height in metatiles",
    )
    parser.add_argument(
        "--crop-x",
        type=int,
        default=0,
        help="Optional output crop X offset in metatiles",
    )
    parser.add_argument(
        "--crop-y",
        type=int,
        default=0,
        help="Optional output crop Y offset in metatiles",
    )
    parser.add_argument(
        "--bottom",
        action="store_true",
        help="When cropping, take the bottom N rows instead of the top",
    )
    parser.add_argument(
        "--auto-crop-to-nonempty",
        action="store_true",
        help="Scan for the first non-empty crop of the requested size",
    )
    parser.add_argument(
        "--no-c",
        action="store_true",
        help="Skip generating .c source file",
    )
    parser.add_argument(
        "--no-h",
        action="store_true",
        help="Skip generating .h header file",
    )

    args = parser.parse_args()

    if args.input.suffix.lower() == ".tmx":
        rows = parse_tmx(args.input, args.layer)
    else:
        rows = parse_csv(args.input)

    if args.input.suffix.lower() != ".tmx" and not args.no_gid_offset:
        rows = normalize_tiles(rows, args.firstgid)

    crop_x = args.crop_x
    crop_y = args.crop_y

    # Scan for the first non-empty crop if requested
    if getattr(args, "auto_crop_to_nonempty", False):
        found = find_first_nonempty_crop(rows, args.crop_width, args.crop_height)
        if found is None:
            raise ValueError(
                f"{args.input}: could not find a non-empty crop of {args.crop_width}x{args.crop_height}"
            )
        crop_x, crop_y = found
        print(f"auto-crop selected non-empty viewport at {crop_x},{crop_y}")

    rows = crop_rows(rows, args.crop_width, args.crop_height, crop_x, crop_y, bottom=args.bottom)
    validate_byte_values(rows)

    nonzero_tiles = count_nonzero_tiles(rows)
    if nonzero_tiles == 0:
        print(f"warning: cropped level is empty ({len(rows[0])}x{len(rows)})")

    name = args.name if args.name else args.input.stem
    outputs = write_outputs(rows, name, args.array_name, args.out_dir, skip_c=args.no_c, skip_h=args.no_h)
    header_path, source_path, binary_path, width, height = outputs

    print(f"Generated {width}x{height} level:")
    if not args.no_h: print(f"- {header_path}")
    if not args.no_c: print(f"- {source_path}")
    print(f"- {binary_path}")


if __name__ == "__main__":
    main()
