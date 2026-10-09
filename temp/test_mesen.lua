
local frame = 0
emu.addEventCallback(function()
  frame = frame + 1
  if frame == 60 then
    local png = emu.takeScreenshot()
    print('SCREENSHOT_LEN ' .. #png)
    emu.stop(0)
  end
end, emu.eventType.endFrame)
