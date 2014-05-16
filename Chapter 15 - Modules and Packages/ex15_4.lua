--[[
--  Chapter 15, Exercise 4
--
--  What happens if you set a metatable for table package.preload
--  with an __index metamethod? Can this behavior be useful?
--
--  Solution:
--  That __index metamethod would be used when doing require as stated in
--      http://www.lua.org/manual/5.2/manual.html#pdf-require
--  Could be useful to track, which library was loaded where probabaly.
--]]

local mt = {
    __index = function ()
        print("Yay from metamethod __index")
    end
}
setmetatable(package.preload, mt)

require("foo")
