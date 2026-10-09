
local MEM = emu.memType.gameboyMemory
local frame = 0

emu.addEventCallback(function()
  frame = frame + 1
  if frame == 30 then
    emu.write(0xDB59, 26, MEM)
  end
  if frame % 50 == 0 and frame >= 150 and frame <= 400 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print(string.format('F%d %s', frame, hex_data))
  end
  if frame == 400 then
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 70 and frame <= 75 then emu.setInput({a = true}, 0)
  elseif frame >= 280 and frame <= 295 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
