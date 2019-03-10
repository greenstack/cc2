require "world.map.pathingNode"

PathingGraph = {
  -- (table of pathingNodes) Nodes where NPCs can stop and make
  -- routing decisions.
  Nodes,
  -- (table of pathingNodes) Nodes where NPCs can spawn/despawn.
  SpawnNodes,
  -- (pathingNode) Where the shop is located on the map.
  ShopLocation,
  -- (pathingNode) Where the player starts.
  PlayerStart,
  -- (pathingNode) Where the companion starts.
  CompanionStart,
  -- (canvas) The visual display of this graph.
  Visualization,
  -- (layer) The layer used to make the graph.
  layer,
}

function PathingGraph:setup()
  local x, y
  print("Preparing graph")
  for x = 1, self.layer.LayerWidth do
    for y = 1, self.layer.LayerHeight do
      if not self.layer:IsTileEmpty(x, y) then
        local tile = self.layer:GetTile(x, y).TileId
        local node = PathingNode:new(x, y, tile)
        if tile == NodeTypes.Spawning then
          -- Register spawning node. Find edges.
          table.insert(self.SpawnNodes, node)
          self:findEdges(node)
        elseif tile == NodeTypes.Intersection then
          -- Find edges.
          self:findEdges(node)
        elseif tile == NodeTypes.Shop then
          -- Register shopping node.
          self.ShopLocation = node
        elseif tile == NodeTypes.PlayerStart then
          -- Rehister player start.
          self.PlayerStart = node
        elseif tile == NodeTypes.CompanionStart then
          -- Register companion start.
          self.CompanionStart = node
        end
        -- Any other node type is ignored.
      end
    end
  end
end

-- Finds a valid node in the correct direction, if possible.
-- (node) node: the node to look around.
-- (string) axis: y or x. The direction to look in.
-- (number) step: the direction to look in, represented by a number.
--                Clamped to the range [-1, 1]
function PathingGraph:seekInDirection(node, axis, step) 
  local tile, start, fin, offset
  step = clamp(step, -1, 1)
  if step == 0 then
    error("Step cannot be zero.")
  elseif step < 0 then
    fin = 1
    offset = -1
  else
    offset = 1
  end
  if axis == 'y' then
    if step >= 1 then
      fin = self.layer.LayerHeight
    end
    start = node.LocationY + offset
  elseif axis == 'x' then
    if step >= 1 then
      fin = self.layer.LayerWidth
    end
    start = node.LocationX + offset
  else
    error("Invalid axis provided: " .. axis)
  end

  for a = start, fin, step do
    if axis == 'y' then
      tile = self.layer:GetTile(node.LocationX, a).TileId
    elseif axis == 'x' then
      tile = self.layer:GetTile(a, node.LocationY).TileId
    end

    -- Only react to nodes where NPCs can stop.
    if tile == NodeTypes.Blocking then return
    elseif tile == NodeTypes.Spawning or tile == NodeTypes.Intersection then    
      local edge
      if axis == 'y' then
        edge = PathingNode:new(node.LocationX, a, tile)
      elseif axis == 'x' then
        edge = PathingNode:new(a, node.LocationY, tile)
      end
      if edge ~= nil then
        node:insertEdge(edge)
      end
      return
    end
  end

end

-- Finds all nodes that the provided node can connect to
-- in each direction.
function PathingGraph:findEdges(node)
  -- Check to the left
  self:seekInDirection(node, 'x', -1)
  -- Check to the right
  self:seekInDirection(node, 'x', 1)
  -- Check above
  self:seekInDirection(node, 'y', -1)
  -- Check below
  self:seekInDirection(node, 'y', 1)

  table.insert(self.Nodes, node)
end

-- Shows a visual representation of the graph.
function PathingGraph:show(x, y)
  love.graphics.draw(self.Visualization, x, y)
end

-- Retrieves the number of nodes the graph contains.
function PathingGraph:countNodes()
  return #self.Nodes
end

-- There's gotta be a more efficient way to do this, but since
-- we only do this when the level is loaded - if it's even desired -
-- we probably don't need to worry about it, as right now, each edge is
-- going to be drawn twice. Furthermore, because we're rendering this
-- to a canvas, we needn't worry too much about this taking up too much
-- time per frame.
function PathingGraph:prepareDisplay(map)
  self.Visualization = love.graphics.newCanvas(
    map.MapWidth * map.Tileset.TileWidth, 
    map.MapHeight * map.Tileset.TileHeight
  )
  love.graphics.setCanvas(self.Visualization)
  for _, node in ipairs(self.Nodes) do
    -- Todo: set the color based on the node type.
    local centerX = node.LocationX * map.Tileset.TileWidth - map.Tileset.TileWidth / 2
    local centerY = node.LocationY * map.Tileset.TileHeight - map.Tileset.TileHeight / 2
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle(
      "line",
      centerX,
      centerY,
      map.Tileset.TileWidth/2
    )
    --print("From node at " .. node.LocationX .. ", " ..node.LocationY)
    for i = 1, #node.Edges do
      local edgeX = node.Edges[i].LocationX * map.Tileset.TileWidth - map.Tileset.TileWidth / 2
      local edgeY = node.Edges[i].LocationY * map.Tileset.TileHeight - map.Tileset.TileHeight / 2
      --print("\tConnection found at " .. node.Edges[i].LocationX ..", ".. node.Edges[i].LocationY)
      love.graphics.setColor(1, 1, 1)
      love.graphics.line(
        -- start the line at the center of the graph
        centerX, 
        centerY, 
        edgeX, 
        edgeY)
    end
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.setCanvas()
end

function PathingGraph:new(layer, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Nodes = {}
  o.SpawnNodes = {}
  o.layer = layer
  o:setup(layer)
  return o
end
