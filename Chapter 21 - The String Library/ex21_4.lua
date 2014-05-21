--[[
--  Chapter 21, Exercise 4
--
--  Write a function to reverse a UTF-8 string.
--
--  Solution:
--]]

function reverseutf8(str)
    local arr = {}
    for c in string.gmatch(str, ".[\128-\191]*") do
        arr[#arr + 1] = c
    end

    local return_arr = {}
    for i = #arr, 1, -1 do
        return_arr[#return_arr + 1] = arr[i]
    end

    return table.concat(return_arr)
end

print(reverseutf8("Hei siellä"))
