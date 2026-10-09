
local MEM = emu.memType.gameboyMemory
local frame = 0
local btn_select = false

emu.addEventCallback(function()
  frame = frame + 1
  if frame == 35 then
    emu.write(0xDB59, 28, MEM)
  end
  if frame >= 45 and frame <= 50 then
    btn_select = true
  else
    btn_select = false
  end
  if frame == 95 then
    local png = emu.takeScreenshot()
    local hex_data = png:gsub('.', function(c) return string.format('%02x', c:byte()) end)
    print('PNG_' .. hex_data)
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  emu.setInput({select = btn_select}, 0)
end, emu.eventType.inputPolled)
