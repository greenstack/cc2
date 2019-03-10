lu = require "luaunit"

-- Example Tests
--require "tests.example"

-- Unit Tests
require "tests.unit.testElement"
require "tests.unit.testConsoleElement"
require "tests.unit.testObediometerElement"
require "tests.unit.testPauseElement"
require "tests.unit.testMainMenuElement"
require "tests.unit.testScreen"

-- Cluster Tests

-- Integration Tests

os.exit( lu.LuaUnit.run('-v') )