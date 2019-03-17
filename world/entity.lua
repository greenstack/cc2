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
  o.velocity = {x = 0, y = 0}
  o.movement = {x = 0, y = 0}
  o.maxSpeed = 0
  o.acceleration = 1
  o.facing = "d" -- d,u,l,r
  o.hitBox = nil
  o.name = name
  o.interaction = false -- indicates entity is in an interaction
  o.animation = nil
  o.visible = false
  return o
end

function Entity:update(dt,world)
  if o.animation ~= nil then
    animation.update(dt)
  end
end

function Entity:getPosVec()
  return { self.position.x, self.position.y }
end

function Entity:getVelVec()
  return { self.velocity.x, self.velocity.y }
end

function Entity:getMovVec()
  return { self.movement.x, self.movement.y }
end

function Entity:getAbsoluteHitbox()
  if self.hitBox then
    return {x1=self.hitBox.x1+self.position.x,x2=self.hitBox.x2+self.position.x,y1=self.hitBox.y1+self.position.y,y2=self.hitBox.y2+self.position.y}
  end
end