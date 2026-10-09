
local MEM = emu.memType.gameboyMemory
local frame = 0
local state_set = false

emu.addEventCallback(function()
  frame = frame + 1
  if frame == 20 and not state_set then
    state_set = true
    emu.write(0xDB59, 26, MEM) -- selected_icon = 26 (Improved Cat)
    emu.write(0xDB25, 7, MEM)  -- current_state = STATE_ICON_SELECT
  end
  if frame == 60 then
    local png = emu.takeScreenshot()
    local f = io.open('temp/shot_cat.png', 'wb')
    f:write(png)
    f:close()
    print('Wrote shot_cat.png')
    emu.stop(0)
  end
end, emu.eventType.endFrame)
