
local MEM = emu.memType.gameboyMemory
local frame = 0

emu.addEventCallback(function()
  frame = frame + 1
  local st = emu.read(0xDB25, MEM)
  if frame % 20 == 0 then
    print(string.format('F%d state=%d end_anim=%d lc_pending=%d', frame, st, emu.read(0xC29A, MEM), emu.read(0xC6D5, MEM)))
  end

  if frame == 220 then
    emu.write(0xC29D, 1, MEM) -- end_trigger_requested = 1
  end

  if st == 6 and frame > 360 then
    -- We are in STATE_LEVEL_COMPLETE! Wait until frame reaches 420 for banner to expand
    if frame == 420 then
      local png = emu.takeScreenshot()
      local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
      print('PNG_PRAC_REAL ' .. hex_data)
      emu.stop(0)
    end
  end
  if frame == 480 then emu.stop(0) end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  elseif frame >= 165 and frame <= 170 then emu.setInput({start = true}, 0)
  elseif frame >= 180 and frame <= 185 then emu.setInput({down = true}, 0)
  elseif frame >= 195 and frame <= 200 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
