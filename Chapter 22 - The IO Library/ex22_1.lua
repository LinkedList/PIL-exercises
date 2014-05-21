--[[
--  Chapter 22, Exercise 1
--
--  Write a program that reads a text file and rewrites it with their lines sorted in
--  alphabetical order. When called with no arguments, it should read from the
--  standard input file and write to the standard output file. When called with one file-name
--  argument, it should read from that file and write to the standard output file. When called
--  with two file-name arguments, it should read from the first file and write to the second one.
--
--  Solution:
--]]

local source = arg[1]
local target = arg[2]

local lines = {}

for line in io.lines(source) do lines[#lines + 1] = line end

table.sort(lines)
local file
if target ~= nil then file = io.open(target, "w") end
for _, l in ipairs(lines) do
    if file then
        file:write(l, "\n")
    else
        io.write(l, "\n")
    end
end

if file then file:close() end
