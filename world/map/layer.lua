require "world.map.tile"

Layer = {
  Name = "",
  Grid,
  type = "Tile",
  IsTileEmpty = function(self, x, y)
    return self.Grid[x][y].TileId == 0
  end,
  GetTile = function (self, x, y)
    return self.Grid[x][y]
  end
}

function Layer:new(data, layerId, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Name = data.name
  o.Grid = {}
  local layerWidth = data.width
  local layerHeight = data.height
  local x, y
  for x = 1, layerWidth do
    o.Grid[x] = {}
    for y = 1, layerHeight do
      --print(x * layerHeight + y)
      o.Grid[x][y] = Tile:new(data.data[y * layerWidth + x], layerId)
    end
  end
  return o
end
