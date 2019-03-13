local weather = require 'world.weather'

level = {
    npcCount = 0,
    --the numbers of npcs to spawn for a given level--
    weatherPattern = 0,
    --the weatherPattern for a given level
}

function level:generate(levelNumber)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.weatherPattern = level:getWeatherPattern()
    o.npcCount = level:getNpcCount(levelNumber, o.weatherPattern)
    return o
end


function level:getWeatherPattern()
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


function level:getNpcCount(level, weather)
    local npcCount = 0
    if level == 1 then
        npcCount = math.random(10, 15)
    elseif level == 2 then
        npcCount = math.random(13, 17)
    elseif level == 3 then
        npcCount = math.random(20, 25)
    end
    npcCount = math.floor(npcCount * weather.SpawnRateModifier)
    return npcCount
end