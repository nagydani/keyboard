function love.update(dt)
  
end

-- Replace the displayed text immediately
function showtext(t)
  S.caret = #t
  text = t
end
showtext("\n\n  Press the key highlighted in blue.")

S.char = nil

function highlight(key)
  S.highlight = key
  key_bg = { [key] = Color[Color.blue + Color.bright] }
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
  chars("abcdefghijklmnopqrstuvwxyz")
}
S.pool = 0

function pick()
  local pool = S.pools[S.pool]
  if next(pool) == nil then
    return nil
  end
  return table.remove(pool, math.random(#pool))
end

function next_pool()
  local p = S.pool + 1
  S.pool = p
  return pick(p)
end
highlight(next_pool())

function keypress(k)
  if k == S.highlight then
    local p = pick()
    if not p then
      p = next_pool()
    end
    if not p then
      stop()
      love.event.quit()
    end
    highlight(p)
    sfx.correct()
  else
    key_bg[k] = Color[Color.red]
    sfx.wrong()
  end
end
