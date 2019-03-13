local WeatherPattern = {
  Name,
  -- Modifies a generated NPC's receptiveness stat.
  ReceptivenessModifier = 0,
  -- Modifies a generated NPC's flirtiness stat.
  FlirtinessModifier = 0,
  -- Modifies the likelihood of an NPC spawning.
  SpawnRateModifier = 0,
  -- Decreases how far the player can see
  VisionModifier = 0,
  Shader,
  type = "WeatherPattern"
}

-- Creates a new weather pattern.
function WeatherPattern:new(name, rMod, fMod, srMod, vMod) 
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.Name = name
  o.ReceptivenessModifier = rMod
  o.FlirtinessModifier = fMod
  o.SpawnRateModifier = srMod
  o.VisionModifier = vMod
  return o
end

Weather = {
  -- Clear: Nothing special.
  Clear = WeatherPattern:new("Clear", 1, 1, 1, 1),
  -- Rainy: Vision is slightly decreased, as are spawn rates.
  Rainy = WeatherPattern:new("Rainy", 1, 1, .5, .75),
  -- Sunny: People are less receptive, more flirtatious, and more likely to spawn.
  Sunny = WeatherPattern:new("Sunny", .5, 1.5, 1.5, 1),
  -- Foggy: You can't see as far as you normally can.
  Foggy = WeatherPattern:new("Foggy", 1, 1, 1, .5)
}

function SetWeatherShaders()
  Weather.Foggy.Shader = love.graphics.newShader("graphics/shaders/fog.frag")
  Weather.Foggy.Shader:send("fog_distance", 428)
  Weather.Foggy.Shader:send("fog_distance_min", 256)

  Weather.Sunny.Shader = love.graphics.newShader("graphics/shaders/sun.frag")
end
