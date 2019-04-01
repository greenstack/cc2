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

-- Creates a new instance of the sound manager.
-- (Object) o: The base object to create this manager on.
function SoundManager:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.Items = {}
  o.Length = {}
  o.Songs = {}
  return o
end

-- Sets the mode for this sound manager.
-- (String) mode: loop, random, linear, noloop
function SoundManager:setMode(mode)
  self.Mode = mode
end

-- Adds a new song to the manager.
-- (String) name: the name this song will have in this manager.
-- (String) path: the path to the sound file.
-- (int) length: the length (in seconds) of this sound
function SoundManager:addSong(name, path, length)
  table.insert(self.Songs, name)
  self.Items[name] = love.audio.newSource(path, "stream")
  self.Length[name] = length
  self.Count = self.Count + 1
end

-- Plays the song in this playlist with the given name.
-- (String) name: the name of the registered song.
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

-- Stops the song according to Love2D behavior.
-- (String) name: the name of the song to stop.
function SoundManager:stop(name)
  name = name or self.Current
  self.Items[name]:stop()
end

-- Pauses the song according to Love2D behavior.
-- (String) name: the name of the song to stop.
function SoundManager:pause(name)
  name = name or self.Current
  self.Items[name]:pause()
end

-- Sets the delay between songs being played when one finishes.
-- (number) delay: The time to wait between playing another sound.
function SoundManager:setDelay(delay)
  self.Delay = delay
end

-- Updates the sound manager.
function SoundManager:update(dt)
  self.PlayTime = self.PlayTime + dt
  if not self.Length[self.Current] then
    print("No song selected. Selecting a random one...")
    song = self.Songs[love.math.random(#self.Songs)]
    print(song .. " selected.")
    self:play(song)
  elseif (self.PlayTime > self.Length[self.Current] + self.Delay) then
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
