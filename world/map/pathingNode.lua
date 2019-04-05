PathingNode = {
  Edges = {},
  LocationX,
  LocationY,
  NodeType,
  type = "pathingNode",
}

local NODE_TYPES_OLD = {
  Spawning = 51,
  Intersection = 11,
  Shop = 30,
  PlayerStart = 28,
  CompanionStart = 29,
  Blocking = 40,
}

NodeTypes = {
  Spawning = 101,
  Intersection = 102,
  Shop = 103,
  PlayerStart = 104,
  CompanionStart = 105,
  Blocking = 106
}

function PathingNode:insertEdge(node)
  if node.type ~= "pathingNode" then
    error("Cannot add edge as not a node.")
  end
  table.insert(self.Edges, node)
end

function PathingNode:toString()
  return "pathingNode@(" .. self.LocationX .. "," .. self.LocationY .. ")"
end

function PathingNode:countEdges()
  return #self.Edges
end

function PathingNode:new(x, y, nodeType, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Edges = {}
  o.LocationX, o.LocationY = x, y
  o.NodeType = nodeType
  return o;
end
