--[[
--  Chapter 9, Exercise 3
--
--	Implement a transfer function in Lua. If you think about resume-yield as similar to call-return,
--	a transfer would be like a goto: it suspends the running coroutine and resumes any other coroutine,
--	given as an argument. (Hint: use a kind of dispatch to control your coroutines. Then, a transfer
--	would yield to the dispatch signaling the next coroutine to run, and the dispatch would resume that
--	next coroutine.)
--
--  Solution:
--]]

co1 = coroutine.create(
	function ()
		print("coroutine1")
		transfer(co2)
		print("coroutine1 again")
	end
)

co2 = coroutine.create(
	function ()
		print("coroutine2")
		transfer(co1)
	end
)

function transfer(co)
	coroutine.yield(co)
end

function dispatch()
	local status, res = coroutine.resume(co1)

	while true do
		if status and res then
			status, res = coroutine.resume(res)
		else
			break
		end
	end
end

dispatch()
