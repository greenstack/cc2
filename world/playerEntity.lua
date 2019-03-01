PlayerEntity = Entity:new("player")

function PlayerEntity:new(name,x,y,o)
  local o = Entity.new(self,name,x,y,o)
  o.maxSpeed = 5
  return o
end

function PlayerEntity:update(dt,world)

end