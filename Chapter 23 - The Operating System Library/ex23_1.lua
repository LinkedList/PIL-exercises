--[[
--  Chapter 23, Exercise 1
--
--  Write a function that returns the date/time exactly one month after a given date/time.
--  (Assume the usual coding of date/time as a number)
--
--  Solution:
--]]

function plusMonth(date)
    local date = os.date("*t", date)
    date.month = date.month + 1
    return os.time(date)
end

print(os.date("%c", plusMonth(1419178563)))
