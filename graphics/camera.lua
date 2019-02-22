Camera = {
  -- (number) The X position on the map the camera is on.
  MapX,
  -- (number) The Y position on the map the camera is on.
  MapY,
  -- (map) The map the camera should be drawing.
  Map,
  -- (tilesetbatch) The batch that the camera will draw in the :draw method.
  -- TODO: Turn this into a table of tilesetbatches.
  TilesetBatch,
  -- (number) How many tiles to display horizontally.
  TileDisplayWidth = 28,
  -- (number) How many tiles to display vertically.
  TileDisplayHeight = 15
}

-- Causes the camera to update the part of the world it is to be rendering.
function Camera:UpdateTilesetBatch()
  for layerName, tilesetBatch in pairs(self.TilesetBatch) do
    tilesetBatch:clear()
    for y = 1, self.TileDisplayHeight - 1 do
      for x = 1, self.TileDisplayWidth - 1 do
        if not self.Map.Layers[layerName]:IsTileEmpty(x, y) then  
          tilesetBatch:add(
            self.Map.Tileset:GetTile(self.Map.Layers[layerName]:GetTile(x, y).TileId),
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
  self.MapX = math.max(math.min(self.MapX + dx, self.Map.MapWidth - self.TileDisplayWidth), 1)
  self.MapY = math.max(math.min(self.MapY + dy, self.Map.MapHeight - self.TileDisplayHeight), 1)
  if math.floor(self.MapX) ~= math.floor(oldX) or math.floor(self.MapY) ~= math.floor(oldY) then
    self:UpdateTilesetBatch()
  end
end

-- Causes the camera to render to the screen everything it sees.
function Camera:Render()
  for _, batch in pairs(self.TilesetBatch) do
    if batch ~= nil then 
      love.graphics.draw(batch)
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
