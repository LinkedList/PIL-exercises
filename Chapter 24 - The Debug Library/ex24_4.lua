--[[
--  Chapter 24, Exercise 4
--
--  Write a modification of getvarvalue (Listing 24.1), called getallvars, that returns a table with all
--  variables that are visible at the calling function. (The returned table should not include
--  environmental variables; instead, it should inherit them form the original environment.)
--
--  Solution:
--]]

require("./ex24_1")
function getallvars(level)
    local allvars = {}

    level = (level or 1) + 1

    for i=1,math.huge do
        local n, v = debug.getlocal(level, i)
        if not n then break end

        allvars[n] = v
    end

    local func = debug.getinfo(level, "f").func
    for i=2,math.huge do
        local n, v = debug.getupvalue(func, i)
        if not n then break end

        allvars[n] = v
    end

    local env = getvarvalue("_ENV", level)
    return setmetatable(allvars,{__index = env})
end

a = 10
local b = 11

all = getallvars()

for name,val in pairs(all) do
    print(name, val)
end

print("a", all.a)
