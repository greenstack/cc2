Camera = {
  -- (number) The X position on the map the camera is on.
  MapX,
  -- (number) The Y position on the map the camera is on.
  MapY,
  -- (number) The X component of the zoom.
  ZoomX,
  -- (number) The Y component of the zoom.
  ZoomY,
  -- (map) The map the camera should be drawing.
  Map,
  -- (tilesetbatch) The batch that the camera will draw in the :draw method.
  -- TODO: Turn this into a table of tilesetbatches.
  TilesetBatch,
  -- (number) How many tiles to display horizontally.
  TileDisplayWidth = 30,
  -- (number) How many tiles to display vertically.
  TileDisplayHeight = 15
}

function Camera:UpdateTilesetBatch()
  self.TilesetBatch:clear()
  for y = 1, self.TileDisplayHeight - 1 do
    for x = 1, self.TileDisplayWidth - 1 do
      --print (x .. " " .. y .. "-->" .. self.Map.Layers[1].Grid[x][y].TileId)
      if not self.Map.Layers[1]:IsTileEmpty(x, y) then  
        self.TilesetBatch:add(
          self.Map.Tileset:GetTile(self.Map.Layers[1]:GetTile(x, y).TileId),
          self.Map.Tileset.TileWidth * (x - 1),
          self.Map.Tileset.TileHeight * (y - 1)
        )
      end
    end
  end
  self.TilesetBatch:flush()
end

function Camera:MoveMap(dx, dy)
  local oldX = self.MapX
  local oldY = self.MapY
  self.MapX = math.max(math.min(self.MapX + dx, self.Map.MapWidth - self.TileDisplayWidth), 1)
  self.MapY = math.max(math.min(self.MapY + dy, self.Map.MapHeight - self.TileDisplayHeight), 1)
  if math.floor(self.MapX) ~= math.floor(oldX) or math.floor(self.MapY) ~= math.floor(oldY) then
    self:UpdateTilesetBatch()
  end
end

function Camera:Update(dt)

end

function Camera:Draw()
  love.graphics.draw(self.TilesetBatch)
end

function Camera:SetMap(map)
  self.Map = map
  self.TilesetBatch = love.graphics.newSpriteBatch(map.Tileset.Image, map.Tileset.ImageWidth * map.Tileset.ImageHeight)
  self:UpdateTilesetBatch()
end

function Camera:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
