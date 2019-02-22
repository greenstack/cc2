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
  for i = 0, imgWidth / tilewidth do
    for j = 0, imgHeight / tileheight do
      o.TileQuads[(i * (imgHeight/tileheight) + j) + 1] = 
        love.graphics.newQuad(
          i * tilewidth,
          j * tileheight,
          tilewidth,
          tileheight,
          imgWidth,
          imgHeight
        )
      --print("Loading tile quad " .. (i * (imgHeight/tileheight) + j) + 1)
    end
  end
  print(#o.TileQuads .. " tilequads loaded.")
  return o
end
