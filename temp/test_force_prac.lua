
local MEM = emu.memType.gameboyMemory
local frame = 0
local complete_start = nil

emu.addEventCallback(function()
  frame = frame + 1
  local st = emu.read(0xDB25, MEM)

  if frame == 220 then
    emu.write(0xC29D, 1, MEM) -- end_trigger_requested = 1
  end

  if st == 6 then
    emu.write(0xC6D7, 1, MEM) -- FORCE lc_practice = 1 in STATE_LEVEL_COMPLETE!
    if complete_start == nil then
      complete_start = frame
    end
  end

  if complete_start and (frame == complete_start + 45) then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_PRAC_BANNER ' .. hex_data)
  end

  if complete_start and (frame == complete_start + 90) then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_PRAC_BOX ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
