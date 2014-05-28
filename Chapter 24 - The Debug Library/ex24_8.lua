--  Chapter 24, Exercise 7
--
--  Write a library for breakpoints. It should offer at least two functions:
--      setbreakpoint(function, line) -->returns handle
--      removebreakpoint(handle)
--  A breakpoint is specified by a function and a line inside that function. When
--  the program hits a breakpoint, the library should call debug.debug. (Hint: for a
--  basic implementation, use a line hook, that checks whether it is in a breakpoint;
--  to improve performance, use a call hook, to trace the program execution and only
--  turn the line hook when the program is running the target function.)
--
--  Solution:
--]]
local breakpoints = {}

function setbreakpoint(func, line)
    local f = breakpoints[func]

    if f == nil then
        breakpoints[func] = {}
    end

    local count = #breakpoints[func]
    breakpoints[func][count + 1] = line
    return {func = func, line = line}
end

function removebreakpoint(handle)
    local f = breakpoints[handle.func]

    if f ~= nil then
        for i=1,#f do
            if handle.line == f[i] then
                table.remove(breakpoints[handle.func], i)
                break
            end
        end
    end
end

function debugbreak (event, line)
    local s = debug.getinfo(2)
    local func = s.func

    local f = breakpoints[func]

    if f ~= nil and #f > 0 then
        for i=1,#f do
            if f[i] == s.currentline then
                debug.debug()
            end
        end
    end
end

debug.sethook(debugbreak, "l")


function test()
    print("Line number 1 in test()")
    print("Last line in test()")
end

handle = setbreakpoint(test, 61)
test()
