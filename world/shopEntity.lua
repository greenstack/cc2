ShopEntity = Entity:new()

function ShopEntity:new(name,x,y,o)
  local o = Entity.new(self,name,x,y,o)
  o.type="ShopEntity"
  o.hitBox = {x1=-.5,y1=-.5,x2=.5,y2=.5}
  o.interaction = false
  o.interactionImg = "shopkeep"
  return o
end

function ShopEntity:update(dt,world)
  
end

function ShopEntity:draw(x,y)

end
