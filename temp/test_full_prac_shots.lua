
local MEM = emu.memType.gameboyMemory
local frame = 0
local complete_start = nil

emu.addEventCallback(function()
  frame = frame + 1
  local st = emu.read(0xDB25, MEM)

  if frame == 220 then
    emu.write(0xC29D, 1, MEM) -- end_trigger_requested = 1
  end

  if st == 6 and complete_start == nil then
    complete_start = frame
  end

  if complete_start and (frame == complete_start + 40) then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_BANNER ' .. hex_data)
  end

  if complete_start and (frame == complete_start + 85) then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_BOX ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  elseif frame >= 165 and frame <= 170 then emu.setInput({start = true}, 0)
  elseif frame >= 180 and frame <= 185 then emu.setInput({down = true}, 0)
  elseif frame >= 195 and frame <= 200 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
