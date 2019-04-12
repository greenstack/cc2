require "world.map.tile"

Layer = {
  -- (string) The name of the layer.
  Name = "",
  -- (table) A 2D table of Tiles.
  Grid,
  type = "Tile",
  -- (number) The width, in tiles, of this layer.
  LayerWidth,
  -- (number) The height, in tiles, of this layer.
  LayerHeight,
  -- (number) x: The x-position of the tile to query.
  -- (number) y: The y-position of the tile to query.
  -- (bool) return: True if the tile is out of bounds or the tile is empty.
  IsTileEmpty = function(self, x, y)
    if x <= 0 or x > self.LayerWidth or y <= 0 or y > self.LayerHeight then
      return true
    end
    return self.Grid[x][y].TileId == 0
  end,
  -- (number) x: The x-position of the tile to query.
  -- (number) y: The y-position of the tile to query.
  -- (Tile) return: The tile at the position.
  GetTile = function (self, x, y)
    if x <= 0 or x > self.LayerWidth or y <= 0 or y > self.LayerHeight then
      error("Attempt to query a tile out of the layer's bounds.")
    end
    return self.Grid[x][y]
  end
}

function Layer:new(data, layerId, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Name = data.name
  o.id = data.id
  o.Grid = {}
  o.LayerWidth = data.width
  o.LayerHeight = data.height
  local x, y
  for x = 1, o.LayerWidth do
    o.Grid[x] = {}
    for y = 1, o.LayerHeight do
      --print(x * layerHeight + y)
      o.Grid[x][y] = Tile:new(data.data[(y - 1) * o.LayerWidth + x], layerId)
    end
  end
  o.properties = data.properties or {}
  return o
end
