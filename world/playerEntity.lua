PlayerEntity = Entity:new()

function PlayerEntity:new(name,x,y,o)
  local o = Entity.new(self,name,x,y,o)
  o.maxSpeed = 5
  o.type="PlayerEntity"
  o.acceleration = 1
  o.hitBox = {x1=-.15,y1=-.15,x2=.15,y2=.15}
  return o
end