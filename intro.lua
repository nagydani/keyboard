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

function setchar(c)
  key_bg = { }
  S.char = c
  if c == "\n" then
    sfx.ping()
    S.t = S.t + DT_N
  else
    sfx.knock()
    S.t = S.t + DT
  end
end

function typewriter(dt)
  S.t = S.t - dt
  while S.t < 0 do
    if #text <= S.caret then
      S.char = nil
      return 
    end
    S.caret = S.caret + 1
    setchar(text:sub(S.caret, S.caret))
  end
end

love.update = typewriter

function love.draw()
  gfx.clear(Color[Color.white])
  local c = S.char
  if c then
    local m = modifier[c]
    if m then
      key_bg[m] = Color[Color.blue]
    end
    key_bg[unshift[c]] = Color[Color.blue + Color.bright]
  end
  gfx.setColor(Color[Color.black])
  gfx.print(text:sub(1, S.caret), 16, 16)
  draw_keyboard(30, 200)
end
function keypress()
  key_bg = { }
  dofile("instructions1.lua")
end

function love.keypressed(key, scancode, isrepeat)
  if keypress then
    keypress(key, scancode, isrepeat)
  end
end
function love.keyreleased(key, scancode)
  if keyrelease then
    keyrelease(key, scancode)
  end
end
