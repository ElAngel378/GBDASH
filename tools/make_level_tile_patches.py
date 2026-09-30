"""Generates the per-level background tile data that Pocket Dash's single tile sheet lacks.

1. Sawblades (all levels, CGB only). Famidash draws saws from the SawbladesA CHR bank
   (NES tiles $C0..$EF); Pocket Dash's sheet has no room for them (they were blank).
   They go to CGB VRAM bank 1, BG tiles SAW_VRAM_BASE.. (signed index, 0x9000 area).
   -> levels/chr_data/famidash/saw_tiles.bin (48 tiles, raw NES colour indices; saw
      metatiles use palette 0 = sky, darker sky, black, white like Famidash)
   -> saw metatile table in src/graphics/tile_patch_tables.h

2. Block set B (Clutterfunk, CGB only). Famidash picks the block CHR bank per level.
   Pocket Dash's sheet has set A/C art; the tiles whose set-B art differs are
   overwritten at level start (normal + mirrored copy).
   -> levels/chr_data/famidash/blocks_b_patch.bin (per tile: 16 bytes + 16 bytes mirrored)

usage: python tools/make_level_tile_patches.py [--famidash PATH]
"""
import argparse
import itertools
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SAW_VRAM_BASE = 64
SAW_FIRST, SAW_LAST = 0xC0, 0xEF


def nes_rows(d, t):
    return [[((d[t * 16 + r] >> (7 - x)) & 1) | (((d[t * 16 + 8 + r] >> (7 - x)) & 1) << 1) for x in range(8)]
            for r in range(8)]


def gb_bytes(rows):
    out = bytearray()
    for row in rows:
        b0 = b1 = 0
        for v in row:
            b0 = (b0 << 1) | (v & 1)
            b1 = (b1 << 1) | ((v >> 1) & 1)
        out += bytes([b0, b1])
    return bytes(out)


def gb_rows(data, t):
    return [[((data[t * 16 + 2 * r] >> (7 - x)) & 1) | (((data[t * 16 + 2 * r + 1] >> (7 - x)) & 1) << 1)
             for x in range(8)] for r in range(8)]


