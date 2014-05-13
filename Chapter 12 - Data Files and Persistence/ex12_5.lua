--[[
--  Chapter 12, Exercise 5
--
--  The approach of avoiding constructors when saving tables with cycles is too radical.
--  It is possible to save the table in a more pleasant format using contructors for the
--  general case, and to use assignments later only to fix sharing and loops.
--  Reimplement function save using this approach. Add to it all the goodies that you have
--  implemented in the previous exercises (indentation, record syntax, and list syntax).
--
--  Solution:
--]]

function save(o, name, tab, saved)
    local saved = saved or {}
    local tab = tab or 1

    local function basicSerialize(o)
        if type(o)  == "number" then
            return tostring(o)
        else -- assume it is a string
            return string.format("%q", o)
        end
    end

    local function arr_len(o)
        local arr = {}
        for i=1, math.huge do
            if o[i] ~= nil then
                arr[i] = true
            else
                break
            end
        end
        return #arr
    end

    local function arr_keys(o)
        local arr = {}
        for i=1, math.huge do
            if o[i] ~= nil then
               arr[i] = true
            else
                break
            end
        end
        return arr
    end

    local function all_keys(o)
        local length = 0
        for k, v in pairs(o) do
            length = length + 1
        end
        return length
    end

    local function only_arr(o)
        local length = arr_len(o)
        local number_of_keys = 0
        for k, v in pairs(o) do
            number_of_keys = number_of_keys + 1
        end
        return length == number_of_keys
    end

    local function identifier(i)
        return string.match(i, "^[%a_][%d%a_]*$") ~= nil
    end

    local function already_saved(o)
        return saved[o] ~= nil
    end

    local function is_table(o)
        return type(o) == "table"
    end

    local function write_saved(string)
        io.write("--"..string.."--")
    end

    local function write_tabs()
        for i=1,tab do
            io.write("   ")
        end
    end

    if type(o) == "number" or type(o) == "string" then
        io.write(basicSerialize(o))
    elseif type(o) == "table" then
        saved[o] = name
        local arr = o[1] ~= nil
        io.write(name .. ":")
        if arr then
            io.write("{")
        else
            io.write("{\n")
        end

        if arr then
            for i=1,arr_len(o) do
                if is_table(o[i]) and already_saved(o[i]) then
                    write_saved(saved[o[i]])
                else
                    if is_table(o[i]) then saved[o[i]] = name .. "["..i.."]" end
                    save(o[i], name .. "["..i.."]", tab, saved)
                end
                if i ~= arr_len(o) then
                    io.write(", ")
                end
            end
        end

        if only_arr(o) then
            io.write("}")
        else
            io.write(",\n")
            local done = arr_len(o)
            for k,v in pairs(o) do
                if arr_keys(o)[k] then goto continue end
                write_tabs()
                if identifier(k) then
                    io.write(k)
                else
                    io.write("[",basicSerialize(k),"]")
                end
                io.write(" = ")

                if already_saved(v) and is_table(v) then
                    write_saved(saved[v])
                else
                    if is_table(v) then saved[v] = name .. "["..k.."]" end
                    save(v, name .. "["..k.."]", tab + 1, saved)
                end

                done = done + 1
                if done ~= all_keys(o) then
                    io.write(",\n")
                end
                ::continue::
            end
            io.write("}")
        end
    else
        error("cannot save a " .. type(value))
    end
end

a = {x=1, y=2; 1, {3,4,5}}
a[3] = a
a[4] = a
a.z = a[1]
a.g = {1, 2, 3, x = a, ["9 to 5"] = a.z}
a.h = a.g
save(a, "a")
