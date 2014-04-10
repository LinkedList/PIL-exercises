--[[
--  Chapter 6, Exercise 1
--
--	Write a function integral that receives a function f and returns an approximation of its integral.
--
--  Solution:
--]]

function integral(f, a, b, d)
	local d = d or 1e-4
	local result = 0

	for i=a, b, d do
		result = result + f(i) * d
	end

	return result
end


function x_2(x)
	return x^2
end

print(integral(x_2, 0, 5))
