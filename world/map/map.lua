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
  for _, layer in ipairs(levelData.layers) do
    local l = Layer:new(layer, layerId)
    o.Layers[l.Name] = l
  end
  o.Tileset = Tileset:new(tilesetPath, levelData.tilewidth, levelData.tileheight)
  return o
end
