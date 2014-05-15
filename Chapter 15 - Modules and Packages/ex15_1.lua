--[[
--  Chapter 15, Exercise 1
--
--  Rewrite the code in Listing 13.1 as a proper module.
--
--  Solution:
--]]

Set = {}

function Set.new(set)
    local set = {}
    for _,v in ipairs(set) do
        set[v] = true
    end
    return set
end

function Set.union(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = true
    end
    for k in pairs(b) do
        res[k] = true
    end
    return res
end

function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

function Set.print(set)
    print(Set.tostring(set))
end

return Set
