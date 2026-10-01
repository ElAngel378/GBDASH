"""Headless per-section cycle profile of the gameplay loop with Mesen.

    python tools/profile.py --level 9 --dmg --frames 3000

Builds bin/POCKETDASH_prof.gb (make PROFILE=1: section markers, god mode, starts the level
directly; the normal ROM is never touched), runs it as a DMG (--dmg) or CGB in
tools/mesen_profile.lua in Mesen's test runner and prints the report: dropped frames, average /
max cycles per section, the slowest iterations and the camera x of every dropped frame.
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MESEN = Path(r"C:\Users\soter\OneDrive\Documents\Mesen.exe")
ROM = ROOT / "bin" / "POCKETDASH_prof.gb"


def build():
    r = subprocess.run(["make", "-j8", "PROFILE=1"], cwd=ROOT,
                       capture_output=True, text=True)
    if r.returncode != 0 or not ROM.exists():
        sys.exit(r.stdout[-3000:] + r.stderr[-3000:])


def symbol(name):
    noi = (ROOT / "bin" / "POCKETDASH_prof.noi").read_text()
    m = re.search(r"DEF _%s (0x[0-9A-Fa-f]+)" % name, noi)
    if not m:
        sys.exit(f"symbol {name} not found")
    return int(m.group(1), 16)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--level", type=int, default=0)
    ap.add_argument("--dmg", action="store_true")
    ap.add_argument("--frames", type=int, default=3000)
    ap.add_argument("--skip", type=int, default=400, help="frames of level loading to ignore")
    ap.add_argument("--no-build", action="store_true")
    a = ap.parse_args()

    if not a.no_build:
        build()
    rom = ROM
    lua = (ROOT / "tools" / "mesen_profile.lua").read_text()
    lua = (lua.replace("@MARK_ADDR@", hex(symbol("gpmark"))).replace("@CAMX_ADDR@", hex(symbol("gpcamx")))
              .replace("@RUN_FRAMES@", str(a.frames)).replace("@SKIP_FRAMES@", str(a.skip))
              .replace("@LEVEL@", str(a.level)).replace("@LEVEL_ADDR@", hex(symbol("gplevel"))))
    script = ROOT / "temp_prof" / ("profile_run_%d_%s.lua" % (a.level, "dmg" if a.dmg else "cgb"))
    script.write_text(lua)
    # The model is a command line setting override (the user's own Mesen settings are not changed)
    model = "--Gameboy.Model=" + ("Gameboy" if a.dmg else "GameboyColor")
    r = subprocess.run([str(MESEN), "--testrunner", str(rom), str(script), model], capture_output=True,
                       text=True, timeout=900)
    out = [l for l in r.stdout.splitlines() if "Uninitialized" not in l]
    print("\n".join(out))
    if r.returncode != 0:
        sys.exit(f"Mesen exit code {r.returncode} (-1 = Lua error)")


if __name__ == "__main__":
    main()
