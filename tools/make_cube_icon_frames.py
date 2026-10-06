"""In-game rotation frames of the cube icons (icon select icons 0..6).

    python tools/make_cube_icon_frames.py            # frames PNG -> C (creates the PNG if missing)
    python tools/make_cube_icon_frames.py --regen    # (re)make the frames PNG

levels/chr_data/cube_icon_frames.png: one 16 px row per icon, 24 frames of 16x16: 0, 7.5, ...
172.5 degrees clockwise (the game draws 180..352.5 as these flipped both ways). Grey level =
sprite colour: white transparent, light grey 1 (secondary colour), dark grey 2 (primary
colour), black 3. Icon 0 is the original cube: its hand-drawn 15 degree frames from
sprite_tiles.png, RotSprite frames in between. Icons 1..6 come from cube_icons.png, 14x14 like
the original cube (the 15x15 menu icon without its middle row and column), at (1, 1), all
frames RotSprite (Scale2x three times, rotate, sample). They can be touched up by hand in the
PNG: --regen overwrites it.

levels/chr_data/ship_frames.png: the ship, 31 frames of 16x16 from 45 degrees nose down to 45 up
in 3 degree steps (same colours). The old hand-drawn ship frames at 45, 24, 0, -24, -45 degrees,
RotSprite of the level one in between; made when missing or with --regen.

levels/chr_data/ball_frames.png: the ball, 24 frames like a cube icon. Its old hand-drawn frames at
0 and 30 degrees, RotSprite in between; made when missing or with --regen.

src/graphics/cube_icon_frames.c (bank 61, nothing else in it, not even code: GDMA needs 16
byte aligned data): per icon and frame 4 sprite tiles, left 8x16 pair then right pair (64
bytes). The gameplay VBlank handler copies the frame shown into sprite tiles 0..3 / 4..7.
"""
import math
import sys
from collections import deque
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
CUBES = ROOT / "levels" / "chr_data" / "cube_icons.png"
FRAMES = ROOT / "levels" / "chr_data" / "cube_icon_frames.png"
OUT_C = ROOT / "src" / "graphics" / "cube_icon_frames.c"
OUT_H = ROOT / "include" / "cube_icon_frames.h"
FIRST_ICON, NUM_ICONS, NUM_FRAMES = 0, 7, 24
SHIP_PNG = ROOT / "levels" / "chr_data" / "ship_frames.png"
SHIP_FRAMES = 31                     # 45 .. -45 degrees in 3 degree steps
SHIP_IDX = lambda deg: (45 - deg) // 3
HAND_SHIP = {0: 45, 1: 24, 3: 0, 5: -24, 6: -45}   # old hand-drawn frame: its angle (2, 4 were generated)
BALL_PNG = ROOT / "levels" / "chr_data" / "ball_frames.png"
HAND_BALL = {6: 0, 8: 4}             # sprite_tiles.png pair of an old ball frame: its frame (x 7.5 degrees)
SCROLL_SPEED_FP = 714                # gameplay.c: x speed, 8.8 px per frame
STEP = 7.5   # degrees per frame
SHADE = [255, 170, 85, 0]


def icon14(cubes, i):
    """Menu icon i (15x15 greys) -> 14x14 sprite colours (0 outside, 1 secondary, 2 primary, 3 outline)."""
    g = [[{255: 0, 170: 1, 85: 2, 0: 3}[cubes.getpixel((i * 16 + x, y))] for x in range(15)] for y in range(15)]
    out, q = set(), deque()
    for j in range(15):
        for p in ((j, 0), (j, 14), (0, j), (14, j)):
            if g[p[1]][p[0]] in (0, 1) and p not in out:
                out.add(p)
                q.append(p)
    while q:
        x, y = q.popleft()
        for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            a, b = x + dx, y + dy
            if 0 <= a < 15 and 0 <= b < 15 and g[b][a] in (0, 1) and (a, b) not in out:
                out.add((a, b))
                q.append((a, b))
    # menu greys: 3 outline, 2 primary (outer fill), 1 secondary -> sprite 3, 2, 1
    full = [[0 if (x, y) in out else {3: 3, 2: 2}.get(g[y][x], 1) for x in range(15)] for y in range(15)]
    rows = [r for k, r in enumerate(full) if k != 7]
    return [[v for k, v in enumerate(r) if k != 7] for r in rows]


