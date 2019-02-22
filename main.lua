require "loading"

require "player"
require "world"
require "input"
require "interactions"

require "graphics"
require "ui"

beep = love.audio.newSource("assets/sound/selection_beep.wav", "static")

function love.load()
  player:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)
end

function love.update(dt)
  input:update()
  player:update(dt,input)
  world:update(dt,player)
  interactions:update(dt,world,player)
end

function love.draw()
  graphics:draw(world)
  player.screen:draw()
  --ui:draw(world,player) 
end