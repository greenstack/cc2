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
  -- (love.graphics.Shader) The shader associated with this weather pattern.
  Shader,
  -- (function) A function that updates the current weather. Typically empty.
  update = function(dt) end,
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
  print("Configuring fog...")
  Weather.Foggy.Shader = love.graphics.newShader("graphics/shaders/fog.frag")
  Weather.Foggy.Shader:send("fog_distance", 428)
  Weather.Foggy.Shader:send("fog_distance_min", 256)

  print("Configuring sun...")
  Weather.Sunny.Shader = love.graphics.newShader("graphics/shaders/sun.frag")
  Weather.Sunny.Time = 0
  Weather.Sunny.update = function(self, dt)
    self.Time = self.Time + dt 
    self.Shader:send("time", self.Time)
  end

  print("Configuring rain...")
  Weather.Rainy.Shader = love.graphics.newShader("graphics/shaders/rain.frag")
  local raindrop = love.graphics.newImage("assets/img/raindrop.png")
  local psystem = love.graphics.newParticleSystem(raindrop, 64)
  psystem:setEmissionArea("uniform", love.graphics.getWidth() / 6, 0, 0, false)
  psystem:setParticleLifetime(1.5, 2)
  psystem:setEmissionRate(10)
  psystem:setSizeVariation(1)
  psystem:setDirection(-math.pi/2)
  psystem:setSpeed(-100, -200)
  psystem:setLinearAcceleration(0, 50, 0, 75)
  psystem:setColors(1,1,1,1, 1,1,1,0)
  Weather.Rainy.ParticleSystem = psystem
  Weather.Rainy.update = function(self, dt) self.ParticleSystem:update(dt) end
end
