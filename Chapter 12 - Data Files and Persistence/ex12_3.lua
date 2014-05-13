--[[
--  Chapter 12, Exercise 3
--
--  Modify the code of the previous exercise so that is uses the syntax
--  ["key"]=value only when necessary (that is, when the key is a string but
--  not a valid identifier).
--
--  Solution:
--]]

function serialize(o, tab)
    local tab = tab or 0
    if type(o)  == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            for i=1, tab do
                io.write("\t")
            end
            if string.match(k, "^[%a_][%d%a_]*$") then
                io.write(" ", k, " = ")
            else
                io.write(" ["); serialize(k); io.write("] = ")
            end
            serialize(v, tab + 1)
            io.write(", \n")
        end
            for i=1, tab do
                io.write("\t")
            end
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

local table = {
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
