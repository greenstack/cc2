ObediometerElement = Element:new("obediometer")

function ObediometerElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.obedience = 100;
  o.maxObedience = 100;
  return o;
end

function ObediometerElement:update(dt,input,player)

  self.obedience = player.obedience
  self.maxObedience = player.maxObedience
end

function ObediometerElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth - 30
  local elementHeight = 15
  
  local maxObediometerLength = elementWidth - 120
  local obediometerHeight = 20
  
  local obediometerLength = (self.obedience/self.maxObedience) * maxObediometerLength
  
  --obediometer backdrop
  love.graphics.setColor(0.4, 0.4, 0.6)
  love.graphics.rectangle("fill",self.position.x,self.position.y,elementWidth,elementHeight,10,10)
  
  --obediometer label
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Obediometer",self.position.x + 5,self.position.y)
  
  --obediometer bar color
  local r = 1 - self.obedience/self.maxObedience
  local g = self.obedience/self.maxObedience
  local b = 0
  
  --black background of obediometer bar
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",self.position.x + 110,self.position.y + 2,maxObediometerLength,10,10,10)
  
  --obediometer bar
  love.graphics.setColor(r, g, b)
  if(obediometerLength > 0) then
    love.graphics.rectangle("fill",self.position.x + 110,self.position.y + 2,obediometerLength,10,10,10) 
  end
  
end
