--[[
--  Chapter 5, Exercise 3
--
--	Write a function that reveives an arbitrary number of values and
--	returns all of them, except the first one.
--
--  Solution:
--]]

function allButOne(first, ...)
	return ...
end

print(allButOne("a", "b", "c", "d", "e", nil, "f"))
