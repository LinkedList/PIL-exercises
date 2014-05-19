--[[
--  Chapter 20, Exercise 3
--
--  Write a function to test whether a given table is a valid sequence.
--
--  Solution:
--]]

function isSequence(t)
    local arrlen = #t

    local alllen = 0

    for k,v in pairs(t) do
        alllen = alllen + 1
    end

    if alllen ~= arrlen then return false end
    return true
end

print(isSequence({"a", "b", c = "lol"}))
print(isSequence({1, 2, 3, 4, nil, 5}))
print(isSequence({"a", "b", "c"}))
