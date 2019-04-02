Vector = require "vector"

require "cc2debug"
require "utilities"
require "player"
require "world"
require "input"
require "interactions"
require "soundManager"

-- resources
beep = love.audio.newSource("assets/sound/selection_beep.wav", "static")
font = love.graphics.newImageFont("assets/font/luafont.png",
  " abcdefghijklmnopqrstuvwxyz" ..
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
  "123456789.,!?-+/():;%&`'*#=[]\"><{}")
arrow = love.graphics.newImage("assets/img/arrow.png")

playerImg = love.graphics.newImage("assets/img/player_portrait.png")

function love.load()
  player:init()
  world:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)
  love.keyboard.setKeyRepeat(true)
  SetWeatherShaders()
  gamePlaylist = SoundManager:new()
  gamePlaylist:addSong("themeA", "assets/sound/theme_a.ogg", 226) --226
  gamePlaylist:addSong("themeB", "assets/sound/theme_b.ogg", 150) -- 250
  gamePlaylist:addSong("themeC", "assets/sound/theme_c.ogg", 187) --287
  gamePlaylist:setDelay(5)
  gamePlaylist:setMode("random")
  gamePlaylist:setVolume(0)

  titlePlaylist = SoundManager:new()
  titlePlaylist:addSong("titleTheme", "assets/sound/theme_title.ogg", 37)
  --titlePlaylist:play("titleTheme")
  titlePlaylist:setMode("loop")
  titlePlaylist:setVolume(0)

  testPlaylist = SoundManager:new()
  testPlaylist:addSong("beta1", "assets/sound/Song-A-Unfinished_1.ogg", 500)
  testPlaylist:play("beta1")
  testPlaylist:setVolume(0)
  titlePlaylist:setMode("loop")
  currentPlaylist = testPlaylist

  weatherShader = Weather.Foggy.Shader
end

function love.update(dt)
  input:update()

  player:update(dt,input)
  world:update(dt,player)
  currentPlaylist:update(dt)
end

function love.reset()
  player:init()
  world.entities = {}
  world:init()
end

function love.draw()
  love.graphics.setFont(font)
  if player.screen == player:getScreen("gameScreen") then
    world:draw()
  end
  player.screen:draw()
  love.graphics.setColor(1,1,1)
  love.graphics.print(love.timer.getFPS() .. "fps", 750, 25)
  love.graphics.print(math.floor(world.player.position.x) .. " , " .. math.floor(world.player.position.y),700,45)
  love.graphics.reset()
end

-- this event handles actual text input, as opposed to raw keyboard input. it handles capital letters and other special characters automatically
function love.textinput(text)
  player:textinput(text)
end

--handles backspace input for the context of typing
function love.keypressed(key)
  if key == "backspace" then
    player:backspace()
  end
end
