import sys

def nes_to_gb(nes_tile):
    gb_tile = bytearray(16)
    for i in range(8):
        gb_tile[2*i] = nes_tile[i]
        gb_tile[2*i + 1] = nes_tile[i + 8]
    return gb_tile

def extract_tiles(chr_path, tile_indices):
    with open(chr_path, "rb") as f:
        data = f.read()

    output = []
    for idx in tile_indices:
        offset = idx * 16
        nes_tile = data[offset:offset+16]
        gb_tile = nes_to_gb(nes_tile)
        output.extend(gb_tile)
    return output

# Ball indices for 8x16 mode: [TL, BL, TR, BR]
# Grid 16 wide:
# Row 0: 0..15 -> 2, 3
# Row 1: 16..31 -> 18, 19
# Order for 8x16 (LHS pair, RHS pair): [2, 18, 3, 19]
ball_indices = [2, 18, 3, 19]
chr_file = r"C:\Users\soter\Source\Repos\GBDASH\Full GB Dash Icon Pack + Mini Icons.chr"

ball_data = extract_tiles(chr_file, ball_indices)

print("const uint8_t ball_tiles[] = {")
for i in range(0, len(ball_data), 16):
    tile_data = ball_data[i:i+16]
    # Print 2 lines of 8 bytes each for readability
    print("    " + ", ".join(f"0x{b:02X}" for b in tile_data[:8]) + ",")
    print("    " + ", ".join(f"0x{b:02X}" for b in tile_data[8:]) + ",")
print("};")
