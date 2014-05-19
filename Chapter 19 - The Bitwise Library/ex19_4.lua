--[[
--  Chapter 19, Exercise 4
--
--  Define the shift operations and the bitwise not using the arithmetic operators
--  in Lua.
--
--  Solution:
--]]

function lshift(number, pow)
   return number * 2 ^ pow
end

function rshift(number, pow)
   return number / 2 ^ pow
end

function bnot(number)
   return 2^32 - number - 1
end

print(bit32.lshift(156, 2) == lshift(156, 2))
print(bit32.rshift(156, 2) == rshift(156, 2))
print(bit32.bnot(156) == bnot(156))
