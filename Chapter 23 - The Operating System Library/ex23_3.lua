--[[
--  Chapter 23, Exercise 3
--
--  Can you use the os.execute function to change the current directory of your Lua program? Why?
--
--  Solution:
--  You can't. According to this answer:
--      http://stackoverflow.com/a/8565032
--  Lua has a small library, that doesn't allow this.
--]]

os.execute("cd ..")
os.execute("ls -al") --> prints this folder contents

os.execute("cd /usr/ && ls -al") --> prints /usr/ contents

