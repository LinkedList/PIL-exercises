--[[
--  Chapter 7, Exercise 4
--
--	Write an iterator that returns all non-empty substrings of a given string.
--	(You will need the string.sub function)
--
--  Solution:
--]]

function substrings(string)
	local sub_length = 1
	local pos = 1

	function iter()
		if pos + sub_length - 1 > #string then
			sub_length = sub_length + 1
			pos = 1
		end

		if sub_length > #string then
			return nil
		end

		local substring = string.sub(string, pos, pos + sub_length - 1)

		pos = pos + 1
		return substring
	end

	return iter
end

for str in substrings("banana") do
	print(str)
end
