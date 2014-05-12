--[[
--  Chapter 2, Exercise 1
--
--  What is the value of the expression type(nil)==nil?
--  (You can use Lua to check your answer.) Can you explain this result?
--
--  Solution:
--  false, because type() always returns string
--]]
print(type(nil)==nil)
print(type(nil)=="nil")
