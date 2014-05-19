--[[
--  Chapter 19, Exercise 1
--
--  Write a function to test whether a given numbes is a power of two.
--
--  Solution:
--]]

function power2(num)
    return bit32.band(num, num - 1) == 0
end

print(2,power2(2))
print(4,power2(4))
print(8,power2(8))
print(1048576,power2(1048576))

print(400,power2(400))
print(153,power2(153))
