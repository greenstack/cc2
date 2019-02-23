require "graphics.camera"
require "world.map.map"

world = {
  level = 0,
  weather = 1,
  --whatever values
  player = {
    position = {x = 5, y = 5}
  },
  camera = {},
  map = {}
}

function world:init()
  self.map = Map:new("assets/maps/level3_cc1", "assets/img/tiles.png")
  print("taestaset")
  self.camera = Camera:new()
  self.camera:SetMap(self.map)
end

function world:update(dt,playerController)
  if playerController.paused then return end
  local dx = playerController.movement.x * dt * 5
  local dy = playerController.movement.y * dt * 5
  self.player.position.x = self.player.position.x + dx
  self.player.position.y = self.player.position.y + dy
  
  self.camera:SetPositionCentered(self.player.position.x,self.player.position.y)
  --self.camera:Move(dx,dy)
  --print(self.player.position.x,self.player.position.y)
end

function world:draw()
  self.camera:Draw(self.player.position)
  
  local w,h = love.graphics.getDimensions()
  
  love.graphics.setColor(.7,0,.7,0.6)
  love.graphics.line(w/2,0,w/2,h)
  love.graphics.line(0,h/2,w,h/2)
  love.graphics.setColor(1,1,1)

end