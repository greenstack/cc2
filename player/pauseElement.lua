PauseElement = Element:new("pauseMenu")

function PauseElement:new(name,x,y,o)
  local o = Element.new(self,name,x,y,o)
  o.options = {
    "Option 1",
    "Option 2",
    "Option 3",
    "Quit"
  }
  o.numOptions = 4
  o.selected = 1
  return o
end

function PauseElement:update(dt,input,player)
  if input:pressed('down') then
    beep:stop()
    beep:play()
    self.selected = self.selected + 1
    if(self.selected > self.numOptions) then
      self.selected = 1
    end
  elseif input:pressed('up') then
    beep:stop()
    beep:play()
    self.selected = self.selected - 1
    if(self.selected < 1) then
      self.selected = self.numOptions
    end
  end
  

end

function PauseElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth / 3
  local elementHeight = windowHeight * .7

  love.graphics.setColor(.2,.2,.2)
  love.graphics.rectangle("fill",self.position.x,self.position.y,elementWidth,elementHeight,10,10)
  
  
  for k,v in pairs(self.options) do
    if self.selected == k then
      love.graphics.setColor(1,1,0)
    else
      love.graphics.setColor(.9,.9,.9)
    end
    love.graphics.print(v,self.position.x + 20,self.position.y + 50*k)
  end
  
  
end
