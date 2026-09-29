-- Smoke test for Mesen's headless test runner: run 120 frames, print sys_time, exit.
local frames = 0
emu.addEventCallback(function()
  frames = frames + 1
  if frames == 120 then
    local st = emu.read(0xC214, emu.memType.smsMemory) + emu.read(0xC215, emu.memType.smsMemory) * 256
    emu.log("frames=" .. frames .. " sys_time=" .. st)
    print("frames=" .. frames .. " sys_time=" .. st)
    emu.stop(7)
  end
end, emu.eventType.endFrame)
