--[[
-- Chapter 1, Exercise 1
-- 
-- Run the factorial example. What happens to your program if you enter a negative number?
-- Modify the example to avoid this problem.
--
-- Solution:
-- Factorial cycles till infinity.
-- Added a while loop, that asks for a positive number
--]]

function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n-1) 
	end
end

a = -1
while a < 0 do
	print("enter a positive number:")
	a = io.read("*n")
end
print(fact(a))
