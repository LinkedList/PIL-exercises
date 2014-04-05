--[[
--  Chapter 4, Exercise 5
--
--	Can you explain why Lua has the restriction that a goto cannot
--	jump out of a function? (Hint: how would you implement that feature?)
--
--  Solution:
--  Goto would have to somehow save the state of the program, and then possibly reload it.
--  e.g. if the jump would be into a function, where would the program go after the return
--  statement?
--]]
