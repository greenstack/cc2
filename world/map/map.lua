require "world.map.layer"
require "world.map.tileset"
require "world.map.hitbox"

Map = {
  Name = "",
  Layers = {},
  type = "Map",
  MapWidth,
  MapHeight,
  Tileset,
  Hitboxes,
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
    elseif layer.type == "tilelayer" then
      local l = Layer:new(layer, layerId)
      o.Layers[l.Name] = l
    else
      print("Unsupported layer type: " .. layer.type)
    end
  end
  return o
end
