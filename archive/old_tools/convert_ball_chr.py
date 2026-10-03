import sys
import os

def decode_gb_tile_pixels(tile_bytes):
    pixels = []
    for y in range(8):
        b0 = tile_bytes[y*2]
        b1 = tile_bytes[y*2+1]
        row = [((b0 >> (7-x)) & 1) | (((b1 >> (7-x)) & 1) << 1) for x in range(8)]
        pixels.append(row)
    return pixels

def pixels_to_gb_tile(pixels):
    tb = []
    for y in range(8):
        b0 = 0
        b1 = 0
        for x in range(8):
            col = pixels[y][x]
            bit = 7 - x
            b0 |= ((col & 1) << bit)
            b1 |= (((col >> 1) & 1) << bit)
        tb.append(b0)
        tb.append(b1)
    return tb

def swap_c1_c2(tb):
    out = []
    for y in range(len(tb) // 2):
        out.append(tb[y*2+1])
        out.append(tb[y*2])
    return out

def convert(input_path, output_c_path):
    with open(input_path, "rb") as f:
        data = f.read()

    # GDP Ball.chr has:
    # Frame 1: tiles 71 (TL), 72 (TR), 87 (BL), 88 (BR), and 89 (8x8 Core)
    # Frame 2: tiles 103 (TL), 104 (TR), 119 (BL), 120 (BR), and 121 (8x8 Core)
    def get_tile(idx):
        return data[idx*16:(idx+1)*16]

    def bake_frame(tl, tr, bl, br, core):
        grid = [[0]*16 for _ in range(16)]
        ptl = decode_gb_tile_pixels(get_tile(tl))
        ptr = decode_gb_tile_pixels(get_tile(tr))
        pbl = decode_gb_tile_pixels(get_tile(bl))
        pbr = decode_gb_tile_pixels(get_tile(br))
        pcore = decode_gb_tile_pixels(get_tile(core))

        # Outer gear mapping:
        # 0 -> 0 (transparent)
        # 1 -> 3 (outer outline: solid black)
        # 2 -> 2 (teeth body: primary player color / dark gray on DMG / green on GBC)
        # 3 -> 3 (hole outline: solid black border separating teeth and core)
        outer_map = {0: 0, 1: 3, 2: 2, 3: 3}
        for y in range(8):
            for x in range(8):
                grid[y][x] = outer_map[ptl[y][x]]
                grid[y][x+8] = outer_map[ptr[y][x]]
                grid[y+8][x] = outer_map[pbl[y][x]]
                grid[y+8][x+8] = outer_map[pbr[y][x]]

        # Core star mapping:
        # 0 -> keep outer background (hole outline 3)
        # 1 -> 3 (core outline: solid black)
        # 2 -> 1 (core body: secondary player color / white on DMG / cyan on GBC)
        # 3 -> 1 (core center: secondary player color / white on DMG / cyan on GBC)
        core_map = {1: 3, 2: 1, 3: 1}
        for y in range(8):
            for x in range(8):
                c = pcore[y][x]
                if c != 0:
                    grid[y+4][x+4] = core_map[c]

        # In 8x16 sprite mode: Left sprite = top-left (0..7, 0..7) + bottom-left (0..7, 8..15)
        # Right sprite = top-right (8..15, 0..7) + bottom-right (8..15, 8..15)
        t0 = [row[0:8] for row in grid[0:8]]
        t1 = [row[0:8] for row in grid[8:16]]
        t2 = [row[8:16] for row in grid[0:8]]
        t3 = [row[8:16] for row in grid[8:16]]
        return pixels_to_gb_tile(t0) + pixels_to_gb_tile(t1) + pixels_to_gb_tile(t2) + pixels_to_gb_tile(t3)

    f1 = bake_frame(71, 72, 87, 88, 89)
    f2 = bake_frame(103, 104, 119, 120, 121)

    with open(output_c_path, "w") as f:
        f.write("#pragma bank 10\n")
        f.write("#include <stdint.h>\n")
        f.write("#include <gbdk/platform.h>\n")
        f.write("#include <gbdk/metasprites.h>\n\n")
        f.write("// Converted from GDP Ball.chr (2 animated frames, 8x16 metasprite format)\n")
        f.write("// Total 8 tiles (128 bytes): 4 tiles per 16x16 frame\n\n")

        f.write("// 2-Frame Ball tiles (Solid black outline, Color 2 primary gear body, Color 1 secondary core center)\n")
        f.write("const uint8_t ball_tiles[128] = {\n")
        f.write("    // Frame 0 (0 degrees) - Left 8x16, Right 8x16\n")
        for i in range(0, 64, 8):
            f.write("    " + ", ".join(f"0x{b:02X}" for b in f1[i:i+8]) + ",\n")
        f.write("    // Frame 1 (rotated) - Left 8x16, Right 8x16\n")
        for i in range(0, 64, 8):
            f.write("    " + ", ".join(f"0x{b:02X}" for b in f2[i:i+8]) + ",\n")
        f.write("};\n\n")

        f.write("// Metasprites for 8x16 mode\n")
        f.write("const metasprite_t ball_metasprite0[] = {\n")
        f.write("    METASPR_ITEM(0, 0, 0, 0),\n")
        f.write("    METASPR_ITEM(0, 8, 2, 0),\n")
        f.write("    METASPR_TERM\n")
        f.write("};\n\n")
        f.write("const metasprite_t ball_metasprite1[] = {\n")
        f.write("    METASPR_ITEM(0, 0, 4, 0),\n")
        f.write("    METASPR_ITEM(0, 8, 6, 0),\n")
        f.write("    METASPR_TERM\n")
        f.write("};\n\n")
        f.write("const metasprite_t* const ball_metasprites[2] = {\n")
        f.write("    ball_metasprite0,\n")
        f.write("    ball_metasprite1\n")
        f.write("};\n")

    print(f"Generated {output_c_path} successfully!")

if __name__ == "__main__":
    chr_path = sys.argv[1] if len(sys.argv) > 1 else "archive/raw_assets/GDP Ball.chr"
    out_path = sys.argv[2] if len(sys.argv) > 2 else "src/graphics/ball.c"
    convert(chr_path, out_path)

