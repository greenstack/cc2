local utf8 = require "utf8"

ConsoleElement = Element:new("obediometer")

function ConsoleElement:new(name,x,y,enabled,visible,o)
  local o = Element.new(self,name,x,y,enabled,visible,o)
  o.text = ""
  o.lineText = ""
  o.wait = true -- wait until the next tick so we don't close the element using the same input that opened it
  o.oldPaused = false -- pause state to return to
  o.history = {} -- command history
  o.historyIndex = 0
  o.tempStore = ""
  return o;
end

function ConsoleElement:update(dt,input,player)
  if input:pressed('debug') and not self.wait then
    player.paused = self.oldPaused
    player.debugMode = false
    self:setEnabled(false)
    self:setVisible(false)
  elseif input:pressed('enter') then
    table.insert(self.history,self.lineText)
    self.historyIndex = #self.history + 1
    if(self.lineText == "clear") then
      self.text = ""
      self.lineText = ""
      return
    end
    local f,err = loadstring('return ' .. self.lineText)
    if not f then
      f,err = loadstring(self.lineText)
    end
    self.text = self.text .. "> " .. self.lineText .. "\n"
    local success,result = pcall(f)
    self.text = self.text .. ": " .. tostring(result) .. "\n"
    self.lineText = ""
  elseif input:pressed('kup') then
    self.historyIndex = self.historyIndex - 1
    if self.historyIndex < 1 then
      self.historyIndex = 1
    end
    if self.historyIndex == #self.history then
      self.tempStore = self.lineText
    end
    self.lineText = self.history[self.historyIndex] or ""
  elseif input:pressed('kdown') then
    self.historyIndex = self.historyIndex + 1
    if self.historyIndex > #self.history + 1 then
      self.historyIndex = #self.history + 1
    end
    self.lineText = self.history[self.historyIndex] or self.tempStore
  end
  
  self.wait = false
end

function ConsoleElement:draw()
  local windowWidth,windowHeight = love.graphics.getDimensions()
  
  love.graphics.setColor(.7,.7,.7,.5)
  love.graphics.rectangle('fill', 40, 40, windowWidth-80, windowHeight-80,10,10)
      
  love.graphics.setColor(.9,.9,.9)
  love.graphics.printf(self.text .. "> " .. self.lineText, 45, 45, windowWidth-90, 'left')
end

function ConsoleElement:textinput(text)
  if(text == '`') then return end
  self.lineText = self.lineText .. text
end

function ConsoleElement:backspace()
    --local arrowCheck = self.text:sub(string.len(self.text)-1,string.len(self.text)-1)
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(self.lineText, -1)

    if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
        --self.text = string.sub(self.text, 1, byteoffset - 1)
        self.lineText = string.sub(self.lineText, 1, byteoffset - 1)
    end
end

function ConsoleElement:log(string)
  self.text = self.text .. string .. "\n"
end