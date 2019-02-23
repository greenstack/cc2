local baton = require 'baton.baton'

input = baton.new {
  controls = {
    left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
    action = {'key:x', 'button:a'},
    talk = {'key:space'},
    menu = {'key:escape','button:start'},
    debug = {'key:`'},
    enter = {'key:return','key:kpenter'},
    kup = {'key:up'}, 
    kdown = {'key:down'}, 
  },
  pairs = {
    move = {'left','right','up','down'}
  },
  joystick = love.joystick.getJoysticks()[1]
}