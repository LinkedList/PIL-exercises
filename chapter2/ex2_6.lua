--[[
--  Chapter 2, Exercise 6
--
--  Assume the following code:
--  a = {}; a.a = a
--
--  What would be the value of a.a.a.a? Is any a in that sequence somehow different from the others?
--  Now, add the next line to the previous code:
--  a.a.a.a = 3
--
--  What would be the value of a.a.a.a now?
--
--  Solution:
--  Every a in the first case is the same table.
--  After a.a.a.a = 3, the a key in the table a is equal to 3.
--  So there is no a.a.a, as a.a is not a table
-]]
local a = {}
a.a = a

print(a.a.a.a)
print(a.a.a)
print(a.a.a.a == a.a.a) --> true

a.a.a.a = 3

-- print(a.a.a.a) --> attempt to index field 'a' (a number value)
print(a.a)
print(a)
