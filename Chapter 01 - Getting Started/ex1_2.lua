--[[
-- Chapter 1, Exercise 2
--
-- Run the twice example, both by loading the file with the -l option and with dofile.
-- Which way do you prefer?
--
-- Solution:
-- run
-- 	$lua -l ex1_2
-- in terminal, or
-- 	dofile("ex1_2.lua")
-- from the lua interpreter
--]]
function norm(x, y)
	return (x^2 + y^2)^0.5
end
function twice(x)
	return 2*x
end
