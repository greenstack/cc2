Element = {
  type = "Element",
  name = "An element",
  position = nil,
  enabled = true,
  visible = true
}

-- Creates a new instance of a element object.
-- (string) the name of the element
-- (int) the x position of the element
-- (int) the y position of the element
function Element:new(name,x,y,enabled,visible,o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.name = name
  o.position = {x = x or 0, y = y or 0}
  o.enabled = enabled
  o.visible = visible
  return o
end

function Element:setVisible(visible)
  self.visible = visible
end

function Element:setEnabled(enabled)
  self.enabled = enabled
end

function Element:open()
  self.wait = true
  self:setVisible(true)
  self:setEnabled(true)
end

function Element:update(dt,input,player)

end

function Element:draw()

end

function Element:textinput(text)

end

function Element:backspace()

end
