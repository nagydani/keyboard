LEFT = "~!@#$%QWERTASDF|ZXCV"
RIGHT = "_)(*&^+POIUY:LKJH?><MNB\"}{"

modifier = { }
for c in LEFT:gmatch(".") do
  modifier[c] = "lshift"
end
for c in RIGHT:gmatch(".") do
  modifier[c] = "rshift"
end

unshift = { }
setmetatable(unshift, {
  __index = function(_, v)
    return v:lower()
  end
})
for num, sym in pairs(NUM_SYM) do
  unshift[sym] = ""..num
end

AUX_KEYS = "`-=\\;,./[]'"
for c in AUX_KEYS:gmatch(".") do
  unshift[UPPER[c]] = c
end
unshift["\n"] = "enter"
unshift[" "] = "space"
