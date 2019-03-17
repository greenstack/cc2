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
    self:startConversation(world.player,playerController,self.selectedEntity)
  end
  
end

function interactions:startConversation(player,playerController,npc)
  local conversation = self:getValidConversation(npc)
  
  if conversation then
    local conversationElement = ConversationElement:new("conversation",0,0,true,true,conversation,player,npc)

    local gameScreen = playerController:getScreen("gameScreen")
    gameScreen:addElement(conversationElement)
    
    player.interaction = true
    npc.interaction = true
  end
end

function interactions:getValidConversation(npc)
  local validConversations = {}
  for k,v in pairs(self.list) do
    if (not v.reqGender or table.contains(v.reqGender,npc.gender)) and
       (not v.reqRelationship or table.contains(v.reqRelationship,npc.relationship)) and
       (not v.reqMood or self.inRange(v.reqMood,npc.mood)) and
       (not v.reqReceptiveness or self.inRange(v.reqReceptiveness,npc.receptiveness)) and
       (not v.reqFlirtatiousness or self.inRange(v.reqFlirtatiousness,npc.flirtiness)) and
       (not v.reqAge or self.inRange(v.reqAge,npc.age)) and
       (not v.reqContacted or v.reqContacted == npc.contacted) and 
       (not v.reqType or table.contains(v.reqType,npc.type))
       
    then
      table.insert(validConversations,v)
    end
  end
  if #validConversations > 0 then
    return validConversations[math.random(1,#validConversations)]
  else 
    print("no valid conversation found for " .. npc.name)
  end
end

function interactions.inRange(range,val) 
  return range.min <= val and val <= range.max
end
