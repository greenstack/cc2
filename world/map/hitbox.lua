Hitbox = {
  -- (number) the tile x position of the hitbox.
  xPos,
  -- (number) the tile y position of the hitbox.
  yPos,
  -- (number) the tile width of the hitbox.
  width,
  -- (number) the tile height of the hitbox.
  height,
  -- (number) the pixel x coordinate of the hitbox
  pixelX,
  -- (number) the pixel y coordinate of the hitbox.
  pixelY,
  -- (number) the width in pixels of the hitbox.
  pixelWidth,
  -- (number) the height in pixels of the hitbox.
  pixelHeight
}

-- Retrieves a GLSL shader compatible vec4 representation of
-- the hitbox. The x is the xPos, y = yPos, z = width, w = height.
function Hitbox:getVec4Definition()
  return {self.pixelX, self.pixelY, self.pixelWidth, self.pixelHeight}
end

-- Generates a new hitbox.
-- (number) xPos: The pixel x position.
-- (number) yPos: The pixel y position.
-- (number) width: The pixel width.
-- (number) height: The pixel height.
-- (Tileset) tileset: The tileset this hitbox is being loaded in with.
function Hitbox:new(xPos, yPos, width, height, tileset, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.xPos = xPos / tileset.TileWidth + 1
  o.yPos = yPos / tileset.TileHeight + 1
  o.width = width / tileset.TileWidth
  o.height = height / tileset.TileHeight
  o.pixelX = xPos
  o.pixelY = yPos
  o.pixelWidth = width
  o.pixelHeight = height
  return o
end
