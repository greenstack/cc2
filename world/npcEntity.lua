require "world.entity"
require "world.weather"
require "world.map.pathingNode"

local peachy = require 'peachy.peachy'

----- NPC Class ------

NPC = Entity:new()

RELATIONSHIPS = {
    "single",
    "dating",
    "engaged",
    "married",
    "divorced",
    "widowed"
}

FEMALE_NAMES = {
    "Audrey",
    "Cami",
    "Chelsey",
    "Danielle",
    "Kylie",
    "Lauren",
    "Makenna",
    "Megan",
    "Rachel",
    "Sarah",
    "Shirley",
    "Tessa"
}

MALE_NAMES = {
    "Brandon",
    "Calvin",
    "Cole",
    "David",
    "Derek",
    "Derik",
    "Emmett",
    "Griffin",
    "Jason",
    "Johnathan",
    "Joseph",
    "Steve",
    "Shawn"
}

LAST_NAMES = {
    "Anderson",
    "Burton",
    "Cook",
    "Fischer",
    "Jensen",
    "McAllister",
    "Mines",
    "Newman",
    "Olsen",
    "Owen",
    "Turley",
    "Watts"
}

luke154 = "What man of you, having an hundred sheep, if he lose one of them, "
        .. "doth not leave the ninety and nine in the wilderness, "
        .. "and go after that which is lost, until he find it? "

----- NPC Construtor ------

function NPC:new(id, name, x, y, age, gender, mood, receptiveness, relationship, flirtiness, animation, imagename)
    local o = Entity.new(self, name, x, y)

    o.maxSpeed = 2
    o.acceleration = 1

    o.id = id
    o.name = name
    o.type = "NPC"
    o.age = age
    o.gender = gender
    o.mood = mood
    o.receptivenessValue = math.clamp(receptiveness, 0, 100) -- scale 0 to 100 (not receptive to very receptive)

    o.receptiveness = function ()
        return math.clamp(math.floor(o.receptivenessValue * world.weather.ReceptivenessModifier), 0, 100)
    end

    if age < 18 then
        o.relationship = RELATIONSHIPS[1]
    else
        o.relationship = relationship
    end

    o.flirtinessValue = math.clamp(flirtiness, 0, 100) -- scale 0 to 100 (not flirtatious to very flirtatious)

    o.flirtiness = function ()
        return math.clamp(math.floor(o.flirtinessValue * world.weather.FlirtinessModifier), 0, 100)
    end

    o.contacted = false

    o.animation = animation
    o.interactionImg = imagename
    o.despawnToggle = false
    o.spawned = false
    o.spawnNode = {}
    o.prevNode = nil
    o.targetNode = nil
    o.hitBox = {x1 =- .15, y1 =- .15, x2 = .15, y2 = .15}
    o.arrow = false --arrow pointing at their head to indicate the player can interact with them
    return o
end

----- NPC Getters -----

function NPC:getAge ()
    return self.age
end

function NPC:getGender ()
    return self.age
end

function NPC:getReceptiveness ()
    return self.receptiveness
end

function NPC:getrelationship ()
    return self.relationship
end

function NPC:getFlirtiness ()
    return self.flirtiness
end

function NPC:getImageName ()
  return self.imageName
end

----- NPC Setters -----

function NPC:setAge (age)
    self.age = age
end

function NPC:setReceptiveness (receptiveness)
    self.receptiveness = math.clamp(receptiveness, 0, 100)
end

function NPC:setrelationship (relationship)
    self.relationship = relationship
end

function NPC:setFlirtiness (flirtiness)
    self.flirtiness = math.clamp(flirtiness, 0, 100)
end


----- NPC Methods -----

