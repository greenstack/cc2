ConversationElement = Element:new("conversation")

local scrollSpeed = 30 -- characters per second

function ConversationElement:new(name,x,y,enabled,visible,conversation,playerEntity,npc,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.conversation = conversation
  o.playerEntity = playerEntity
  o.npc = npc
  o.state = 1
  o.text = ""
  o.textProgress = 0 -- for text scrolling. indicates number of characters in
  o.choice = nil
  o.firstTimeInState = true
  o.waiting = false
  return o
end

function ConversationElement:update(dt,input,player)
  if self.state == 1 then -- initial greeting
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.playerText)
      self.firstTimeInState = false
    end
    if self.waiting and input:consumePressed('talk') then
      self:nextState()
    end
  elseif self.state == 2 then -- npc response
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.npcText)
      self.firstTimeInState = false
    end
    if self.waiting and input:consumePressed('talk') then
      self:nextState()
    end
  elseif self.state == 3 then -- chose an option
    self:close()
  elseif self.state == 4 then -- say your response
  
  elseif self.state == 5 then -- final npc response
  
  end

  
  if not (self.state == 3) then
    if not self.waiting and input:consumePressed('talk') then
      self.textProgress = #self.text
    else
      self.textProgress = self.textProgress + dt * scrollSpeed
    end
  end
  
  if self.textProgress >= #self.text then
    self.waiting = true
  end
  
  --[[if input:consumePressed('talk') then
    
  end]]
  
end

function ConversationElement:nextState()
  self.state = self.state + 1
  self.textProgress = 0
  self.firstTimeInState = true
  self.waiting = false
end

function ConversationElement:close()
  player:getScreen("gameScreen"):removeElement("conversation")
  self.npc.interaction = false
  self.playerEntity.interaction = false
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
  if self.state == 1 or self.state == 3 or self.state == 4 then
    love.graphics.draw(tempPlayerImg,xPos,yPos)
    love.graphics.print(self.playerEntity.name,xPos,yPos+64)
  else 
    love.graphics.draw(tempNPCImg,xPos + elementWidth - 64,yPos)
    love.graphics.print(self.npc.name,xPos + elementWidth - 64,yPos+64)
  end
  
  love.graphics.setColor(.9,.9,.9)
  love.graphics.print(self:scrollText(self.text),xPos + 70,yPos + 5)
  
  if self.waiting then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(arrow,xPos + 550 , yPos + 120)
  end
  
end

function ConversationElement:replaceText(text)
  text = text:gsub("{name}",self.npc.name)
  text = text:gsub("{age}",self.npc.age)
  return text
end

function ConversationElement:scrollText(text)
  text = text:sub(0,self.textProgress)
  return text
end

