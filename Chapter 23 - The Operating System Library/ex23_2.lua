--[[
--  Chapter 23, Exercise 2
--
--  Write a function that receives a date/time (coded as a number) and returns the number of seconds passed
--  since the beginning of its respective day.
--
--  Solution:
--]]

function numberOfSeconds(date)
    local date = os.date("*t", date)
    return date.sec + 60*date.min + 3600*date.hour
end

print(numberOfSeconds(1419178563))
