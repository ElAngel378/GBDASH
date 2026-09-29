#!/usr/bin/env python3
"""Convert Pocket Dash (Game Boy) assets to Game Gear data for the Dry Out proof of concept.

Outputs gg/src/gg_data.c and gg/src/gg_data.h.

Game Gear tiles are 4bpp, so the 2bpp Game Boy tiles are "baked" with their sub-palette:
pixel value = sub_palette * 4 + gb_pixel.  One 16-colour background palette therefore
holds the four Game Boy sub-palettes used by Dry Out (0, 1, 2 and the ground palette 4),
and one 16-colour sprite palette holds the player.
"""
import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
OUT_C = os.path.join(ROOT, 'gg', 'src', 'gg_data.c')
OUT_H = os.path.join(ROOT, 'gg', 'src', 'gg_data.h')

LEVEL_MAP = 'levels/level_data/dryout_16high.bin'
LEVEL_NAME = 'dryout'
SKY_COLOR_IDX = 22      # level_initial_bg_color[Dry Out]
GROUND_COLOR_IDX = 22   # level_initial_g_color[Dry Out]

GB_TO_SUB = {0: 0, 1: 1, 2: 2, 4: 3}  # GB bg palette -> sub-palette in the GG bg palette


def read(path):
    with open(os.path.join(ROOT, path), 'rb') as f:
        return f.read()


def read_text(path):
    with open(os.path.join(ROOT, path), 'r', encoding='utf-8') as f:
        return f.read()


def decode_2bpp_tile(data, idx):
    """Returns an 8x8 list of rows of pixel values 0-3."""
    rows = []
    for y in range(8):
        lo = data[idx * 16 + y * 2]
        hi = data[idx * 16 + y * 2 + 1]
        rows.append([(((hi >> (7 - x)) & 1) << 1) | ((lo >> (7 - x)) & 1) for x in range(8)])
    return rows


def encode_4bpp_tile(rows, sub, transparent0=False):
    out = bytearray()
    for y in range(8):
        planes = [0, 0, 0, 0]
        for x in range(8):
            v = rows[y][x]
            if v or not transparent0:
                v += sub * 4
            for b in range(4):
                planes[b] |= ((v >> b) & 1) << (7 - x)
        out += bytes(planes)
    return bytes(out)


def parse_block(text, name):
    m = re.search(re.escape(name) + r'[^=]*=\s*\{(.*?)\n\};', text, re.S)
    if not m:
        sys.exit('block not found: ' + name)
    body = re.sub(r'/\*.*?\*/|//[^\n]*', '', m.group(1), flags=re.S)
    return [int(n) for n in re.findall(r'\d+', body)]


def gb555_to_gg(v):
    r, g, b = v & 31, (v >> 5) & 31, (v >> 10) & 31
    return (r >> 1) | ((g >> 1) << 4) | ((b >> 1) << 8)


def rgb8_to_gg(r, g, b):
    return (r >> 4) | ((g >> 4) << 4) | ((b >> 4) << 8)


