--[[
--  Chapter 7, Exercise 2
--
--	Add a step parameter to the iterator from the previous exercise.
--	Can you still implement it as a stateless iterator?
--
--  Solution:
--]]

function fromto(from, to, step)
	local function iter(to, cur)
		cur  = cur + step

		if cur <= to then
			return cur
		else
			return nil
		end
	end

	return iter, to, from-step
end

for i in fromto(0, 30, 2) do
	print(i)
end
