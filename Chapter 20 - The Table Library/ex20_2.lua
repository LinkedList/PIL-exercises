--[[
--  Chapter 20, Exercise 2
--
--  A problem with table.sort is that the sort is not stable, that is, elements that
--  the comparison function considers equal may not keep their original order in the array
--  after the sort. How can you do a stable sort in Lua?
--
--  Solution:
--  I got lazy and implemented a bubble sort, which is stable, but not really effective
--]]

function stablesort(list, func)
    local function swap(j, k)
        list[j], list[k] = list[k], list[j]
    end

    repeat
        local swapped = false
        for i=1,#list - 1 do
            if func == nil and list[i] > list[i+1] then
                swap(i + 1, i)
                swapped = true
            elseif func ~= nil and func(list[i+1], list[i]) then
                    swap(i+1, i)
                    swapped = true
            end
        end
    until not swapped
end

--test table that will be sorted only by str field
t = {{str = "b", int = 1}, {str = "b", int = 2}, {str = "a", int = 3}}

stablesort(t, function (a, b)
    return a.str < b.str
end)

for _, v in pairs(t) do
    io.write(v.str, " ", v.int, ";")
end