def main():
    mt_src = read_text('include/famidash_metatiles_dmg.c')
    metatiles = parse_block(mt_src, 'metatiles[FAMIDASH_NUM_METATILES][4]')
    mt_pal = parse_block(mt_src, 'famidash_metatile_palettes')
    mt_col = parse_block(mt_src, 'famidash_metatile_collision')
    assert len(metatiles) == 1024 and len(mt_pal) == 256 and len(mt_col) == 256

    tiles2bpp = read('levels/chr_data/chr_gb_dmg_tiles.bin')
    ground2bpp = read('levels/chr_data/menu_ground_tiles.bin')
    level = read(LEVEL_MAP)
    assert len(level) % 16 == 0
    map_w = len(level) // 16
    used_mts = sorted(set(level))

    # ---- background tiles ----
    bg_tiles = [bytes(32)]           # tile 0: blank (sky colour, palette entry 0)
    bg_index = {}

    def bg_tile(key, rows, sub):
        if key not in bg_index:
            bg_index[key] = len(bg_tiles)
            bg_tiles.append(encode_4bpp_tile(rows, sub))
        return bg_index[key]

    gg_mt = [[0] * 4 for _ in range(256)]
    for mt in used_mts:
        pal = mt_pal[mt]
        sub = GB_TO_SUB.get(pal, 0)
        for i in range(4):
            t = metatiles[mt * 4 + i]
            if t == 12:
                gg_mt[mt][i] = 0     # parallax placeholder -> plain sky
            else:
                gg_mt[mt][i] = bg_tile(('lvl', t, sub), decode_2bpp_tile(tiles2bpp, t), sub)

    ground_top_src = [48, 49, 49, 49, 49, 49, 49, 50]
    ground_bot_src = [51, 52, 52, 52, 52, 52, 52, 53]
    ground_sub = GB_TO_SUB[4]
    ground_top = [bg_tile(('gnd', t), decode_2bpp_tile(ground2bpp, t - 48), ground_sub) for t in ground_top_src]
    ground_bot = [bg_tile(('gnd', t), decode_2bpp_tile(ground2bpp, t - 48), ground_sub) for t in ground_bot_src]
    if len(bg_tiles) > 256:
        sys.exit('too many bg tiles: %d (need >8-bit tile ids)' % len(bg_tiles))

    # ---- palettes ----
    tables = read_text('src/famidash_bg_tables.h')
    sky = re.findall(r'\{\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u\s*\}', tables)
    gnd = re.findall(r'\{\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u,\s*(0x[0-9A-Fa-f]+)u\s*\}', tables)
    assert len(sky) == 64 and len(gnd) == 64
    sky_c = int(sky[SKY_COLOR_IDX][0], 16)
    sky_d = int(sky[SKY_COLOR_IDX][1], 16)
    g_color = int(sky[GROUND_COLOR_IDX][0], 16)
    g_dark, g_18, g_9 = (int(v, 16) for v in gnd[GROUND_COLOR_IDX])
    WHITE = rgb8_to_gg(255, 255, 255)
    BLACK = 0
    bg_pal = [
        gb555_to_gg(sky_c), gb555_to_gg(sky_d), BLACK, WHITE,                       # 0 normal
        gb555_to_gg(sky_c), gb555_to_gg(g_dark), gb555_to_gg(g_color), WHITE,      # 1 accent
        gb555_to_gg(sky_c), gb555_to_gg(sky_d), BLACK, rgb8_to_gg(125, 255, 0),    # 2 hazards
        WHITE, gb555_to_gg(g_color), gb555_to_gg(g_18), gb555_to_gg(g_9),          # 3 = GB palette 4 (ground)
    ]

    # ---- player sprites (icon1) ----
    icon_src = read_text('src/graphics/icon1.c')
    m = re.search(r'icon1_tiles\[128\]\s*=\s*\{(.*?)\};', icon_src, re.S)
    icon_bytes = bytes(int(x, 16) for x in re.findall(r'0x([0-9a-fA-F]{2})', m.group(1)))
    assert len(icon_bytes) == 128
    icon_imgs = []      # 16 rows x 8 cols per 8x16 sprite image
    for k in range(4):
        top = decode_2bpp_tile(icon_bytes, 2 * k)
        bot = decode_2bpp_tile(icon_bytes, 2 * k + 1)
        icon_imgs.append(top + bot)

    spr_tiles = []
    spr_index = {}

    def sprite_pair(k, fx, fy):
        key = (k, fx, fy)
        if key not in spr_index:
            img = [row[:] for row in icon_imgs[k]]
            if fy:
                img = img[::-1]
            if fx:
                img = [row[::-1] for row in img]
            spr_index[key] = len(spr_tiles)
            spr_tiles.append(encode_4bpp_tile(img[:8], 1, True))
            spr_tiles.append(encode_4bpp_tile(img[8:], 1, True))
        return spr_index[key]

    frames = []
    for fm in re.finditer(r'icon1_metasprite\d+\[\]\s*=\s*\{(.*?)METASPR_TERM', icon_src, re.S):
        items = re.findall(r'METASPR_ITEM\(([^\n]*)\),', fm.group(1))
        row = []
        for it in items:
            parts = [p.strip() for p in it.split(',', 3)]
            tile = int(parts[2])
            flags = parts[3]
            row.append(sprite_pair(tile // 2, 'S_FLIPX' in flags, 'S_FLIPY' in flags))
        assert len(row) == 2
        frames.append(row)
    assert len(frames) == 25, len(frames)

    spr_pal = [0] * 16
    spr_pal[4:8] = [WHITE, rgb8_to_gg(0, 255, 255), rgb8_to_gg(125, 255, 0), BLACK]

    # ---- emit ----
    with open(OUT_H, 'w', newline='\n') as h:
        h.write('/* Generated by gg/tools/gg_convert.py - do not edit. */\n')
        h.write('#ifndef GG_DATA_H\n#define GG_DATA_H\n\n#include <stdint.h>\n\n')
        h.write('#define GG_BG_TILE_COUNT %d\n' % len(bg_tiles))
        h.write('#define GG_SPR_TILE_COUNT %d\n' % len(spr_tiles))
        h.write('#define GG_LEVEL_WIDTH %d\n\n' % map_w)
        h.write('extern const uint8_t gg_bg_tiles[GG_BG_TILE_COUNT * 32];\n')
        h.write('extern const uint8_t gg_spr_tiles[GG_SPR_TILE_COUNT * 32];\n')
        h.write('extern const uint8_t gg_mt[256][4];\n')
        h.write('extern const uint8_t gg_ground_top[8];\nextern const uint8_t gg_ground_bot[8];\n')
        h.write('extern const uint16_t gg_bg_palette[16];\nextern const uint16_t gg_spr_palette[16];\n')
        h.write('extern const uint8_t gg_cube_frames[25][2];\n')
        h.write('extern const uint8_t famidash_metatile_collision[256];\n')
        h.write('extern const uint8_t %s_map[GG_LEVEL_WIDTH * 16];\n\n#endif\n' % LEVEL_NAME)

    def arr(name, ctype, values, per_line=16, fmt='%d', nested=False):
        s = 'const %s %s = {\n' % (ctype, name)
        for i in range(0, len(values), per_line):
            row = ', '.join(fmt % v for v in values[i:i + per_line])
            s += '    ' + ('{ %s },' % row if nested else row + ',') + '\n'
        return s + '};\n\n'

    with open(OUT_C, 'w', newline='\n') as c:
        c.write('/* Generated by gg/tools/gg_convert.py - do not edit. */\n')
        c.write('#include "gg_data.h"\n\n')
        c.write(arr('gg_bg_tiles[GG_BG_TILE_COUNT * 32]', 'uint8_t', list(b''.join(bg_tiles)), 16, '0x%02x'))
        c.write(arr('gg_spr_tiles[GG_SPR_TILE_COUNT * 32]', 'uint8_t', list(b''.join(spr_tiles)), 16, '0x%02x'))
        c.write(arr('gg_mt[256][4]', 'uint8_t', [v for row in gg_mt for v in row], 4, nested=True))
        c.write(arr('gg_ground_top[8]', 'uint8_t', ground_top))
        c.write(arr('gg_ground_bot[8]', 'uint8_t', ground_bot))
        c.write(arr('gg_bg_palette[16]', 'uint16_t', bg_pal, 8, '0x%03x'))
        c.write(arr('gg_spr_palette[16]', 'uint16_t', spr_pal, 8, '0x%03x'))
        c.write(arr('gg_cube_frames[25][2]', 'uint8_t', [v for row in frames for v in row], 2, nested=True))
        c.write(arr('famidash_metatile_collision[256]', 'uint8_t', mt_col))
        c.write(arr('%s_map[GG_LEVEL_WIDTH * 16]' % LEVEL_NAME, 'uint8_t', list(level), 32))

    print('bg tiles: %d, sprite tiles: %d, level width: %d metatile columns' % (len(bg_tiles), len(spr_tiles), map_w))


if __name__ == '__main__':
    main()
