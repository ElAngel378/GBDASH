
local MEM = emu.memType.gameboyMemory
local frame = 0
local trigger = false

emu.addEventCallback(function()
  frame = frame + 1
  -- start level from menu: press A on frame 50..55
  -- then once level is running around frame 120, trigger level complete
  if frame == 120 then
    emu.write(0xC6D7, 1, MEM) -- lc_practice = 1
    emu.write(0xC6D5, 1, MEM) -- lc_pending = 1
    emu.write(0xC6D6, 0, MEM) -- lc_level = 0
    emu.write(0xC6D9, 23, MEM) -- lc_attempts = 23
    emu.write(0xDB25, 6, MEM) -- current_state = STATE_LEVEL_COMPLETE
  end

  -- Wait for the banner animation (it takes ~30-40 frames to expand)
  if frame == 200 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_PRAC ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  -- press A on frame 40..45 to start level from menu
  if frame >= 40 and frame <= 45 then
    emu.setInput({a = true}, 0)
  elseif frame >= 70 and frame <= 75 then
    emu.setInput({a = true}, 0)
  else
    emu.setInput({}, 0)
  end
end, emu.eventType.inputPolled)
