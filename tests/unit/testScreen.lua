-- Unit tests for the Screen.

local lu = require "luaunit"
require "player.screen"

TestScreen = Screen:new("Test")

-------------------------------------------------
-- Mock tables/functions needed for testing.
-------------------------------------------------

Element1 = {
  type = "Element",
  name = "Element1"
}

Element2 = {
  type = "Element",
  name = "Element2"
}

NotAnElement = {
  type = "NotElement",
  name = "NonElement1"
}

-------------------------------------------------
-- Setup Method
-------------------------------------------------

function TestScreen:setUp()
  self.elements = {}
end

-------------------------------------------------
-- Tests
-------------------------------------------------

function TestScreen:testGetElement()
  self.elements = {
    Element1
  }
  result = self:getElement("Element1")
  lu.assertIs(result, Element1, "Getting a valid element did not return the element.")
  result = self:getElement("NotAnElement")
  lu.assertIsNil(result, "Trying to get a non-element returned something.")
end

function TestScreen:testAddElement()
  result = self:addElement(Element1)
  lu.assertTrue(result, "Adding a valid element did not return true.")
  lu.assertEquals(self.elements, {Element1}, "Adding a valid element does not add the element.")
  result = self:addElement(NotAnElement)
  lu.assertFalse(result, "Adding a non-element returned true.")
  lu.assertEquals(self.elements, {Element1}, "Trying to add a non-element changed the elements list.")
end

function TestScreen:testRemoveElement()
  self.elements = {
    Element1,
    Element2
  }
  self:removeElement("Element1")
  lu.assertEquals(self.elements, {Element2}, "Removing a valid element failed.")
  self:removeElement("Element1")
  lu.assertEquals(self.elements, {Element2}, "Removing a non-existent element changed the elements list.")
  self:removeElement("Element2")
  lu.assertEquals(self.elements, {}, "Removing the last element failed.")
end