--[[
--  Chapter 3, Exercise 5
--
--	How can you check whether a value is a boolean without the type function?
--
--  Solution:
--  As stated on page 22, part 3.2: If the values have different types, Lua considers them not equal.
--	The solution is therefore e.g. function isBoolean
--]]

function isBoolean(value)
	return value == false or value == true
end

print(isBoolean(true))
print(isBoolean(false))
print(isBoolean("string"))
print(isBoolean(12))
print(isBoolean({a = 1, b = "string"}))
