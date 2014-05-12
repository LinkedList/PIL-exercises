--[[
--  Chapter 5, Exercise 2
--
--	Write a function that reveives an array and prints all elements in that array.
--	Consider the pros and cons of using table.unpack in this function.
--
--  Solution:
--  table.unpack takes only a proper sequence - wihtout nils.
--  elements funcion considers every element.
--]]

function elements(arr)
	for i, elem in pairs(arr) do
		print(elem)
	end
end

print(elements{"a", "b", "c", "d", "e", nil, "f"})
print(table.unpack{"a", "b", "c", "d", "e", nil, "f"})

print(elements{[1] = "a", [2] = nil, [3] = "b"})
print(table.unpack{[1] = "a", [2] = nil, [3] = "b"})
