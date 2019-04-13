OptionsElement = Element:new("optionsElement")

function OptionsElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.options = {
    {text = "Master Volume", volumeType = 'master', volumeLevel = masterVolume},
    {text = "Music Volume", volumeType = 'music', volumeLevel = musicVolume},
    {text = "SFX Volume", volumeType = 'sfx', volumeLevel = sfxVolume},
    {text = "Done", f = OptionsElement.done}
  }
  o.selected = 1
  o.wait = true
  return o
end

function OptionsElement:update(dt,input,player)
  if not self.wait and input:pressed('menu') then
    self.done(player)
  end

  local curSelection = self.options[self.selected]
  if input:pressed('down') then
    self:moveDown()
  elseif input:pressed('up') then
    self:moveUp()
  elseif input:pressed('left') and curSelection.volumeType ~= nil then
    -- There were some issues with the value being something like 1.812376847628756e-14 instead of 0.
    -- That's why these lines are here
    local newLevel = curSelection.volumeLevel - 0.1
    local round = math.floor(newLevel * 10 + 0.5) / 10
    newLevel = math.max(round, 0)

    self.options[self.selected].volumeLevel = newLevel
    self.setVolume(curSelection.volumeType, newLevel)
  elseif input:pressed('right') and curSelection.volumeType ~= nil then
    local newLevel = math.min(curSelection.volumeLevel + 0.1, 1)
    self.options[self.selected].volumeLevel = newLevel
    self.setVolume(curSelection.volumeType, newLevel)
  end

  if not self.wait and input:pressed('talk') and self.options[self.selected].f then
    self.options[self.selected].f(player)
  end

  self.wait = false
end

function OptionsElement:draw()
  local windowWidth, widowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth / 2
  local elementHeight = #self.options * 75 + 50

  love.graphics.setColor(.1,.1,.1)
  love.graphics.rectangle("fill",self.position.x,self.position.y,elementWidth,elementHeight,10,10)

  love.graphics.setColor(.9,.9,.9)
  love.graphics.print("OPTIONS",self.position.x + 170, self.position.y + 10)

  for k,v in pairs(self.options) do
    if self.selected == k then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,self.position.x + 20,self.position.y + 50*k + 2)
      love.graphics.setColor(.8,.8,.7)
    else
      love.graphics.setColor(.9,.9,.9)
    end
    love.graphics.print(v.text,self.position.x + 40,self.position.y + 50*k)

    if v.volumeType then
      self.drawSlider(self.position.x + 175, self.position.y + 50*k, v.volumeLevel)
      love.graphics.setColor(.9,.9,.9)
      love.graphics.print(v.volumeLevel*100,self.position.x + 350, self.position.y + 50*k)
    end
  end
end

function OptionsElement.drawSlider(x,y,volume)
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", x, y, 160*volume, 20,0,0)
end

function OptionsElement:moveDown()
  beep:stop()
  beep:play()
  self.selected = self.selected + 1
  if (self.selected > #self.options) then
    self.selected = 1
  end
end

function OptionsElement:moveUp()
  beep:stop()
  beep:play()
  self.selected = self.selected - 1
  if(self.selected < 1) then
    self.selected = #self.options
  end
end

function OptionsElement.setVolume(type, volume)
  if type == 'master' then
    masterVolume = volume
    love.audio.setVolume(masterVolume)
  elseif type == 'music' then
    musicVolume = volume
    gamePlaylist:setVolume(musicVolume)
    titlePlaylist:setVolume(musicVolume)
    testPlaylist:setVolume(musicVolume)
  elseif type == 'sfx' then
    sfxVolume = volume
    beep:setVolume(sfxVolume)
    Weather.Rainy.Sound:setVolume(sfxVolume)
  end
end

function OptionsElement.done(player)
  print("Options done")
  player.screen:getElement("options"):setEnabled(false)
  player.screen:getElement("options"):setVisible(false)
  player.screen:getElement("options").selected = 1
  if player.inPlay then
    player.screen:getElement("pauseMenu"):setEnabled(true)
  else
    player.screen:getElement("mainMenu"):setEnabled(true)
  end
end