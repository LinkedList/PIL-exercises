--[[
--  Chapter 13, Exercise 3
--
--  Complete the implementation of proxies in Seciton 13.4 with an __iparis metamethod.
--
--  Solution:
--]]

t = {}

local _t = t

t = {}

local mt = {
    __index = function (t, k)
        print("*access to element " .. tostring(k))
        return _t[k]
    end,

    __newindex = function (t, k, v)
        print("*update of element " .. tostring(k) ..
              " to " .. tostring(v))
        _t[k] = v
    end
}

setmetatable(t, mt)

mt.__pairs = function ()
    return function (_, k)
        return next(_t, k)
    end
end

mt.__ipairs = function ()
    local function iter(_, i)
        i = i + 1
        local v = _t[i]
        if v then
            return i, v
        end
    end

    return iter, _t, 0
end

t = {"one", "two", "three"}

for k, v in ipairs(t) do
    print(k, v)
end
