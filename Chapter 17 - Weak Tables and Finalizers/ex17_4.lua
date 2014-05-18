--[[
--  Chapter 17, Exercise 4
--
--  Explain the output of the following program:
--
--  Solution:
--]]

local count = 0

local mt = {__gc = function ()
    count = count - 1
end}

local a = {}

for i = 1, 10000 do
    count = count + 1
    a[i] = setmetatable({}, mt)
end

collectgarbage()
-- collectgarbage"count" shows total memory in usage by lua, count shows how many tables are there in a
-- after the first collectgarbage() nothing happens, because a is still accessible
print(collectgarbage"count" * 1024, count)

a = nil
collectgarbage()
-- after the second collectgarbage() count is 0 because every table in a had called it's finalizer that
-- reduced count by one
-- but as stated in Section 17.6:
--
--  Because of resurrection, objects with finalizers are collected in two phases.
--  The first time the collector detect that an object wih a finalizer in not reachable,
--  the collector resurrects the object and queues it to be finalized. Once its finalizer runs, Lua
--  marks the object as finalized. The next time the collector detects that the object is not reachable,
--  it deletes the object. If you want to ensure that all garbage in your program has been actually
--  released, you must call collectgarbage twice; the second call will delete the objects that were
--  finalized during the first call.
--
-- objects are only marked as finalized, we must call collectgarbage for a second time for them
-- to be actually deleted
print(collectgarbage"count" * 1024, count)

collectgarbage()
--second collectgarbage deletes finalized objects and releases memory
print(collectgarbage"count" * 1024, count)
