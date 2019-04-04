require 'a-star-lua.a-star'
local peachy = require 'peachy.peachy'

CompanionEntity = Entity:new()

function CompanionEntity:new(name,x,y,o)
  local o = Entity.new(self,name,x,y,o)
  o.maxSpeed = 5
  o.age = 19
  o.type="CompanionEntity"
  o.acceleration = 0.5
  o.hitBox = {x1=-.15,y1=-.15,x2=.15,y2=.15}
  o.mood = 5 -- 1 to 10, 1 being very mad, and 10 being tolerant of the player
  o.restlessness = 5 -- timer that accumlates time, affects when he will run somewhere new
  o.restlesnessThreshold = 20
  o.curPath = {}
  o.animation = peachy.new("assets/animation/companion.json", nil, "Idle")
  o.curPathIndex = 0
  o.atTarget = true
  o.interactionImg = "companion_portrait"
  return o
end

function CompanionEntity:update(dt,world)
  if self.atTarget then
    -- might move somewhere new
    local restlessnessModifier
    if self.visible then
      restlessnessModifier = 3
    else
      restlessnessModifier = 1
    end

    self.restlessness = self.restlessness + dt * restlessnessModifier
    local range = math.round(self.restlessness) + 10
    if self.restlessness > (self.restlesnessThreshold - self.mood) then
      --find new dark place
      local validNodes = {}
      for i=1,10 do -- try 10 spots
        local spotX = math.random(math.floor(self.position.x - range),math.ceil(self.position.x + range))
        local spotY = math.random(math.floor(self.position.y - range),math.ceil(self.position.y + range))
        local spot = {x=spotX,y=spotY}

        --find node in pathing grid

        local pathNode = world.map:getPathingNodeAt(spotX,spotY)

        if pathNode and not world:pointCanSeePoint(world.player.position,{x=spotX,y=spotY}) then
          table.insert(validNodes,pathNode)
        end
      end
      if #validNodes > 0 then
        local targetNode = validNodes[math.random(1,#validNodes)]

        -- generate path to target
        local currentNode = world.map:getPathingNodeAt(math.floor(self.position.x),math.floor(self.position.y))
        if not currentNode then
          print("current node not found in pathing grid")
        else
          self.curPath = astar.path (currentNode, targetNode, world.map.PathingGrid, false,
                                     function(node,neighbor) return math.abs(node.x-neighbor.x) <= 1 and math.abs(node.y-neighbor.y) <= 1 end)
          if self.curPath then
            self.curPathIndex = 1
            self.atTarget = false
          end
        end
        self.restlessness = 0
      end
    end
  elseif #self.curPath > 0 then
    -- get to current target
    local closeEnough = 0.1
    local nextNode = self.curPath[self.curPathIndex]
    local diff = {x=nextNode.x + 0.5 - self.position.x,y=nextNode.y + 0.5 - self.position.y}
    local movement = Vector.new(diff.x,diff.y)
    movement:normalize()
    self.movement.x = movement.x
    self.movement.y = movement.y
    if math.abs(diff.x) < closeEnough and math.abs(diff.y) < closeEnough then
      self.curPathIndex = self.curPathIndex + 1
      if not self.curPath[self.curPathIndex] then
        self.atTarget = true
        self.movement.x = 0
        self.movement.y = 0
      end
    end

  else
    error("your companion is lost")
  end

  -- Update the animation
  if self.movement.x > 0 and self.facing == "r" then
    self.animation:setTag("RunRight")
  elseif self.movement.x < 0 and self.facing == "l" then
    self.animation:setTag("RunLeft")
  elseif self.movement.y > 0 and self.facing == "d" then
    self.animation:setTag("RunDown")
  elseif self.movement.y < 0 and self.facing == "u" then
    self.animation:setTag("RunUp")
  else
    self.animation:setTag("Idle")
  end

  self.animation:update(dt)
end

function CompanionEntity:draw(x,y)
  self.animation:draw(x,y)
end
