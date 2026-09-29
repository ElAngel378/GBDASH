# Headless performance profiling with Mesen2

A guide for profiling the Game Boy build of Pocket Dash (`bin/POCKETDASH.gb`) without opening an
emulator window. The method was worked out on the Game Gear port in `gg/`, where it found the
real cause of the lag in minutes after guessing had failed. The working reference implementation
is `gg/tools/mesen_profile.lua` plus `gg/tools/profile.py`; copy them and adapt as described below.

> **Status of the Game Boy details.** Everything marked *verified* was run on the Game Gear
> build with Mesen 2.1.1. The Game Boy memory type, CPU type, cycle units and frame budget are
> **not yet verified** — check them with step 1 before trusting any numbers.

---

## Why do it this way

- **Measure, don't guess.** Tinted-background tricks and screenshots of on-screen lag counters
  are slow and easy to misread. Cycle counts per code section give an exact answer.
- **It runs without a window**, so it never steals focus or keyboard input from the user's own
  Mesen window (it did, repeatedly, when screenshots were driven with SendKeys).
- **A full-level run takes about a minute** and is repeatable, so every optimisation can be
  checked with a before/after number.

## Mesen facts (verified on the Game Gear build)

- Mesen lives at `C:\Users\soter\OneDrive\Documents\Mesen.exe` (Mesen2 / MesenCE 2.1.1).
- Headless run: `Mesen.exe --testrunner <rom> <script.lua>`. No window opens. The process exit
  code is whatever the script passes to `emu.stop(code)`. `print()` goes to stdout.
- A script error makes Mesen exit with **-1 and prints nothing**. If you get -1 with no output,
  the Lua script crashed.
- **No `os` library** in Mesen's Lua sandbox (`os.getenv` crashes the script). Pass parameters by
  having the Python runner substitute placeholders (`@MARK_ADDR@`) into a generated copy of the
  script.
- `emu.getState()` returns a flat table with keys such as `cpu.cycleCount`, `cpu.pc`,
  `frameCount`. **Dump the keys first** (step 1); names differ per console.
- `emu.addMemoryCallback(fn, emu.callbackType.write, start, end, cpuType, memType)` —
  **pass `cpuType` and `memType` explicitly**. The callback receives `(address, value)`.
- **An error inside a callback silently disables it** (no message, the rest of the script keeps
  running). Classic trap: the C runtime zero-initialises your marker variable at boot, the
  callback receives value 0, indexes a Lua table with 0, gets `nil`, the arithmetic fails and the
  callback is gone. Always range-check the value first.
- `emu.addEventCallback(fn, emu.eventType.endFrame)` runs once per video frame. After you call
  `emu.stop()` it may fire once more — guard the summary with a `finished` flag.
- `emu.read(addr, memType)` reads memory from any callback.

## GBDK / linker facts

- The `.map` file packs several symbols per line and **truncates names to about 9 characters**
  (seen with the Z80 linker; check the Game Boy one). Give the marker variable a short unique
  name (`gpmark`) and find it with a regex like `([0-9A-F]{8})\s+_gpmark\b`. The `.noi`/`.sym`
  files (`-Wl-j` is already in the GB `LCCFLAGS`) may give full names more easily.
- Build profiling ROMs to a **separate output file** (e.g. `bin/POCKETDASH_prof.gb`). Never
  overwrite the user's normal ROM with a debug build — it happened once and "broke" the game
  they were testing.

---

## Step by step for the Game Boy build

### 1. Confirm the Mesen API names for Game Boy

Run a tiny script that dumps state keys and exits:

```lua
local done = false
emu.addEventCallback(function()
  if done then return end
  done = true
  local st, keys = emu.getState(), {}
  for k, v in pairs(st) do if type(v) ~= "table" then keys[#keys + 1] = k .. "=" .. tostring(v) end end
  table.sort(keys)
  for _, k in ipairs(keys) do print(k) end
  emu.stop(0)
end, emu.eventType.endFrame)
```

Look for the cycle counter key (expected `cpu.cycleCount`) and check the enum names by printing
them: `emu.memType.gameboyMemory` and `emu.cpuType.gameboy` are the likely names — confirm they
are not `nil` before using them.

Then confirm the **frame budget in the units Mesen reports**: record `cpu.cycleCount` at two
consecutive `endFrame` events and subtract. A Game Boy frame is 70224 T-cycles (17556
M-cycles); in CGB double-speed mode the CPU gets twice as many. Use the measured delta as
`FRAME_CYCLES`, not a number from memory.

### 2. Add section markers to the game loop

In C, a global byte that each section of the main loop writes its id to. It must compile away in
normal builds:

```c
#ifdef DEBUG_PROFILE
volatile uint8_t gpmark;              // short name: map files truncate symbols
#define PROF_MARK(n) (gpmark = (n))
#else
#define PROF_MARK(n)
#endif
```

Place marks at the start of each logical section of `play_level()`'s loop in `src/gameplay.c`,
for example: 1 input/scroll, 2 sprite logic (`process_sprite_logic`), 3 `player_update`,
4 camera, 5 `prepare_mt_column` / row prep, **6 immediately before `wait_vbl_done()`**,
**7 immediately after it**, 8 OAM / `draw_sprites`, 9 palette / parallax work. Marks 6 and 7 are
what separate "waiting for vblank" from real work, so they must hug the wait call.

Keep in mind that `gameplay.c` is `#pragma bank 10`; the marker variable itself lives in WRAM so
banking doesn't affect it. The main loop also has pause-menu and death paths — marks only need
to cover the normal per-frame path.

