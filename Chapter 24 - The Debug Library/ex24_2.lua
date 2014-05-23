--[[
--  Chapter 24, Exercise 2
--
--  Adapt function getvarvalue (Listing 24.1) to work with different coroutines.
--  (like other functions from the debug library)
--
--  Solution:
--]]

-- func from Listing 24.1
function getvarvalue(co, name, level)
    local thread = false
    if type(co) == "thread" then
        thread = true
    else
        name, level = co, name
    end

    local value
    local found = false

    if thread then
        level = (level or 1)
    else
        level = (level or 1) + 1
    end

    for i=1,math.huge do
        local n, v
        if thread then
             n, v = debug.getlocal(co, level, i)
        else
             n, v = debug.getlocal(level, i)
        end

        if not n then break end

        if n == name then
            value = v
            found = true
        end
    end

    if found then return value end

    local func
    if thread then
        func = debug.getinfo(co, level, "f").func
    else
        func = debug.getinfo(level, "f").func
    end

    for i=1,math.huge do
        local n, v = debug.getupvalue(func, i)

        if not n then break end
        if n == name then return v end
    end

    local env
    if thread then
         env = getvarvalue(co, "_ENV", level)
    else
         env = getvarvalue("_ENV", level)
    end

    return env[name]
end

local a = 15

print("a is ", getvarvalue("a"))

co = coroutine.create(function ()
    local x = 10
    error("some error")
end)

coroutine.resume(co)
print("x is ", getvarvalue(co, "x"))

co = coroutine.create(function ()
    local function test()
        coroutine.yield()
    end
    x = 11
    test()
    error("some error")
end)

coroutine.resume(co)
print("x is ", getvarvalue(co, "x"))

co = coroutine.create(function ()
    local function test()
        _ENV["x"] = 12
        coroutine.yield()
    end
    local x = 11
    test()
    error("some error")
end)

coroutine.resume(co)
print("x is ", getvarvalue(co, "x"))
