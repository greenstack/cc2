local WeatherPattern = {
  -- Modifies a generated NPC's receptiveness stat.
  ReceptivenessModifier = 0,
  -- Modifies a generated NPC's flirtiness stat.
  FlirtinessModifier = 0,
  -- Modifies the likelihood of an NPC spawning.
  SpawnRateModifier = 0,
  -- Decreases how far the player can see
  VisionModifier = 0,
  type = "WeatherPattern"
}

-- Creates a new weather pattern.
function WeatherPattern:new(rMod, fMod, srMod, vMod) 
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.ReceptivenessModifier = rMod
  o.FlirtinessModifier = fMod
  o.SpawnRateModifier = srMod
  o.VisionModifier = vMod
  return o
end

Weather = {
  -- Clear weather: nothing special.
  Clear = WeatherPattern:new(0, 0, 0, 0),
  -- Rainy: sight slightly decreased, as are spawn rates.
  Rainy = WeatherPattern:new(0, 0, -.5, 1),
  -- Sunny: People are less receptive, more flirtatious, and more likely to spawn.
  Sunny = WeatherPattern:new(-.25, .25, .25, 0),
  -- Foggy: You can't see as far as you normally can.
  Foggy = WeatherPattern:new(0, 0, 0, 5),
}
