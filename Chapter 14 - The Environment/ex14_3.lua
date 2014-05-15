--[[
--  Chapter 14, Exercise 3
--
--  Explain in detail what happens in the following program and what it output is.
--
--  Solution:
--]]

-- local print
local print = print
function foo(_ENV, a)
    -- foo(_ENV, a) is the same as making local _ENV = _ENV
    -- thus whatever is passed to foo as first parameter will
    -- be considered _ENV

    --print is local, so no problem
    --a is local and b is looked up in _ENV
    print(a + b)
end

-- _ENV in foo will be equal to {b=14}
foo({b = 14}, 12) --> 26
-- _ENV in foo will be equal to {b=10}
foo({b = 10}, 1) --> 11
