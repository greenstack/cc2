-- Unit tests for the base Element class.
-- Each specific type of element is under its own set of unit tests.

local lu = require "luaunit"
require "player.element"

TestElement = Element:new("Test", 10, 10, false, false)

-------------------------------------------------
-- Setup Method
-------------------------------------------------

function TestElement:setUp()
  self.enabled = false
  self.visible = false
end

-------------------------------------------------
-- Tests
-------------------------------------------------

function TestElement:testSetVisible()
  self:setVisible(true)
  lu.assertTrue(self.visible)
  self:setVisible(false)
  lu.assertFalse(self.visible)
end

function TestElement:testSetEnabled()
  self:setEnabled(true)
  lu.assertTrue(self.enabled)
  self:setEnabled(false)
  lu.assertFalse(self.enabled)
end

function TestElement:testOpen()
  self:open()
  lu.assertTrue(self.visible, "Element:open() does not set visible to true.")
  lu.assertTrue(self.enabled, "Element:open() does not set enabled to true.")
  lu.assertTrue(self.wait, "Element:open() does not set wait to true.")
end