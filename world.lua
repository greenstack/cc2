world = {
  level = 0,
  weather = 1,
  --whatever values
  player = {
    position = {x = 5, y = 5}
  },
  camera = {}
}

function world:init()
  local map = Map:new("assets/maps/level3_cc1", "assets/img/tiles.png")
  print("taestaset")
  self.camera = Camera:new()
  self.camera:SetMap(map)
end

function world:update(dt,playerController)
  local dx = playerController.movement.x * dt
  local dy = playerController.movement.y * dt
  self.player.position.x = self.player.position.x + dx
  self.player.position.y = self.player.position.y + dy
  self.camera:Move(dx,dy)
  print(self.player.position.x,self.player.position.y)
end

function world:draw()
  self.camera:Draw()
end