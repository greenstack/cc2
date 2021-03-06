Camera = {
  -- MapX and MapY are the top left corner coordinates.
  -- (number) The X position on the map the camera is on.
  MapX = 0,
  -- (number) The Y position on the map the camera is on.
  MapY = 0,
  -- (map) The map the camera should be drawing.
  Map,
  -- (tilesetbatch) The batch that the camera will draw in the :draw method.
  TilesetBatch,
  HighTilesetBatch,
  -- (number) How many tiles to display horizontally.
  TileDisplayWidth = 27,
  -- (number) How many tiles to display vertically.
  TileDisplayHeight = 21,
  type = "Camera",
  -- (shader) The shader that draws the shadows.
  Shadows,
  -- Screen coordiantes for use in shaders
  PlayerPosition = { 1,1 }
}

-- Causes the camera to update the part of the world it is to be rendering.
function Camera:UpdateTilesetBatch()
  self.HighTilesetBatch:clear()
  for layerId, tilesetBatch in pairs(self.TilesetBatch) do
    tilesetBatch:clear()
    for y = 0, self.TileDisplayHeight - 1 do
      for x = 0, self.TileDisplayWidth - 1 do
        if not self.Map.Layers[layerId]:IsTileEmpty(x + math.floor(self.MapX), y + math.floor(self.MapY)) then
          if self.Map.Layers[layerId].properties["order"] ~= "high" then
            tilesetBatch:add(
              self.Map.Tileset:GetTile(self.Map.Layers[layerId]:GetTile(x + math.floor(self.MapX), y + math.floor(self.MapY)).TileId),
              self.Map.Tileset.TileWidth * (x - 1),
              self.Map.Tileset.TileHeight * (y - 1)
            )
          else
            self.HighTilesetBatch:add(
              self.Map.Tileset:GetTile(self.Map.Layers[layerId]:GetTile(x + math.floor(self.MapX), y + math.floor(self.MapY)).TileId),
              self.Map.Tileset.TileWidth * (x - 1),
              self.Map.Tileset.TileHeight * (y - 1)
            )
          end
        end
      end
    end
    tilesetBatch:flush()
  end
  self.HighTilesetBatch:flush()
end

-- Moves the camera through the world, relative to tiles.
-- (number) dx: the delta x position of the camera.
-- (number) dy: the delta y position of the camera.
function Camera:Move(dx, dy)
  self:SetPosition(
    self.MapX + dx,
    self.MapY + dy
  )
end


function Camera:GetScreenPosition(x, y)
  return {
    (x - self.MapX - 1) * self.Map.Tileset.TileWidth,
    (y - self.MapY - 1) * self.Map.Tileset.TileHeight
  }
end

-- Moves the camera to the specified world pixel position.
function Camera:SetPosition(x, y)
  local oldX = self.MapX
  local oldY = self.MapY

  self.MapX = x
  self.MapY = y
  -- I don't know why I need to add 2. But I do, and it works, so... whatever, I guess.
  self.MapX = math.max(math.min(x, self.Map.MapWidth - self.TileDisplayWidth + 2), 0)
  self.MapY = math.max(math.min(y, self.Map.MapHeight - self.TileDisplayHeight + 2), 0)

  if math.floor(self.MapX) ~= math.floor(oldX) or math.floor(self.MapY) ~= math.floor(oldY) then
    self:UpdateTilesetBatch()
  end
  if ShadowsEnabled then
    self.Shadows:send("translate", {-self.MapX * self.Map.Tileset.TileWidth, -self.MapY * self.Map.Tileset.TileHeight})
  end
end

function Camera:SetPositionCentered(x,y)
  self:SetPosition(
    x - (self.TileDisplayWidth / 2),
    y - (self.TileDisplayHeight / 2)
  )
end

function Camera:updatePlayerPos(player)
  self.PlayerPosition = self:GetScreenPosition(player.position.x, player.position.y)
  if ShadowsEnabled then
    self.Shadows:send("playerPos", self.PlayerPosition)
  end
end

