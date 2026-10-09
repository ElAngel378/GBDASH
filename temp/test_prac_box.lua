
local MEM = emu.memType.gameboyMemory
local frame = 0

emu.addEventCallback(function()
  frame = frame + 1
  if frame == 100 then
    emu.write(0xC6D7, 1, MEM) -- lc_practice = 1
    emu.write(0xC6D5, 1, MEM) -- lc_pending = 1
    emu.write(0xC6D6, 0, MEM) -- lc_level = 0
    emu.write(0xC6D9, 14, MEM) -- lc_attempts = 14
    emu.write(0xC6D8, 0, MEM) -- lc_coins = 0
    emu.write(0xDB25, 6, MEM) -- current_state = STATE_LEVEL_COMPLETE
  end

  if frame == 290 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_PRAC ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then
    emu.setInput({a = true}, 0)
  elseif frame >= 65 and frame <= 70 then
    emu.setInput({a = true}, 0)
  else
    emu.setInput({}, 0)
  end
end, emu.eventType.inputPolled)
