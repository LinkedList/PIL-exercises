--[[
--  Chapter 11, Exercise 1
--
--  Modify the queue implementation so that both indices return to zero when the queue is empty.
--
--  Solution:
--]]

List = {}

function List.new()
	return {first = 0, last = 0}
end

function List.pushfirst(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

function List.pushlast(list, value)
	local last = list.last
	list[last] = value
	list.last = last + 1
end

function List:checkEmpty(list)
	if list.first == list.last then
		list.first = 0
		list.last = 0
	end
end

function List.popfirst(list)
	if list.first == list.last then error("list is empty") end

	local value = list[list.first]
	list[list.first] = nil
	list.first = list.first + 1

	List:checkEmpty(list)

	return value
end

function List.poplast(list)
	if list.first == list.last then error("list is empty") end

	local value = list[list.last-1]
	list[list.last-1] = nil
	list.last = list.last - 1

	List:checkEmpty(list)

	return value
end

list = List.new()

List.pushlast(list, "Hey")
List.pushlast(list, "Ho")
List.pushfirst(list, "Hay")

print("first pop: ", List.popfirst(list))
print("second pop: ", List.popfirst(list))
print("third pop: ", List.poplast(list))
