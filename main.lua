require "loading"

require "player"
require "world"
require "input"
require "interactions"

require "world.map.map"
require "graphics.camera"
--require "graphics"
--require "ui"

beep = love.audio.newSource("assets/sound/selection_beep.wav", "static")

function love.load()
  player:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)

  map = Map:new("assets/maps/level3_cc1", "assets/img/tiles.png")
  --print(map.Layers[1]:IsTileEmpty(1, 1))
  --print(map.Layers[1]:GetTile(1, 1).TileId)
  
  camera = Camera:new()
  camera:SetMap(map)
  --tileset = Tileset:new("assets/img/tiles.png", 32, 32)
  --tilesetBatch = love.graphics.newSpriteBatch(tileset.Image, tileset.ImageWidth * tileset.ImageHeight)
  --for i = 0, 10 - 1  do
  --  for j = 1, 10 do
  --    tilesetBatch:add(tileset:GetTile(i * 10 + j), i * 32, j * 32)
  --  end
  --end6
  --tilesetBatch:flush()
end

function love.update(dt)
  input:update()
  player:update(dt,input)
  world:update(dt,player)
  interactions:update(dt,world,player)
end

function love.draw()
  --graphics:draw(world)
  camera:Draw()
  player.screen:draw()
  love.graphics.reset()
  --ui:draw(world,player) 
  --love.graphics.draw(tilesetBatch)
end