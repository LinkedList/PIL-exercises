--[[
--  Chapter 24, Exercise 5
--
--  Write an improved version of debug.debug that runs the given commands as if they were in the lexical scope
--  of the calling function. (Hint: run commands in an empty environment and use the __index metamethod attached
--  to function getvarvalue to do all accesses to variables.)
--
--  Solution:
--]]

require("./ex24_1")


function debugimp()
    mt = {
        __index = function (t, k)
            return getvarvalue(k)
        end
    }
    local setmetatable = setmetatable
    while true do
        io.write("lua_debug>")
        local line = io.read()
        if line == "cont" then
            return
        else
            local f = assert(load(line))
            local _ENV = {}
            setmetatable(_ENV, mt)
            f()
        end
    end
end

function test()
    local a = "test this"
    print(getvarvalue("a"))
    debugimp()
end

test()
