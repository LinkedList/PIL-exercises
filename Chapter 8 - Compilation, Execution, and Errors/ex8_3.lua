--[[
--  Chapter 8, Exercise 3
--
--	Function stringrep, in Listing 8.2, uses a binary multiplication algorithm to concatenate n copies
--	of a given string s. For any fixed n, we can create a specialized version of stringrep by unrolling
--	the loop into a sequence of instructions r=r..s and s=s..s. As an example, for n=5 the unrolling
--	gives us the following function:
--
--		function stringrep_5 (s)
--			local r = ""
--			r = r..s
--			s = s..s
--			s = s..s
--			r = r..s
--			return r
--		end
--
--	Write a function that, given n, returns a specialized function stringrep_n. Instead of using a closure,
--	your function should build the text of a Lua function with the proper sequence of instructions (r=r..s and
--	s=s..s) and then use load to produce the final function. Compare the performance of the generic function
--	stringrep (or of a closure using it) with your tailor-made functions.
--
--  Solution:
--]]

function build_stringrep_n(n)
	local strings = {
		"function stringrep_"..n.."(s) ",
		"local r = '';",
	}
	if n > 0 then
		while n > 1 do
			if n % 2 ~= 0 then
				strings[#strings + 1] = "r = r .. s;"
			end
			strings[#strings + 1] = "s = s .. s;"
			n = math.floor(n / 2)
		end
		strings[#strings + 1] = "r = r .. s;"
	end

	strings[#strings + 1] = "return r;"
	strings[#strings + 1] = "end"

	local line = 0
	local function reader()
		line = line + 1
		return strings[line]
	end
	return load(reader)
end

print("Testing stringrep_n:")
build_stringrep_n(10)()
print(stringrep_10("ab"))

build_stringrep_n(5)()
print(stringrep_5("a"))

-- Listint 8.2 function stringrep
function stringrep(s, n)
	local r = ""
	if n > 0 then
		while n > 1 do
			if n % 2 ~= 0 then r = r .. s end
			s = s .. s
			n = math.floor(n / 2)
		end
		r = r .. s
	end
	return r
end

print("Performance test:")
print("stringrep 500000x")

local start_time = os.time()
for i = 1, 500000 do
	stringrep("abcdef", 10000)
end
local end_time = os.time()
print("stirngrep: " .. end_time - start_time .. "s")

print("stringrep_n 500000x")
build_stringrep_n(10000)()

local start_time = os.time()
for i = 1, 500000 do
	stringrep_10000("abcdef")
end
local end_time = os.time()
print("stirngrep_n: " .. end_time - start_time .. "s")
