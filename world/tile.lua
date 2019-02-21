Tile = {
  TileId = 0,
  layer = -1,
  type = "Tile",
}

-- Creates a new instance of a tile object.
-- (int) TileId is the id of the tile.
-- (int) layer is the layer on which the tile lives.
function Tile:new(tileId, layer, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.TileId = tileId
  o.layer = layer
  return o
end
