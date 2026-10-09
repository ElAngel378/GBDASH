
local frame = 0
emu.addEventCallback(function()
  frame = frame + 1
  if frame == 40 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_DATA ' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)
