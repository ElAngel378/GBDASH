import sys

def convert_tile_nes_to_gb(nes_data):
    gb_data = [0] * 16
    for i in range(8):
        gb_data[i*2] = nes_data[i]          # Bitplane 0
        gb_data[i*2 + 1] = nes_data[i + 8]  # Bitplane 1
    return bytes(gb_data)

def main():
    if len(sys.argv) < 3:
        print("Usage: python chr2gb.py input.chr output.c [array_name]")
        return

    input_path = sys.argv[1]
    output_path = sys.argv[2]
    array_name = sys.argv[3] if len(sys.argv) > 3 else "sprite_tiles"

    with open(input_path, "rb") as f:
        chr_data = f.read()

    num_tiles = len(chr_data) // 16
    gb_tiles = []
    for i in range(num_tiles):
        tile = chr_data[i*16 : (i+1)*16]
        gb_tiles.append(convert_tile_nes_to_gb(tile))

    with open(output_path, "w") as f:
        f.write("#include <stdint.h>\n\n")
        f.write(f"const uint8_t {array_name}[{num_tiles * 16}] = {{\n")
        for i, tile in enumerate(gb_tiles):
            f.write(f"    // tile {i}\n    ")
            hex_data = ", ".join([f"0x{b:02X}" for b in tile])
            f.write(hex_data + ("," if i < num_tiles - 1 else ""))
            f.write("\n")
        f.write("};\n")

if __name__ == "__main__":
    main()
