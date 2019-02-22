require "world.map.layer"

Map = {
  Name = "",
  Layers = {},
  type = "Map"
}

function Map:new(levelName)
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.name = levelName
  return o
end
