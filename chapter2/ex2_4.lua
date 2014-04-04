--[=[
--  Chapter 2, Exercise 4
--
--  How can you embed the following piece of XML as a string in Lua?
--  <![CDATA[
--    Hello world
--  ]]>
--
--  Solution:
-]=]
local string = "<![CDATA[\n  Hello World\n]]"
print(string)
string = [===[
<![CDATA[
  Hello World
]]
]===]
print(string)
