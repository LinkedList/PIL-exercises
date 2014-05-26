--[[
--  Chapter 24, Exercise 5
--
--  Write an improved version of debug.debug that runs the given commands as if they were in the lexical scope
--  of the calling function. (Hint: run commands in an empty environment and use the __index metamethod attached
--  to function getvarvalue to do all accesses to variables.)
--
--  Solution:
--]]

-- Listing 24.1 getvarvalue
require("./ex24_1")

function debugimp()
    mt = {
        __index = function (t, k)
            return getvarvalue(k, 3)
        end
    }
    while true do
        io.write("lua_debug>")
        local line = io.read()
        if line == "cont" then
            return
        else
            env = {}
            setmetatable(env, mt)
            local f = assert(load(line))
            debug.setupvalue(f, 1, env)
            f()
        end
    end
end

function test()
    local a = "test this"
    debugimp()
end

test()