-- Causes the camera to render to the screen everything it sees.
function Camera:Draw(player,entities)
  local highReserve = {}
  for _, batch in pairs(self.TilesetBatch) do
    if batch ~= nil then
      love.graphics.draw(batch, math.floor(-(self.MapX%1)*self.Map.Tileset.TileWidth), math.floor(-(self.MapY%1)*self.Map.Tileset.TileHeight))
    end
  end

  -- draw entities

  self:drawEntity(player)
  for _, entity in ipairs(entities) do
    self:drawEntity(entity)
  end

  love.graphics.draw(self.HighTilesetBatch, math.floor(-(self.MapX%1)*self.Map.Tileset.TileWidth), math.floor(-(self.MapY%1)*self.Map.Tileset.TileHeight))

  --Store the screen coordinates for later use
  love.graphics.setColor(1, 1, 1)
  if ShowHitboxes then
    for _, obj in ipairs(self.Map.Hitboxes) do
      local objPos = self:GetScreenPosition(obj.xPos, obj.yPos)
      love.graphics.rectangle("line", objPos[1], objPos[2], obj.pixelWidth, obj.pixelHeight)
    end
  end
  if ShadowsEnabled then
    love.graphics.setShader(self.Shadows)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()
  end
  if ShowPathingGraph then
    self.Map.PathingGraph:show(-(self.MapX)*self.Map.Tileset.TileWidth,-(self.MapY)*self.Map.Tileset.TileHeight)
  end
  if ShowPathingGrid then
    for k,v in pairs(self.Map.PathingGrid) do
      local nodePos = self:GetScreenPosition(v.x + 0.5,v.y + 0.5)
      love.graphics.circle("fill",nodePos[1] + .5,nodePos[2] + .5,1)
    end
  end
end

-- Sets the map the camera is rendering.
-- (Map) map: the map to start rendering through the camera.
function Camera:SetMap(map)
  self.Map = map
  self.TilesetBatch = {}
  print("Map has " .. #map.Layers .. " layers.")
  for _, layer in pairs(map.Layers) do
    print("Setting layer " .. layer.Name .. " tileset batch.")
    self.TilesetBatch[layer.id] = love.graphics.newSpriteBatch(map.Tileset.Image, map.Tileset.ImageWidth * map.Tileset.ImageHeight)
  end
  self.HighTilesetBatch = love.graphics.newSpriteBatch(map.Tileset.Image, map.Tileset.ImageWidth * map.Tileset.ImageHeight)
  self:UpdateTilesetBatch()

  -- Update the shadows shader to contain the right objects.
  local hitboxes = {}
  for _, box in ipairs(self.Map.Hitboxes) do
    table.insert(hitboxes, box:getVec4Definition())
  end

  -- We need to read it from a file and then into a shader
  -- because we need to replace some text.
  local shader = love.filesystem.read("graphics/shaders/shadows.frag")
  -- This ensures that we have exactly as much space
  -- as we need in our fragment shader. Nothing more.
  shader = shader:gsub('_HITBOX_TOTAL_', #hitboxes)
  self.Shadows = love.graphics.newShader(shader)
  self.Shadows:send("rects", unpack(hitboxes))
  
  -- configure the fade distance
  self.Shadows:send("morning_fade", 150)
  self.Shadows:send("fade", 300)
  self.Shadows:send("evening_fade", 50)
  self.Shadows:send("morningBounds", {34200, 39600})
  self.Shadows:send("eveningBounds", {70200, 75600})

  self.Shadows:send("shadowAlpha", .3)
end

-- Creates a new camera instance. This should rarely, if ever, be done.
function Camera:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Draws an entity. currently only displays their hitbox.
function Camera:drawEntity(entity)
  local pos = self:GetScreenPosition(entity.position.x, entity.position.y)
  love.graphics.setColor(1,1,1)
  if entity.type == "PlayerEntity" then
    entity:draw(pos[1]-16, pos[2]-16)
    --return -- Renove this line for debug drawing on the playera
  elseif entity.type == "NPC" and entity.visible then
    entity:draw(pos[1]-16, pos[2]-16)
    --return -- Renove this line for debug drawing on the NPCs
  elseif entity.type == "CompanionEntity" and entity.visible then
    entity:draw(pos[1]-16, pos[2]-16)
    --return -- Renove this line for debug drawing on the companion
  end

  if entity.visible and entity.arrow then
    love.graphics.polygon("fill",pos[1],pos[2] - 15,
                                  pos[1] + 5,pos[2] - 23,
                                  pos[1] - 5,pos[2] - 23)
  end

  if ShowHitboxes and entity.hitBox then
    local hitBoxP1 = self:GetScreenPosition(entity.position.x + entity.hitBox.x1,entity.position.y + entity.hitBox.y1)
    local hitBoxP2 = self:GetScreenPosition(entity.position.x + entity.hitBox.x2,entity.position.y + entity.hitBox.y2)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", hitBoxP1[1],
                                    hitBoxP1[2],
                                    hitBoxP2[1] - hitBoxP1[1],
                                    hitBoxP2[2] - hitBoxP1[2])

  end
end
