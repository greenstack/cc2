require "world.entity"
require "world.weather"
require "world.map.pathingNode"

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

function NPC:new(id, name, x, y, age, gender, receptiveness, relationship, flirtiness)
    local o = Entity.new(self, name, x, y)
  
    o.maxSpeed = 2
    o.acceleration = 1
  
    o.id = id
    o.name = name
    o.type = "NPC"
    o.age = age
    o.gender = gender
    o.receptiveness = math.clamp(receptiveness, 0, 100) -- scale 0 to 100 (not receptive to very receptive)

    if age < 18 then
        o.relationship = RELATIONSHIPS[1]
    else 
        o.relationship = relationship
    end

    o.flirtiness = math.clamp(flirtiness, 0, 100) -- scale 0 to 100 (not flirtatious to very flirtatious)

    o.spawnToggle = false
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
weather - the weather generated by the level
nodes - the spawnToggle nodes on the map
]]
function NPC:generate(count, weather, nodes) 
    math.randomseed(os.time())
    local npcs = {}

    local minAge, maxAge = 8, 40
    local minMood, maxMood = 0, 100
    local minReceptiveness, maxReceptiveness = 0, 100
    local minFlirtiness, maxFlirtiness = 0, 100

    local half = math.ceil(count / 2)

    local name, x, y, age, gender, receptiveness, relationship, flirtiness -- variables used when inserting

    local used_nodes = {}
    local index

    for i = 1, count do

        if i <= half then
            name = FEMALE_NAMES[math.random(1, #FEMALE_NAMES)]
            gender = "female"
        else
            name = MALE_NAMES[math.random(1, #MALE_NAMES)]
            gender = "male"    
        end
        
        name = name .. " " .. LAST_NAMES[math.random(1, #LAST_NAMES)]
        age = math.random(minAge, maxAge)
        receptiveness = math.floor(math.random(minReceptiveness, maxReceptiveness) * weather.ReceptivenessModifier)
        relationship = RELATIONSHIPS[math.random(1, #RELATIONSHIPS)]
        flirtiness = math.floor(math.random(minFlirtiness, maxFlirtiness) * weather.FlirtinessModifier)

        -- spawnToggle until the nodes are filled up
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

        x = nodes[index].LocationX + 0.5
        y = nodes[index].LocationY + 0.5
        local npc = NPC:new(i, name, x, y, age, gender, receptiveness, relationship, flirtiness)
        npc.spawnNode = nodes[index]
        npc.prevNode = npc.spawnNode
        npc.targetNode = npc.spawnNode
        table.insert(npcs, npc)
    end 

    return npcs
end

function NPC:shouldDespawn()
    if self.spawned and self.spawnToggle then
        -- print(self.name .. " DESPAWNED")
        self.spawned = false
        self.spawnToggle = false
        return true
    end

    return false
end

function NPC:shouldSpawn()
    if not self.spawned and math.random(1, 100) == 100 then
        self.spawnNode = NPC:getNode(world.map.PathingGraph.Nodes, self.position.x, self.position.y)
        self.spawned = true
        self.spawnToggle = false
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
    if self.interaction or self.spawnToggle then
        return
    end

    local x = self.position.x
    local y = self.position.y

    local node = NPC:getNode(world.map.PathingGraph.Nodes, x, y)

    if node then
        if node.NodeType == NodeTypes.Spawning and not (node == self.spawnNode) and math.random(0, 1) == 1 then
            self.spawnToggle = true
            return
        end
        
        if node == self.targetNode and world.hitBoxContains(self:getAbsoluteHitbox(),{x=node.LocationX + 0.5,y=node.LocationY + 0.5}) then
          -- choose new direction
          self.targetNode = node.Edges[math.random(1, #node.Edges)]
          self.targetNode = self:getNode(world.map.PathingGraph.Nodes,self.targetNode.LocationX,self.targetNode.LocationY)
          local targetX = self.targetNode.LocationX + 0.5
          local targetY = self.targetNode.LocationY + 0.5

          self.movement.x = targetX - x
          self.movement.y = targetY - y
          
        end
    end

    -- check if they are still on the map
    if self.position.x < 0 or 
        self.position.x > world.map.MapWidth + 1 or 
        self.position.y < 0 or 
        self.position.x > world.map.MapHeight + 1 then
        error(luke154 .. self.name .. " is lost. at " .. self.position.x .. "," .. self.position.y)
    end
end

function NPC:getStats ()
    return string.format("%s\n%s\n%s\n%s\n%s\n%s\n", 
    "Name: " .. self.name, 
    "Age: " .. self.age, 
    "Gender: " .. self.gender,
    "Receptiveness: " .. self.receptiveness, 
    "Relationship status: " .. self.relationship, 
    "flirtiness: " .. self.flirtiness)
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