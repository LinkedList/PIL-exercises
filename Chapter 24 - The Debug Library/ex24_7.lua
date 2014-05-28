--[[
--  Chapter 24, Exercise 7
--
--  Implement some of the suggested improvements for the basic profiler in Section 24.3.
--
--  Solution:
--  Implemented sorting by counter, using third parameter,
--]]

local Counters = {}
local Names = {}

-- sort by counter is by flag -s as a second parameter to the profiler
-- e.g
--  lua ex24_7 tested_script.lua -s
local sort = arg[2] == "-s"

-- show folder names by flag -f as a third parameter to the profiler
-- e.g
--  lua ex24_7 tested_script.lua -s -f
local folder = arg[3] == "-f"

local function hook()
    local f = debug.getinfo(2, "f").func
    local count = Counters[f]

    if count == nil then -- first time 'f' is called?
        Counters[f] = 1
        Names[f] = debug.getinfo(2, "Sn")
    else
        Counters[f] = count + 1
    end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c")
f()
debug.sethook()

local function getname(func)
    local n = Names[func]
    if n.what == "C" then
        return n.name
    end

    local source = n.short_src

    if not folder then
        source = string.match(source, "/(.*)")
    end

    local lc = string.format("[%s]:%d", source, n.linedefined)
    if n.what ~= "main" and n.namewhat ~= "" then
        return string.format("%s (%s)", lc, n.name)
    else
        return lc
    end
end
print()
print("============================= Profiler data =============================")
if sort then
    local sorted = {}
    for func, count in pairs(Counters) do
        sorted[#sorted + 1] = {
            name = getname(func),
            count = count
        }
    end

    table.sort(sorted, function (a, b)
        return a.count > b.count
    end)

    for i=1, #sorted do
        print(sorted[i].name, sorted[i].count)
    end
else
    for func, count in pairs(Counters) do
        print(getname(func), count)
    end
end
print("=========================================================================")
