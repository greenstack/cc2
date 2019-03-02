----- NPC Class ------
NPC = {
  name = "Name", 
  age = 0, 
  gender = "", 
  mood = 0, 
  receptiveness = 0, 
  relationshipStatus = "", 
  flirtatiousness = 0,
  type = "NPC"
}

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

function NPC:new(name, age, gender, mood, receptiveness, relationshipStatus, flirtatiousness, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  
  self.name = name
  self.age = age
  self.gender = gender
  self.mood = math.clamp(mood, 0, 100) -- scale from 0 to 100 (bad to good)
  self.receptiveness = math.clamp(receptiveness, 0, 100) -- scale 0 to 100 (not receptive to very receptive)
  self.relationshipStatus = relationshipStatus
  self.flirtatiousness = math.clamp(flirtatiousness, 0, 100) -- scale 0 to 100 (not flirtatious to very flirtatious)
 
  return self
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
    self.mood = math.clamp(mood, 0, 100)
end

function NPC:setReceptiveness (receptiveness)
    self.receptiveness = math.clamp(receptiveness, 0, 100)
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
