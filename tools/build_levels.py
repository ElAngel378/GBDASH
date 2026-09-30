import os
import sys
import glob
import re
import struct
import subprocess
import xml.etree.ElementTree as ET
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TMX_DIR = REPO_ROOT / "levels" / "chr_data" / "tmx"
LEVEL_DATA_DIR = REPO_ROOT / "levels" / "level_data"
SRC_DIR = REPO_ROOT / "src"
MUSIC_DIR = SRC_DIR / "music"
ROOT_MUSIC_DIR = REPO_ROOT / "music"
UGE2SOURCE_BIN = REPO_ROOT / "tools" / ("uge2source.exe" if os.name == "nt" else "uge2source")
SPRITES_DIR = SRC_DIR / "sprites"
LEVELS_DIR = SRC_DIR / "levels"
ASSETS_C_PATH = SRC_DIR / "assets.c"

KNOWN_LEVELS = {
    "stereomadness": {"title": "STEREO MADNESS", "divider": 192, "order": 1, "short": "sm"},
    "backontrack":   {"title": "BACK ON TRACK",   "divider": 184, "order": 2, "short": "bot"},
    "polargeist":    {"title": "POLARGEIST",      "divider": 193, "order": 3, "short": "pg"},
    "dryout":        {"title": "DRY OUT",         "divider": 185, "order": 4, "short": "du"},
    "baseafterbase": {"title": "BASE AFTER BASE", "divider": 183, "order": 5, "short": "bab"},
    "cantletgo":     {"title": "CANT LET GO",     "divider": 196, "order": 6, "short": "clg"},
    "jumper":        {"title": "JUMPER",          "divider": 142, "order": 7, "short": "ju"},
    "timemachine":   {"title": "TIME MACHINE",    "divider": 41,  "order": 8, "short": "tm"},
    "cycles":        {"title": "CYCLES",          "divider": 183, "order": 9, "short": "cy"},
    "xstep":         {"title": "XSTEP",           "divider": 138, "order": 10, "short": "xs"},
    "ultiatedestruction": {"title": "UTLIMATE DESTCTN", "divider": 183, "order": 11, "short": "ultiatedestruction"},
    # 1.4 levels (music converted from Famidash by tools/famidash_song_to_huge.py)
    "clutterfunk":   {"title": "CLUTTERFUNK",     "divider": 195, "order": 12, "short": "cf"},
}

def read_uge_tempo(uge_path):
    """
    Extracts (divider/TMA, ticks_per_row) from a hUGETracker .uge file.
    Offset 63609: ticks_per_row (uint32)
    Offset 63613: timer_enabled (uint8)
    Offset 63614: timer_divider / TMA (uint32)
    """
    try:
        with open(uge_path, 'rb') as f:
            d = f.read()
        if len(d) >= 63618:
            ticks, = struct.unpack_from('<I', d, 63609)
            timer_en = d[63613]
            divider, = struct.unpack_from('<I', d, 63614)
            if timer_en and 0 <= divider <= 255:
                return divider, ticks
    except Exception as e:
        print(f"  Warning reading tempo from {uge_path}: {e}")
    return None, None

def find_uge_file(stem):
    """
    Finds a matching .uge file in music/ for a given level stem.
    Normalizes names (alphanumeric only) and handles common aliases.
    """
    if not ROOT_MUSIC_DIR.exists():
        return None
    norm_stem = re.sub(r'[^a-z0-9]', '', stem.lower())
    aliases = {
        'ultiatedestruction': 'ultimate',
        'ultimatedestruction': 'ultimate',
    }
    target = aliases.get(norm_stem, norm_stem)
    for p in ROOT_MUSIC_DIR.glob('*.uge'):
        if re.sub(r'[^a-z0-9]', '', p.stem.lower()) == target:
            return p
    return None

def format_title(stem):
    return stem.replace("_", " ").replace("-", " ").upper()

def make_c_ident(name):
    return re.sub(r'[^a-zA-Z0-9_]', '_', name.lower())

def get_map_dimensions(tmx_path):
    tree = ET.parse(tmx_path)
    root = tree.getroot()
    width = int(root.attrib.get('width', 0))
    height = int(root.attrib.get('height', 0))
    return width, height

