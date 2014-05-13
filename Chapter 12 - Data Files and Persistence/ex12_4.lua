--[[
--  Chapter 12, Exercise 4
--
--  Modify the code of the previous exercise so that is uses the constructor syntax
--  for lists whenever possible. For instance, it should serialize the table {14, 15, 19}
--  as {14, 15 ,19}, not as {[1] = 14, [2] = 15, [3] = 19}. (Hint: start by saving the values
--  of keys 1,2,..., as long as they aro not nil. Take care not to save them again when
--  traversing the rest of the table.)
--
--  Solution:
--]]

function serialize(o, tab)
    local tab = tab or 0
    local saved_keys = {}
    local last_saved_key = nil
    local last_number_key = 0
    if type(o)  == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then

        if o[1] ~= nil then
            io.write("{")
        else
            io.write("{\n")
        end
        for i=1, math.huge do
            if o[i] ~= nil then
                serialize(o[i]); io.write(", ")
                saved_keys[i] = true
                last_saved_key = i
            else
                last_number_key = i - 1
                break
            end
        end

        for k, v in pairs(o) do
            if saved_keys[k] then
                goto next
            end

            for i=1, tab do
                io.write("\t")
            end
            if string.match(k, "^[%a_][%d%a_]*$") then
                if last_saved_key == last_number_key then io.write("\n") end
                io.write(" ", k, " = ")
            else
                io.write(" ["); serialize(k); io.write("] = ")
            end
            last_saved_key = k
            serialize(v, tab + 1)
            io.write(",\n")
            ::next::
        end

        if last_saved_key ~= last_number_key then
            for i=1, tab do
                io.write("\t")
            end
        end

        io.write("}")
    else
        error("cannot serialize a " .. type(o))
    end
end

local table = {"a", "b",
    a = 1,
    b = 2,
    c = {
        d = "string",
        e = "another string",
        f = {
            1, 2, 3, 4
        },
        ["9 to 5"] = "string"
    }
}

serialize(table)
