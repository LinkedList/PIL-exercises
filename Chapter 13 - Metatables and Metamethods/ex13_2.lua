--[[
--  Chapter 13, Exercise 2
--
--  Define a metamethod __len for sets so that #s returns the number of elements in the set s
--
--  Solution:
--]]

Set = {}

local mt = {}

function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do set[v] = true end
    return set
end

mt.__len = function (a)
    local len = 0

    for k in pairs(a) do
        len = len + 1
    end

    return len
end

s1 = Set.new{2,4}
s2 = Set.new{4,10,1, 2}

print(#s1)
print(#s2)
