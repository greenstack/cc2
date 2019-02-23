PauseElement = Element:new("pauseMenu")

function PauseElement:new(name,x,y,o)
  local o = Element.new(self,name,x,y,o)
  o.options = {
    {text="Option 1",f=PauseElement.option1},
    {text="Option 2",f=PauseElement.option2},
    {text="Option 3",f=PauseElement.option3},
    {text="Quit",f=PauseElement.quit}
  }
  o.numOptions = 4
  o.selected = 1
  o.wait = true -- 
  return o
end

function PauseElement:update(dt,input,player)
  if not self.wait and input:pressed('menu') then
    player.paused = false
    player.screen:removeElement("pauseMenu")
    --love.event.quit()
  end
  
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
  
  if input:pressed('talk') then
    self.options[self.selected].f()
  end
  
  self.wait = false
end

function PauseElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth / 4
  local elementHeight = self.numOptions * 50 + 60

  love.graphics.setColor(.2,.2,.2)
  love.graphics.rectangle("fill",self.position.x,self.position.y,elementWidth,elementHeight,10,10)
  
  love.graphics.setColor(.9,.9,.9)
  love.graphics.print("PAUSED",self.position.x + 70, self.position.y + 10)
  
  for k,v in pairs(self.options) do
    if self.selected == k then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,self.position.x + 20,self.position.y + 50*k + 2)
      love.graphics.setColor(.8,.8,
      .7)
    else
      love.graphics.setColor(.9,.9,.9)
    end
    love.graphics.print(v.text,self.position.x + 40,self.position.y + 50*k)
  end
end

function PauseElement.option1()
  print("option 1")
end
function PauseElement.option2()
  print("option 2")
end
function PauseElement.option3()
  print("option 3")
end
function PauseElement.quit()
  love.event.quit()
end