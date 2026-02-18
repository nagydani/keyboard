function love.update(dt)
  
end

CORRECT_KEY = {
  0,
  0.25,
  0
}

-- Replace the displayed text immediately
function showtext(t)
  S.caret = #t
  text = t
end
showtext("\n\n  Press the key highlighted in blue.")

S.char = nil

function highlight(key)
  S.highlight = key
  if key then
    key_bg[key] = Color[Color.blue + Color.bright]
  end
end

function chars(s)
  local r = { }
  for c in s:gmatch(".") do
    table.insert(r, c)
  end
  return r
end

S.pools = {
  chars("1234567890"),
  chars("abcdefghijklmnopqrstuvwxyz"),
  chars("`-=\\;,./[]'")
}
table.insert(S.pools, {
  "escape",
  "delete",
  "backspace",
  "tab",
  "return",
  "space",
  "menu"
})
table.insert(S.pools, {
  "up",
  "left",
  "right",
  "down"
})
table.insert(S.pools, {
  "lshift",
  "rshift",
  "lctrl",
  "lalt"
})

S.pool = 1

function pick(pool)
  if next(pool) == nil then
    return nil
  end
  local i = math.random(#pool)
  pool[i], pool[#pool] = pool[#pool], pool[i]
  return table.remove(pool)
end

function next_key()
  local pool = S.pools[S.pool]
  if pool == nil then
    return nil
  end
  local r = pick(pool)
  if r then
    return r
  end
  S.pool = S.pool + 1
  return next_key()
end
key_bg = { }
highlight(next_key())

function keypress(k)
  if k == S.highlight then
    key_bg[k] = CORRECT_KEY
    local n = next_key()
    highlight(n)
    sfx.correct()
    if not n then
      dofile("instructions2.lua")
    end
  else
    key_bg[k] = Color[Color.red]
    sfx.wrong()
  end
end
