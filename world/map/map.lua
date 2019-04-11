require "world.map.layer"
require "world.map.tileset"
require "world.map.hitbox"
require "world.map.pathingGraph"

Map = {
  Name = "",
  Layers = {},
  type = "Map",
  MapWidth,
  MapHeight,
  Tileset,
  Hitboxes,
  PathingGraph,
  PathingGrid,
}

function Map:new(levelName, tilesetPath, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Name = levelName
  local levelData = require(levelName)
  o.MapWidth = levelData.width
  o.MapHeight = levelData.height
  o.Tileset = Tileset:new(tilesetPath, levelData.tilewidth, levelData.tileheight)
  o.Layers = {}
  local layerId = 1
  for _, layer in ipairs(levelData.layers) do
    if layer.type == "objectgroup" then
      local objects = {}
      print ("preparing to load in " .. #layer.objects .. " objects")
      for _, obj in ipairs(layer.objects) do
        print("loading in " .. obj.shape)
        if obj.shape == "rectangle" then
          local rect = Hitbox:new(obj.x, obj.y, obj.width, obj.height, o.Tileset)
          table.insert(objects, rect)
        else 
          print("Unsupported object shape: " .. obj.shape)
        end
      end
      o.Hitboxes = objects
    elseif layer.name == "complete nodes" or (layer.properties and layer.properties["graph"]) then
      local l = Layer:new(layer, layerId)
      print("Setting up pathing graph.")
      o.PathingGraph = PathingGraph:new(l)
      o.PathingGraph:prepareDisplay(o)
    elseif layer.type == "tilelayer" and layer.visible then
      local l = Layer:new(layer, layerId)
      o.Layers[l.id] = l
    elseif not layer.visible then
      print("Skipping invisible layer " .. layer.name)
    else
      print("Unsupported layer type: " .. layer.type)
    end
  end
  
  --generate pathing grid
  o.PathingGrid = {}
  for x=1, o.MapWidth do
    for y=1, o.MapHeight do
      if world.locationIsPathable(nil,{x=x + 0.5,y=y + 0.5},o.Hitboxes) then
        table.insert(o.PathingGrid,{x=x,y=y})
      end
    end
  end
  
  return o
end

-- returns the node in the pathing grid at (x,y), or nil if it does not exist
function Map:getPathingNodeAt(x,y)
  for _,v in pairs(self.PathingGrid) do
    if v.x == x and v.y == y then
      return v
    end
  end
end