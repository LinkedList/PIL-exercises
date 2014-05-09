--[[
--  Chapter 11, Exercise 2
--
--	Repeat Exrecise 10.3 but, instead of using length as the criteria for ignoring a word, the program
--	should read from a text file a list of words to be ignored
--
--  Solution:
--]]

local disallowed_words = {}

for line in io.lines("./ex11_2.txt") do
	disallowed_words[line] = true
end

local function allwords()
	local auxwords = function (...)
		for line in io.lines() do
			for word in string.gmatch(line, "%w+") do
				coroutine.yield(word)
			end
		end
	end
	return coroutine.wrap(auxwords)
end

local counter = {}
for w in allwords() do
	if not disallowed_words[w] then
		counter[w] = (counter[w] or 0) + 1
	end
end

local words = {}
for w in pairs(counter) do
	words[#words + 1] = w
end

table.sort(words, function (w1, w2)
	return counter[w1] > counter[w2] or
		   counter[w1] == counter[w2] and w1 < w2
end)

for i = 1, (tonumber(arg[1]) or 10) do
	print(words[i], counter[words[i]])
end
