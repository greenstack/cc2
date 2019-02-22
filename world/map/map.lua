require "world.map.layer"
require "world.map.tileset"

Map = {
  Name = "",
  Layers = {},
  type = "Map",
  MapWidth,
  MapHeight,
  Tileset,
}

function Map:new(levelName, tilesetPath, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Name = levelName
  local levelData = require(levelName)
  o.MapWidth = levelData.width
  o.MapHeight = levelData.height
  o.Layers = {}
  local layerId = 1
  for key, layer in ipairs(levelData.layers) do
    table.insert(o.Layers, Layer:new(layer, layerId))
    layerId = layerId + 1
  end
  o.Tileset = Tileset:new(tilesetPath, levelData.tilewidth, levelData.tileheight)
  return o
end
