
-- debug variables
ShadowsEnabled = true
FogEnabled = true
ShowHitboxes = false
ShowScreenCenter = false
ShowPathingGraph = false

function SetWeather(weather)
  world.levelVars:setWeatherPattern(weather)
end

function ReloadShaders()
  SetWeatherShaders()
end

function ToggleShadow()
  ShadowsEnabled = not ShadowsEnabled
end

function ToggleFog()
  FogEnabled = not FogEnabled
end

function ToggleHitboxes()
  ShowHitboxes = not ShowHitboxes
end

function ToggleScreenCenter()
  ShowScreenCenter = not ShowScreenCenter
end

function TogglePathingGraphDisplay()
  ShowPathingGraph = not ShowPathingGraph
end

TogglePGD = TogglePathingGraphDisplay

function listDebug()
  print("ToggleShadow() - toggles shadow shader.")
  print("ToggleFog() - toggles fog shader.")
  print("ToggleHitboxes() - toggles hitbox display.")
  print("ToggleScreenCenter() - divides the screen into quadrants.")
  print("TogglePathingGraphDisplay() - displays the pathing graph.")
  print("TogglePGD() - alias for TogglePathingGraphDisplay().")
  print("SetWeather(weather) - sets the weather to the given weather pattern.")
  print("SetWeatherShaders() - reloads the shaders responsible for drawing weather.")
  return "See console for available commands."
end
