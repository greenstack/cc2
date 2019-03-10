require "graphics.camera"
require "world.map.map"
require "world.entity"
require "world.playerEntity"
require "world.npcEntity"
require "world.weather"
local peachy = require 'peachy.peachy'

world = {
  level = 0,
  weather = 1,
  player = {},
  entities = {},
  camera = {},
  map = {},
}

function world:init()
  math.randomseed(os.time())
  sewr = peachy.new("assets/img/animated_sewr.json", love.graphics.newImage("assets/img/animated_sewr.png"), "slime")
  self.map = Map:new("assets/maps/level3_cc1", "assets/img/tiles.png")
  self.camera = Camera:new()
  self.camera:SetMap(self.map)

  self.player = PlayerEntity:new("player",30.5,25.5)
  
  self:spawnNPCs() --for testing
end

function world:update(dt,playerController)
  if playerController.paused or not playerController.inPlay then return end
  
  if not self.player.interaction then
    self.player.movement = playerController.movement
  else
    self.player.movement = {x=0,y=0}
  end
  
  self:updateEntities(dt)
  self:moveEntities(dt)
  
  interactions:update(dt,self,playerController,input)
  
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
  self.camera:updatePlayerPos(self.player)
  self.camera:SetPositionCentered(self.player.position.x,self.player.position.y)
  sewr:update(dt)
end

function world:draw()
  self.camera:Draw(self.player,self.entities)
  local w,h = love.graphics.getDimensions()

  -- WEATHER ELEMENTS --
  -- Fog Shader for testing
  if FogEnabled then
    love.graphics.setShader(weatherShader)
    weatherShader:send("player_position", self.camera.PlayerPosition)
    weatherShader:send("screen_position", {self.camera.Map.Tileset.TileWidth * self.camera.MapX,self.camera.Map.Tileset.TileHeight * self.camera.MapY})
    love.graphics.rectangle("fill", 1, 1, w, h)
    love.graphics.setShader()
  end

  -- DEGUG ELEMENTS --
  -- lines showing the center of the screen for testing
  if ShowScreenCenter then
    love.graphics.setColor(.7,0,.7,0.6)
    love.graphics.line(w/2,0,w/2,h)
    love.graphics.line(0,h/2,w,h/2)
    love.graphics.setColor(1,1,1)
  end

  sewr:draw(100, 100)
end

function world:spawnNPCs()
  local npcs = NPC:generate(5, Weather.Clear)

  for i = 1, #npcs do
    npcs[i].position = { x = math.random(30,35), y = math.random(25,30) }
    table.insert(self.entities, npcs[i])
  end
end

function world:moveEntities(dt)
  self:moveEntity(dt,self.player)

  for _,entity in pairs(self.entities) do
    self:moveEntity(dt,entity)
  end
end

function world:updateEntities(dt)
  self.player:update(dt,self)
  for _,entity in pairs(self.entities) do
    entity:update(dt,self)
  end
end

function world:moveEntity(dt,entity)
  local brakeX = 1
  local brakeY = 1
  if entity.movement.x == 0 then
    brakeX = 0.2
  end
  if entity.movement.y == 0 then 
    brakeY = 0.2
  end
  local velocity = Vector.new(entity.velocity.x + entity.movement.x * entity.acceleration,entity.velocity.y + entity.movement.y * entity.acceleration)
  if velocity:length() > entity.maxSpeed then
    velocity:normalize()
    velocity = velocity * entity.maxSpeed
  end
  
  velocity.x = velocity.x * brakeX
  velocity.y = velocity.y * brakeY
  
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
  
  if entity.velocity.x > math.abs(entity.velocity.y) then
    entity.facing = "r"
  elseif entity.velocity.x < -math.abs(entity.velocity.y) then
    entity.facing = "l"
  elseif entity.velocity.y > math.abs(entity.velocity.x) then
    entity.facing = "d"
  elseif entity.velocity.y < -math.abs(entity.velocity.x) then
    entity.facing = "u"
  end
  
  entity.position = proposedPosition
end

-- static helper function
-- hitbox is of the form {x1,x2,y1,y2} 
--   where x1 world x coordinate of the left bound of the hitbox
--   and x2 is the world x coordinate to the right. similarly, y1 is the distnace to the top, and
--   y2 is the distance to the bottom
-- returns true when position lies within hitBox
function world.hitBoxContains(hitBox,position)
  return hitBox.x1 < position.x and
          hitBox.x2 > position.x and
          hitBox.y1 < position.y and
          hitBox.y2 > position.y
end
