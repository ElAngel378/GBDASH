"""
POCKETDASH FPS Diagnostic -- tools/fps_diagnostic.py
=================================================
Tests all (or selected) levels in DMG and/or GBC mode.
Navigates the real game menu via joypad, runs at real-time speed
(set_emulation_speed(1)), and measures fps per 60-frame window.

Usage:
  python tools/fps_diagnostic.py
  python tools/fps_diagnostic.py --mode dmg
  python tools/fps_diagnostic.py --mode gbc --levels 0 2 6
  python tools/fps_diagnostic.py --play-secs 15 --report out.json
  python tools/fps_diagnostic.py --quiet

How it works:
  PyBoy tick() = one Game Boy VBlank period (70224 CPU cycles).
  Running at speed=1 (real-time, ~59.73 fps target) lets us measure
  wall-clock seconds per 60-tick window. Windows below the lag
  threshold indicate the host cannot sustain real-time emulation,
  which is a proxy for per-frame CPU workload. This catches crashes,
  hangs, and pathologically heavy frames before shipping.
"""

import argparse
import datetime
import json
import sys
import time
import warnings

warnings.filterwarnings("ignore")

try:
    from pyboy import PyBoy
except ImportError:
    sys.exit("ERROR: pyboy not installed. Run: pip install pyboy")

# ---------------------------------------------------------------------------
# Level list -- must match game_levels[] order in src/assets.c
# ---------------------------------------------------------------------------
LEVEL_NAMES = [
    "Stereo Madness",           # 0
    "Back on Track",            # 1
    "Polargeist",               # 2
    "Dry Out",                  # 3
    "Base After Base",          # 4
    "Cant Let Go",              # 5
    "Jumper",                   # 6
    "Time Machine",             # 7
    "Cycles",                   # 8
    "xStep",                    # 9
    "Theory of Everything (UD)", # 10
]

GB_FPS         = 59.73
DEFAULT_THRESH = 57.0
SAMPLE_WIN     = 60
BOOT_FRAMES    = 300

# ---------------------------------------------------------------------------
# Navigation helpers
# ---------------------------------------------------------------------------

def _tick(pb, n=1):
    for _ in range(n):
        pb.tick(render=False)


def _press(pb, btn, hold=4):
    pb.button(btn, delay=1)
    _tick(pb, hold)


def navigate(pb, level_idx):
    """Boot -> menu -> level select -> start level."""
    _tick(pb, BOOT_FRAMES)
    _press(pb, "a", hold=12)
    _tick(pb, 60)
    for _ in range(level_idx):
        _press(pb, "down", hold=6)
        _tick(pb, 4)
    _press(pb, "a", hold=12)
    _tick(pb, 180)


# ---------------------------------------------------------------------------
# FPS measurement
# ---------------------------------------------------------------------------

def measure(pb, play_secs):
    """Tap A every window, return list of fps per SAMPLE_WIN frames."""
    total = int(play_secs * GB_FPS)
    done  = 0
    out   = []
    while done < total:
        t0 = time.perf_counter()
        _tick(pb, SAMPLE_WIN)
        elapsed = time.perf_counter() - t0
        out.append(SAMPLE_WIN / elapsed if elapsed > 0 else GB_FPS)
        done += SAMPLE_WIN
        pb.button("a", delay=1)
    return out


# ---------------------------------------------------------------------------
# Per-level test
# ---------------------------------------------------------------------------

