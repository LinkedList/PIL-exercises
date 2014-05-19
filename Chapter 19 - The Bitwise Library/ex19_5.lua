--[[
--  Chapter 19, Exercise 5
--
--  Write a function that receives a string coded in UTF-8 and returns its first code point
--  as a number. The function should return nil if the string does not start with a valid
--  UTF-8 sequence.
--
--  Solution:
--  taken from: http://lua-users.org/wiki/LuaUnicode
--]]

function Utf8to32(utf8str)
   assert(type(utf8str) == "string")
   local res, seq, val = {}, 0, nil
   local c = string.byte(utf8str, 1)
   if seq == 0 then
      table.insert(res, val)
      seq = c < 0x80 and 1 or c < 0xE0 and 2 or c < 0xF0 and 3 or
      c < 0xF8 and 4 or --c < 0xFC and 5 or c < 0xFE and 6 or
      error("invalid UTF-8 character sequence")
      val = bit32.band(c, 2^(8-seq) - 1)
   else
      val = bit32.bor(bit32.lshift(val, 6), bit32.band(c, 0x3F))
   end
   return val
end

t = Utf8to32("hi")
print(t)
