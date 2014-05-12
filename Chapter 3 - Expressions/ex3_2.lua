--[[
--  Chapter 3, Exercise 2
--
--	What is the result of the expression 2^3^4? What about 2^-3^4?
--
--  Solution:
--  ^ is right associative, so
--  2^3^4 is interpreted as 2^(3^4) and
--	2^-3^4 as 2^(-3^4)
-]]

print(2^3^4)
print(2^-3^4)

print(2^3^4 == 2^(3^4)) --> true
print(2^-3^4 == 2^(-3^4)) --> true
