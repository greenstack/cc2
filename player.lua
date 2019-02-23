require "player.screen"
require "player.element"
require "player.obediometerElement"
require "player.pauseElement"
require "player.consoleElement"

player = {
  screen = Screen:new("gameScreen"),
  obedience = 100,
  maxObedience = 100,
  paused = false,
  movement = {x=0,y=0},
  debugMode = false
}

function player:init()
  self.screen:addElement(ObediometerElement:new("obediometer",10,10))
end

function player:update(dt,input)

  if input:pressed('debug') and not self.debugMode then
    
    local consoleElement = ConsoleElement:new("console",0,0)
    consoleElement.oldPaused = self.paused
    
    self.paused = true
    self.debugMode = true
    self.screen:addElement(consoleElement)
  end


  if input:pressed('menu') and not self.paused then
    self.paused = true
    
    self.screen:addElement(PauseElement:new("pauseMenu",300,150))
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

  self.screen:update(dt,input,self)
end

function player:textinput(text)
  self.screen:textinput(text)
end

function player:backspace()
  self.screen:backspace()
end