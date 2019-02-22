require "loading"

require "player"
require "world"
require "input"
require "interactions"

require "graphics"
require "ui"

function love.init()

end

function love.update(dt)
  input:update()
  player:update(input)
  world:update(player)
  interactions:update(world,player)
end

function love.draw()
  graphics:draw(world)
  ui:draw(world,player) 
end