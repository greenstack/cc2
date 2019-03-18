Vector = require "vector"

require "cc2debug"
require "utilities"
require "loading"
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

tempPlayerImg = love.graphics.newImage("assets/img/temp_player.png")
tempNPCImg = love.graphics.newImage("assets/img/temp_npc.png")


function love.load()
  player:init()
  world:init()
  love.graphics.setBackgroundColor(0.5,0.5,0.5)
  love.keyboard.setKeyRepeat(true)
  SetWeatherShaders()
  sm = SoundManager:new()
  sm:addSong("themeA", "assets/sound/theme_a.ogg", 226) --226
  sm:addSong("themeB", "assets/sound/theme_b.ogg", 150) -- 250
  sm:addSong("themeC", "assets/sound/theme_c.ogg", 187) --287
  sm:setDelay(5)
  sm:setMode("random")
  sm:play("themeA")
  weatherShader = Weather.Foggy.Shader
end

function love.update(dt)
  input:update()

  player:update(dt,input)
  world:update(dt,player)
  sm:update(dt)
  --interactions:update(dt,world,player)
end

function love.draw()
  love.graphics.setFont(font)
  world:draw()
  player.screen:draw()
  love.graphics.setColor(1,1,1)
  love.graphics.print(love.timer.getFPS() .. "fps",750,25)
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
