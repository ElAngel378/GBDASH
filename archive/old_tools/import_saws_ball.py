"""Imports the saw and mini ball art from the GDP CHR files into the game's source images.

    python tools/import_saws_ball.py            (reads archive/raw_assets/GDP Saws.chr / GDP Mini Ball.chr)
    python tools/build_bg_tiles.py
    python tools/build_sprite_tiles.py

The CHR files are GB 2bpp tile sheets (16 tiles per row). This tool does not copy their tiles
anywhere: it redraws the art into the layouts the game already uses, so nothing moves.

Saws (levels/chr_data/bg_tiles.png)
    The CHR holds 3 saws: 42x42 (big), 32x32 (medium), 16x16 (small). Raw colours: 1 = teeth,
    2 = ring, 3 = hub. Like Famidash's saws (black blade, a ring darker than the sky, and the sky
    showing through the middle), teeth -> 2 (black), ring -> 1 (darker than the sky), hub -> 0
    (the sky colour). On DMG that is black / dark grey / the light grey sky.
    Each saw is drawn into the existing saw tile layout of build_bg_tiles.py (SAW_METATILES) as
    3 animation frames, rotated anticlockwise by a third of the saw's tooth angle per frame
    (big 16 teeth: 7.5 deg, medium 12 teeth: 10 deg, small 8 teeth: 15 deg), so the 3 frames
    loop. The big saw's centre metatile (120) gets its own 4 tiles (0x30..0x33).
    Frame 0 goes to SAWS_0 (rows 11..14), frames 1 and 2 to SAWS_1 / SAWS_2 (rows 22..29).

Mini ball (levels/chr_data/sprite_tiles.png, sprite pair 62 = tile 124)
    GDP Mini Ball.chr holds a big ring and two small balls (labelled 1 and 2). Only a small ball
    is imported, as the mini ball (the big ball is not touched): spikes -> 3 (black), body -> 2
    (player colour 1), centre -> 1 (player colour 2). MINI_BALL_VARIANT picks 1 or 2.
"""
import math
import sys
from collections import Counter
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
BG_PNG = ROOT / "levels" / "chr_data" / "bg_tiles.png"
SPR_PNG = ROOT / "levels" / "chr_data" / "sprite_tiles.png"
RAW = ROOT / "archive" / "raw_assets"

# CHR bounding boxes (x, y, size) of the saws and their tooth counts
SAWS = {"big": (75, 19, 42, 16), "med": (16, 24, 32, 12), "small": (56, 32, 16, 8)}
SAW_COLOURS = {0: 0, 1: 2, 2: 1, 3: 0}
MINI_BALL_VARIANT = 1      # 1 or 2: which of the two small balls in the CHR
MINI_BALL_PAIR = 62        # sprite pair of the mini ball (tile 124)
SAW_FRAMES = 3
SAW_SECTION_TILES = 52
SAW_SECTION_ROWS = {0: 11, 1: 22, 2: 26}      # first png tile row of each frame's section
OLD_SAW_ROWS = range(11, 17)                  # the previous SAWS_CGB / SAWS_DMG art

# tile ids inside a saw section (see SAW_METATILES in build_bg_tiles.py)
BIG_IDS = [
    [None, 0x01, 0x02, 0x03, 0x04, None],
    [0x10, 0x11, 0x12, 0x13, 0x14, 0x15],
    [0x06, 0x07, 0x30, 0x31, 0x08, 0x09],
    [0x16, 0x17, 0x32, 0x33, 0x18, 0x19],
    [0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F],
    [None, 0x1B, 0x1C, 0x1D, 0x1E, None],
]
MED_IDS = [[0x20 + r * 4 + c for c in range(4)] for r in range(4)]
SMALL_IDS = [[0x00, 0x05], [0x1A, 0x1F]]


