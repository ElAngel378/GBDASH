
local MEM = emu.memType.gameboyMemory
local frame = 0

emu.addEventCallback(function()
  frame = frame + 1
  -- force icon
  emu.write(0xDB59, 28, MEM)
  if frame == 260 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  elseif frame >= 230 and frame <= 245 then emu.setInput({a = true}, 0) -- JUMP!
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
