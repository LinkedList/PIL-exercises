--[[
--  Chapter 15, Exercise 3
--
--  Write a searcher that searches for Lua files and C libraries at the same time. For instance, the path
--  used for this searcher could be something like this:
--  ./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua
--  (Hint: use package.searchpath to find a proper file and then try to load it, first
--  with loadfile and next with package.loadlib)
--
--  Solution:
--  Need to run following command before trying this example:
--      gcc -shared -o foo.so -fPIC foo.c
--]]

function lua_c_searcher(name, path)
    local file, err = package.searchpath(name, path)

    if err then
        print("Error searching for file:")
        print(err)
        return
    end

    local func = loadfile(file)
    if func then
        return func
    end

    func = package.loadlib(file, "main")

    if func then
        return func
    end

    error("Error searching for file")
end
-- .lua search
local f = lua_c_searcher("foo", "./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua")
f()
-- .so search
local f = lua_c_searcher("foo", "./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua")
f()
