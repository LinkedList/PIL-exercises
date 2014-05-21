--[[
--  Chapter 21, Exercise 5
--
--  Rewrite the transliterate function for UTF-8 characters.
--
--  Solution:
--]]

function transliterate(str, tab)
    return_str = string.gsub(str, ".[\128-\191]*", function (char)
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

print(transliterate("력사 역노", {
    [" "] = false,
    ["력"] = false,
    ["사"] = "A",
    ["역"] = "B",
    ["노"] = "C"
}))
