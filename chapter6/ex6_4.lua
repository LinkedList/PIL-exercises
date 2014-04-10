--[[
--  Chapter 6, Exercise 4
--
--	As we have seen, a tail call is a goto in disguise. Using this idea, reimplement
--	the simple maze game from Section 4.4 using tail calls. Each block should become a new function,
--	and each goto becomes a tail call.
--
--  Solution:
--]]

function room1()
	local move = io.read()
	local f
	if move == "south" then f = room3
	elseif move == "east" then f = room2
	else
		print("invalid move")
		f = room1
	end

	return f()
end

function room2()
	local move = io.read()
	local f
	if move == "south" then f = room4
	elseif move == "west" then f = room1
	else
		print("invalid move")
		f = room2
	end

	return f()
end

function room3()
	local move = io.read()
	local f
	if move == "north" then f = room1
	elseif move == "east" then f = room4
	else
		print("invalid move")
		f = room3
	end

	return f()
end

function room4()
	print("Congratulations, you won!")
end

room1() -- initial room