def test_level(rom, idx, name, cgb, play_secs, thresh, verbose):
    mode = "GBC" if cgb else "DMG"
    pb   = PyBoy(rom, window="null", sound_volume=0)
    pb.set_emulation_speed(1)
    if not cgb:
        try:
            pb.memory[0x143] = 0x00   # clear CGB flag -> force DMG
        except Exception:
            pass
    try:
        navigate(pb, idx)
        samples = measure(pb, play_secs)
    except Exception as exc:
        pb.stop(save=False)
        if verbose:
            print(f"  [{mode}] Lv{idx+1:2d} {name:<30}  ERROR: {exc}")
        return {"level": name, "index": idx, "mode": mode, "error": str(exc)}
    pb.stop(save=False)

    mn  = min(samples)
    avg = sum(samples) / len(samples)
    mx  = max(samples)
    lag = [i for i, f in enumerate(samples) if f < thresh]
    ok  = not lag

    if verbose:
        tag = "OK " if ok else f"LAG {lag}"
        print(f"  [{mode}] Lv{idx+1:2d} {name:<30}"
              f"  min={mn:5.1f}  avg={avg:5.1f}  max={mx:5.1f}  {tag}")

    return {
        "level":       name,
        "index":       idx,
        "mode":        mode,
        "min_fps":     round(mn,  2),
        "avg_fps":     round(avg, 2),
        "max_fps":     round(mx,  2),
        "samples":     [round(f, 2) for f in samples],
        "lag_windows": lag,
        "status":      "OK" if ok else "LAG",
    }


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    p = argparse.ArgumentParser(
        description="POCKETDASH FPS Diagnostic",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("--rom",       default="bin/POCKETDASH.gb",
                   help="Path to POCKETDASH ROM")
    p.add_argument("--mode",      choices=["dmg", "gbc", "both"],
                   default="both", help="Hardware mode to test")
    p.add_argument("--levels",    type=int, nargs="+", metavar="IDX",
                   help="Level indices 0-based (default: all)")
    p.add_argument("--play-secs", type=float, default=10,
                   metavar="N",   help="Seconds of gameplay per level")
    p.add_argument("--threshold", type=float, default=DEFAULT_THRESH,
                   metavar="FPS", help="Lag detection threshold in fps")
    p.add_argument("--report",    metavar="FILE",
                   help="Save JSON report to FILE")
    p.add_argument("--quiet",     action="store_true",
                   help="Only print summary, suppress per-level output")
    args = p.parse_args()

    cgb_modes = {"dmg": [False], "gbc": [True], "both": [False, True]}[args.mode]
    levels    = args.levels or list(range(len(LEVEL_NAMES)))
    verbose   = not args.quiet
    bar       = "=" * 62
    now       = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")

    print(f"POCKETDASH FPS Diagnostic  [{now}]")
    print(f"ROM: {args.rom}  |  Levels: {levels}  |  "
          f"{args.play_secs}s/level  |  Lag < {args.threshold} fps")

    results = []
    for cgb in cgb_modes:
        if verbose:
            lbl = "GBC" if cgb else "DMG"
            print(f"\n{bar}\n  MODE: {lbl}\n{bar}")
        for idx in levels:
            if idx >= len(LEVEL_NAMES):
                print(f"  WARNING: level index {idx} out of range, skipping")
                continue
            results.append(
                test_level(args.rom, idx, LEVEL_NAMES[idx], cgb,
                           args.play_secs, args.threshold, verbose)
            )

    # --- Summary ---
    print(f"\n{bar}\n  SUMMARY\n{bar}")
    for cgb in cgb_modes:
        lbl     = "GBC" if cgb else "DMG"
        sub     = [r for r in results if r.get("mode") == lbl]
        lagging = [r for r in sub if r.get("lag_windows")]
        errored = [r for r in sub if "error" in r]
        print(f"\n  {lbl}:")
        for r in errored:
            print(f"    !! {r['level']}: ERROR -- {r['error']}")
        if lagging:
            for r in lagging:
                n = len(r["lag_windows"])
                print(f"    !! {r['level']}: {n} lag window(s)  "
                      f"avg={r['avg_fps']:.1f}  min={r['min_fps']:.1f} fps")
        if not lagging and not errored:
            fps_list = [r["avg_fps"] for r in sub if "avg_fps" in r]
            worst = min(fps_list) if fps_list else 0
            print(f"    All {len(sub)} level(s) clean  (worst avg: {worst:.1f} fps)")
        elif not lagging:
            print(f"    {len(sub) - len(errored)} clean, {len(errored)} error(s)")

    # --- JSON report ---
    if args.report:
        rpt = {
            "timestamp": datetime.datetime.now().isoformat(),
            "rom":       args.rom,
            "play_secs": args.play_secs,
            "threshold": args.threshold,
            "results":   results,
        }
        with open(args.report, "w") as f:
            json.dump(rpt, f, indent=2)
        print(f"\n  JSON report saved: {args.report}")
    print()


if __name__ == "__main__":
    main()