def scale2x(g):
    h, w = len(g), len(g[0])
    o = [[0] * (2 * w) for _ in range(2 * h)]
    for y in range(h):
        for x in range(w):
            e = g[y][x]
            b = g[y - 1][x] if y > 0 else e
            h_ = g[y + 1][x] if y < h - 1 else e
            d = g[y][x - 1] if x > 0 else e
            f = g[y][x + 1] if x < w - 1 else e
            if b != h_ and d != f:
                o[2 * y][2 * x] = d if d == b else e
                o[2 * y][2 * x + 1] = f if b == f else e
                o[2 * y + 1][2 * x] = d if d == h_ else e
                o[2 * y + 1][2 * x + 1] = f if h_ == f else e
            else:
                o[2 * y][2 * x] = o[2 * y][2 * x + 1] = o[2 * y + 1][2 * x] = o[2 * y + 1][2 * x + 1] = e
    return o


def rotate(canvas, angles, cx=8.0, cy=8.0):
    """RotSprite: a 16x16 canvas turned clockwise by each angle (degrees) around (cx, cy)."""
    big = scale2x(scale2x(scale2x(canvas)))   # 128x128
    frames = []
    for deg in angles:
        a = math.radians(deg)
        ca, sa = math.cos(a), math.sin(a)
        f = [[0] * 16 for _ in range(16)]
        for y in range(16):
            for x in range(16):
                # clockwise on screen: sample the source rotated back
                px, py = x + 0.5 - cx, y + 0.5 - cy
                sx, sy = px * ca + py * sa + cx, -px * sa + py * ca + cy
                bx, by = int(math.floor(sx * 8)), int(math.floor(sy * 8))
                if 0 <= bx < 128 and 0 <= by < 128:
                    f[y][x] = big[by][bx]
        frames.append(f)
    return frames


def rotations(ic):
    canvas = [[0] * 16 for _ in range(16)]
    for y in range(14):
        for x in range(14):
            canvas[1 + y][1 + x] = ic[y][x]
    return rotate(canvas, [STEP * k for k in range(NUM_FRAMES)])


