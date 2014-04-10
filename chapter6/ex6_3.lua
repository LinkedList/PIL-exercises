--[[
--  Chapter 6, Exercise 2
--
--	Exercise 3.3 asked you to write a function that receives a polynomial (represented as a table)
--	and a value for its vaiable, and returns the polynomial value. Write the curried
--	version of that function. Your function should receive a polynomial and returns a function that,
--	when called with a value for x, returns the value of the polynomial for that x.
--
--  Solution:
--]]
local n = 1
function f ()
	print("Step ".. n)
	n = n + 1
	return ';'
end
--[===[
-- as per lua5.2 manual:
-- load (ld [, source [, mode [, env]]])
-- Loads a chunk.
-- If ld is a string, the chunk is this string. If ld is a function, load calls it repeatedly to get the chunk pieces. Each call to ld must return a string that concatenates with previous results.
--
-- this call cycles till infinity, need to terminate it by ctrl-c
--]===]
load(f)()
