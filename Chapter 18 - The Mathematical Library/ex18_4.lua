--[[
--  Chapter 18, Exercise 4
--
--  Using math.random, write a function to produce a pseudorandom number with a standard
--  normal (Gaussian) distribution.
--
--  Solution:
--]]
math.randomseed(os.time())
function gauss_rand()
    return 1.0 + 0.5 * (math.sqrt(-2 * math.log(math.random())) * math.cos(2*math.pi*math.random()))
end

print(gauss_rand())
