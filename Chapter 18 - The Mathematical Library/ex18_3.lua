--[[
--  Chapter 18, Exercise 3
--
--  Implement a better random function in Lua. Search the Web for a good algorithm. (You may need
--  the bitwise library; see Chapter 19.)
--
--  Solution:
--]]

do
    math.randomseed(os.time())
    local x = math.random(1, 100) % 2^32;
    local y = x * math.random(1, 100) % 2^32;
    local z = y * math.random(1, 100) % 2^32;
    local w = z * math.random(1, 100) % 2^32;

    local function xorshift()
        t = bit32.bxor(x, bit32.lshift(x, 11))
        x = y
        y = z
        z = w

        w = bit32.bxor(bit32.bxor(w, bit32.rshift(w, 19)), bit32.bxor(t, bit32.rshift(t, 8)))
        return w
    end

    function random(lower, upper)
        local r = xorshift()
        --make r = 0,<value of xorshift()>
        while r >= 1 do
            r = r / 10
        end


        if lower == nil then
            return r
        elseif upper == nil then
            upper = lower
            lower = 1
        end

        if lower > upper then error("lower can't be bigger than upper") end

        return math.floor(r * (upper - lower + 1)) + lower
    end
end

print(random())
print(random(100))
print(random(50, 100))
