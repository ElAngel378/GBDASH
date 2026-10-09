
local frame = 0
local btn_select = false

emu.addEventCallback(function()
  frame = frame + 1
  if frame >= 80 and frame <= 90 then
    btn_select = true
  else
    btn_select = false
  end
  if frame == 160 then
    local png = emu.takeScreenshot()
    local f = io.open('temp/shot_garage.png', 'wb')
    f:write(png)
    f:close()
    print('WROTE_GARAGE_PNG')
    emu.stop(0)
  end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  emu.setInput({select = btn_select}, 0)
end, emu.eventType.inputPolled)
