--[[
--  Chapter 24, Exercise 1
--
--  Why the recursion in function getvarvalue (Listing 24.1) is guaranteed to stop?
--
--  Solution:
--  Because debug.getupvalue(func, i) returns _ENV for index = 1.
--  When we call getvarvalue("_ENV", level) we are guaranteed to stop on the first cycle
--  of debug.getupvalue and return _ENV.
--]]

-- func from Listing 24.1
function getvarvalue(name, level)
    local value
    local found = false

    level = (level or 1) + 1

    for i=1,math.huge do
        local n, v = debug.getlocal(level, i)
        if not n then break end

        if n == name then
            value = v
            found = true
        end
    end

    if found then return value end

    local func = debug.getinfo(level, "f").func

    for i=1,math.huge do
        local n, v = debug.getupvalue(func, i)
        print(n) --> if i == 1 then n == "_ENV"
        if not n then break end
        if n == name then return v end
    end

    local env = getvarvalue("_ENV", level)
    return env[name]
end

print(getvarvalue("a"))
