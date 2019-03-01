Camera = {
  -- MapX and MapY are the top left corner coordinates.
  -- (number) The X position on the map the camera is on.
  MapX = 0,
  -- (number) The Y position on the map the camera is on.
  MapY = 0,
  -- (map) The map the camera should be drawing.
  Map,
  -- (tilesetbatch) The batch that the camera will draw in the :draw method.
  -- TODO: Turn this into a table of tilesetbatches.
  TilesetBatch,
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
  for layerName, tilesetBatch in pairs(self.TilesetBatch) do
    tilesetBatch:clear()
    for y = 0, self.TileDisplayHeight - 1 do
      for x = 0, self.TileDisplayWidth - 1 do
        if not self.Map.Layers[layerName]:IsTileEmpty(x + math.floor(self.MapX), y + math.floor(self.MapY)) then  
          tilesetBatch:add(
            self.Map.Tileset:GetTile(self.Map.Layers[layerName]:GetTile(x + math.floor(self.MapX), y + math.floor(self.MapY)).TileId),
            self.Map.Tileset.TileWidth * (x - 1),
            self.Map.Tileset.TileHeight * (y - 1)
          )
        end
      end
    end
    tilesetBatch:flush()
  end
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
  self.MapX = math.max(math.min(x, self.Map.MapWidth - self.TileDisplayWidth), 0)
  self.MapY = math.max(math.min(y, self.Map.MapHeight - self.TileDisplayHeight), 0)
  
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

function Camera:updatePlayerPos()
  if ShadowsEnabled then
    self.Shadows:send("playerPos", self.PlayerPosition)
  end
end

-- Causes the camera to render to the screen everything it sees.
function Camera:Draw(playerPosition)
  for _, batch in pairs(self.TilesetBatch) do
    if batch ~= nil then 
      love.graphics.draw(batch, math.floor(-(self.MapX%1)*self.Map.Tileset.TileWidth), math.floor(-(self.MapY%1)*self.Map.Tileset.TileHeight))
    end
  end
  
  --temporary player indicator
  love.graphics.setColor(.7,0,.7)
  self.PlayerPosition = self:GetScreenPosition(playerPosition.x, playerPosition.y)
  love.graphics.circle("fill",self.PlayerPosition[1], self.PlayerPosition[2],4)
  
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
end

-- Sets the map the camera is rendering.
-- (Map) map: the map to start rendering through the camera.
function Camera:SetMap(map)
  self.Map = map
  self.TilesetBatch = {}
  print(#map.Layers)
  for _, layer in pairs(map.Layers) do
    print("Setting layer " .. layer.Name .. " tileset batch.")
    self.TilesetBatch[layer.Name] = love.graphics.newSpriteBatch(map.Tileset.Image, map.Tileset.ImageWidth * map.Tileset.ImageHeight)
  end
  self:UpdateTilesetBatch()

  
  -- Update the shadows shader to contain the right objects.
  local hitboxes = {}
  for _, box in ipairs(self.Map.Hitboxes) do
    table.insert(hitboxes, box:getVec4Definition())
  end
  
  local shader = love.filesystem.read("graphics/shaders/shadows.frag")
  -- This ensures that we have exactly as much space
  -- as we need in our fragment shader. Nothing more.
  shader = shader:gsub('_HITBOX_TOTAL_', #hitboxes)
  self.Shadows = love.graphics.newShader(shader)
  self.Shadows:send("rects", unpack(hitboxes))
end

-- Creates a new camera instance. This should rarely, if ever, be done.
function Camera:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