def export_binary_map(tmx_path, out_bin_path):
    tree = ET.parse(tmx_path)
    root = tree.getroot()

    width = int(root.attrib['width'])
    height = int(root.attrib['height'])

    bg_layer = None
    for layer in root.findall('layer'):
        if layer.get('name') in ['Tile Layer 1', 'background', 'BG', 'Level']:
            bg_layer = layer
            break
    if bg_layer is None:
        bg_layer = root.find('layer')

    data_el = bg_layer.find('data')
    if data_el is None or data_el.get('encoding') != 'csv':
        raise ValueError(f"Expected CSV encoding in {tmx_path}")

    csv_text = data_el.text.strip()
    raw_tiles = [int(x.strip()) for x in csv_text.split(',') if x.strip()]

    grid = []
    for y in range(height):
        row = raw_tiles[y * width : (y + 1) * width]
        row_0based = [(tid - 1 if tid > 0 else 0) for tid in row]
        grid.append(row_0based)

    crop_height = 16
    start_y = max(0, height - crop_height)
    cropped_grid = grid[start_y:height]

    while len(cropped_grid) < crop_height:
        cropped_grid.insert(0, [0] * width)

    os.makedirs(out_bin_path.parent, exist_ok=True)
    with open(out_bin_path, 'wb') as f:
        for x in range(width):
            for y in range(crop_height):
                f.write(bytes([cropped_grid[y][x] & 0xFF]))

def update_music_bank(music_path, target_bank):
    if not music_path.exists():
        return
    with open(music_path, 'r') as f:
        content = f.read()

    if re.search(r'#pragma\s+bank', content):
        new_content = re.sub(r'#pragma\s+bank\s+\d+', f'#pragma bank {target_bank}', content)
    else:
        new_content = f'#pragma bank {target_bank}\n\n' + content
    new_content = re.sub(r'__at\(\d+\)', f'__at({target_bank})', new_content)

    if new_content != content:
        with open(music_path, 'w') as f:
            f.write(new_content)

def generate_assets_c(levels):
    with open(ASSETS_C_PATH, 'w') as f:
        f.write('// Auto-generated by tools/build_levels.py - DO NOT EDIT DIRECTLY\n')
        f.write('#include <gbdk/incbin.h>\n')
        f.write('#include "assets.h"\n')
        f.write('#include "../levels/chr_data/chr_gb.h"\n\n')

        f.write('BANKREF(game_levels)\n')
        f.write('BANKREF_EXTERN(chr_gb)\n')
        f.write('extern const uint8_t chr_gb_tiles[];\n')
        f.write('extern const uint8_t chr_gb_tiles_rev[];\n\n')

        # External map declarations
        f.write('// External map data definitions from level files\n')
        for lvl in levels:
            ident = lvl["ident"]
            f.write(f'BANKREF_EXTERN({ident}_map)\n')
            f.write(f'extern const uint8_t {ident}_map[];\n')
        f.write('\n')

        # External sprite declarations
        f.write('// External sprite data definitions\n')
        for lvl in levels:
            ident = lvl["ident"]
            f.write(f'extern const SpDef {ident}_sp[];\n')
            f.write(f'extern const SpDef {ident}_sp_dmg[];\n')
            f.write(f'BANKREF_EXTERN({ident}_sp)\n')
        f.write('\n')

        # External music declarations
        f.write('// Music songs\n')
        for lvl in levels:
            if lvl["has_music"]:
                f.write(f'extern const hUGESong_t {lvl["ident"]};\n')
        f.write('\n')

        # level_songs array
        f.write('// Level songs array\n')
        f.write('const hUGESong_t * const level_songs[] = {\n')
        for lvl in levels:
            if lvl["has_music"]:
                f.write(f'  &{lvl["ident"]}, // level_{lvl["short_name"]}\n')
            else:
                f.write(f'  NULL, // level_{lvl["short_name"]} (silent)\n')
        f.write('};\n\n')

        # song_bank array
        f.write('// Per-level song banks: matches level_songs[]; 0 = silent\n')
        f.write('const uint8_t song_bank[] = {\n')
        for lvl in levels:
            f.write(f'  {lvl["music_bank"]}u, // level_{lvl["short_name"]}\n')
        f.write('};\n\n')

        # Level struct definitions
        f.write('// Level definitions with dimensions and bank info\n')
        for lvl in levels:
            ident = lvl["ident"]
            f.write(f'const Level level_{lvl["short_name"]} = {{\n')
            f.write(f'  "{lvl["title"]}",\n')
            f.write('  chr_gb_tiles,\n')
            f.write('  chr_gb_tiles_rev,\n')
            f.write(f'  {ident}_map,\n')
            f.write(f'  chr_gb_TILE_COUNT, {lvl["width"]}, {lvl["height"]}, 0, 0,\n')
            f.write(f'  BANK({ident}_map),\n')
            f.write(f'  {lvl["divider"]},\n')
            f.write(f'  {ident}_sp,\n')
            f.write(f'  BANK({ident}_sp),\n')
            f.write(f'  {ident}_sp_dmg\n')
            f.write('};\n\n')

        # game_levels array
        f.write('// Global level list used by the menu and gameplay systems\n')
        f.write('const Level* const game_levels[] = {\n')
        for lvl in levels:
            f.write(f'  &level_{lvl["short_name"]},\n')
        f.write('};\n')
        f.write('const uint8_t MAX_LEVELS = sizeof(game_levels) / sizeof(game_levels[0]);\n')

