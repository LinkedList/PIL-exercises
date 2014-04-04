--[[
--  Chapter 3, Exercise 3
--
--	We can represent a polynomial a_n x^n + a_n-1 x^(n-1) + ... a_1 x^1 + a_0 in
--	Lua as a list of its coefficients, sucha as {a0, a1, ... , an}.
--	Write a function that receives a polynomial (represented as a table) and a
--	value for x and returns the polynomial value.
--
--  Solution:
-]]

--[[
--	coefficients is a table, that starts with a_0 and goes to a_n
--	value is a value for x
--]]
function polynomial(coefficients, value)
	local result = coefficients[1]

	if(#coefficients > 1 and value == nil) then
		return "Value must be provided"
	end

	for i=2,#coefficients do
		result = result + (coefficients[i] * (value^(i-1)))
	end
	return result
end

print(polynomial({1})) --> only one coefficient
print(polynomial({1,1}, 1)) --> x + 1
print(polynomial({1,1})) --> x + 1
print(polynomial({1,2,3}, 50)) --> 3x^2 + 2x + 1 where x = 50
