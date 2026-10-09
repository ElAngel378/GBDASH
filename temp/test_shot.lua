
local frame = 0
emu.addEventCallback(function()
  frame = frame + 1
  if frame == 40 then
    local png = emu.takeScreenshot()
    local f = io.open('temp/menu_shot.png', 'wb')
    f:write(png)
    f:close()
    print('SUCCESS')
    emu.stop(0)
  end
end, emu.eventType.endFrame)
