require "loading"

require "player"
require "world"
require "input"
require "interactions"


-- resources
beep = love.audio.newSource("assets/sound/selection_beep.wav", "static")
font = love.graphics.newImageFont("assets/font/luafont.png",
  " abcdefghijklmnopqrstuvwxyz" ..
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
  "123456789.,!?-+/():;%&`'*#=[]\"><{}")
arrow = love.graphics.newImage("assets/img/arrow.png")

function love.load()
  player:init()
  world:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)
  love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
  input:update()
  player:update(dt,input)
  world:update(dt,player)
  interactions:update(dt,world,player)
end

function love.draw()
  love.graphics.setFont(font)
  world:draw()
  player.screen:draw()
  love.graphics.reset()
end

-- this event handles actual text input, as opposed to raw keyboard input. it handles capital letters and other special characters automatically
function love.textinput(text)
  player:textinput(text)
end

--handles backspace input for the context of typing
function love.keypressed(key)
  if key == "backspace" then
    player:backspace()
  end
end