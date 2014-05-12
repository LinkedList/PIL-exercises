--[[
--  Chapter 5, Exercise 1
--
--	Write a function that receives an arbitrary number of strings and returns 
--	all of them concatenated together.
--
--  Solution:
--]]

function concatenatedStrings(...)
	local result = ""
	for i, str in pairs{...} do
		result = result .. str
	end
	return result
end

print(concatenatedStrings("a", "b", "c", "d", "e"))
