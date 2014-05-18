--[[
--  Chapter 17, Exercise 3
--
--  Consider that you have to implement a memorizing table for a function from strings to strings.
--  Doing the table weak will not allow the removal of entries, because weak tables do not consider strings as
--  collectable objects. How can you implement memorization in that case?
--
--  Solution:
--  Using another table with object keys as a indicator, when to set a key in strings table to nil (and therefore
--  be collected)
--]]

local strings = {}
local keys = {}

setmetatable(keys, {
    __mode = "kv",
})

function mem_string_set(k, v)
    local res = strings[k]
    if res == nil then
        strings[k] = v
        local key = {string = k}
        setmetatable(key, {
            __gc = function (o)
                strings[o.string] = nil
            end
        } )
        keys[key] = {}
    end
end

function mem_string_get(k)
    return strings[k]
end

mem_string_set("string1", "string1")
mem_string_set("string2", "string2")
print("Trying to get string1:",mem_string_get("string1"))

print()
print("Collecting garbage")
collectgarbage()
print()
print("Trying to get string1:",mem_string_get("string1"))
print("Trying to get string2:",mem_string_get("string2"))
print()

print("Strings table pairs:")
for k,v in pairs(strings) do
   print(k, v)
end
print()

print("Keys table pairs")
for k,v in pairs(keys) do
   print(k, v)
end
