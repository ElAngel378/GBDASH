local seen, f = {}, 0
emu.addMemoryCallback(function(a, v)
  if #seen < 12 then seen[#seen + 1] = tostring(a) .. ":" .. tostring(v) .. "/" .. emu.read(0xC167, emu.memType.smsMemory) end
end, emu.callbackType.write, 0xC167, 0xC167, emu.cpuType.sms, emu.memType.smsMemory)
emu.addEventCallback(function()
  f = f + 1
  if f == 30 then print(table.concat(seen, " ")); emu.stop(0) end
end, emu.eventType.endFrame)
