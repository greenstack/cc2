-- Unit tests for the Pause Element.

local lu = require "luaunit"
require "player.pauseElement"

TestElementPause = PauseElement:new("Test", 0, 0, true, true)

-------------------------------------------------
-- Mock tables/functions needed for testing.
-------------------------------------------------

beep = {}

function beep:stop() end

function beep:play() end

MockPlayer = {
  paused = true,
  quit = false
}

love = {
  event = {}
}

function love.event.quit()
  MockPlayer.quit = true
end

-------------------------------------------------
-- Setup Method
-------------------------------------------------

function TestElementPause:setUp()
  self.selected = 1
  self.enabled = true
  self.visible = true

  MockPlayer.paused = true
  MockPlayer.quit = false
end

-------------------------------------------------
-- Tests
-------------------------------------------------

function TestElementPause:testNavigation()
  self:moveDown()
  lu.assertEquals(self.selected, 2, "Pause menu move down does not update 'selected'.")
  self:moveUp()
  lu.assertEquals(self.selected, 1, "Pause menu move up does not update 'selected'.")
  self:moveUp()
  lu.assertEquals(self.selected, #self.options, "Moving up past option 1 does not set selected to last option.")
  self:moveDown()
  lu.assertEquals(self.selected, 1, "Moving down past last option does not set selected to 1.")
end

function TestElementPause:testUnpause()
  self:unpause(MockPlayer)
  lu.assertFalse(MockPlayer.paused, "Player remains in paused state after unpausing.")
  lu.assertFalse(self.visible, "Pause element remains visible after unpausing.")
  lu.assertFalse(self.enabled, "Pause element remains enabled after unpausing.")
end

function TestElementPause:testQuit()
  self:quit()
  lu.assertTrue(MockPlayer.quit, "Quitting from the pause menu doesn't call love.event.quit()")
end