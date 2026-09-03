import xml.etree.ElementTree as ET
import os
import sys
import argparse
import json
from pathlib import Path

def load_metadata_for_level(level_name, metadata_dir=None):
    """Searches levels/metadata/*.json for the specified level and returns its offset dictionary."""
    if metadata_dir is None:
        metadata_dir = Path(__file__).resolve().parent.parent / "levels" / "metadata"

    if not metadata_dir.is_dir():
        return {}

    target = level_name.lower().replace("_", "").replace("-", "")

    # Look across all json metadata files
    for mf in metadata_dir.glob("*.json"):
        try:
            with open(mf, 'r', encoding='utf-8') as fp:
                data = json.load(fp)
            g_offsets = data.get('globalObjectOffsets', [])
            all_lvls = data.get('official_levels', []) + data.get('community_levels', [])
            for lvl in all_lvls:
                cur_name = lvl.get('level', '').lower().replace("_", "").replace("-", "")
                if cur_name == target:
                    l_offsets = lvl.get('objectOffsets', [])
                    return build_offset_dict(g_offsets, l_offsets)
        except Exception:
            continue
    return {}

def build_offset_dict(global_settings, level_settings):
    """Builds offset dictionary matching FamiDash export_levels.py getDictFromOffsetSettings."""
    out = {}
    for setting_list in [global_settings, level_settings]:
        for s in setting_list:
            # On Game Boy 8x16 sprite mode, pad tiles in VRAM are already pre-drawn
            # at rows 13..15 (the bottom 8px of the 16px tile). On NES, sprites are 8x8,
            # so FamiDash added +8px to move them to the bottom of the cell.
            # In GBDASH, adding +8px pushes the pad 8px down into the floor, so we skip it.
            if s.get('objectID'):
                oids = s['objectID'] if isinstance(s['objectID'], list) else [s['objectID']]
                if any(o in [10, 13, 37, 82, 86, 253] for o in oids) and s.get('offsetY', 0) == 8:
                    continue

            off = s.get('offset')
            if not off:
                off = [s.get('offsetX', 0), s.get('offsetY', 0)]
            if off == [0, 0]:
                continue
            if 'coordinates' in s:
                coords = s['coordinates']
                if len(coords) == 2 and isinstance(coords[0], int):
                    coords = [coords]
                for c in coords:
                    c = tuple(c)
                    if c not in out or s.get('override'):
                        out[c] = (off, s.get('override', False))
                    else:
                        prev = out[c][0]
                        out[c] = ([prev[0] + off[0], prev[1] + off[1]], False)
            elif 'objectID' in s:
                oids = s['objectID'] if isinstance(s['objectID'], list) else [s['objectID']]
                for o in oids:
                    if o not in out or s.get('override'):
                        out[o] = off
                    else:
                        prev = out[o]
                        out[o] = [prev[0] + off[0], prev[1] + off[1]]
    return out

