Entity = {
  type = "Entity",
  position = nil,
}

-- Creates a new instance of an entity object.
-- (number) the x position of the entity
-- (number) the y position of the entity
function Entity:new(name,x,y,o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.position = {x = x or 0, y = y or 0}
  return o
end

function Eneity:update(dt)

end

function Entity:draw()

end