--[[
--  Chapter 16, Exercise 2
--
--  Implement a class StackQueue as a subclass of Stack. Besides the inherited methods,
--  add to this class a method insertbottom, which inserts an element at the bottom of the stack.
--  (This method allows us to use objects of this class as queues.)
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

StackQueue = Stack:new()

function StackQueue:insertbottom(o)
   -- super slow insert
   for i=#self.arr + 1,2,-1 do
      self.arr[i] = self.arr[i - 1]
   end
   self.arr[1] = o
end

q = StackQueue:new()
q:push("c")
q:push("b")
q:push("a")
q:insertbottom("d")

print(q:pop())
print(q:pop())
print(q:pop())
print(q:pop())
