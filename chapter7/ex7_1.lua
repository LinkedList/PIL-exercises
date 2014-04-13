--[[
--  Chapter 7, Exercise 1
--
--	Write an iterator fromto such that the next two loops become equivalent:
--
--		for i in fromto(n, m)
--			<body>
--		end
--
--		for i = n, m
--			<body>
--		end
--	Can you implement it as a stateless iterator?
--
--  Solution:
--]]

function fromto(from, to)
	local function iter(to, cur)
		cur  = cur + 1

		if cur <= to then
			return cur
		else
			return nil
		end
	end

	return iter, to, from-1
end

for i in fromto(1, 10) do
	print(i)
end
