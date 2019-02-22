require "world.map.tile"

Layer = {
  LayerId = 0,
  Grid = {},
  type = "Tile"
}

function Layer:new(layerNo, data)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.LayerId = layerNo
  return o
end
