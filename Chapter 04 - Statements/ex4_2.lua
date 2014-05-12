--[[
--  Chapter 4, Exercise 2
--
--	Describe four different ways to write an unconditional loop in Lua.
--	Which one do you prefer?
--
--  Solution:
--]]

-- using while
local i = 1
while true do
	print(i)
	i = i + 1
end

-- using repeat
local i = 1
repeat
	print(i)
	i = i + 1
until false

-- using goto
local i = 1
::infinite::
print(i)
i = i + 1
goto infinite

-- using recursion
local i = 1
function infinite_recursion()
	print(i)
	i = i + 1
	return infinite_recursion()
end

infinite_recursion()
