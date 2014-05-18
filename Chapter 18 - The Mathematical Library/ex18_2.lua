--[[
--  Chapter 18, Exercise 2
--
--  Write a function to compute the volume of a right circular cone,
--  given its height and the angle between a generatrix and the axis.
--
--  Solution:
--]]

function cone_volume(height, angle, deg)
    -- radians or degrees
    if deg == nil then
        deg = true
    else
        deg = false
    end

    if deg then angle = math.rad(angle) end

    local r = math.tan(angle) * height

    return (math.pi * (r^2) * height)/3
end

print(cone_volume(10, 30))
