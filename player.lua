require "player.screen"
require "player.element"
require "player.obediometerElement"
require "player.pauseElement"

player = {
  screen = Screen:new("gameScreen"),
  obedience = 100,
  maxObedience = 100,
  paused = false,
  movement = {x=0,y=0}
}

function player:init()
  self.screen:addElement(ObediometerElement:new("obediometer",10,10))
end

function player:update(dt,input)
  if input:pressed('menu') and not self.paused then
    self.paused = true
    print("pausing")
    self.screen:addElement(PauseElement:new("pauseMenu",260,70))
  --elseif input:pressed('menu') and paused then
    --paused = false
    --self.screen:removeElement("pauseMenu")
  end
  
  if not self.paused then
  
    self.movement.x,self.movement.y = input:get('move')
  
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
  
  --input:update()
  self.screen:update(dt,input,self)
end