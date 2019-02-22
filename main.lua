require "loading"

require "player"
require "world"
require "input"
require "interactions"

beep = love.audio.newSource("assets/sound/selection_beep.wav", "static")

function love.load()
  player:init()
  world:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)
end

function love.update(dt)
  input:update()
  player:update(dt,input)
  world:update(dt,player)
  interactions:update(dt,world,player)
end

function love.draw()
  world:draw()
  player.screen:draw()
  love.graphics.reset()
end