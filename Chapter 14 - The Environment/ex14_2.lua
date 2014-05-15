--[[
--  Chapter 14, Exercise 2
--
--  Explain in detail what happens in the following program and what it output is.
--
--  Solution:
--]]

-- local variable foo
local foo
-- new chunk
do
    -- new _ENV that is equal to global _ENV
    local _ENV = _ENV
    -- foo now equals to function that prints X from _ENV
    function foo () print(X) end
end

-- set global _ENV["X"] = 13
X = 13
-- _ENV = nil, no global variables from here
_ENV = nil
-- calls local foo
-- foo has _ENV instantiated, so no problem there, prints 13
foo()

--trying to set _ENV["X"], but _ENV is nil so error
X = 0
