lu = require "luaunit"

require "tests.example"

os.exit( lu.LuaUnit.run('-v') )