def extract_portals(tmx_filepath, output_c_filepath, file_base_name, bank=None):
    # Parse the XML tree
    try:
        tree = ET.parse(tmx_filepath)
        root = tree.getroot()
    except FileNotFoundError:
        print(f"Error: Could not find {tmx_filepath}")
        sys.exit(1)
    except ET.ParseError as e:
        print(f"Error parsing XML in {tmx_filepath}: {e}")
        sys.exit(1)

    # Get the map dimensions
    if 'width' not in root.attrib or 'height' not in root.attrib:
        print(f"Error: TMX file {tmx_filepath} is missing width or height attributes.")
        sys.exit(1)
    map_width = int(root.attrib['width'])
    map_height = int(root.attrib['height'])

    # Find the 'sprites' tileset to dynamically get its starting ID (firstgid)
    sprites_firstgid = None
    for tileset in root.findall('tileset'):
        if tileset.get('name') == 'sprites':
            firstgid_attr = tileset.get('firstgid')
            if firstgid_attr is not None:
                sprites_firstgid = int(firstgid_attr)
            break

    # If the tileset isn't found, exit with an error instead of using a hardcoded fallback
    if sprites_firstgid is None:
        print(f"Error: Could not find a tileset named 'sprites' in {tmx_filepath}.")
        sys.exit(1)

    # Map the TMX Global IDs to your desired engine IDs.
    portals_map = {
        sprites_firstgid + 0:  0,   # Cube portal
        sprites_firstgid + 1:  1,   # Ship portal
        sprites_firstgid + 2:  2,   # Ball portal
        sprites_firstgid + 5:  5,   # Blue Orb (Gravity)
        sprites_firstgid + 6:  6,   # Pink Orb
        sprites_firstgid + 8:  8,   # Normal gravity trigger
        sprites_firstgid + 9:  9,   # Inverted gravity trigger
        sprites_firstgid + 10: 10,  # Yellow Pad
        sprites_firstgid + 11: 11,  # Yellow Orb
        sprites_firstgid + 12: 12,  # Yellow Pad (upside down)
        sprites_firstgid + 13: 13,  # Blue Pad
        sprites_firstgid + 14: 14,  # Blue Pad (upside down)
        sprites_firstgid + 15: 15,  # Level end
        sprites_firstgid + 16: 16,  # Normal gravity portal (horizontal down)
        sprites_firstgid + 17: 17,  # Normal gravity portal (horizontal up)
        sprites_firstgid + 18: 18,  # Inverted gravity portal (horizontal down)
        sprites_firstgid + 19: 19,  # Inverted gravity portal (horizontal up)
        sprites_firstgid + 126: 126,  # test
        sprites_firstgid + 121: 121,  # test
        sprites_firstgid + 253: 13,  # Blue Pad (invisible)
        sprites_firstgid + 254: 14,  # Blue Pad (invisible)
    }

    # Deco objects
    for i in range(42, 64):
        portals_map[sprites_firstgid + i] = i

    # BG Color mappings (Rows 8, 9, 10):
    # Mapping unique indices 128-175 to obj_ids 100-147
    for i in range(128, 176):
        portals_map[sprites_firstgid + i] = 100 + (i - 128)

    # Ground Color mappings (Rows 12, 13, 14):
    # Mapping unique indices 192-239 to obj_ids 192-239
    for i in range(192, 240):
        portals_map[sprites_firstgid + i] = i

    # Load FamiDash metadata offsets
    offset_dict = load_metadata_for_level(file_base_name)
    if offset_dict:
        print(f"  - Loaded {len(offset_dict)} FamiDash offset rules for {file_base_name}")

    portal_data = []

    # Find the layer named 'SP'
    sp_layer_found = False
    for layer in root.findall('layer'):
        if layer.get('name') == 'SP':
            sp_layer_found = True
            data_element = layer.find('data')

            if data_element is not None and data_element.get('encoding') == 'csv':
                csv_data = data_element.text.replace('\n', '').replace('\r', '') if data_element.text else ""
                tiles = csv_data.split(',')

                start_y = max(0, map_height - 16)

                for index, tile_str in enumerate(tiles):
                    if not tile_str.strip():
                        continue

                    try:
                        tile_id = int(tile_str.strip())
                    except ValueError:
                        continue

                    if tile_id in portals_map:
                        col = index % map_width
                        row = index // map_width
                        obj_id = portals_map[tile_id]

                        # Look up FamiDash offsets
                        offsetA = offset_dict.get(obj_id, [0, 0])
                        offsetB, override = offset_dict.get((col, row), [[0, 0], False])
                        if override:
                            dx = offsetB[0]
                            dy = offsetB[1]
                        else:
                            dx = offsetA[0] + offsetB[0]
                            dy = offsetA[1] + offsetB[1]

                        row_16 = row - start_y

                        x_px = col * 16 + dx
                        if row_16 < 0:
                            y_px = 0
                        else:
                            y_px = max(0, row_16 * 16 + dy)

                        portal_data.append((x_px, y_px, obj_id))
            break

    if not sp_layer_found:
        print(f"Warning: 'SP' layer was not found in {tmx_filepath}. Outputting terminator only.")

    # Sort portals by pixel X coordinate
    portal_data.sort(key=lambda p: p[0])

    c_var_name = file_base_name.lower().replace(" ", "_").replace("-", "_")

    # Write out the GBDK formatted C file
    try:
        with open(output_c_filepath, 'w') as f:
            if bank is not None:
                f.write(f'#pragma bank {bank}\n')
            f.write('#include "assets.h"\n\n')

            if bank is not None:
                f.write(f'BANKREF({c_var_name}_sp)\n\n')

            f.write(f"// Extracted {len(portal_data)} objects from SP layer\n")
            f.write(f"const SpDef {c_var_name}_sp[] = {{\n")

            for x, y, obj in portal_data:
                f.write(f"    {{{x}, {y}, {obj}}},\n")

            # Sentinel terminator
            f.write("    {0xFFFF, 0, 0}\n")
            f.write("};\n")
    except IOError as e:
        print(f"Error writing to output file {output_c_filepath}: {e}")
        sys.exit(1)

    print(f"Success! Extracted {len(portal_data)} portals into {output_c_filepath}")

def main():
    parser = argparse.ArgumentParser(description="Convert the Tiled SP layer into portal and object data.")
    parser.add_argument("input", type=Path, help="Input TMX map")
    parser.add_argument("-o", "--out-dir", type=Path, help="Output directory for .c file")
    parser.add_argument("-n", "--name", help="Output file stem name")
    parser.add_argument("-b", "--bank", type=int, help="ROM bank for the data")

    args = parser.parse_args()

    input_file = str(args.input)
    file_raw_name = args.name if args.name else args.input.stem

    if args.out_dir:
        output_file = str(args.out_dir / f"{file_raw_name}_sprites.c")
    else:
        base_path_without_ext = os.path.splitext(input_file)[0]
        output_file = f"{base_path_without_ext}_sprites.c"

    extract_portals(input_file, output_file, file_raw_name, args.bank)

if __name__ == "__main__":
    main()
