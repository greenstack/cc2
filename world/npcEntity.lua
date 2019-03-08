require "world.entity"
require "world.weather"

----- NPC Class ------

NPC = Entity:new()

--[[{
  name = "Name", 
  age = 0, 
  gender = "", 
  mood = 0, 
  receptiveness = 0, 
  relationship = "", 
  flirtiness = 0,
  type = "NPC"
}]]

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
 
----- NPC Construtor ------

function NPC:new(name, x, y, age, gender, receptiveness, relationship, flirtiness)
    local o = Entity.new(self, name, x, y)
  
    o.maxSpeed = 2
    o.acceleration = 1
  
    o.name = name
    o.type = "NPC"
    o.age = age
    o.gender = gender
    -- o.mood = math.clamp(mood, 0, 100) -- scale from 0 to 100 (bad to good)
    o.receptiveness = math.clamp(receptiveness, 0, 100) -- scale 0 to 100 (not receptive to very receptive)

    if age < 18 then
        o.relationship = RELATIONSHIPS[1]
    else 
        o.relationship = relationship
    end

    o.flirtiness = math.clamp(flirtiness, 0, 100) -- scale 0 to 100 (not flirtatious to very flirtatious)
    o.hitBox = {x1=-.15, y1=-.15, x2=.15, y2=.15}
    o.arrow = true --arrow pointing at their head to indicate the player can interact with them
    return o
end

----- NPC Getters -----

function NPC:getAge () 
    return self.age
end

function NPC:getGender () 
    return self.age
end

-- function NPC:getMood () 
--     return self.mood
-- end

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

-- function NPC:setMood (mood)
--     self.mood = math.clamp(mood, 0, 100)
-- end

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

function NPC:generate(total, weather) 
    -- Rain: Fewer NPCs will spawn. NPCs that do spawn will have shorter objective lists.
    -- Sunny: NPCs will spawn with greater flirtiness, less receptiveness 

    math.randomseed(os.time())
    local npcs = {}

    local minAge, maxAge = 8, 40
    local minMood, maxMood = 0, 100
    local minReceptiveness, maxReceptiveness = 0, 100
    local minFlirtiness, maxFlirtiness = 0, 100

    total = math.floor(total * weather.SpawnRateModifier)
    local half = math.ceil(total / 2)

    local name, age, gender, receptiveness, relationship, flirtiness

    -- NPC:new(name, x, y, age, gender, receptiveness, relationship, flirtiness)
    -- tito = NPC:new("Tito", 0, 0, 23, "male", 100, 0, RELATIONSHIPS.SINGLE, 0)

    for i = 1, total do

        if i <= half then
            name = FEMALE_NAMES[math.random(1, #FEMALE_NAMES)] .. " "
            gender = "female"
        else
            name = MALE_NAMES[math.random(1, #MALE_NAMES)] .. " "
            gender = "male"    
        end
        
        name = name .. LAST_NAMES[math.random(1, #LAST_NAMES)]
        age = math.random(minAge, maxAge)
        receptiveness = math.floor(math.random(minReceptiveness, maxReceptiveness) * weather.ReceptivenessModifier)
        relationship = RELATIONSHIPS[math.random(1, #RELATIONSHIPS)]
        flirtiness = math.floor(math.random(minFlirtiness, maxFlirtiness) * weather.FlirtinessModifier)

        table.insert(npcs, NPC:new(name, 0, 0, age, gender, receptiveness, relationship, flirtiness))
    end 

    return npcs
end

function NPC:getStats ()
    return string.format("%s\n%s\n%s\n%s\n%s\n%s\n", 
    "Name: " .. self.name, 
    "Age: " .. self.age, 
    "Gender: " .. self.gender,
    -- "Mood: " .. self.mood, 
    "Receptiveness: " .. self.receptiveness, 
    "Relationship status: " .. self.relationship, 
    "flirtiness: " .. self.flirtiness)
end

function math.clamp(low, n, high) 
    return math.min(math.max(n, low), high) 
end