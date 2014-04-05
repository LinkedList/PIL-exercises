--[[
--  Chapter 4, Exercise 6
--
--	Assuming that a goto could jump out of a function, explain what the program
--	in Listing 4.3 would do. (Try to reason about the label using the same scoping rules
--	used for local variables.)
--
--  Solution:
--  Function f prints its argument and returns itself with a one less argument.
--  After the argument is equal to zero it returns
--  a result of function getlabel() -> which returns an anonymous function that
--  only goes to L1. This way the call x() could return zero.
--]]

function getlabel()
	return function () goto L1 end
	::L1::
	return 0
end

function f (n)
	if n == 0  then return getlabel()
	else
		local res = f(n-1)
		print(n)
		return res
	end
end

x = f(10)
x()
