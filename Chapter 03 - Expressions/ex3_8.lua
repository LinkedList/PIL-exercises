--[[
--  Chapter 3, Exercise 8
--
--	Suppose that you want to create a table that associates each escape sequence for strings (see Section 2.4) with its meaning.
--	How could you write a contructor for that table?
--
--  Solution:
-]]

local escape_sequences = {
	["\a"] = "bell",
	["\b"] = "back space",
	["\f"] = "form feed",
	["\n"] = "newline",
	["\r"] = "carriage return",
	["\t"] = "horizontal tab",
	["\v"] = "vertical tab",
	["\\"] = "backslash",
	["\""] = "double quote",
	["\'"] = "single quote"
}

print(escape_sequences["\t"])