def load_chr(path):
    d = Path(path).read_bytes()
    img = [[0] * 128 for _ in range(len(d) // 16 // 16 * 8)]
    for t in range(len(d) // 16):
        for y in range(8):
            lo, hi = d[t * 16 + 2 * y], d[t * 16 + 2 * y + 1]
            for x in range(8):
                img[(t // 16) * 8 + y][(t % 16) * 8 + x] = ((hi >> (7 - x)) & 1) << 1 | ((lo >> (7 - x)) & 1)
    return img


def crop(img, x0, y0, n):
    return [[img[y0 + y][x0 + x] for x in range(n)] for y in range(n)]


def rotate(c, deg, ss=4):
    """Rotates anticlockwise about the centre; every pixel is the majority of ss*ss samples."""
    n = len(c)
    cx = cy = n / 2
    a = math.radians(deg)
    ca, sa = math.cos(a), math.sin(a)
    out = [[0] * n for _ in range(n)]
    for y in range(n):
        for x in range(n):
            votes = Counter()
            for j in range(ss):
                for i in range(ss):
                    px = x + (i + 0.5) / ss - cx
                    py = y + (j + 0.5) / ss - cy
                    sx = int(math.floor(ca * px - sa * py + cx))
                    sy = int(math.floor(sa * px + ca * py + cy))
                    votes[c[sy][sx] if 0 <= sx < n and 0 <= sy < n else 0] += 1
            out[y][x] = votes.most_common(1)[0][0]
    return out


def png_values(img):
    """png pixel value that stands for each Game Boy colour index (white 0 .. black 3)"""
    value = {}
    if img.mode == "P":
        pal = img.getpalette()
        for i in range(len(pal) // 3):
            g = pal[i * 3]
            k = min(range(4), key=lambda q: abs(g - (255 - 85 * q)))
            value.setdefault(k, i)
    elif img.mode == "L":
        value = {k: 255 - 85 * k for k in range(4)}
    else:
        raise SystemExit("unsupported png mode " + img.mode)
    return value


def put_tile(png_px, raw_of, tile_row_x, tile_row_y, pixels):
    for y in range(8):
        for x in range(8):
            png_px[tile_row_x + x, tile_row_y + y] = raw_of(pixels[y][x])


def import_saws(chr_path):
    src = load_chr(chr_path)
    sheet = Image.open(BG_PNG)
    height = 30 * 8
    img = Image.new(sheet.mode, (128, max(sheet.height, height)), 0)
    if sheet.mode == "P":
        img.putpalette(sheet.getpalette())
    img.paste(sheet, (0, 0))
    px = img.load()
    value = png_values(img)
    colour = lambda v: value[v]

    def clear(row0, rows):
        for y in range(row0 * 8, (row0 + rows) * 8):
            for x in range(128):
                px[x, y] = colour(0)

    clear(OLD_SAW_ROWS.start, len(OLD_SAW_ROWS))
    for row0 in SAW_SECTION_ROWS.values():
        clear(row0, 4)

    crops = {k: crop(src, x, y, n) for k, (x, y, n, _) in SAWS.items()}
    for f in range(SAW_FRAMES):
        base_row = SAW_SECTION_ROWS[f]

        def place(tile_id, pixels):
            tx = (tile_id % 16) * 8
            ty = (base_row + tile_id // 16) * 8
            put_tile(px, lambda v: colour(SAW_COLOURS[v]), tx, ty, pixels)

        for key, ids, canvas in (("big", BIG_IDS, 48), ("med", MED_IDS, 32), ("small", SMALL_IDS, 16)):
            x, y, n, teeth = SAWS[key]
            r = rotate(crops[key], f * 360.0 / teeth / SAW_FRAMES)
            off = (canvas - n) // 2
            full = [[0] * canvas for _ in range(canvas)]
            for yy in range(n):
                for xx in range(n):
                    full[yy + off][xx + off] = r[yy][xx]
            for ty, row in enumerate(ids):
                for tx, tid in enumerate(row):
                    tile = [full[ty * 8 + yy][tx * 8: tx * 8 + 8] for yy in range(8)]
                    if tid is None:
                        assert not any(any(t) for t in tile), "saw pixels in an unused tile"
                        continue
                    place(tid, tile)
    img.save(BG_PNG)
    print("saws: 3 frames written to", BG_PNG.name)


def import_mini_ball(chr_path):
    """The two small balls in the CHR (tiles 121 and 122, labelled 1 and 2) are mini ball designs;
    MINI_BALL_VARIANT picks one. The mini ball is the top tile of sprite pair 62 (tile 124)."""
    src = load_chr(chr_path)
    col = 9 if MINI_BALL_VARIANT == 1 else 10
    ball = [row[col * 8: col * 8 + 8] for row in src[7 * 8: 8 * 8]]
    mapping = {0: 0, 1: 3, 2: 2, 3: 1}   # spikes -> black outline, body -> player colour 1, centre -> colour 2
    img = Image.open(SPR_PNG)
    px = img.load()
    value = png_values(img)
    x0, y0 = (MINI_BALL_PAIR % 16) * 8, (MINI_BALL_PAIR // 16) * 16
    for y in range(8):
        for x in range(8):
            px[x0 + x, y0 + y] = value[mapping[ball[y][x]]]
    img.save(SPR_PNG)
    print("mini ball: design %d written to %s" % (MINI_BALL_VARIANT, SPR_PNG.name))


if __name__ == "__main__":
    saws = sys.argv[1] if len(sys.argv) > 1 else RAW / "GDP Saws.chr"
    ball = sys.argv[2] if len(sys.argv) > 2 else RAW / "GDP Mini Ball.chr"
    import_saws(saws)
    import_mini_ball(ball)
