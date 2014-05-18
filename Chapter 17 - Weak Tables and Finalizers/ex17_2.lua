--[[
--  Chapter 17, Exercise 2
--
--  Consider the first example of Section 17.6, which creates a table with a finalizer that only prints a message
--  when activated. What happens if the program ends without a collection cycle? What happens if the program calls
--  os.exit? What happens if the program ends with some error?
--
--  Solution:
--]]

local object = {}
setmetatable(object, {__gc = function (o)
    print("Finalizing object: ", o)
end})

object = nil

-- > if this is all in the script the object is collected

--error("Forced error") --> object is collected after error()

os.exit() --> object is not collected
