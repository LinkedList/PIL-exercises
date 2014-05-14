--[[
--  Chapter 13, Exercise 1
--
--  Define a metamethod __sub for sets that returns the difference of two sets. (The set a - b is the
--  set of elements from a that are not in b.)
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

function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

function Set.print(s)
    print(Set.tostring(s))
end

mt.__sub = function (a, b)
    local set = Set.new{}

    for k in pairs(a) do
        set[k] = true
    end

    for k in pairs(b) do
        set[k] = nil
    end
    return set
end

s1 = Set.new{2,4}
s2 = Set.new{4,10,1, 2}

Set.print(s1 - s2)
