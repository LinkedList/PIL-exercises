--[[
--  Chapter 3, Exercise 7
--
--	What will the following script print? Explain
--
--  Solution:
--	It will print "monday  sunday sunday"
--	t.sunday is declared as the first record on line 12.
--	t[sunday] is equivalent to t["monday"] and because we declared [sunday] = monday on line 11
--		it is equivalent to this: t["monday"] = monday, and therefore t["monday"] = "sunday"
--	t[t.sunday] is equivalent to t["monday"] and is the same as t[sunday]
-]]

sunday = "monday"; monday = "sunday"
t = {sunday = "monday", [sunday] = monday}
print(t.sunday, t[sunday], t[t.sunday])
