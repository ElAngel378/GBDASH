import re
import os

def generate_reversed_metatiles(input_path, output_path):
    if not os.path.exists(input_path):
        print(f"Error: Could not find {input_path}")
        return

    with open(input_path, 'r') as f:
        lines = f.readlines()

    in_array = False
    
    with open(output_path, 'w') as out:
        out.write("const uint8_t metatiles_rev[FAMIDASH_NUM_METATILES][4] = {\n")
        
        for line in lines:
            # Detect the start of the original array
            if "const uint8_t metatiles[" in line:
                in_array = True
                continue
            
            if in_array:
                # Detect the end of the array
                if "};" in line:
                    out.write("};\n")
                    break
                
                # Match the pattern: { TL, TR, BL, BR }, /* Comment */
                match = re.search(r'\{\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}\s*,(.*)', line)
                if match:
                    tl, tr, bl, br = match.groups()[:4]
                    comment = match.group(5)
                    
                    # Swap the left and right tiles!
                    out.write(f"    {{ {tr}, {tl}, {br}, {bl} }},{comment}\n")
                else:
                    # Just in case there's an empty line or something else
                    out.write(line)
                    
    print(f"Success! Reversed metatiles saved to {output_path}")

if __name__ == "__main__":
    generate_reversed_metatiles("famidash_metatiles.c", "metatiles_rev_output.txt")