MainMenuElement = Element:new("mainMenu")

function MainMenuElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.options = {
    {text="Start Game",x=355,f=MainMenuElement.startGame},
    {text="Quit",x=380,f=MainMenuElement.quit}
  }
  o.selected = 1
  return o
end

function MainMenuElement:update(dt,input,player)
  if input:pressed('enter') or input:pressed('talk') then
    self.options[self.selected].f(player)
  elseif input:pressed('down') then
    beep:stop()
    beep:play()
    self.selected = self.selected + 1
    if (self.selected > #self.options) then
      self.selected = 1
    end
  elseif input:pressed('up') then
    beep:stop()
    beep:play()
    self.selected = self.selected - 1
    if (self.selected < 1) then
      self.selected = #self.options
    end
  end
end

function MainMenuElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",self.position.x,self.position.y,windowWidth,windowHeight,10,10)

  love.graphics.setColor(.9,.9,.9)
  love.graphics.print("COMPA CHAOS 2",self.position.x + 340, self.position.y + 50)
  love.graphics.print("The One We Wanted to Make",self.position.y + 285, self.position.y + 90)


  for k,v in pairs(self.options) do
    if self.selected == k then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,self.position.x + v.x - 20,self.position.y + 75*k + 202)
      love.graphics.setColor(.8,.8,.7)
    else
      love.graphics.setColor(.9,.9,.9)
    end
    love.graphics.print(v.text,self.position.x + v.x,self.position.y + 75*k + 200)
  end
end

function MainMenuElement.startGame(player)
  print("Starting game")
  player.inPlay = true
  player.screen = player:getScreen("gameScreen")
end

function MainMenuElement.quit()
  print("Quitting game")
  love.event.quit()
end