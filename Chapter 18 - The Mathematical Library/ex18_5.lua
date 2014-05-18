--[[
--  Chapter 18, Exercise 5
--
--  Write a function to shuffle a given list. Make sure that all permutations are equally probable.
--
--  Solution:
--]]
math.randomseed(os.time())

function shuffle(list)
    local copy = {}

    for i = 1, #list do
        copy[i] = list[i]
    end

    local shuffled_list = {}

    while #copy > 0 do
        local i = math.random(#copy)

        shuffled_list[#shuffled_list + 1] = copy[i]

        table.remove(copy, i)
    end

    return shuffled_list
end

l = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

s = shuffle(l)

for _,val in pairs(s) do
    io.write(val, ", ")
end
