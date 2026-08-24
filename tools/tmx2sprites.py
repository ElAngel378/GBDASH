import xml.etree.ElementTree as ET
import os
import sys
import argparse
from pathlib import Path

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
    # Confirmed against the actual sprites.png sheet: everything used lives in row 0
    # (local ids 0-14), read left to right:
    #   0=Cube portal   1=Ship portal
    #   5=Blue orb (gravity)   6=Pink orb
    #   8=Normal gravity trigger   9=Inverted gravity trigger
    #   10=Yellow pad   11=Yellow orb   12=Yellow pad (upside down)
    #   13=Blue pad     14=Blue pad (upside down)
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
        # **{sprites_firstgid + i: i for i in range(42, 62)}, # DECO DISABLED
    }

    # BG Color mappings:
    portals_map[sprites_firstgid + 143] = 103  # Dark (was 13)
    for i in range(128, 141): portals_map[sprites_firstgid + i] = 102 # Dark grey (was 12)
    for i in range(144, 157): portals_map[sprites_firstgid + i] = 101 # Light grey (was 11)
    for i in range(160, 173): portals_map[sprites_firstgid + i] = 100 # Light (was 10)

    portal_data = []

    # Find the layer named 'SP'
    sp_layer_found = False
    for layer in root.findall('layer'):
        if layer.get('name') == 'SP':
            sp_layer_found = True
            data_element = layer.find('data')

            # Ensure it's the expected CSV format
            if data_element is not None and data_element.get('encoding') == 'csv':
                # Clean up whitespace and linebreaks
                csv_data = data_element.text.replace('\n', '').replace('\r', '') if data_element.text else ""
                tiles = csv_data.split(',')

                # Iterate through all tiles
                for index, tile_str in enumerate(tiles):
                    if not tile_str.strip():
                        continue

                    try:
                        tile_id = int(tile_str.strip())
                    except ValueError:
                        continue

                    # If this tile is one of our portals, extract it
                    if tile_id in portals_map:
                        # Calculate X and Y coordinates (Flipping Y: Tiled 0 is Top, Engine 0 is Bottom)
                        x = index % map_width
                        y_tiled = index // map_width
                        # Flip Y based on map height (e.g., if height is 27, Tiled 26 becomes Engine 0)
                        y = (map_height - 1) - y_tiled
                        obj_id = portals_map[tile_id]

                        portal_data.append((x, y, obj_id))
            break

    if not sp_layer_found:
        print(f"Warning: 'SP' layer was not found in {tmx_filepath}. Outputting terminator only.")

    # Sort portals by X coordinate to allow the engine to optimize lookups
    portal_data.sort(key=lambda p: p[0])

    # Sanitize the base name to create a safe C variable name (remove spaces, hyphens, etc.)
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

            # Write all extracted portals
            for x, y, obj in portal_data:
                f.write(f"    {{{x}, {y}, {obj}}},\n")

            # Write sentinel terminator
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
        # Fallback to same directory as input if no out-dir provided
        base_path_without_ext = os.path.splitext(input_file)[0]
        output_file = f"{base_path_without_ext}_sprites.c"

    extract_portals(input_file, output_file, file_raw_name, args.bank)

if __name__ == "__main__":
    main()
