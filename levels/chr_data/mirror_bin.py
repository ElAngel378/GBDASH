import os

def mirror_bits(b):
    # Standard bit-reversal for Game Boy tile mirroring
    res = 0
    for i in range(8):
        if (b >> i) & 1:
            res |= (1 << (7 - i))
    return res

MIRROR_TABLE = bytes([mirror_bits(i) for i in range(256)])

def mirror_tileset(input_path, output_path):
    if not os.path.exists(input_path):
        print(f"Error: {input_path} not found.")
        return

    with open(input_path, "rb") as f:
        data = f.read()

    # Game Boy tiles are 16 bytes each.
    # Each pair of bytes represents one row of 8 pixels.
    res = bytearray(len(data))
    for i in range(0, len(data), 2):
        res[i] = MIRROR_TABLE[data[i]]
        res[i+1] = MIRROR_TABLE[data[i+1]]

    with open(output_path, "wb") as f:
        f.write(res)
    print(f"Successfully created mirrored binary: {output_path}")

if __name__ == "__main__":
    # Mirror the ALREADY EXPORTED bin file to maintain index parity
    mirror_tileset("chr_gb_tiles.bin", "chr_gb_flipped_tiles.bin")