DMG_BG_SLOTS = 144                  # DMG BG tiles 0..143 (144..159 = coin sprite tiles)
DMG_RESERVED_TILES = [12, 26] + list(range(48, 54))   # blank, black fill, ground (used by code)
DMG_BLOCK_MAP = {0: 0, 1: 1, 2: 3, 3: 2}   # NES sky, darker sky, black fill, white outline


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--famidash", default=r"C:\Users\soter\Source\Repos\famidash-main")
    args = ap.parse_args()
    fd = Path(args.famidash)
    tiles_dir = fd / "GRAPHICS" / "Level Tiles"
    inc = (fd / "METATILES" / "metatiles.inc").read_text()
    names = re.findall(r'^Metatile\s+"([^"]+)"', inc, re.M)
    nes_mt = [[int(a, 16), int(b, 16), int(c, 16), int(d, 16)] for a, b, c, d in
              re.findall(r'^Metatile\s+"[^"]+",\s*\$(\w\w),\s*\$(\w\w),\s*\$(\w\w),\s*\$(\w\w)', inc, re.M)]
    assert len(nes_mt) == 256

    src = (ROOT / "include" / "famidash_metatiles_dmg.c").read_text()

    def table(name):
        a = src.index(name)
        b = src.index('};', a)
        return [list(map(int, m)) for m in re.findall(r'\{ (\d+), (\d+), (\d+), (\d+) \}', src[a:b])]
    pd_mt = table('const uint8_t metatiles[FAMIDASH_NUM_METATILES][4]')

    out_dir = ROOT / "levels" / "chr_data" / "famidash"

    # 1. saws
    saw = (tiles_dir / "SawbladesA.chr").read_bytes()
    saw_bin = bytearray()
    for t in range(SAW_FIRST, SAW_LAST + 1):
        saw_bin += gb_bytes(nes_rows(saw, t - 0xC0))
    (out_dir / "saw_tiles.bin").write_bytes(saw_bin)

    saw_mts = []
    for i, m in enumerate(nes_mt):
        if "SAW" not in names[i]:
            continue
        if not any(SAW_FIRST <= t <= SAW_LAST for t in m):
            continue
        saw_mts.append((i, [SAW_VRAM_BASE + t - SAW_FIRST if SAW_FIRST <= t <= SAW_LAST else 0xFF for t in m]))

    # 2. block set B patch (Clutterfunk)
    blocks = {n: (tiles_dir / ("Blocks%s.chr" % n)).read_bytes() for n in "ABCD"}
    sheet = (ROOT / "levels" / "chr_data" / "chr_gb_dmg_tiles.bin").read_bytes()
    # any NES colour -> sheet colour mapping (the sheet sometimes merges two NES colours)
    perms = list(itertools.product(range(4), repeat=4))

    def best(nes, gb):
        flat_n = [v for r in nes for v in r]
        flat_g = [v for r in gb for v in r]
        return max(sum(1 for a, b in zip(flat_n, flat_g) if p[a] == b) for p in perms)

    nes2pd = {}
    for n, p in zip(nes_mt, pd_mt):
        for a, b in zip(n, p):
            if a and b != 12:
                nes2pd.setdefault(a, set()).add(b)
    level = (ROOT / "levels" / "level_data" / "clutterfunk_16high.bin").read_bytes()
    used = sorted(set(t for i in set(level) for t in nes_mt[i] if 0x40 <= t < 0x80))
    patch_tiles = []
    patch_bin = bytearray()
    patch_dmg_bin = bytearray()
    for t in used:
        for p in sorted(nes2pd.get(t, ())):
            g = gb_rows(sheet, p)
            scores = {n: best(nes_rows(blocks[n], t - 0x40), g) for n in "ABCD"}
            rep = max(scores, key=scores.get)   # which Famidash set this tile of the sheet shows
            b = nes_rows(blocks["B"], t - 0x40)
            if b == nes_rows(blocks[rep], t - 0x40):
                continue
            patch_tiles.append(p)
            patch_bin += gb_bytes(b) + gb_bytes([row[::-1] for row in b])
            # DMG: the sheet's block shading (fill 3, outline 2, sky 0/1)
            bd = [[DMG_BLOCK_MAP[v] for v in row] for row in b]
            patch_dmg_bin += gb_bytes(bd) + gb_bytes([row[::-1] for row in bd])
    (out_dir / "blocks_b_patch.bin").write_bytes(patch_bin)
    (out_dir / "blocks_b_patch_dmg.bin").write_bytes(patch_dmg_bin)

    # 3. DMG per-level tile layout (Famidash-style: only what the level uses is loaded).
    # BG tiles 144..159 share VRAM with sprite tiles 144..159, which hold the coins on
    # DMG. Tiles a level uses there, and its saw tiles, go to BG slots the level leaves
    # free; the level gets a remapped metatile table in WRAM.
    # saws are black/white like the BLACK_* blocks: shade them the same way
    saw_map = DMG_BLOCK_MAP
    saw_dmg_bin = bytearray()
    for t in range(SAW_FIRST, SAW_LAST + 1):
        r = [[saw_map[v] for v in row] for row in nes_rows(saw, t - 0xC0)]
        saw_dmg_bin += gb_bytes(r) + gb_bytes([row[::-1] for row in r])
    (out_dir / "saw_tiles_dmg.bin").write_bytes(saw_dmg_bin)

    assets = (ROOT / "src" / "assets.c").read_text()
    order = re.findall(r'&(level_\w+)', assets.split("game_levels[] = {")[1].split("};")[0])
    ident = dict(re.findall(r'const Level (level_\w+) = \{.*?\n\s*(\w+)_map,', assets, re.S))
    saw_of = dict(saw_mts)
    remaps = []
    for lv in order:
        level_mts = set((ROOT / "levels" / "level_data" / ("%s_16high.bin" % ident[lv])).read_bytes())
        used_t = set(DMG_RESERVED_TILES)
        saw_k = set()
        for m in level_mts:
            for q in range(4):
                st = saw_of[m][q] if m in saw_of else 0xFF
                if st != 0xFF:
                    saw_k.add(st - SAW_VRAM_BASE)
                else:
                    used_t.add(pd_mt[m][q])
        high = sorted(t for t in used_t if t >= DMG_BG_SLOTS)
        if not high and not saw_k:
            remaps.append((lv, None))
            continue
        free = [s for s in range(DMG_BG_SLOTS) if s not in used_t]
        need = len(high) + len(saw_k)
        if need > len(free):
            raise SystemExit("%s: needs %d free DMG BG slots, has %d" % (ident[lv], need, len(free)))
        moves = list(zip(free, high))
        saw_slot = dict(zip(sorted(saw_k), free[len(high):]))
        over = [(m, q, saw_slot[saw_of[m][q] - SAW_VRAM_BASE]) for m in sorted(level_mts) if m in saw_of
                for q in range(4) if saw_of[m][q] != 0xFF]
        data = [len(moves)] + [v for mv in moves for v in mv] + \
               [len(saw_slot)] + [v for k in sorted(saw_slot) for v in (saw_slot[k], k)] + \
               [len(over)] + [v for o in over for v in o]
        remaps.append((lv, data))
        print("DMG %s: %d tiles moved above slot %d, %d saw tiles, %d free slots left"
              % (ident[lv], len(moves), DMG_BG_SLOTS, len(saw_slot), len(free) - need))

    lines = [
        "/* Generated by tools/make_level_tile_patches.py - do not edit */",
        "#ifndef TILE_PATCH_TABLES_H",
        "#define TILE_PATCH_TABLES_H",
        "",
        "#define SAW_VRAM_BASE %d" % SAW_VRAM_BASE,
        "#define SAW_TILE_COUNT %d" % (SAW_LAST - SAW_FIRST + 1),
        "#define SAW_MT_COUNT %d" % len(saw_mts),
        "",
        "// Saw metatiles: metatile id and its 4 tiles in CGB VRAM bank 1 (0xFF = keep the sheet tile)",
        "// saw_mt_index[metatile] = row in saw_mt_tiles + 1, 0 = not a saw",
        "static const uint8_t saw_mt_index[256] = {",
    ]
    idx = [0] * 256
    for k, (i, _) in enumerate(saw_mts):
        idx[i] = k + 1
    for r in range(0, 256, 16):
        lines.append("    " + ", ".join(str(v) for v in idx[r:r + 16]) + ",")
    lines += [
        "};",
        "static const uint8_t saw_mt_tiles[SAW_MT_COUNT][4] = {",
    ]
    for i, tl in saw_mts:
        lines.append("    { %s }, /* %s */" % (", ".join("0x%02X" % v for v in tl), names[i]))
    lines += [
        "};",
        "",
        "#define BLOCKS_B_PATCH_COUNT %d" % len(patch_tiles),
        "// Sheet tiles replaced by Famidash block set B art (Clutterfunk)",
        "static const uint8_t blocks_b_patch_tiles[BLOCKS_B_PATCH_COUNT] = { %s };" % ", ".join(map(str, patch_tiles)),
        "",
        "// DMG per-level layout: BG tiles 0..%d; sprite tiles %d..159 hold the coins" % (DMG_BG_SLOTS - 1, DMG_BG_SLOTS),
        "#define DMG_BG_SLOTS %d" % DMG_BG_SLOTS,
        "// Per level (game_levels order), NULL = the sheet as is. Otherwise:",
        "// n, n x (dst slot, src tile)   sheet tiles >= DMG_BG_SLOTS copied down",
        "// n, n x (dst slot, saw tile)  saw tiles (saw_tiles_dmg.bin, normal + mirrored)",
        "// n, n x (metatile, quarter, tile)  saw metatile tiles",
    ]
    for lv, data in remaps:
        if data:
            lines.append("static const uint8_t dmg_remap_%s[] = { %s };" % (lv, ", ".join(map(str, data))))
    lines += [
        "#define DMG_REMAP_LEVELS %d" % len(remaps),
        "static const uint8_t * const dmg_level_remap[DMG_REMAP_LEVELS] = {",
    ]
    for lv, data in remaps:
        lines.append("    %s, // %s" % (("dmg_remap_" + lv) if data else "0", ident[lv]))
    lines += [
        "};",
        "",
        "#endif",
        "",
    ]
    (ROOT / "src" / "graphics" / "tile_patch_tables.h").write_text("\n".join(lines), newline="\n")
    print("saw metatiles:", [names[i] for i, _ in saw_mts])
    print("block B patch tiles:", patch_tiles)


if __name__ == "__main__":
    main()
