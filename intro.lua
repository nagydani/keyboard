require "graphics"
require "model"

-- text to type
text = readfile("intro.txt")

-- interval between keystrikes in seconds
DT = 0.1
-- interval after newline in seconds
DT_N = 0.5

-- state
S = {
  caret = 0,
  t = 1
}

sfx = compy.audio

function love.update(dt)
  S.t = S.t - dt
  while S.t < 0 do
    if S.caret >= #text then
      return
    end
    S.caret = S.caret + 1
    local c = text:sub(S.caret, S.caret)
    if c == "\n" then
      sfx.ping()
      S.t = S.t + DT_N
    else
      sfx.knock()
      S.t = S.t + DT
    end
  end
end

function love.draw()
  gfx.clear(Color[Color.white])
  key_bg = { }
  local caret = S.caret
  if 0 < caret then
    local c = text:sub(caret, caret)
    local m = modifier[c]
    if m then
      key_bg[m] = Color[Color.blue]
    end
    key_bg[unshift[c]] = Color[Color.blue + Color.bright]
    gfx.setColor(Color[Color.black])
    gfx.print(text:sub(1, caret), 16, 16)
  end
  draw_keyboard(30, 200)
end

function love.keypressed(key, scancode, isrepeat)
  love.event.quit()
end
