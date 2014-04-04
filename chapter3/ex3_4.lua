--[[
--  Chapter 3, Exercise 4
--
--	Can you write the function from the previous item so that is uses at most n additions
--	and n multiplications (and no exponentiations)?
--
--  Solution:
-]]

--[[
--	coefficients is a table, that starts with a_0 and goes to a_n
--	value is a value for x
--]]
function nMostPolynomial(coefficients, value)
	local result = coefficients[1]

	if(#coefficients > 1 and value == nil) then
		return "Value must be provided"
	end
	local current = value
	for i=2,#coefficients do
		result = result + (current * coefficients[i])
		if(i ~= #coefficients) then -- if i == #coefficients, then don't multiply current, as it won't be used anymore
			current = current * value
		end
	end
	return result
end

print(nMostPolynomial({1})) --> only one coefficient
print(nMostPolynomial({1,1}, 1)) --> x + 1
print(nMostPolynomial({1,1})) --> x + 1
print(nMostPolynomial({1,2,3}, 50)) --> 3x^2 + 2x + 1 where x = 50

