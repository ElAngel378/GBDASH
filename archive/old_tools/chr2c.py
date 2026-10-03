import sys
import os

def chr_to_c(filepath):
    name = os.path.splitext(os.path.basename(filepath))[0]
    try:
        with open(filepath, "rb") as f:
            data = f.read()
    except Exception as e:
        print(f"Error reading file: {e}")
        return

    c_file = f"src/{name}_tiles.c"
    h_file = f"include/{name}_tiles.h"

    with open(c_file, "w") as f:
        f.write(f"// Generated from {filepath}\n")
        f.write(f"#include <stdint.h>\n")
        f.write(f"#include <gb/gb.h>\n\n")
        f.write(f"const uint8_t {name}_tiles[{len(data)}] = {{\n")
        for i, b in enumerate(data):
            f.write(f"0x{b:02x}")
            if i < len(data) - 1:
                f.write(", ")
            if (i + 1) % 16 == 0:
                f.write("\n")
        f.write(f"\n}};\n")

    with open(h_file, "w") as f:
        f.write(f"#ifndef {name.upper()}_TILES_H\n")
        f.write(f"#define {name.upper()}_TILES_H\n\n")
        f.write(f"#include <stdint.h>\n\n")
        f.write(f"extern const uint8_t {name}_tiles[{len(data)}];\n\n")
        f.write(f"#endif\n")

    print(f"Generated {c_file} and {h_file}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python chr2c.py <file.chr>")
    else:
        chr_to_c(sys.argv[1])
