require "player.screen"
require "player.element"
require "player.obediometerElement"
require "player.pauseElement"
require "player.consoleElement"
require "player.mainMenuElement"
require "player.actionElement"
require "player.conversationElement"
require "player.contactsElement"
require "player.optionsElement"

player = {}

function player:init()
  self.obedience = 100
  self.maxObedience = 100
  self.contacts = 0
  self.contactsGoal = 0
  self.paused = false
  self.movement = {x=0,y=0}
  self.debugMode = false
  self.inPlay = false
  self.screen = {}
  self.screens = {}
  masterVolume = 1.0
  musicVolume = 1.0
  sfxVolume = 1.0
  local optionsElement = OptionsElement:new("options",200,150,false,false)
  local gameScreen = Screen:new("gameScreen")
  gameScreen:addElement(ObediometerElement:new("obediometer",10,10,true,true))
  gameScreen:addElement(PauseElement:new("pauseMenu",300,150,false,false))
  gameScreen:addElement(ActionElement:new("action",0,30,false,false))
  gameScreen:addElement(ContactsElement:new("contacts",10,55,true,true))
  gameScreen:addElement(optionsElement)
  gameScreen:addElement(ConsoleElement:new("console",0,0,false,false))
  local mainMenuScreen = Screen:new("mainMenuScreen")
  mainMenuScreen:addElement(MainMenuElement:new("mainMenu",0,0,true,true))
  mainMenuScreen:addElement(optionsElement)
  self.screens = {
    gameScreen,
    mainMenuScreen
  }
  
  self.screen = self:getScreen("mainMenuScreen")
end

function player:update(dt,input)
  if self.inPlay and input:pressed('debug') and not self.debugMode and not self.paused then
    
    local consoleElement = self.screen:getElement("console")
    consoleElement.oldPaused = self.paused
    consoleElement:open()
    
    self.paused = true
    self.debugMode = true
  end


  if self.inPlay and input:pressed('menu') and not self.paused then
    self.paused = true
    local pauseElement = self.screen:getElement("pauseMenu")
    pauseElement:open()
  end
  
  if self.inPlay and not self.paused then
    self.movement.x,self.movement.y = input:get('move')
  end

  self.screen:update(dt,input,self)
end

function player:addObedience(amount)
  self.obedience = self.obedience + amount
  self.obedience = math.min(self.maxObedience,self.obedience)
  self.obedience = math.max(0,self.obedience)
end

function player:setObedience(amount)
  self.obedience = amount
  self.obedience = math.min(self.maxObedience,self.obedience)
  self.obedience = math.max(0,self.obedience)
end

function player:addMaxObedience(amount)
  self.maxObedience = self.maxObedience + amount
  self.maxObedience = math.max(0,self.maxObedience)
end

function player:setMaxObedience(amount)
  self.maxObedience = amount
  self.maxObedience = math.max(0,self.maxObedience)
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

function player:isScreenActive(screen)
  if self.screen == screen then
    return true
  end
  return false
end