--[[
--  Chapter 16, Exercise 1
--
--  Implement a class Stack, with methods push, pop, top, and isempty
--
--  Solution:
--]]

Stack = {}

function Stack:new()
   o = {arr = {}}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Stack:push(o)
    self.arr[#self.arr + 1] = o
end

function Stack:pop()
    local o = self.arr[#self.arr]
    self.arr[#self.arr] = nil
    return o
end

function Stack:top()
    return self.arr[#self.arr]
end

function Stack:isempty()
    return #self.arr == 0
end

s = Stack:new()
s:push("c")
s:push("b")
s:push("a")

print(s:pop())
print(s:isempty())
print(s:top())
print(s:pop())
print(s:pop())
print(s:isempty())
