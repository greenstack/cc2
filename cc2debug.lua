
-- debug variables
ShadowsEnabled = true
FogEnabled = true
ShowHitboxes = true
ShowScreenCenter = false
ShowPathingGraph = false

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
  return "See console for available commands."
end
