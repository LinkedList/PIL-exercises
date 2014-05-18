--[[
--  Chapter 17, Exercise 1
--
--  Write an experiment to determine whether Lua actually implements ephemeron tables.
--  (Remember to call collectgarbage to force a garbage collection cycle.)
--  If possible, try your code both in Lua 5.1 and in Lua 5.2 to see the difference.
--
--  Solution:
--]]

function test_key_value(t)
    for key,val in pairs(t) do
        print("Key and value still here:")
        print(key, val)
        break
    end
    print()
end
local table = {}

setmetatable(table, {__mode = "k"})

local key = {key = true}

local value = {key = key}

table[key] = value

print("After initialization:")
collectgarbage()
test_key_value(table)

print("With key = nil:")
key = nil
collectgarbage()
test_key_value(table)

print("With value = nil:")
key = value.key
value = nil
collectgarbage()
test_key_value(table)

print("With both nil:")
key = nil
value = nil
collectgarbage()
test_key_value(table)
