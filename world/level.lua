local weather = require 'weather.weather'

local LevelVars = {
    contactGoal = 0,
    --the goal number of contacts for a given level--
    weatherPattern = 0,
    --the weatherPattern for a given level

}

function level:generate(levelNumber)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.contactGoal = getContactRequirement();
    o.weatherPattern = getWeatherPattern();
end


function level:getWeatherPattern()
    rand = math.random(4)
    if rand == 1 then
        pattern = Weather.Clear
    else if rand == 2 and rand  then
        pattern = Weather.Sunny
    else if rand == 3 then
        pattern = Weather.Rainy
    else if rand == 4 then
        pattern = Weather.Foggy
    end
    return pattern
end


function level:getContactRequirement(level, weather)
    if level == 1 then
        contacts = random(25, 30)
    elseif level == 2 then
        contacts = random(30, 35)
    elseif level == 3 then
        contacts = random(35, 40)
    end
    return contacts
end