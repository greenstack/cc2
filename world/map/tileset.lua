Tileset = {
  Image,
  ImageWidth,
  ImageHeight,
  TileWidth,
  TileHeight,
  TileQuads,
  type = "Tileset",
  GetTile = function(self, qid)
    return self.TileQuads[qid]
  end,
}

function Tileset:Display(xPos, yPos)
  local tsb = love.graphics.newSpriteBatch(self.Image, self.ImageWidth * self.ImageHeight)
  tsb:clear()

  for x = 0, self.ImageWidth / self.TileWidth - 1 do
    for y = 0, self.ImageHeight / self.TileHeight - 1 do
      tsb:add(
        self.TileQuads[(y * (self.ImageWidth/self.TileWidth) + x) + 1],
        self.TileWidth * (x-1),
        self.TileHeight * (y-1)
      )
    end
  end
  tsb:flush()
  love.graphics.push()
  love.graphics.scale(2, 2)
  love.graphics.draw(tsb, xPos or 0, yPos or 0)
  love.graphics.pop()
end

function Tileset:new(path, tilewidth, tileheight, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Image = love.graphics.newImage(path)
  o.Image:setFilter("nearest", "linear")
  o.TileWidth = tilewidth
  o.TileHeight = tileheight
  local imgWidth = o.Image:getWidth()
  local imgHeight = o.Image:getHeight()
  o.ImageWidth = imgWidth
  o.ImageHeight = imgHeight
  o.TileQuads = {}
  for i = 0, imgWidth / tilewidth - 1 do
    for j = 0, imgHeight / tileheight - 1 do
      o.TileQuads[(j * (imgWidth/tilewidth) + i) + 1] =
      --o.TileQuads[(i * (imgHeight/tileheight) + j) + 1] = 
        love.graphics.newQuad(
          i * tilewidth,
          j * tileheight,
          tilewidth,
          tileheight,
          imgWidth,
          imgHeight
        )
    end
  end
  print(#o.TileQuads .. " tilequads loaded.")
  return o
end
