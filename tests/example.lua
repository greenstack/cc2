local lu = require('luaunit')

-- Helper functions/objects
function throwError(param)
    if (param == 1) then
        error("Error Message")
    end
end

Object1 = {
    a=1,
    b=2,
    c=3
}

Object2 = {
    a=1,
    b=2,
    c=3
}

-- Test tables must begin with 'Test' or 'test'
TestExample = {}

-- Called before EACH test case (so changing things in a test case doesn't affect later cases)
function TestExample:setUp()
    self.a = 1
    self.b = "Some Stuff"
    self.c = nil
    self.d = true
    self.e = false
    self.f = Object1
    self.g = {1, 2, 3}
end

-- Any function that begins with 'test' counts as a test case
function TestExample:testEquals()
    lu.assertEquals(self.a, 1, "Asserts have an optional final message parameter (shown if the test fails)")
    lu.assertNotEquals(self.a, 2)
end

function TestExample:testEvals()
    lu.assertTrue(self.d) -- Only passes if the value is the boolean 'true'
    lu.assertEvalToTrue(self.a) -- Passes for any 'truthy' value (non-zero, non-empty, etc.)
    lu.assertFalse(self.e) -- Same deal, but now for the boolean 'false'
    lu.assertEvalToFalse(self.c)
end

function TestExample:testIsStatements()
    --    Same as assertEquals for primitives including strings,
    --    but will fail on different object references with identical fields
    lu.assertIs(self.f, Object1)
    lu.assertNotIs(self.f, Object2)
    lu.assertEquals(self.f, Object2)
end

function TestExample:testStrings()
    lu.assertStrContains(self.b, "Some")
    lu.assertStrIContains(self.b, "sOmE") -- case insensitive check
    lu.assertNotStrContains(self.b, "some")
    lu.assertNotStrIContains(self.b, "Weasel")
    lu.assertStrMatches(self.b, "Some Stuff")
end

function TestExample:testErrors()
    -- All of these functions do not support the extra optional message parameter.
    -- Any arguments after the function are parameters to the called function
    lu.assertError(throwError, 1)
    lu.assertErrorMsgEquals("./tests/example.lua:6: Error Message", throwError, 1) -- Obviously, this is not ideal...
    lu.assertErrorMsgContains("Error", throwError, 1)
end

function TestExample:testTypes()
    lu.assertIsNumber(self.a)
    lu.assertIsString(self.b)
    lu.assertIsTable(self.g)
    lu.assertIsBoolean(self.e)
    lu.assertIsNil(self.c)
    lu.assertIsFunction(throwError)
end