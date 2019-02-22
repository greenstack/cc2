local baton = require 'baton.baton'

input = baton.new {
  controls = {
    left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
    action = {'key:x', 'button:a'},
    talk = {'key:space'},
  },
  pairs = {
    move = {'left','right','up','down'}
  },
  joystick = love.joystick.getJoysticks()[1]
  --this is just the example code from the baton documentation, we will likely want to adapt this
}