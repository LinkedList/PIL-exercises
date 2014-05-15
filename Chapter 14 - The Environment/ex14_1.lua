--[[
--  Chapter 14, Exercise 1
--
--  The getfield function that we defined in the beginning of this chapter is too
--  forgiving, as it accepts "fields" like math?sin or string!!!gsub.
--  Rewrite it so that it accepts only single dots as name separators.
--  (You may need some knowledge from Chapter 21 to do this exercise.)
--
--  Solution:
--]]
local pprint = require("pprint")
function getfield(f)
    local v = _G

    if string.find(f, "%.%.") then
        error("Wrong separator: Two dots!")
    end

    if not string.match(f, "^[%w_%.]+$") then
        error("Disallowed characters")
    end

    for w in string.gmatch(f, "([%w_]+)%.?") do
        v = v[w]
    end
    return v
end

a = {}
a.b = {}
a.b.c = "YAY"
_G["a"] = a

c = getfield("a.b.c")
print(c)