--[[
NPC:generate
count - the number of NPCs to generate
nodes - the spawning nodes on the map
]]
function NPC:generate(count, nodes)
    math.randomseed(os.time())
    local npcs = {}

    local minAge, maxAge = 8, 40
    local minMood, maxMood = 0, 100
    local minReceptiveness, maxReceptiveness = 0, 100
    local minFlirtiness, maxFlirtiness = 0, 100

    local half = math.ceil(count / 2)

    local name, x, y, age, gender, mood, receptiveness, relationship, flirtiness -- variables used when inserting

    local used_nodes = {}
    local index

    for i = 1, count do

        if i <= half then
            name = FEMALE_NAMES[math.random(1, #FEMALE_NAMES)]
            gender = "female"
            -- Choose a random female npc animation set here
            imagename = "female_" .. (i % 2)
            animation = peachy.new("assets/animation/" .. imagename .. ".json", nil, "Idle")
        else
            name = MALE_NAMES[math.random(1, #MALE_NAMES)]
            gender = "male"
            -- Choose a random male npc animation set here
            imagename = "male_" .. (i % 2)
            animation = peachy.new("assets/animation/" .. imagename .. ".json", nil, "Idle")
        end

        name = name .. " " .. LAST_NAMES[math.random(1, #LAST_NAMES)]
        age = math.random(minAge, maxAge)
        mood = math.random(minMood, maxMood)
        receptiveness = math.random(minReceptiveness, maxReceptiveness)
        relationship = RELATIONSHIPS[math.random(1, #RELATIONSHIPS)]
        flirtiness = math.random(minFlirtiness, maxFlirtiness)

        -- spawn at random nodes until the nodes are filled up
        if i <= #nodes then
            while true do
                index = math.random(1, #nodes)
                if table.indexOf(used_nodes, index) == -1 then
                    table.insert(used_nodes, index)
                    break
                end
            end
        else
            index = math.random(1, #nodes)
        end

        print(#nodes)

        x = nodes[index].LocationX + 0.5
        y = nodes[index].LocationY + 0.5
        local npc = NPC:new(i, name, x, y, age, gender, mood, receptiveness, relationship, flirtiness, animation, imagename)
        npc.spawnNode = nodes[index]
        npc.prevNode = npc.spawnNode
        npc.targetNode = npc.spawnNode
        table.insert(npcs, npc)
    end

    return npcs
end

function NPC:shouldDespawn()
    if self.spawned and self.despawnToggle then
        return true
    end

    return false
end

function NPC:getNode(nodes, x, y)
    for i, node in pairs(nodes) do
        if node.LocationX == math.floor(x) and node.LocationY == math.floor(y) then
            return node
        end
    end

    return nil
end

function NPC:update(dt, world)
    if self.interaction or self.despawnToggle then
        return
    end

    local x = self.position.x
    local y = self.position.y

    local node = NPC:getNode(world.map.PathingGraph.Nodes, x, y)

    if node then
        if node.NodeType == NodeTypes.Spawning and not (node == self.spawnNode) and math.random(0, 100) == 100 then
            self.despawnToggle = true
            return
        end

        if node == self.targetNode and world.hitBoxContains(self:getAbsoluteHitbox(),{x=node.LocationX + 0.5,y=node.LocationY + 0.5}) then
          -- choose new direction
          self.targetNode = node.Edges[math.random(1, #node.Edges)]
          self.targetNode = self:getNode(world.map.PathingGraph.Nodes,self.targetNode.LocationX,self.targetNode.LocationY)
        end
    end

    if self.targetNode then
      local targetX = self.targetNode.LocationX + 0.5
      local targetY = self.targetNode.LocationY + 0.5

      self.movement.x = targetX - x
      self.movement.y = targetY - y
    else
      self.movement.x = 0
      self.movement.y = 0
    end

    -- check if they are still on the map
    if self.position.x < 0 or
        self.position.x > world.map.MapWidth + 1 or
        self.position.y < 0 or
        self.position.x > world.map.MapHeight + 1 then
        print(luke154 .. self.name .. " is lost. at " .. self.position.x .. "," .. self.position.y)
    end

    -- Update the animation state to match the movement state
    -- TODO: This could be optimized by moving it to changing the state only based
    --       when we change the state
    if self.animation ~= nil then
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
end

function NPC:getStats ()
    return string.format("%s\n%s\n%s\n%s\n%s\n%s\n",
    "Name: " .. self.name,
    "Age: " .. self.age,
    "Gender: " .. self.gender,
    "Receptiveness: " .. self.receptivenessValue,
    "Relationship status: " .. self.relationship,
    "flirtiness: " .. self.flirtinessValue)
end

function NPC:draw(x,y)
  self.animation:draw(x,y)
end

----- Helper Methods -----

function math.clamp(low, n, high)
    return math.min(math.max(n, low), high)
end

function math.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function table.indexOf(t, object)
    if type(t) ~= "table" then
        error("table expected, got " .. type(t), 2)
    end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end

    return -1
end
