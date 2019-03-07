----- NPC Class ------
NPC = Entity:new()

--[[{
  name = "Name", 
  age = 0, 
  gender = "", 
  mood = 0, 
  receptiveness = 0, 
  relationshipStatus = "", 
  flirtatiousness = 0,
  type = "NPC"
}]]

NPC_GENDER = {
    MALE = "male",
    FEMALE = "female"
}

NPC_RELATIONSHIP = {
    SINGLE = "single",
    DATING = "dating",
    ENGAGED = "engaged",
    MARRIED = "married",
    DIVORCED = "divorced",
    WIDOWED = "widowed"
}
 
----- NPC Construtor ------

function NPC:new(name, x, y, age, gender, mood, receptiveness, relationshipStatus, flirtatiousness, o)
  local o = Entity.new(self, name, x, y, o)
  
  o.maxSpeed = 2
  o.acceleration = 1
  
  o.name = name
  o.type = "NPC"
  o.age = age
  o.gender = gender
  o.mood = clamp(mood, 0, 100) -- scale from 0 to 100 (bad to good)
  o.receptiveness = clamp(receptiveness, 0, 100) -- scale 0 to 100 (not receptive to very receptive)
  o.relationshipStatus = relationshipStatus
  o.flirtatiousness = clamp(flirtatiousness, 0, 100) -- scale 0 to 100 (not flirtatious to very flirtatious)
  o.hitBox = {x1=-.15,y1=-.15,x2=.15,y2=.15}
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

function NPC:getMood () 
    return self.mood
end

function NPC:getReceptiveness () 
    return self.receptiveness
end

function NPC:getRelationshipStatus () 
    return self.relationshipStatus
end

function NPC:getFlirtatiousness () 
    return self.flirtatiousness
end

----- NPC Setters -----

function NPC:setAge (age)
    self.age = age
end

function NPC:setMood (mood)
    self.mood = clamp(mood, 0, 100)
end

function NPC:setReceptiveness (receptiveness)
    self.receptiveness = clamp(receptiveness, 0, 100)
end

function NPC:setRelationshipStatus (relationshipStatus)
    self.relationshipStatus = relationshipStatus
end

function NPC:setFlirtatiousness (flirtatiousness)
    self.flirtatiousness = checkScaleValue(flirtatiousness)
end

function NPC:checkWeather ()
    -- TODO
end

function NPC:getStats ()
    return string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s", 
    "Name: " .. self.name, 
    "Age: " .. self.age, 
    "Gender: " .. self.gender,
    "Mood: " .. self.mood, 
    "Receptiveness: " .. self.receptiveness, 
    "Relationship status: " .. self.relationshipStatus, 
    "Flirtatiousness: " .. self.flirtatiousness)
end
