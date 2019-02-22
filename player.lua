require "player.screen"
require "player.element"
require "player.obediometerElement"
require "player.pauseElement"

player = {
  screen = Screen:new("gameScreen"),
  obedience = 100,
  maxObedience = 100,
  paused = false
}

function player:init()
  self.screen:addElement(ObediometerElement:new("obediometer",10,10))
end

function player:update(dt,input)
  if input:pressed('talk') and not paused then
    paused = true
    self.screen:addElement(PauseElement:new("pauseMenu",260,70))
  elseif input:pressed('talk') and paused then
    paused = false
    self.screen:removeElement("pauseMenu")
  end
  
  if not paused then
    --temporary way to change obediometer for testing
    if input:down("action") then
      self.obedience = self.obedience - 0.4
    else
      self.obedience = self.obedience + 0.2
    end
    self.obedience = math.min(self.maxObedience,self.obedience)
    self.obedience = math.max(0,self.obedience)
  else
    
  end
  
  
  self.screen:update(dt,input,self)
end