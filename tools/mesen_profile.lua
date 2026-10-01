-- Per-section cycle profiler for the gameplay loop, run headless by tools/profile.py:
--   Mesen.exe --testrunner bin/POCKETDASH_prof.gb <generated copy of this script>
-- The profiling build writes a section id to gpmark at the start of every section of
-- play_level()'s loop (PROF_MARK in src/gameplay.c). 9 = waiting for VBlank, 10 = after it.
-- Placeholders filled in by profile.py: @MARK_ADDR@ @CAMX_ADDR@ @RUN_FRAMES@ @SKIP_FRAMES@ @LEVEL@ @LEVEL_ADDR@
-- The ROM waits at boot until the level number + 1 is written to gplevel (src/main.c).

local MARK = @MARK_ADDR@
local CAMX = @CAMX_ADDR@
local RUN_FRAMES = @RUN_FRAMES@
local SKIP_FRAMES = @SKIP_FRAMES@        -- level loading at the start
local N, WAIT, AFTER = 13, 9, 10
local NAMES = { "input/scroll/cache", "object logic", "physics", "camera/end anim", "player sprite",
                "level sprites", "column job", "band/bg/row req", "WAIT vblank", "after vblank",
                "col: map read", "col: build rows", "col: after build" }
local MEM = emu.memType.gameboyMemory
local CPU = emu.cpuType.gameboy

local frame, last_cycles, cur = 0, nil, 0
local iter_busy, iter_sect = 0, {}
local sum, maxs, cnt = {}, {}, {}
for i = 1, N do sum[i], maxs[i], cnt[i] = 0, 0, 0; iter_sect[i] = 0 end
local iters, slow = 0, {}
local worst, worst_x, busy_hist = 0, 0, {0, 0, 0, 0}
local seen_after, dropped, dropped_at = false, 0, {}
local frame_cycles, prev_frame_cycles = nil, nil
local finished = false
local level_set = false

local function camx() return emu.read(CAMX, MEM) + 256 * emu.read(CAMX + 1, MEM) end

emu.addMemoryCallback(function(addr, value)
  if value < 1 or value > N then return end
  local c = emu.getState()["cpu.cycleCount"]
  if last_cycles ~= nil and cur >= 1 and cur <= N then
    local d = c - last_cycles
    iter_sect[cur] = iter_sect[cur] + d
    if cur ~= WAIT then iter_busy = iter_busy + d end
  end
  if value == 1 and frame > SKIP_FRAMES then
    -- the previous iteration is complete
    iters = iters + 1
    for i = 1, N do
      sum[i] = sum[i] + iter_sect[i]
      if iter_sect[i] > maxs[i] then maxs[i] = iter_sect[i] end
    end
    if frame_cycles then
      if iter_busy > worst then worst = iter_busy; worst_x = camx() end
      local p = iter_busy / frame_cycles
      if p > 0.95 then busy_hist[4] = busy_hist[4] + 1 elseif p > 0.9 then busy_hist[3] = busy_hist[3] + 1
      elseif p > 0.8 then busy_hist[2] = busy_hist[2] + 1 else busy_hist[1] = busy_hist[1] + 1 end
    end
    if frame_cycles and iter_busy > frame_cycles then
      local s = {}
      for i = 1, N do s[i] = iter_sect[i] end
      slow[#slow + 1] = { busy = iter_busy, sect = s, frame = frame, x = camx() }
    end
  end
  if value == 1 then
    iter_busy = 0
    for i = 1, N do iter_sect[i] = 0 end
  end
  if value == AFTER then seen_after = true end
  cur = value
  last_cycles = c
end, emu.callbackType.write, MARK, MARK, CPU, MEM)

emu.addEventCallback(function()
  if finished then return end
  frame = frame + 1
  -- keep writing until the game has taken it (the boot ROM and the C runtime clear RAM first)
  if not level_set then
    if last_cycles ~= nil then level_set = true else emu.write(@LEVEL_ADDR@, @LEVEL@ + 1, MEM) end
  end
  local c = emu.getState()["cpu.cycleCount"]
  if prev_frame_cycles then frame_cycles = c - prev_frame_cycles end
  prev_frame_cycles = c
  if frame > SKIP_FRAMES then
    if not seen_after then
      dropped = dropped + 1
      if #dropped_at < 400 then dropped_at[#dropped_at + 1] = camx() end
    end
  end
  seen_after = false
  if frame >= SKIP_FRAMES + RUN_FRAMES then
    finished = true
    print(string.format("frames %d  iterations %d  frame = %d cycles", RUN_FRAMES, iters, frame_cycles))
    print(string.format("DROPPED %d frames (%.1f%%)", dropped, 100 * dropped / RUN_FRAMES))
    print(string.format("worst iteration %.1f%% of a frame (camera x %d); iterations <=80%%: %d, 80-90%%: %d, 90-95%%: %d, >95%%: %d",
                        100 * worst / frame_cycles, worst_x, busy_hist[1], busy_hist[2], busy_hist[3], busy_hist[4]))
    print("section                 avg cyc   avg %%   max cyc   max %%")
    for i = 1, N do
      local avg = iters > 0 and sum[i] / iters or 0
      print(string.format("%d %-20s %8.0f %6.1f %9d %6.1f", i, NAMES[i], avg, 100 * avg / frame_cycles,
                          maxs[i], 100 * maxs[i] / frame_cycles))
    end
    print(string.format("slow iterations (busy > 1 frame): %d", #slow))
    table.sort(slow, function(a, b) return a.busy > b.busy end)
    for k = 1, math.min(12, #slow) do
      local s = slow[k]
      local parts = {}
      for i = 1, N do
        if i ~= WAIT then parts[#parts + 1] = string.format("%d:%d", i, math.floor(100 * s.sect[i] / frame_cycles)) end
      end
      print(string.format("  frame %5d x %5d busy %3d%%  [%s]", s.frame, s.x,
                          math.floor(100 * s.busy / frame_cycles), table.concat(parts, " ")))
    end
    local xs = {}
    for k = 1, #dropped_at do xs[#xs + 1] = tostring(dropped_at[k]) end
    print("dropped at camera x: " .. table.concat(xs, " "))
    emu.stop(0)
  end
end, emu.eventType.endFrame)
