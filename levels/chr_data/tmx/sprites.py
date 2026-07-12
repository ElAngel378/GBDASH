import xml.etree.ElementTree as ET
import os
import sys

def extract_portals(tmx_filepath, output_c_filepath, file_base_name):
    # Parse the XML tree
    try:
        tree = ET.parse(tmx_filepath)
        root = tree.getroot()
    except FileNotFoundError:
        print(f"Error: Could not find {tmx_filepath}")
        return

    # Get the map dimensions
    map_width = int(root.attrib['width'])

    # Find the 'sprites' tileset to dynamically get its starting ID (firstgid)
    sprites_firstgid = 257 # Fallback based on your file
    for tileset in root.findall('tileset'):
        if tileset.get('name') == 'sprites':
            sprites_firstgid = int(tileset.get('firstgid'))
            break

    # Map the TMX Global IDs to your desired engine IDs
    portals_map = {
        sprites_firstgid + 0: 0, # Cube portal
        sprites_firstgid + 1: 1, # Ship portal
        sprites_firstgid + 8: 8, # Normal gravity
        sprites_firstgid + 9: 9  # Inverted gravity
    }

    portal_data = []

    # Find the layer named 'SP'
    for layer in root.findall('layer'):
        if layer.get('name') == 'SP':
            data_element = layer.find('data')

            # Ensure it's the expected CSV format
            if data_element is not None and data_element.get('encoding') == 'csv':
                # Clean up whitespace and linebreaks
                csv_data = data_element.text.replace('\n', '').replace('\r', '')
                tiles = csv_data.split(',')

                # Iterate through all tiles
                for index, tile_str in enumerate(tiles):
                    if not tile_str.strip():
                        continue

                    tile_id = int(tile_str.strip())

                    # If this tile is one of our portals, extract it
                    if tile_id in portals_map:
                        # Calculate X and Y coordinates
                        x = index % map_width
                        y = index // map_width
                        obj_id = portals_map[tile_id]

                        portal_data.append((x, y, obj_id))
            break

    # Sanitize the base name to create a safe C variable name (remove spaces, hyphens, etc.)
    c_var_name = file_base_name.lower().replace(" ", "_").replace("-", "_")

    # Write out the GBDK formatted C file
    with open(output_c_filepath, 'w') as f:
        f.write('#include "assets.h"\n\n')

        f.write(f"// Extracted {len(portal_data)} portals from SP layer\n")
        f.write(f"const PortalDef {c_var_name}_portals[{max(1, len(portal_data))}] = {{\n")

        if len(portal_data) == 0:
            f.write("    {0, 0, 0}\n") # fallback if level has 0 portals
        else:
            for i, (x, y, obj) in enumerate(portal_data):
                f.write(f"    {{{x}, {y}, {obj}}}")
                if i < len(portal_data) - 1:
                    f.write(",\n")
                else:
                    f.write("\n")

        f.write("};\n\n")
        f.write(f"const uint16_t {c_var_name}_portals_count = {len(portal_data)};\n")

    print(f"Success! Extracted {len(portal_data)} portals into {output_c_filepath}")

if __name__ == "__main__":
    # Ensure a file argument was passed
    if len(sys.argv) < 2:
        print("Usage: python parse_portals.py <path_to_tmx_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    # Get just the file name without extensions or directory paths (e.g., "backontrack")
    file_raw_name = os.path.splitext(os.path.basename(input_file))[0]

    # Automatically generate the output path in the same directory as the input TMX
    base_path_without_ext = os.path.splitext(input_file)[0]
    output_file = f"{base_path_without_ext}_sprites.c"

    extract_portals(input_file, output_file, file_raw_name)