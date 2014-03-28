--[[
-- Chapter 2, Exercise 2
--
-- Which of the following are valid numerals? What are their values?
-- .0e12, .e12, 0.0e, 0x12, 0xABFG, 0xA, FFFF, 0xFFFFFFF, 0x, 0x1P10
--  0.1e1, 0x0.1p1
-- Solution:
-- this script prints only the valid numerals
--]]
print(.0e12) --> 0
--print(.e12)
--print(0.0e)
print(0x12) --> 18
--print(0xABFG)
print(0xA) --> 10
--print(FFFF) --> nil, is not a numeral, could be a identifier
print(0xFFFFFFF) --> 268435455
--print(0x)
print(0x1P10) --> 1024
print(0.1e1) --> 1
print(0x0.1p1) --> 0.125
