S = {
  caret = 0,
  t = 2
}
text = readfile("exercise2.txt")

love.update = typewriter

function keypress(k)
  love.action.quit()
end