def ship_frames():
    """The ship: frame k is tilted 45 - 3k degrees clockwise (0: nose steep down, 15: level, 30:
    steep up). The hand-drawn frames of sprite_tiles.png (pairs 18.. of tiles 36..63) at their
    angles, RotSprite of the level one in between."""
    st = Image.open(ROOT / "levels" / "chr_data" / "sprite_tiles.png").convert("L")
    idx = lambda v: min(range(4), key=lambda i: abs(v - SHADE[i]))

    def hand(f):   # old ship frame f (0 steep down .. 3 level .. 6 steep up), 16x16
        g = [[0] * 16 for _ in range(16)]
        for half in (0, 1):
            pr = 18 + 2 * f + half
            for y in range(16):
                for x in range(8):
                    g[y][half * 8 + x] = idx(st.getpixel(((pr % 16) * 8 + x, (pr // 16) * 16 + y)))
        return g
    gen = rotate(hand(3), [45 - 3 * k for k in range(SHIP_FRAMES)], 8.0, 8.5)
    keep = {SHIP_IDX(a): hand(f) for f, a in HAND_SHIP.items()}
    return [keep.get(k, gen[k]) for k in range(SHIP_FRAMES)]


def default_cube():
    """Icon 0, the original cube: its hand-drawn 15 degree frames from sprite_tiles.png (the
    metasprites of src/graphics/icon1.c composed into 16x16), RotSprite in between."""
    st = Image.open(ROOT / "levels" / "chr_data" / "sprite_tiles.png").convert("L")
    idx = lambda v: min(range(4), key=lambda i: abs(v - SHADE[i]))

    def pair(n, fx, fy):   # 8x16 image of tile pair n
        return [[idx(st.getpixel((n * 8 + (7 - x if fx else x), 15 - y if fy else y))) for x in range(8)]
                for y in range(16)]
    # frames 0..5 of a quarter turn: (left pair, flip y), (right pair = same image, flips)
    quarter = [(0, 0, 0, 1, 0), (1, 0, 1, 1, 1), (2, 0, 2, 1, 1), (3, 0, 3, 1, 0), (2, 1, 2, 1, 0), (1, 1, 1, 1, 0)]
    hand = []
    for li, lfy, ri, rfx, rfy in quarter:
        L, R = pair(li, 0, lfy), pair(ri, rfx, rfy)
        hand.append([L[y] + R[y] for y in range(16)])
    # the original cube looks the same turned 90 degrees: 90..165 = 0..75
    hand = hand + hand
    ic = [row[1:15] for row in hand[0][1:15]]
    gen = rotations(ic)
    return [hand[k // 2] if k % 2 == 0 else gen[k] for k in range(NUM_FRAMES)]


def ball_frames():
    """The ball: 24 frames, 0..172.5 degrees clockwise (the game draws the other half flipped
    both ways). Its old hand-drawn frames (left half; the right half is it turned 180 degrees)
    at 0 and 30 degrees, RotSprite of the first one in between."""
    st = Image.open(ROOT / "levels" / "chr_data" / "sprite_tiles.png").convert("L")
    idx = lambda v: min(range(4), key=lambda i: abs(v - SHADE[i]))

    def hand(pr):
        L = [[idx(st.getpixel(((pr % 16) * 8 + x, (pr // 16) * 16 + y))) for x in range(8)] for y in range(16)]
        return [L[y] + [L[15 - y][7 - x] for x in range(8)] for y in range(16)]
    gen = rotate(hand(6), [STEP * k for k in range(NUM_FRAMES)])
    keep = {k: hand(pr) for pr, k in HAND_BALL.items()}
    return [keep.get(k, gen[k]) for k in range(NUM_FRAMES)]


def main():
    n = NUM_ICONS - FIRST_ICON
    if "--regen" in sys.argv or not FRAMES.exists():
        cubes = Image.open(CUBES).convert("L")
        img = Image.new("L", (NUM_FRAMES * 16, n * 16), 255)
        for r, i in enumerate(range(FIRST_ICON, NUM_ICONS)):
            frames = default_cube() if i == 0 else rotations(icon14(cubes, i))
            for k, f in enumerate(frames):
                for y in range(16):
                    for x in range(16):
                        img.putpixel((k * 16 + x, r * 16 + y), SHADE[f[y][x]])
        img.save(FRAMES)
        print("wrote", FRAMES)

    if "--regen" in sys.argv or not SHIP_PNG.exists():
        img = Image.new("L", (SHIP_FRAMES * 16, 16), 255)
        for k, f in enumerate(ship_frames()):
            for y in range(16):
                for x in range(16):
                    img.putpixel((k * 16 + x, y), SHADE[f[y][x]])
        img.save(SHIP_PNG)
        print("wrote", SHIP_PNG)

    if "--regen" in sys.argv or not BALL_PNG.exists():
        img = Image.new("L", (NUM_FRAMES * 16, 16), 255)
        for k, f in enumerate(ball_frames()):
            for y in range(16):
                for x in range(16):
                    img.putpixel((k * 16 + x, y), SHADE[f[y][x]])
        img.save(BALL_PNG)
        print("wrote", BALL_PNG)

    idx = lambda v: min(range(4), key=lambda i: abs(v - SHADE[i]))
    data = bytearray()

    def add_frame(img, x0, y0):   # left 8x16 pair, right pair
        nonlocal data
        for half in (0, 8):
            for ty in (0, 8):
                for y in range(8):
                    lo = hi = 0
                    for x in range(8):
                        v = idx(img.getpixel((x0 + half + x, y0 + ty + y)))
                        lo = (lo << 1) | (v & 1)
                        hi = (hi << 1) | (v >> 1)
                    data += bytes([lo, hi])
    img = Image.open(FRAMES).convert("L")
    for r in range(n):
        for k in range(NUM_FRAMES):
            add_frame(img, k * 16, r * 16)
    ship_first = len(data) // 64
    img = Image.open(SHIP_PNG).convert("L")
    for k in range(SHIP_FRAMES):
        add_frame(img, k * 16, 0)
    ball_first = len(data) // 64
    img = Image.open(BALL_PNG).convert("L")
    for k in range(NUM_FRAMES):
        add_frame(img, k * 16, 0)
    # |vertical speed| (8.8) from which the ship tilts k steps (3k degrees, rounded): its flight
    # direction, atan(vy / x speed)
    steps = [round(SCROLL_SPEED_FP * math.tan(math.radians(3 * k - 1.5))) for k in range(1, 16)]

    lines = ",\n".join("    " + ", ".join(f"0x{b:02X}" for b in data[i:i + 16]) for i in range(0, len(data), 16))
    OUT_C.write_text(f"""#pragma bank 61
// Generated by tools/make_cube_icon_frames.py from levels/chr_data/cube_icon_frames.png and
// ship_frames.png. Do not edit.
// The only thing in its bank (no code either), so 16 byte aligned: GDMA source.

#include <gb/gb.h>
#include "cube_icon_frames.h"

BANKREF(cube_icon_frames)

const uint8_t cube_icon_frames[{len(data)}] = {{
{lines}
}};
""")
    OUT_H.write_text(f"""// Generated by tools/make_cube_icon_frames.py. Do not edit.
#ifndef CUBE_ICON_FRAMES_H
#define CUBE_ICON_FRAMES_H

#include <gb/gb.h>
#include <stdint.h>

#define CUBE_ICON_FIRST {FIRST_ICON}
#define CUBE_ICON_FRAMES {NUM_FRAMES}   // 0..172.5 degrees in 7.5 degree steps; 180..352.5 = flipped both ways

BANKREF_EXTERN(cube_icon_frames)
extern const uint8_t cube_icon_frames[];   // per icon, per frame: left 8x16 pair, right pair (64 bytes)

// Address of an icon's frame in cube_icon_frames
#define CUBE_ICON_FRAME(icon, frame)     (cube_icon_frames + ((uint16_t)((icon) - CUBE_ICON_FIRST) * CUBE_ICON_FRAMES + (frame)) * 64u)

// Ship frames, after the cube ones: frame k tilted 45 - 3k degrees (0 nose steep down, level, 30 up)
#define SHIP_FRAME_COUNT {SHIP_FRAMES}
#define SHIP_FRAME_LEVEL {SHIP_FRAMES // 2}
#define SHIP_FRAME(k) (cube_icon_frames + ((uint16_t){ship_first} + (k)) * 64u)
// Ball frames, after the ship: 0..172.5 degrees like a cube icon (drawn at x + 0, not x - 1)
#define BALL_FRAME(k) (cube_icon_frames + ((uint16_t){ball_first} + (k)) * 64u)

// |vel_y| (8.8) from which the ship tilts one more step: the frame for its flight direction. An
// initializer, not an array: anything defined here would also land in bank 61 ahead of the frames
#define SHIP_TILT_VY {{ {", ".join(str(v) for v in steps)} }}

#endif
""")
    print(f"{n} icons x {NUM_FRAMES} frames + {SHIP_FRAMES} ship + {NUM_FRAMES} ball frames: {len(data)} bytes")


if __name__ == "__main__":
    main()
