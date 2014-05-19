--[[
--  Chapter 19, Exercise 3
--
--  Write a function to test whether the binary representation of a number is a palindrome.
--
--  Solution:
--]]

function palindrome(number)
   local i = 32

   while number == bit32.extract(number, 0, i) do
      i = i - 1
   end

   local up = i
   local down = 0
   local result = true
   while up > down do
      if bit32.extract(number, up) ~= bit32.extract(number, down) then
         result = false
         break
      end
      up = up - 1
      down = down + 1
   end
   return result
end

print(palindrome(15)) --> true
print(palindrome(16)) --> false
