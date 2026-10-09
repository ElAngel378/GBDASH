
local MEM = emu.memType.gameboyMemory
local frame = 0

emu.addEventCallback(function()
  frame = frame + 1
  local st = emu.read(0xDB25, MEM)
  if frame % 30 == 0 then
    print(string.format('F%d state=%d end_anim=%d', frame, st, emu.read(0xC29A, MEM)))
  end

  if frame == 220 then
    -- trigger level end!
    emu.write(0xC29D, 1, MEM) -- end_trigger_requested = 1
  end

  if frame == 350 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_PRAC ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  -- Main menu: press A
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  -- Level select: press A
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  -- In gameplay: press START for pause menu
  elseif frame >= 165 and frame <= 170 then emu.setInput({start = true}, 0)
  -- Pause menu: press DOWN to select PRACTICE
  elseif frame >= 180 and frame <= 185 then emu.setInput({down = true}, 0)
  -- Pause menu: press A to confirm practice mode
  elseif frame >= 195 and frame <= 200 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
