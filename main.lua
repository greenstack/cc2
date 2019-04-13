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
  gamePlaylist:addSong("themeA", "assets/sound/ComeOnElder.wav", 199)
  gamePlaylist:addSong("themeB", "assets/sound/GoalChaser.wav", 125)
  gamePlaylist:addSong("themeC", "assets/sound/OnTheLookout.wav", 121)
  gamePlaylist:addSong("themeD", "assets/sound/PluggingAway.wav", 146)
  gamePlaylist:setDelay(5)
  gamePlaylist:setMode("random")
  gamePlaylist:setVolume(1)

  titlePlaylist = SoundManager:new()
  titlePlaylist:addSong("titleTheme", "assets/sound/theme_title.ogg", 37)
  titlePlaylist:play("titleTheme")
  titlePlaylist:setMode("loop")
  titlePlaylist:setVolume(1)

  currentPlaylist = titlePlaylist

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
