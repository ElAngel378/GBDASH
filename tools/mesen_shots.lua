-- Visual regression: prints a hash of the rendered frame every @STEP@ frames, run headless by
-- tools/visual_regression.py (Mesen --testrunner, profiling ROM so it starts the level directly).
-- Placeholders: @LEVEL_ADDR@ @LEVEL@ @FRAMES@ @STEP@ @JUMP@ @DUMP@ @ENDSTATE_ADDR@ @PLAYER_PTR@ (frame number to dump as hex PNG, -1: none)
local MEM = emu.memType.gameboyMemory
local FRAMES, STEP, JUMP, DUMP = @FRAMES@, @STEP@, @JUMP@, @DUMP@
local frame, level_set, ended = 0, false, false
-- Level loading takes a different number of cycles per ROM, so the first gameplay frame shifts by a
-- frame between builds. Hashes are taken relative to the frame the player first moves (world_x).
local t0, wx0 = nil, nil
local function player_x()
  local p = emu.read(@PLAYER_PTR@, MEM) + 256 * emu.read(@PLAYER_PTR@ + 1, MEM)
  if p < 0xC000 then return 0 end
  return emu.read(p, MEM) + 256 * emu.read(p + 1, MEM)
end

if JUMP > 0 then
  emu.addEventCallback(function() emu.setInput({a = (frame % JUMP) < 6}, 0) end, emu.eventType.inputPolled)
end

local function fnv(s)
  local h = 2166136261
  for i = 1, #s do h = ((h ~ s:byte(i)) * 16777619) & 0xFFFFFFFF end
  return h
end

emu.addEventCallback(function()
  frame = frame + 1
  if not level_set then
    if frame > 200 then level_set = true else emu.write(@LEVEL_ADDR@, @LEVEL@ + 1, MEM) end
  end
  -- the level end animation shakes the screen with DIV (cycle-timing dependent): stop there
  if emu.read(@ENDSTATE_ADDR@, MEM) ~= 0 and frame > 300 then ended = true end
  if not t0 then
    local x = player_x()
    if wx0 == nil then wx0 = x elseif x ~= wx0 then t0 = frame end
  end
  if t0 and (frame - t0) % STEP == 0 and not ended then
    local png = emu.takeScreenshot()
    print(string.format("F%d %08x", frame - t0, fnv(png)))
    if frame - t0 == DUMP then
      local o = {}
      for i = 0, 159 do o[#o + 1] = string.format("%02x", emu.read(0xFE00 + i, MEM)) end
      print("OAM " .. table.concat(o))
    end
    if frame - t0 == DUMP then print("PNG " .. (png:gsub(".", function(c) return string.format("%02x", c:byte()) end))) end
  end
  if frame >= FRAMES then emu.stop(0) end
end, emu.eventType.endFrame)
