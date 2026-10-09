
local frame = 0
local sel_press = false

emu.addEventCallback(function()
  frame = frame + 1
  -- Main menu fades in during frames 0..30
  -- Press SELECT on frames 50..55
  if frame >= 50 and frame <= 55 then
    sel_press = true
  else
    sel_press = false
  end

  if frame == 90 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_GARAGE ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  emu.setInput({select = sel_press}, 0)
end, emu.eventType.inputPolled)
