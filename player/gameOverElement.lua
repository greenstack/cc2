GameOverElement = Element:new("gameWin")

function GameOverElement:new(name, o)
  local o = Element.new(self, name, 0, 0, true, true, o)
  o.options = {
    {text="Restart", f=GameOverElement.restart},
    {text="Main Menu", f=GameOverElement.mainMenu},
    {text="Quit", f=GameOverElement.quit}
  }
  o.selected = 1
  o.wait = true
  o.victory = false
  return o
end

function GameOverElement:moveDown()
  beep:stop()
  beep:play()
  self.selected = self.selected + 1
  if(self.selected > #self.options) then
    self.selected = 1
  end
end

function GameOverElement:moveUp()
  beep:stop()
  beep:play()
  self.selected = self.selected - 1
  if(self.selected < 1) then
    self.selected = #self.options
  end
end

function GameOverElement:update(dt, input, player)
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

function GameOverElement:draw()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
  love.graphics.setColor(1,1,1)
  if self.victory then
    love.graphics.print("You won")
  else
    love.graphics.print("game over")
  end
  love.graphics.push()
  love.graphics.translate(200, 100)
  love.graphics.print("Contact Goal: " .. world.playthroughStats.contactsGoalTotal, 0, 0)
  love.graphics.print("Contacts Made: " .. world.playthroughStats.contactsTotal, 0, 16)
  love.graphics.print("Completion:" .. world.playthroughStats.contactsTotal / world.playthroughStats.contactsGoalTotal * 100 .. "%", 0, 32)
  love.graphics.pop()
  love.graphics.push()
  love.graphics.translate(500, 100)
  for k,v in pairs(self.options) do
    if self.selected == k then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,20,50*k + 2)
      love.graphics.setColor(.8,.8,.7)
    else
      love.graphics.setColor(.9,.9,.9)
    end
    love.graphics.print(v.text,40,50*k)
  end
  love.graphics.pop()
end

function GameOverElement:setVictory(status)
  self.victory = status
end

function GameOverElement.restart(player)
  currentPlaylist:stop()
  currentPlaylist:play("themeA")
  player:resetStats()
  world:goToLevel(1)
  player.screen = player:getScreen("gameScreen")
  player.paused = false
end

function GameOverElement.mainMenu(player)
  player.screen = player:getScreen('mainMenuScreen')
  gamePlaylist:stop()
  currentPlaylist = titlePlaylist
  currentPlaylist:play("titleTheme")
  love.reset()
end

function GameOverElement.quit(player)
  love.event.quit()
end
