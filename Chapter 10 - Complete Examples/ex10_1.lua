--[[
--  Chapter 10, Exercise 1
--
--	Modify the eight-queen program so that is stops after printing the firts solution.
--
--  Solution:
--]]

local N = 8

-- check whether positon (n, c) is free from attacks
local function isplaceok(a, n, c)
	for i=1,n-1 do
		if (a[i] == c) or
		   (a[i] - i == c - n) or
		   (a[i] + i == c + n) then
		   return false
	   end
	end
	return true
end

local function printsolution(a)
	for i=1,N do
		for j=1,N do
			io.write(a[i] == j and "X" or "-", " ")
		end
		io.write("\n")
	end
	io.write("\n")
end

local printed = false
local function addqueen(a, n)
	if printed then return end

	if n > N then
		printsolution(a)
		printed = true
	else
		for c=1,N do
			if isplaceok(a, n, c) then
				a[n] = c
				addqueen(a, n + 1)
			end
		end
	end
end

addqueen({}, 1)
