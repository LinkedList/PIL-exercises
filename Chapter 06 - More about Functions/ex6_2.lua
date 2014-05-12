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

function polynomial(coefficients)
	return function(value)
		local result = coefficients[1]

		if(#coefficients > 1 and value == nil) then
			return "Value must be provided"
		end

		for i=2,#coefficients do
			result = result + (coefficients[i] * (value^(i-1)))
		end
		return result
	end
end

f = polynomial({1, 0, 3})

print(f(0))
print(f(5))
print(f(10))
