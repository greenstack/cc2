local peachy = require 'peachy.peachy'

PlayerEntity = Entity:new()

function PlayerEntity:new(name,x,y,o)
  local o = Entity.new(self,name,x,y,o)
  o.maxSpeed = 5
  o.type="PlayerEntity"
  o.acceleration = 1
  o.hitBox = {x1=-.15,y1=-.15,x2=.15,y2=.15}
  o.animation = peachy.new("assets/img/player.json", nil, "Idle")
  return o
end

function PlayerEntity:draw(x,y)
  self.animation:draw(x,y)
end

function PlayerEntity:update(dt,world)
  -- Also fix the animation tag here
  if self.movement.x > 0 then
    self.animation:setTag("RunRight")
  elseif self.movement.x < 0 then
    self.animation:setTag("RunLeft")
  elseif self.movement.y > 0 then
    self.animation:setTag("RunDown")
  elseif self.movement.y < 0 then
    self.animation:setTag("RunUp")
  else
    self.animation:setTag("Idle")
  end

  self.animation:update(dt)
end
