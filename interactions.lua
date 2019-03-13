interactions = {
  list = require "assets.interactions.interactions",
  selectedEntity = nil,
}

function interactions:update(dt,world,playerController,input)
  --find eligible interactables
  
  local playerTalkHitBox = {x1 = (world.player.hitBox.x1 * 2) + world.player.position.x,
                            x2 = (world.player.hitBox.x2 * 2) + world.player.position.x,
                            y1 = (world.player.hitBox.y1 * 2) + world.player.position.y,
                            y2 = (world.player.hitBox.y2 * 2) + world.player.position.y}
  if world.player.facing == "d" then
    playerTalkHitBox.y2 = playerTalkHitBox.y2 + 1
  elseif world.player.facing == "r" then
    playerTalkHitBox.x2 = playerTalkHitBox.x2 + 1
  elseif world.player.facing == "u" then
    playerTalkHitBox.y1 = playerTalkHitBox.y1 - 1
  elseif world.player.facing == "l" then
    playerTalkHitBox.x1 = playerTalkHitBox.x1 - 1
  end
  
  local eligible = {}
  
  for _,entity in ipairs(world.entities) do
    if world.hitBoxContains(playerTalkHitBox,entity.position) then
      table.insert(eligible,entity)
    end
  end
  
  if self.selectedEntity and not table.contains(eligible,self.selectedEntity) then
    self.selectedEntity.arrow = false
    self.selectedEntity = nil
  end
  
  if #eligible > 0 and not self.selectedEntity then
    self.selectedEntity = eligible[1]
    self.selectedEntity.arrow = true
  end

  
  local actionElement = playerController.screen:getElement("action")
  if self.selectedEntity then
    actionElement:setText("Talk to " .. self.selectedEntity.name)
    actionElement:setVisible(true)
  else
    actionElement:setText("")
    actionElement:setVisible(false)
  end
  
  
  if self.selectedEntity and not world.player.interaction and input:consumePressed('talk') then
    self:startConversation(world,playerController,self.selectedEntity)
  end
  
end

function interactions:startConversation(world,playerController,npc)
  local conversation = self.list[math.random(1,3)]
  
  local conversationElement = ConversationElement:new("conversation",0,0,true,true,conversation,world.player,npc)

  local gameScreen = playerController:getScreen("gameScreen")
  gameScreen:addElement(conversationElement)
  
  world.player.interaction = true
  npc.interaction = true
end
