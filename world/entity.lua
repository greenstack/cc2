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
  o.velocity = {x = x or 0, y = y or 0}
  o.maxSpeed = 0
  return o
end

function Entity:update(dt,world)

end

function Entity:draw()

end

function Entity:getPosVec()
  return { self.position.x, self.position.y }
end