--[[
--  Chapter 21, Exercise 3
--
--  Write a transliterate function. This function receives a string and replaces each character
--  in that string by another character, according to a table given as a second argument.
--  If the table maps 'a' to 'b', the function should replace any occurrence of 'a' by 'b'.
--  If the table maps 'a' to false, the function should remove occurrences of 'a' from the resulting string.
--
--  Solution:
--]]

function transliterate(str, tab)
    return_str = string.gsub(str, ".", function (char)
        local val = tab[char]
        if val == nil then return char end

        if val then
            return val
        else
            return ""
        end
    end)

    return return_str
end

print(transliterate("READY! STEADY! GO!", {
    ["!"] = false,
    ["E"] = "e",
    ["A"] = "a",
    ["D"] = "d",
    ["Y"] = "y",
    ["T"] = "t",
    ["O"] = "o"
}))
