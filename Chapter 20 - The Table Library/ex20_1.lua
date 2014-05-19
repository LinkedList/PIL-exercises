--[[
--  Chapter 20, Exercise 1
--
--  Rewrite function rconcat so that it can get a separator, just like table.concat does
--
--  Solution:
--]]
local pprint = require("pprint")
function rconcat(list, sep)
    if type(list) ~= "table" then return list end
    local res = {}

    for i = 1, #list do
        if type(list[i]) == "table" and #list[i] == 0 then
            goto cont
        end
        res[#res + 1] = rconcat(list[i], sep)
        ::cont::
    end
    return table.concat(res, sep)
end

print(rconcat({{{"a", "b"}, {"c"}}, "d", {}, {"e"}}, ";"))
