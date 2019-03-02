require "graphics.camera"
require "world.map.map"
require "world.entity"
require "world.playerEntity"

world = {
  level = 0,
  weather = 1,
  --whatever values
  player = {},
  entities = {},
  camera = {},
  map = {}
}

function world:init()
  self.map = Map:new("assets/maps/level3_cc1", "assets/img/tiles.png")
  self.camera = Camera:new()
  self.camera:SetMap(self.map)
  
  self.player = PlayerEntity:new("player",30.5,25.5)
end

function world:update(dt,playerController)
  if playerController.paused or not playerController.inPlay then return end
  
  self.player.movement = playerController.movement
  
  --[[
  local dx = playerController.movement.x * dt * 5
  local dy = playerController.movement.y * dt * 5
  self.player.position.x = self.player.position.x + dx
  self.player.position.y = self.player.position.y + dy
  --]]
  
  for _,entity in pairs(self.entities) do
    entity:update(dt,world)
  end
  
  self:moveEntities(dt)
  
  self.camera:updatePlayerPos()
  self.camera:SetPositionCentered(self.player.position.x,self.player.position.y)
   
end

function world:draw()
  self.camera:Draw(self.player.position,self.player,self.entities)
  local w,h = love.graphics.getDimensions()

  -- Fog Shader for testing
  if FogEnabled then
    weatherShader = love.graphics.newShader("graphics/shaders/fog.frag")
    love.graphics.setShader(weatherShader)
    weatherShader:send("player_position", self.camera.PlayerPosition)
    weatherShader:send("screen_position", {self.camera.Map.Tileset.TileWidth * self.camera.MapX,self.camera.Map.Tileset.TileHeight * self.camera.MapY})
    weatherShader:send("fog_distance", 428)
    weatherShader:send("fog_distance_min", 256)
    love.graphics.rectangle("fill", 1, 1, w, h)
    love.graphics.setShader()
  end
 
  -- lines showing the center of the screen for testing
  if ShowScreenCenter then
    love.graphics.setColor(.7,0,.7,0.6)
    love.graphics.line(w/2,0,w/2,h)
    love.graphics.line(0,h/2,w,h/2)
    love.graphics.setColor(1,1,1)
  end
  
end

function world:moveEntities(dt)
  self:moveEntity(dt,self.player)
  
  for _,entity in pairs(self.entities) do
    self:moveEntity(dt,entity)
  end
end

function world:moveEntity(dt,entity)
  local brake = 1
  if entity.movement.x == 0 and entity.movement.y == 0 then 
    brake = 0.2
  end
  local velocity = Vector.new(entity.velocity.x + entity.movement.x * entity.acceleration,entity.velocity.y + entity.movement.y * entity.acceleration)
  if velocity:length() > entity.maxSpeed then
    velocity:normalize()
    velocity = velocity * entity.maxSpeed
  end
  
  velocity = velocity * brake
  
  entity.velocity = {x=velocity.x,y=velocity.y}
  local proposedPosition = {x=entity.position.x + entity.velocity.x * dt,y=entity.position.y + entity.velocity.y * dt}
  
  local collisions = {}
  for _,mapHitBox in pairs(self.map.Hitboxes) do
    local leftCol = mapHitBox.xPos < proposedPosition.x + entity.hitBox.x2
    local rightCol = mapHitBox.xPos + mapHitBox.width > proposedPosition.x + entity.hitBox.x1
    local topCol = mapHitBox.yPos < proposedPosition.y + entity.hitBox.y2
    local bottomCol = mapHitBox.yPos + mapHitBox.height > proposedPosition.y + entity.hitBox.y1
  
    if leftCol and rightCol and topCol and bottomCol then
      table.insert(collisions,mapHitBox)
    end
    
  end
  table.sort(collisions,function(a,b) 
      local aDeltaX = (a.xPos + (a.width/2) - entity.position.x)
      local aDeltaY = (a.yPos + (a.height/2) - entity.position.y)
      local bDeltaX = (b.xPos + (b.width/2) - entity.position.x)
      local bDeltaY = (b.yPos + (b.height/2) - entity.position.y)
      local aDist = math.sqrt(aDeltaX*aDeltaX + aDeltaY*aDeltaY)
      local bDist = math.sqrt(bDeltaX*bDeltaX + bDeltaY*bDeltaY)
      return aDist < bDist
    end
  )
  
  for _,mapHitBox in pairs(collisions) do
    local fromLeft = not (mapHitBox.xPos < entity.position.x + entity.hitBox.x2)
    local fromRight = not (mapHitBox.xPos + mapHitBox.width > entity.position.x + entity.hitBox.x1)
    local fromTop = not (mapHitBox.yPos < entity.position.y + entity.hitBox.y2)
    local fromBottom = not (mapHitBox.yPos + mapHitBox.height > entity.position.y + entity.hitBox.y1)
    
    local correction = {x=0,y=0}
    
    local count = 0
    if fromLeft then count = count + 1 end
    if fromRight then count = count + 1 end
    if fromTop then count = count + 1 end
    if fromBottom then count = count + 1 end
    
    if count > 1 then print("count",count,fromLeft,fromRight,fromTop,fromBottom) end

    if fromTop then
      correction.y = mapHitBox.yPos - (proposedPosition.y + entity.hitBox.y2)
    elseif fromRight  then
      correction.x = mapHitBox.xPos + mapHitBox.width - (proposedPosition.x + entity.hitBox.x1)
    elseif fromLeft  then
      correction.x = mapHitBox.xPos - (proposedPosition.x + entity.hitBox.x2)
    elseif fromBottom then
      correction.y = mapHitBox.yPos + mapHitBox.height - (proposedPosition.y + entity.hitBox.y1)
    end
    
    proposedPosition.x = proposedPosition.x + correction.x
    proposedPosition.y = proposedPosition.y + correction.y
    
  end
  
  entity.position = proposedPosition
end
