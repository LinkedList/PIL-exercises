--[[
--  Chapter 21, Exercise 2
--
--  The patterns %D and [^%d] are equivalent. What about he patters [^%d%u] and [%D%U]
--
--  Solution:
--  They are not the same.
--]]

print(string.match("1234", "[^%d%u]")) --> nil
print(string.match("1234", "[%D%U]")) --> 1