For a full-level run without input, add a god mode (on death: clear `dead`, reset Y, keep
scrolling) behind `#ifdef DEBUG_GODMODE`. A start-position define (`DEBUG_START_PX`) is handy for
zooming in on one section of a level.

### 3. The Lua profiler

Copy `gg/tools/mesen_profile.lua`. Its logic:

- On every write to the marker: `c = cycleCount`; charge `c - last_cycles` to the previous
  section; add it to the iteration's busy time unless the previous section was the wait (6).
- When value 1 arrives, the previous iteration is complete: if its busy time is over
  `FRAME_CYCLES`, count it as slow and store a per-section breakdown.
- At every `endFrame`: if mark 7 was not seen during that frame, the game **dropped a frame**.
  This is the number that matters to the player; slow iterations explain it.
- After N frames print: iterations, dropped frames and at which frame numbers, average/max
  cycles per section, and the breakdown of the first few slow iterations. Then `emu.stop(0)`.

Change `emu.cpuType.sms` / `emu.memType.smsMemory` to the Game Boy names from step 1.

### 4. The Python runner

Copy `gg/tools/profile.py` and point it at the GB build:

1. Build a profiling ROM with `-DDEBUG_PROFILE -DDEBUG_GODMODE` to a separate file. The GB build
   uses the root `makefile` (`LCCFLAGS`), so either add a `PROFILE=1` switch that appends the
   defines and changes `PROJECT_NAME`, or call `lcc` directly with the same flags.
2. Read the marker address from the map/sym file.
3. Substitute `@MARK_ADDR@` and `@RUN_FRAMES@` into a copy of the Lua script.
4. Run `Mesen.exe --testrunner <prof rom> <generated lua>` with a timeout and print stdout,
   filtering Mesen's `Uninitialized memory read` noise.

Note: `C:\Users\soter\...` has the `GBDK` environment variable pointing at `lcc.exe` itself, not
the GBDK folder; the makefile's `GBDK ?= C:/gbdk` default is what works.

### 5. Reading the results

- **Slow iterations that repeat on a regular period** point at periodic work. On the Game Gear
  they came every 5–6 frames — exactly the 16 px column streaming (16 px ÷ ~2.8 px/frame). On the
  Game Boy expect the same from `prepare_mt_column` / `flush_mt_column`, and on CGB also from
  the parallax GDMA (`update_bg_parallax`, already rate-limited to every other frame).
- **The max of a section can include interrupt time.** If a frame overruns, the vblank
  interrupt fires inside whatever section is running and its cost (hUGE music on the timer ISR,
  OAM DMA, the LYC/STAT handlers in `main.c` / `state_menu.c`) is charged there. Judge sections
  by their breakdown in iterations that fit, and keep the budget below 100% with headroom for
  interrupts (~85% worst case was fine on the Game Gear).
- Frames at the very start (loading) and a huge spike at the level end (reload with the display
  off) are expected — ignore them.

### 6. Verify correctness after every optimisation

Speed work on the Game Gear port broke the background twice while the frame counters looked
great. Keep the old implementation behind a define (`DEBUG_SLOWVDP` in `gg/src/main.c`) and
compare the two:

- Freeze the game after N frames (`DEBUG_FREEZE`: stop updating, keep waiting for vblank) so
  both builds show exactly the same moment.
- Capture the frame and compare pixel for pixel. The Game Gear A/B test used screenshots
  (F12 → `Documents\Mesen2\Screenshots`); in the headless runner it is better to take the
  screenshot from Lua (`emu.takeScreenshot()` returns PNG data — **unverified**, check the Mesen
  Lua docs) or compare VRAM/tilemap bytes with `emu.read` over the VRAM memory type.
- Test several start positions across the level, not just the start.

---

## What paid off on the Game Gear (ideas to check on GB, not conclusions)

Measured on the Game Gear with decos on: slow iterations 208 → 0 over the whole level, worst
iteration 114% → 86% of a frame.

1. **Column streaming.** A metatile's 4 tile ids already are two rows of (left, right) pairs, so
   building a column became a straight 4-byte copy per metatile instead of 2D-array indexing and
   ring-buffer `memcpy`s (16k → 5k cycles). Writing it with one address set and a single wrap
   instead of per-row address maths halved the VRAM write.
2. **8-bit sprite maths.** Convert object positions once into screen space biased by +64 so
   every visibility check is an unsigned 8-bit compare; no 16-bit signed compares per sprite.
3. **Split object lists.** Logic loops walked every object including decorations; a separate
   short list of interactive objects removed that cost entirely.
4. **Terminate the sprite list instead of hiding unused sprites one by one** (SMS/GG has a
   0xD0 terminator; on GB the equivalent is only clearing slots that were used last frame, which
   `gameplay.c` already does).
5. **`-Wf--max-allocs-per-node50000`** — the GB makefile already has it. It makes builds much
   slower (85 s on the Game Gear) but noticeably speeds up generated code.

The existing GB build already contains a lot of hand optimisation (see comments in
`src/gameplay.c`, `src/sp_draw.c`, `src/graphics/mt_renderer.c`) and there is an older
`tools/fps_diagnostic.py` — read those first so measurements start from what is already known.

## Practical rules for the agent

- Never drive the user's own Mesen window; use `--testrunner` and separate output files.
- Report numbers from runs, not expectations. If a check could not be run, say so.
- One change at a time, profile before and after, and run the pixel A/B check before handing a
  ROM to the user.
