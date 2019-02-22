Camera = {
  MapX,
  MapY,
  ZoomX,
  ZoomY,
  Map,
  TilesetBatch
}

function Camera:UpdateTilesetBatch()
  self.TilesetBatch:clear()
  for x = 0, self.Map.MapWidth - 1 do
    for y = 0, self.Map.MapHeight - 1 do
      --print (x .. " " .. y .. "-->" .. self.Map.Layers[1].Grid[x][y].TileId)
      self.TilesetBatch:add(
        self.Map.Tileset:GetTile(self.Map.Layers[1]:GetTile(x+1, y+1).TileId),
        self.Map.Tileset.TileWidth * x,
        self.Map.Tileset.TileHeight * y
      )
    end
  end
  self.TilesetBatch:flush()
end

function Camera:MoveMap(dx, dy)
  local oldX = self.TilePositionX
  local oldY = self.TilePositionY
  self.TilePositionX = math.max(math.min(self.TilePositionX + dx / self.Map.TileWidth, self.Tile))
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
