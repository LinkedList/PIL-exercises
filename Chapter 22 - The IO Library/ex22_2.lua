--[[
--  Chapter 22, Exercise 2
--
--  Change the previous program so that it asks for a confirmation if the user gives the name
--  of an existing file for it's output.
--
--  Solution:
--]]

local source = arg[1]
local target = arg[2]

local check
if target ~= nil then
    local f = io.open(target, "r")
    if f~= nil then
        check = true
    else
        check = false
    end
end

if check then
    print("File " .. target .." already exists.")
    print("Do you want to overwrite it? [Y/n]")
    local answer = io.read()
    if answer ~= "Y" then target = nil end
end

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
