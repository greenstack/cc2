-- Unit tests for the Main Menu Element.

local lu = require "luaunit"
require "player.mainMenuElement"

TestElementMainMenu = MainMenuElement:new("Test", 0, 0, true, true)

-------------------------------------------------
-- Mock tables/functions needed for testing.
-------------------------------------------------

beep = {}

function beep:stop() end

function beep:play() end

MockPlayer = {
  inPlay = false,
  screen = "mainMenuScreen",
  quit = false
}

function MockPlayer:getScreen(screen)
  return screen
end

love = {
  event = {}
}

function love.event.quit()
  MockPlayer.quit = true
end

currentPlaylist = {}
function currentPlaylist:stop() return end

gamePlaylist = {}
function gamePlaylist:play(theme) return end

-------------------------------------------------
-- Setup Method
-------------------------------------------------

function TestElementMainMenu:setUp()
  self.enabled = true
  self.visible = true
  self.selected = 1
  MockPlayer.inPlay = false
  MockPlayer.screen = "mainMenuScreen"
  MockPlayer.quit = false
end

-------------------------------------------------
-- Tests
-------------------------------------------------

function TestElementMainMenu:testNavigation()
  self:moveDown()
  lu.assertEquals(self.selected, 2, "Moving down does not update selected.")
  self:moveDown()
  lu.assertEquals(self.selected, 1, "Moving down past number of options does not set selected to 1.")
  self:moveDown()
  self:moveUp()
  lu.assertEquals(self.selected, 1, "Moving up does nt update selected.")
  self:moveUp()
  lu.assertEquals(self.selected, 2, "Moving up past option 1 does not set selected to last item.")
end

function TestElementMainMenu:testStartGame()
  self.options[1].f(MockPlayer)
  lu.assertTrue(MockPlayer.inPlay, "Starting game does not set player to inPlay")
  lu.assertEquals(MockPlayer.screen, "gameScreen", "Starting game does not set player screen to gameScreen")
end

function TestElementMainMenu:testQuitGame()
  self.options[2].f(MockPlayer)
  lu.assertTrue(MockPlayer.quit, "Selecting quit doesn't call love.event.quit()")
end