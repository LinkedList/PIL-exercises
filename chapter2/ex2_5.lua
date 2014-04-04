--[=[
--  Chapter 2, Exercise 5
--
--  Suppose you need to format a long sequence of arbitrary bytes as a string literal in Lua.
--  How would you do it? Consider issues like readability, maxiumim line length, and performance.
--
--  Solution:
--  We can use the escape sequence \z, which ignores any whitespace after it in a string.
--  (taken from http://www.lua.org/manual/5.2/manual.html#3.1)
--
--  Or a string library function concat.
-]=]

local sequence = "0101010111111010101010101010110101010110\z
                  010011110111010111110110111111111101011110"
print(sequence)

local sequence_table = {
  "0101010111111010101010101010110101010110",
  "0100111101110101111101101111111111010110"
}

print(table.concat(sequence_table));
