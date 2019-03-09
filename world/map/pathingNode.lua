PathingNode = {
  Edges = {},
  LocationX,
  LocationY,
  NodeType,
  type = "pathingNode",
}

NodeTypes = {
  Spawning = 51,--1,
  Intersection = 11,--2,
  Shop = 30,--3,
  PlayerStart = 28,--4,
  CompanionStart = 29,--5,
  Blocking = 40,--6
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
