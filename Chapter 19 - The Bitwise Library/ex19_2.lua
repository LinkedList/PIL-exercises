--[[
--  Chapter 19, Exercise 2
--
--  Write a function to compute the Hamming weight of a given integer.
--  (The Hamming weight of a number is the number of ones in
--  its binary representation.)
--
--  Solution:
--]]

function hamming(number)
   local hamm = 0

   for i=0, 31 do
       hamm = hamm + bit32.extract(number, i)
   end
   return hamm
end

print(hamming(4))
print(hamming(1))
print(hamming(3))
print(hamming(15))
