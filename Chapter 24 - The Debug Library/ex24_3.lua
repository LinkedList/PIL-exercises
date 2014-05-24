--[[
--  Chapter 24, Exercise 3
--
--  Write a function setvarvalue similar to getvarvalue (Listing 24.1).
--
--  Solution:
--]]

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
        if not n then break end
        if n == name then return v end
    end

    local env = getvarvalue("_ENV", level)
    return env[name]
end

function setvarvalue(name, value, level)
    local found = false

    level = (level or 1) + 1

    local index = false
    for i=1,math.huge do
        local n, v = debug.getlocal(level, i)
        if not n then break end

        if n == name then
            index = i
            found = true
        end
    end

    if found then
        debug.setlocal(level, index, value)
        return
    end

    local func = debug.getinfo(level, "f").func
    for i=1,math.huge do
        local n, v = debug.getupvalue(func, i)
        if not n then break end
        if n == name then
            index = i
            found = true
        end
    end

    if found then
        debug.setupvalue(func, index, value)
        return
    end

    local env = getvarvalue("_ENV", level)

    if env[name] ~= nil then
        env[name] = value
    end
end
