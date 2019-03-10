-- Unit tests for the Console Element.

local lu = require "luaunit"
require "player.consoleElement"

TestElementConsole = ConsoleElement:new("Test", 10, 10, false, false)

-------------------------------------------------
-- Mock tables/functions needed for testing.
-------------------------------------------------

MockPlayer = {
  paused = true,
  debugMode = true
}

-------------------------------------------------
-- Setup Method
-------------------------------------------------

function TestElementConsole:setUp()
  self.enabled = false
  self.visible = false
  self.text = ""
  self.lineText = ""
  self.wait = true
  self.oldPaused = false
  self.history = {}
  self.historyIndex = 0
  self.tempStore = ""

  MockPlayer.paused = true
  MockPlayer.debugMode = true
end

-------------------------------------------------
-- Tests
-------------------------------------------------

function TestElementConsole:testClose()
  self:close(MockPlayer)
  lu.assertFalse(MockPlayer.paused, "Closing console does not un-pause player.")
  lu.assertFalse(MockPlayer.debugMode, "Closing console does not take player out of debug mode.")
  lu.assertFalse(self.enabled, "Closing console does not disable the console.")
  lu.assertFalse(self.visible, "Closing console does not make the element invisible.")
end

function TestElementConsole:testTextInput()
  self:textinput("ABC123")
  lu.assertEquals(self.lineText, "ABC123", "Adding alphanumeric characters failed.")
  self:textinput(" !@#.$%^(){}")
  lu.assertEquals(self.lineText, "ABC123 !@#.$%^(){}", "Adding special characters failed.")
  self:backspace()
  self:backspace()
  self:backspace()
  lu.assertEquals(self.lineText, "ABC123 !@#.$%^(", "Failed to delete characters.")
end

function TestElementConsole:testDoCommand()
  commandString = "MockPlayer.paused = false"
  self.lineText = commandString
  self:doCommand()
  lu.assertEquals(#self.history, 1, "Incorrect number of items in history.")
  lu.assertEquals(self.historyIndex, 2, "History index is not correct.")
  lu.assertEquals(self.text, "> " .. commandString .. "\n: nil\n", "Console text is inconsistent after executing.")
  lu.assertFalse(MockPlayer.paused, "Console does not execute command.")
  lu.assertEquals(self.history[1], commandString, "Previous command not in history.")
end

function TestElementConsole:testMoveHistory()
  string1 = "ABCD"
  string2 = "a1b2"
  table.insert(self.history, string1)
  table.insert(self.history, string2)
  self.historyIndex = 1

  self:historyDown()
  lu.assertEquals(self.lineText, string2, "Problem moving down history.")
  lu.assertEquals(self.historyIndex, 2, "History index does not update when moving down.")
  self:historyDown()
  self:historyDown()
  lu.assertEquals(self.lineText, "", "Moving to bottom of history does not leave blank text.")
  lu.assertEquals(self.historyIndex, 3, "Moving to bottom of history, index is not correct.")

  self:historyUp()
  lu.assertEquals(self.lineText, string2, "Problem moving up history.")
  lu.assertEquals(self.historyIndex, 2, "History index does not update when moving up.")
  self:historyUp()
  self:historyUp()
  lu.assertEquals(self.lineText, string1, "Moving past top of history does not keep first history item.")
  lu.assertEquals(self.historyIndex, 1, "Moving past top of history does not keep index at 1.")

  self:historyDown()
  self:historyDown()
  self:historyDown()
  self:historyUp()
  lu.assertEquals(self.lineText, string2, "Moving past bottom of history then back up does not load last history item.")
  lu.assertEquals(self.historyIndex, 2, "Moving past bottom of history then back up does not set index properly.")
end