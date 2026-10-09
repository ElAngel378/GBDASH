
local MEM = emu.memType.gameboyMemory
local frame = 0
emu.addEventCallback(function()
  frame = frame + 1
  local st = emu.read(0xDB25, MEM)
  if frame % 30 == 0 then
    print(string.format('frame=%d state=%d', frame, st))
  end
  if frame == 400 then emu.stop(0) end
end, emu.eventType.endFrame)

emu.addEventCallback(function()
  if frame >= 40 and frame <= 45 then emu.setInput({a = true}, 0)
  elseif frame >= 130 and frame <= 135 then emu.setInput({a = true}, 0)
  else emu.setInput({}, 0) end
end, emu.eventType.inputPolled)
