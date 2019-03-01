Screen = {
  type = "Screen",
  name = "A screen",
  elements = nil,
  background = {0.75,0.75,0.75}
}

-- Creates a new instance of a screen object.
-- (string) the name of the screen
function Screen:new(name,o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.name = name
  o.elements = {}
  return o
end

function Screen:addElement(element)
  if element.type == "Element" then
    table.insert(self.elements, element)
    return true
  else
    print("Trying to add non-element as an element")
    return false
  end
end

function Screen:removeElement(elementName)
  for k,v in pairs(self.elements) do
    if v.name == elementName then
      return table.remove(self.elements,k)
    end
  end
end

function Screen:getElement(elementName)
  for k,v in pairs(self.elements) do
    if v.name == elementName then
      return v
    end
  end
end

function Screen:update(dt,input,player)
  for k,v in pairs(self.elements) do
    if v.enabled then
      v:update(dt,input,player)
    end
  end
end

function Screen:draw()
  for k,v in pairs(self.elements) do
    if v.visible then
      v:draw()
    end
  end
end

function Screen:textinput(text)
  for k,v in pairs(self.elements) do
    if v.enabled then
      v:textinput(text)
    end
  end
end

function Screen:backspace()
  for k,v in pairs(self.elements) do
    if v.enabled then
      v:backspace()
    end
  end
end