--  Chapter 24, Exercise 6
--
--  Improve the previous exercise to handle updates, too.
--
--  Solution:
--]]

-- Listing 24.1 getvarvalue
require("./ex24_1")
-- Exercise 24.3 setvarvalue
require("./ex24_3")

function debugimp()
    mt = {
        __index = function (t, k)
            return getvarvalue(k, 3)
        end,

        __newindex = function (t, k, v)
            setvarvalue(k, v, 4)
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
