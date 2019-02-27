require "player.screen"
require "player.element"
require "player.obediometerElement"
require "player.pauseElement"
require "player.consoleElement"

player = {
  obedience = 100,
  maxObedience = 100,
  paused = false,
  movement = {x=0,y=0},
  debugMode = false,
  screen = {},
  screens = {}
}

function player:init()
  local gameScreen = Screen:new("gameScreen")
  gameScreen:addElement(ObediometerElement:new("obediometer",10,10,true,true))
  gameScreen:addElement(ConsoleElement:new("console",0,0,false,false))
  gameScreen:addElement(PauseElement:new("pauseMenu",300,150,false,false))
  self.screens = {
    gameScreen
  }
  
  self.screen = self:getScreen("gameScreen")
end

function player:update(dt,input)

  if input:pressed('debug') and not self.debugMode and not self.paused then
    
    local consoleElement = self.screen:getElement("console")
    consoleElement.oldPaused = self.paused
    consoleElement:open()
    
    self.paused = true
    self.debugMode = true
  end


  if input:pressed('menu') and not self.paused then
    self.paused = true
    local pauseElement = self.screen:getElement("pauseMenu")
    pauseElement:open()
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

function player:getScreen(screen)
  for k,v in pairs(self.screens) do
    if v.name == screen then 
      return v
    end
  end
end