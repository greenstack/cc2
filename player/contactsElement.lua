ContactsElement = Element:new("contacts")

function ContactsElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.currentContacts = 0
  o.goal = 0
  o.money = 0
  o.icecream = 0
  return o
end

function ContactsElement:update(dt,input,player)
  self.currentContacts = player.contacts
  self.goal = player.contactsGoal
  self.money = player.money
  self.icecream = player.icecream
end

function ContactsElement:draw()
  local barWidth = 25
  local barHeight = 110
  local filledBarHeight = (self.currentContacts/self.goal) * (barHeight - 10)
  if (filledBarHeight > (barHeight - 10)) then
    filledBarHeight = barHeight - 10
  end

  -- Progress bar backdrop
  love.graphics.setColor(0.4, 0.4, 0.6)
  love.graphics.rectangle("fill",self.position.x,self.position.y,barWidth,barHeight,10,10)

  -- Progress bar color
  local r = 1 - (self.currentContacts/self.goal)
  local g = 0.5 + (self.currentContacts/self.goal) * 0.5
  local b = 0

  -- Progress bar black background
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",self.position.x+5,self.position.y+5,barWidth-10,barHeight-10,10,10)

  -- Progress bar
  love.graphics.setColor(r,g,b)
  if (self.currentContacts > 0) then
    love.graphics.rectangle("fill",
      self.position.x+5,
      self.position.y+barHeight-filledBarHeight-5,
      barWidth-10,
      filledBarHeight,
      10,10)
  end

  -- Text
  love.graphics.setColor(1,1,1)
  love.graphics.print("Contacts: ".. self.currentContacts .. "/" .. self.goal, self.position.x + 30, self.position.y)
  love.graphics.print("Money: $".. self.money, self.position.x + 30, self.position.y + 62)
  love.graphics.print("Icecream: " .. self.icecream, self.position.x + 30, self.position.y + 78)
end