def find_png2asset():
    candidates = [
        Path("C:/gbdk/bin/png2asset.exe"),
        Path("C:/Users/soter/gbdk-win64/gbdk/bin/png2asset.exe"),
        Path("C:/gbdk/bin/png2asset"),
    ]
    env_gbdk = os.environ.get("GBDK")
    if env_gbdk:
        p = Path(env_gbdk)
        if p.is_file():
            candidates.insert(0, p.parent / ("png2asset.exe" if os.name == "nt" else "png2asset"))
        else:
            candidates.insert(0, p / "bin" / ("png2asset.exe" if os.name == "nt" else "png2asset"))
    for c in candidates:
        if c.exists():
            return c
    return Path("png2asset")

def export_tileset():
    png_path = REPO_ROOT / "levels" / "chr_data" / "chr_gb_neww.png"
    if not png_path.exists():
        return

    p2a = find_png2asset()
    out_c = REPO_ROOT / "levels" / "chr_data" / "chr_gb.c"
    tiles_bin = REPO_ROOT / "levels" / "chr_data" / "chr_gb_tiles.bin"
    flipped_bin = REPO_ROOT / "levels" / "chr_data" / "chr_gb_flipped_tiles.bin"
    mirror_js = REPO_ROOT / "tools" / "mirror_gb_tiles.js"

    print("Exporting tileset from chr_gb_neww.png via png2asset...")
    cmd = [
        str(p2a),
        str(png_path),
        "-o", str(out_c),
        "-map", "-bin", "-keep_duplicate_tiles", "-noflip"
    ]
    res = subprocess.run(cmd, cwd=str(REPO_ROOT), capture_output=True, text=True)
    if res.returncode != 0:
        print(f"  Warning: png2asset failed: {res.stderr}")
        return

    # Clean up unnecessary map/palette binaries produced by png2asset
    for extra in [
        REPO_ROOT / "levels" / "chr_data" / "chr_gb_map.bin",
        REPO_ROOT / "levels" / "chr_data" / "chr_gb_palettes.bin"
    ]:
        if extra.exists():
            extra.unlink()

    # Generate flipped tiles binary for mirror mode using tools/mirror_gb_tiles.js
    if mirror_js.exists() and tiles_bin.exists():
        print("Mirroring tileset for mirror mode using tools/mirror_gb_tiles.js...")
        subprocess.run(["node", str(mirror_js), str(tiles_bin), str(flipped_bin)], cwd=str(REPO_ROOT), check=True)

    # Touch src/graphics/tileset.c so make always detects the tileset binary update
    tileset_c = REPO_ROOT / "src" / "graphics" / "tileset.c"
    if tileset_c.exists():
        tileset_c.touch()

