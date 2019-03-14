local weather = require 'world.weather'

level = {
    --the numbers of npcs to spawn for a given level--
    npcCount = 0,
    --the weatherPattern for a given level
    weatherPattern = 0,
    --in game hour count
    hour = 0,
    --in game minute count
    minute = 0,
    --in game am/pm count,
    ampm = 0,
    --in game dt counter
    dtCount = 0,
    --in game time rate
    rate = 0,
    --in game late boolean
    late = 0
}

function level:timeInit(o) 
    o.hour = 9
    o.minute = 30
    o.ampm = "am"
    o.rate = 15
    o.late = false
end

function level:generate(levelNumber)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.weatherPattern = level:getWeatherPattern()
    o.npcCount = level:getNpcCount(levelNumber, o.weatherPattern)
    level:timeInit(o);
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

-- function level:updateTime(dt, levelVar)
--     levelVar.dtCount = levelVar.dtCount + 1
--     if (levelVar.dtCount == levelVar.rate) then
--         levelVar.dtCount = 0
--         levelVar.minute = levelVar.minute + 1
--     end
--     if (levelVar.minute == 60) then
--         levelVar.minute = 0
--         levelVar.hour = levelVar.hour + 1
--     end
--     if levelVar.hour == 13 then
--         levelVar.hour = 1
--         levelVar.ampm = "pm"
--     end
--     print("time: " .. levelVar.hour .. ":" .. levelVar.minute .. " " .. levelVar.ampm)
-- end