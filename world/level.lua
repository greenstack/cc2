local weather = require 'world.weather'

level = {
    --the numbers of npcs to spawn for a given level
    npcCount = 0,
    --the number of npcs needed to contact for this level
    contactGoal = 0,
    --the weatherPattern for a given level
    weatherPattern = {},
    --in game hour count
    hour = 0,
    --in game minute count
    minute = 0,
    --in game am/pm count,
    ampm = 0,
    --dt counter, counts how many frames have passed for keeping time
    dtCount = 0,
    --in game time rate
    rate = 0,
    --late boolean, when true obedience drops at a constant rate
    late = 0,
    --late drop, the lower the variable the faster the obedience drops when late
    lateDrop = 0,
    --current level number
    levelNumber = 0
}

function level:getTimeInSeconds(hour, minute, ampm)
  hour = hour or self.hour
  minute = minute or self.minute
  ampm = ampm or self.ampm
  local timeInSeconds = 0;
  local twelveHours = 43200;
  local hours = hour * 3600
  local minutes = minute * 60
  if ampm ~= "AM" and hour < 12 then
      timeInSeconds = twelveHours
  end
  timeInSeconds = timeInSeconds + hours + minutes
  return timeInSeconds
end

function level:timeInit()
    self.hour = 9
    self.minute = 00
    self.ampm = "AM"
    self.rate = 15 --the lower the rate, the faster time will move in game
    self.late = false
    self.lateDrop = 0.37
end

function level:generate(levelNumber, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    local wp = level.getWeatherPattern()
    o:setWeatherPattern(wp)
    o.npcCount = level.getNpcCount(levelNumber, o.weatherPattern)
    o.contactGoal = level.getContactGoal(levelNumber, o.weatherPattern)
    o.levelNumber = levelNumber
    level:timeInit(o);
    return o
end

function level:update(dt, world) 
  if world.weather ~= self.weatherPattern then
    print("npc: " .. self.npcCount)
    world.weather = self.weatherPattern
    self.npcCount = self.getNpcCount(self.levelNumber, self.weatherPattern)
    print("npc: " .. self.npcCount)
  end
end

--TODO: this data should be specified in a level asset
function level.getWeatherPattern()
    rand = math.random(4)
    local pattern
    if rand == 1 then
        pattern = Weather.Clear
    elseif rand == 2 and rand  then
        pattern = Weather.Sunny
    elseif rand == 3 then
        pattern = Weather.Rainy
    elseif rand == 4 then
        pattern = Weather.Foggy
    end
    return pattern
end

function level:setWeatherPattern(pattern)
    if self.weatherPattern and self.weatherPattern.Sound then
        self.weatherPattern.Sound:stop()
    end
    self.weatherPattern = pattern
end

--TODO: this data should be specified in a level asset
function level.getNpcCount(level, weather)
    local npcCount = 0
    if level == 1 then
        npcCount = math.random(10, 15)
    elseif level == 2 then
        npcCount = math.random(13, 17)
    elseif level == 3 then
      npcCount = math.random(20, 25)
    elseif level == 4 then
      npcCount = math.random(24, 29)
    elseif level == 5 then
      npcCount = math.random(26, 31)
    elseif level == 6 then
      npcCount = math.random(30, 31)
    elseif level == 7 then
      npcCount = math.random(33, 35)
    end
    npcCount = math.floor(npcCount * weather.SpawnRateModifier)
    return npcCount
end

function level:after(hour, minute, ampm)
  local check = self:getTimeInSeconds(hour, minute, ampm)
  return check < self:getTimeInSeconds()
end

function level:timeToString()
  return string.format("%i:%02s %s", self.hour, self.minute, self.ampm)
end

--TODO: this data should be specified in a level asset
function level.getContactGoal(levelNumber,weatherPattern)
  if levelNumber == 1 then
    return 8
  elseif levelNumber == 2 then
    return 10
  elseif levelNumber == 3 then
    return 12
  elseif levelNumber == 4 then
    return 12
  elseif levelNumber == 5 then
    return 14
  elseif levelNumber == 6 then
    return 16
  elseif levelNumber == 7 then
    return 18
  else 
    return 15
  end
end