def build_all(export_tiles=False, export_metatiles=False):
    print("=== Pocket Dash Automated Level Pipeline ===")

    # 1. Export tileset and generate flipped tiles (disabled by default to avoid clobbering metatiles/bin files)
    if export_tiles:
        export_tileset()

    os.makedirs(LEVEL_DATA_DIR, exist_ok=True)
    os.makedirs(MUSIC_DIR, exist_ok=True)
    os.makedirs(SPRITES_DIR, exist_ok=True)
    os.makedirs(LEVELS_DIR, exist_ok=True)

    tmx_files = [p for p in TMX_DIR.glob("*.tmx") if p.stem.lower() != "template"]

    def sort_key(p):
        stem = p.stem.lower()
        if stem in KNOWN_LEVELS:
            return (0, KNOWN_LEVELS[stem]["order"], stem)
        return (1, 999, stem)

    tmx_files.sort(key=sort_key)
    print(f"Found {len(tmx_files)} level(s): {[p.stem for p in tmx_files]}")

    # Auto-export menuLoop if present
    menu_uge = ROOT_MUSIC_DIR / "menuLoop.uge"
    if menu_uge.exists() and UGE2SOURCE_BIN.exists():
        menu_c = SRC_DIR / "menuloop.c"
        cmd = [str(UGE2SOURCE_BIN), str(menu_uge), "-b", "1", "menuloop", str(menu_c)]
        res = subprocess.run(cmd, capture_output=True, text=True)
        if res.returncode == 0:
            print(f"Exported menuLoop: {menu_uge.name} -> {menu_c.name} (Bank 1)")
        else:
            print(f"Warning: uge2source failed for menuLoop.uge: {res.stderr}")

    levels_info = []

    BASE_MAP_BANK = 30
    PARALLAX_BANK_FIRST = 41
    PARALLAX_BANK_COUNT = 4
    BASE_SPRITE_BANK = 100
    BASE_MUSIC_BANK = 200

    sys.path.insert(0, str(REPO_ROOT / "tools"))
    from tmx2sprites import extract_portals

    for idx, tmx_path in enumerate(tmx_files):
        stem = tmx_path.stem.lower()
        ident = make_c_ident(stem)
        map_bank = BASE_MAP_BANK + idx
        # Banks 41..44 hold the parallax background phases: skip them
        if map_bank >= PARALLAX_BANK_FIRST:
            map_bank += PARALLAX_BANK_COUNT
        sprite_bank = BASE_SPRITE_BANK + idx
        music_bank = BASE_MUSIC_BANK + idx

        if stem in KNOWN_LEVELS:
            meta = KNOWN_LEVELS[stem]
            title = meta["title"]
            divider = meta["divider"]
            short_name = meta["short"]
        else:
            title = format_title(stem)
            divider = 180
            short_name = ident

        print(f"\n[{idx+1}/{len(tmx_files)}] Processing {title} ({stem})...")

        out_bin = LEVEL_DATA_DIR / f"{ident}_16high.bin"
        export_binary_map(tmx_path, out_bin)
        width, height = get_map_dimensions(tmx_path)
        print(f"  - Map binary: {out_bin.name} ({width}x16 metatiles)")

        out_sprites_c = SPRITES_DIR / f"{ident}_sprites.c"
        extract_portals(str(tmx_path), str(out_sprites_c), ident, sprite_bank)
        print(f"  - Sprites: {out_sprites_c.name} (Bank {sprite_bank})")

        out_level_c = LEVELS_DIR / f"level_{short_name}.c"
        with open(out_level_c, 'w') as f:
            f.write(f"#pragma bank {map_bank}\n")
            f.write('#include <gbdk/incbin.h>\n\n')
            f.write(f'INCBIN({ident}_map, "levels/level_data/{ident}_16high.bin")\n')
            f.write(f'INCBIN_EXTERN({ident}_map)\n')
        print(f"  - Level wrapper: {out_level_c.name} (Bank {map_bank})")

        music_file = MUSIC_DIR / f"{ident}.c"
        uge_file = find_uge_file(stem)

        if uge_file and UGE2SOURCE_BIN.exists():
            uge_divider, uge_ticks = read_uge_tempo(uge_file)
            if uge_divider is not None:
                divider = uge_divider
                print(f"  - Music tempo: auto-detected TMA divider = {divider} (ticks={uge_ticks}) from {uge_file.name}")
            else:
                print(f"  - Music tempo: {uge_file.name} does not have timer enabled, using divider = {divider}")

            cmd = [str(UGE2SOURCE_BIN), str(uge_file), "-b", str(music_bank), ident, str(music_file)]
            res = subprocess.run(cmd, capture_output=True, text=True)
            if res.returncode == 0:
                print(f"  - Music: exported {uge_file.name} -> {music_file.name} (Bank {music_bank})")
                has_music = True
            else:
                print(f"  - Warning: uge2source failed for {uge_file.name}: {res.stderr}")
                has_music = music_file.exists()
                if has_music:
                    update_music_bank(music_file, music_bank)
        elif music_file.exists():
            has_music = True
            update_music_bank(music_file, music_bank)
            print(f"  - Music: Using existing {music_file.name} (Bank {music_bank})")
        else:
            has_music = False
            print(f"  - Music: Not found for {stem} (Will play silent)")

        levels_info.append({
            "ident": ident,
            "short_name": short_name,
            "title": title,
            "width": width,
            "height": 16,
            "map_bank": map_bank,
            "sprite_bank": sprite_bank,
            "music_bank": music_bank if has_music else 0,
            "divider": divider,
            "has_music": has_music
        })

    print("\nGenerating src/assets.c...")
    generate_assets_c(levels_info)

    print("\nConverting mirror portals...")
    subprocess.run([sys.executable, "tools/convert_mirror_portals.py"], cwd=str(REPO_ROOT), check=True)

    if (REPO_ROOT / "endStart_02.ogg").exists():
        print("Converting level complete SFX...")
        subprocess.run([sys.executable, "tools/convert_end_sfx.py"], cwd=str(REPO_ROOT), check=True)

    # 2. Update Sprite VRAM / Metatile packing (disabled by default to avoid clobbering metatiles/bin files)
    if export_metatiles:
        print("Updating Sprite VRAM packing...")
        subprocess.run(["node", "tools/build_dmg_sprite_vram.js"], cwd=str(REPO_ROOT), check=True)

    print("\n=== Level Pipeline Completed Successfully! ===")

if __name__ == "__main__":
    export_tiles = "--export-tileset" in sys.argv
    export_metatiles = "--export-metatiles" in sys.argv or "--full" in sys.argv
    build_all(export_tiles=export_tiles, export_metatiles=export_metatiles)