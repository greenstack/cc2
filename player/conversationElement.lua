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
  o.firstTimeInState = true
  o.waiting = false
  return o
end

function ConversationElement:update(dt,input,playerController)
  if self.state == 1 then -- initial greeting
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.playerText)
      self.firstTimeInState = false
    end
    if self.waiting and input:consumePressed('talk') then
      self:nextState()
      return
    end
  elseif self.state == 2 then -- npc response
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.npcText)
      self.firstTimeInState = false
    end
    if self.waiting and input:consumePressed('talk') then
      if self.conversation.dialogue.options then
        self:nextState()
      else
        self:close()
      end
      return
    end
  elseif self.state == 3 then -- chose an option
    if self.firstTimeInState then
      self.text = ""
      for _,v in ipairs(self.conversation.dialogue.options) do
        table.insert(self.choices,self:replaceText(v.optionText))
      end
      self.firstTimeInState = false
      self.waiting = true
    end

    if input:pressed('up') then
      self.choice = math.max(1,self.choice - 1)
    end
    if input:pressed('down') then
      self.choice = math.min(self.choice + 1,#self.choices)
    end

    if self.waiting and input:consumePressed('talk') then
      self:nextState()
      return
    end
  elseif self.state == 4 then -- say your response
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.options[self.choice].playerText)
      self.firstTimeInState = false
    end

    if self.waiting and input:consumePressed('talk') then
      self:nextState()
      return
    end
  elseif self.state == 5 then -- final npc response
    if self.firstTimeInState then
      self.text = self:replaceText(self.conversation.dialogue.options[self.choice].npcText)
      self.firstTimeInState = false

      self:applyEffects(playerController,self.conversation.dialogue.options[self.choice].effect)

    end

    if self.waiting and input:consumePressed('talk') then
      self:close()
      return
    end
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

function ConversationElement:applyEffects(playerController,effects)
  if not effects then return end

  if effects.contacts then
    playerController.contacts = playerController.contacts + effects.contacts
  end
  if effects.obediometer then
    playerController.maxObedience = playerController.maxObedience + effects.obediometer
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
  if self.state == 1 or self.state == 3 or self.state == 4 then
    love.graphics.draw(playerImg,xPos + padding,yPos)
    love.graphics.print(self.playerEntity.name,xPos + padding,yPos+64)
  else
    love.graphics.draw(self.npcImg,xPos + elementWidth - 64 - padding,yPos)
    width = font:getWidth(self.npc.name)
    love.graphics.print(self.npc.name,xPos + elementWidth - width - padding,yPos+64)
  end

  love.graphics.setColor(.9,.9,.9)

  if self.state == 3 then
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
  text = text:gsub("{name}",self.npc.name)
  text = text:gsub("{age}",self.npc.age)
  return text
end

function ConversationElement:scrollText(text)
  text = text:sub(0,self.textProgress)
  return text
end
