--[[
--  Chapter 21, Exercise 1
--
--  Write a split function that receives a string and a delimiter pattern and
--  returns a sequence with the chunks in the original string separated by the
--  delimiter:
--      t = split("a whole new world", " ")
--      -- t = {"a", "whole", "new", "world"}
--  How does your function handle empty strings? (In particular, is an empty
--  string an empty sequence or a sequence with one empty string?)
--
--  Solution:
--]]

function split(str, del)
    if #str == 0 or #del == 0 then
        error("Length of string or delimiter must be greater than 0")
    end

    local res = {}
    local str = str .. del
    local find = nil

    repeat
        first, last = string.find(str, del)
        if first ~= nil then
            find = true
            res[#res + 1] = string.sub(str, 1, first - 1)
            str = string.sub(str, last + 1)
        else
            find = nil
        end
    until find == nil
    return res
end


s = split("what a world this is", " ")

for _,val in pairs(s) do
    print(val)
end
