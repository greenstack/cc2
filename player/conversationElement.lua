ConversationElement = Element:new("conversation")

local scrollSpeed = 30 -- characters per second

function ConversationElement:new(name,x,y,enabled,visible,conversation,playerEntity,npc,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.conversation = conversation
  o.playerEntity = playerEntity
  o.npc = npc
  o.npcImg = love.graphics.newImage("assets/img/".. npc.interactionImg .. ".png")
  o.state = 1
  o.text = ""
  o.choices = {}
  o.textProgress = 0 -- for text scrolling. indicates number of characters in
  o.choice = 1
  o.waiting = false
  o.nextState(o,1)
  return o
end

function ConversationElement:update(dt,input,playerController)
  local currentBlock = self.conversation.dialogue[self.state]
  local next = currentBlock.next
  

  if currentBlock.options then
    if input:pressed('up') then
      self.choice = math.max(1,self.choice - 1)
    end
    if input:pressed('down') then
      self.choice = math.min(self.choice + 1,#self.choices)
    end
    next = currentBlock.options[self.choice].next
  end

  if currentBlock.options or self.textProgress >= #self.text then
    self.waiting = true
  end

  if input:consumePressed('talk') then
    if self.waiting then
      if next then
        self:nextState(next,playerController)
      else
        self:close() 
      end
    else
      self.textProgress = #self.text
    end
  else 
    self.textProgress = self.textProgress + dt * scrollSpeed
  end
end

function ConversationElement:nextState(state,playerController)
  self.state = state
  self.textProgress = 0
  self.waiting = false
  
  local nextBlock = self.conversation.dialogue[state]
    
  if nextBlock.options then
    self.choice = 1
    self.choices = {}
    for _,v in ipairs(nextBlock.options) do
      table.insert(self.choices,self:replaceText(v.optionText))
    end
  else
    self.text = self:replaceText(nextBlock.text)
  end
  
  self:applyEffects(playerController,nextBlock.effects)
end

function ConversationElement:close()
  player:getScreen("gameScreen"):removeElement("conversation")
  self.npc.interaction = false
  self.playerEntity.interaction = false
end

function ConversationElement:applyEffects(playerController,effects)
  if not effects then return end
  
  for k,v in pairs(effects) do
    if playerController[k] ~= nil then
      playerController[k] = playerController[k] + v
    end
  end
end

function ConversationElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  local elementWidth = windowWidth * 0.8
  local elementHeight = windowHeight / 4

  local xPos = (windowWidth - elementWidth) / 2
  local yPos = windowHeight - elementHeight


  love.graphics.setColor(.2,.2,.2)
  love.graphics.rectangle("fill",xPos,yPos,elementWidth,elementHeight)

  love.graphics.setColor(1,1,1)
  padding = 8
  
  local currentBlock = self.conversation.dialogue[self.state]
  
  if currentBlock.isPlayerText then
    love.graphics.draw(playerImg,xPos + padding,yPos)
    love.graphics.print(self.playerEntity.name,xPos + padding,yPos+64)
  else
    love.graphics.draw(self.npcImg,xPos + elementWidth - 64 - padding,yPos)
    local width = font:getWidth(self.npc.name)
    love.graphics.print(self.npc.name,xPos + elementWidth - width - padding,yPos+64)
  end

  love.graphics.setColor(.9,.9,.9)

  if currentBlock.options then
    for k,v in ipairs(self.choices) do
      love.graphics.print(v,xPos + 70,yPos + 5 + 30 * (k - 1))
    end
    if self.waiting then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,xPos + 60,yPos + 5 + 30 * (self.choice - 1))
    end
  else
    love.graphics.printf(self:scrollText(self.text),xPos + 70,yPos + 5,500)
    if self.waiting then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(arrow,xPos + 550 , yPos + 120)
    end
  end
end

function ConversationElement:replaceText(text)
  text = text:gsub("{playerName}",self.playerEntity.name)
  text = text:gsub("{name}",self.npc.name)
  text = text:gsub("{age}",self.npc.age)
  return text
end

function ConversationElement:scrollText(text)
  text = text:sub(0,self.textProgress)
  return text
end
