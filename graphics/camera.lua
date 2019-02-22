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
  type = "Camera"
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

-- Moves the camera through the world.
-- (number) dx: the delta x position of the camera.
-- (number) dy: the delta y position of the camera.
function Camera:Move(dx, dy)
  local oldX = self.MapX
  local oldY = self.MapY
  self.MapX = math.max(math.min(self.MapX + dx, self.Map.MapWidth - self.TileDisplayWidth), 0)
  self.MapY = math.max(math.min(self.MapY + dy, self.Map.MapHeight - self.TileDisplayHeight), 0)
  print(oldX); print(self.MapX)
  if math.floor(self.MapX) ~= math.floor(oldX) or math.floor(self.MapY) ~= math.floor(oldY) then
    self:UpdateTilesetBatch()
  end
end

-- Moves the camera to the specified world position.
function Camera:SetPosition(x, y)
  self.MapX = x / self.Map.Tileset.TileWidth
  self.MapY = y / self.Map.Tileset.TileHeight
  self.MapX = math.max(math.min(x / self.Map.Tileset.TileWidth, self.Map.MapWidth - self.TileDisplayWidth), 0)
  self.MapY = math.max(math.min(y / self.Map.Tileset.TileHeight, self.Map.MapHeight - self.TileDisplayHeight), 0)
  
  self:UpdateTilesetBatch()
end

-- Causes the camera to render to the screen everything it sees.
function Camera:Draw()
  for _, batch in pairs(self.TilesetBatch) do
    if batch ~= nil then 
      love.graphics.draw(batch, math.floor(-(self.MapX%1)*self.Map.Tileset.TileWidth), math.floor(-(self.MapY%1)*self.Map.Tileset.TileHeight))
    end
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
end

-- Creates a new camera instance. This should rarely, if ever, be done.
function Camera:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
