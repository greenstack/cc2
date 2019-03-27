SoundManager = {
  Songs = {},
  Items = {},
  Length = {},
  PlayTime = 0,
  Count = 0,
  Delay = 0,
  Current = "",
  Mode = "random"
}

function SoundManager:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Items = {}
  o.Length = {}
  o.Songs = {}
  return o
end

function SoundManager:setMode(mode)
  self.Mode = mode
end

function SoundManager:addSong(name, path, length)
  table.insert(self.Songs, name)
  self.Items[name] = love.audio.newSource(path, "stream")
  self.Length[name] = length
  self.Count = self.Count + 1
end

function SoundManager:play(name)
  if not name then
    error("A name of a song must be provided.")
  elseif not self.Items[name] then
    error("The song " .. name .. " could not be found.")
  end
  
  self.Items[name]:play()
  self.PlayTime = 0
  self.Current = name
end

function SoundManager:stop(name)
  name = name or self.Current
  self.Items[name]:stop()
end

function SoundManager:pause(name)
  name = name or self.Current
  self.Items[name]:pause()
end

function SoundManager:setDelay(delay)
  self.Delay = delay
end

function SoundManager:update(dt)
  self.PlayTime = self.PlayTime + dt
  if (self.PlayTime > self.Length[self.Current] + self.Delay) then
    print("Stopping song " .. self.Current)
    self:stop(self.Current)
    local song
    if self.Mode == "loop" then
      print("Looping " .. self.Current)
      song = self.Current
    elseif self.Mode == "random" then
      song = self.Songs[love.math.random(#self.Songs)]
    elseif self.Mode == "linear" then
      print("linear play mode hasn't been implemented.")
      return
    elseif self.Mode == "noloop" then
      return
    else
      error("Invalid mode " .. self.Mode)
    end
    print("Now playing " .. song) 
    self:play(song)
  end
end
