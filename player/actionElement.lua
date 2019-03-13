ActionElement = Element:new("action")

function ActionElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.text = love.graphics.newText(font,"")
  return o
end

function ActionElement:update(dt,input,player)

  
end

function ActionElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = self.text:getWidth() + 10--windowWidth / 5
  local elementHeight = 20

  love.graphics.setColor(.2,.2,.2)
  love.graphics.rectangle("fill",self.position.x,self.position.y,elementWidth,elementHeight)
  
  love.graphics.setColor(.9,.9,.9)
  love.graphics.draw(self.text,self.position.x + 2,self.position.y + 2)
  
end

function ActionElement:setText(text)
  self.text:set(text)
end