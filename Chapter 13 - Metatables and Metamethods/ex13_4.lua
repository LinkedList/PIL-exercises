--[[
--  Chapter 13, Exercise 4
--
--  An alternative way to implement read-only tables might use a function as the __index metamethod.
--  This alternative makes accesses more expensive, but the creation of read-only tables is cheaper,
--  as all read-only tables can share a single metateble. Rewrite function readOnly using this approach.
--
--  Solution:
--]]

local index = {}
local mt = {
    __index = function (t, k)
        return t[index][k]
    end,
    __newindex = function (t, k, v)
        error("attempt to update a read-only table", 2)
        -- body
    end
}

function readOnly(t)
    local proxy = {}
    proxy[index] = t
    setmetatable(proxy, mt)
    return proxy
end

local days = readOnly{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
print(days[1])
days[2] = "Noday"

local dayParts = readOnly{"AM", "PM"}
print(dayParts[1])
dayParts[1] = "No part"
