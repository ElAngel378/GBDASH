-- Dump state keys once (to find cycle counter / scanline names), then exit.
local done = false
emu.addEventCallback(function()
  if done then return end
  done = true
  local st = emu.getState()
  local keys = {}
  for k, v in pairs(st) do
    if type(v) ~= "table" then keys[#keys + 1] = k .. "=" .. tostring(v) end
  end
  table.sort(keys)
  for _, k in ipairs(keys) do print(k) end
  emu.stop(0)
end, emu.eventType.endFrame)
