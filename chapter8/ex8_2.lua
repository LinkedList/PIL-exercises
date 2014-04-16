--[[
--  Chapter 8, Exercise 2
--
--	Write a function multiload that generalizes loadwithprefix by receiving a list of readers, as in the following
--	example:
--		f = multiload("local x = 10", io.lines("temp", "*L"), " print(x)")
--	For the above example, multiload should load a chunk equivalent to the concatenation of the string
--	"local.. " with the contents of the temp file with the string "print(x)". Again, like function loadwithprefix
--	from the previous exercise, multiload should not actually concatenate anything.
--
--  Solution:
--]]

function multiload(...)
	local arguments = table.pack(...)
	local number_done = 0
	local max_done = arguments.n

	local function reader()
		while number_done <= max_done do
			number_done = number_done + 1
			if type(arguments[number_done]) == 'function' then
				local ret = arguments[number_done]()

				if ret ~= nil then
					number_done = number_done - 1
					return ret
				end

			else
				return arguments[number_done]
			end
		end
	end

	return load(reader)
end

f = multiload("local x = 10;", io.lines("./temp", "*L")," print(x)", " print(y)")
f()
