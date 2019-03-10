PauseElement = Element:new("pauseMenu")

function PauseElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.options = {
    {text="Pokedex",f=PauseElement.option1}, --temporary stuff for fun because why not
    {text="Pokemon",f=PauseElement.option2},
    {text="Save",f=PauseElement.option2},
    {text="Main Menu",f=PauseElement.mainMenu},
    {text="Quit",f=PauseElement.quit}
  }
  o.selected = 1
  o.wait = true -- wait until the next tick so we don't close the element using the same input that opened it
  return o
end

function PauseElement:update(dt,input,player)
  if not self.wait and input:pressed('menu') then
    self:unpause(player)
  end
  
  if input:pressed('down') then
    self:moveDown()
  elseif input:pressed('up') then
    self:moveUp()
  end
  
  if input:pressed('talk') then
    self.options[self.selected].f(player)
  end
  
  self.wait = false
end

function PauseElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth / 4
  local elementHeight = #self.options * 50 + 60

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

function PauseElement:unpause(player)
  player.paused = false
  self:setEnabled(false)
  self:setVisible(false)
end

function PauseElement:moveDown()
  beep:stop()
  beep:play()
  self.selected = self.selected + 1
  if(self.selected > #self.options) then
    self.selected = 1
  end
end

function PauseElement:moveUp()
  beep:stop()
  beep:play()
  self.selected = self.selected - 1
  if(self.selected < 1) then
    self.selected = #self.options
  end
end

--static menu item handler functions

function PauseElement.option1(player)
  print("option 1")
end
function PauseElement.option2(player)
  print("option 2",player:getScreen("gameScreen"))
  player:getScreen("gameScreen"):getElement("console"):log("option 2")
end
function PauseElement.mainMenu(player)
  player.screen = player:getScreen("mainMenuScreen")
end
function PauseElement.quit()
  love.event.quit()
end