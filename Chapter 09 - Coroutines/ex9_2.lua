--[[
--  Chapter 9, Exercise 2
--
--  Implement and run the code fo the previous secction (non-preemptive multitasking).
--
--  Solution:
--]]

local socket = require("socket")

function download(host, file)
	local c = assert(socket.connect(host, 80))
	local count = 0

	c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")

	while true do
		local s, status = receive(c)
		count = count + #s
		if status == "closed" then break end
	end

	c:close()
	print(file, count)
end

function receive(connection)
	connection:settimeout(0)
	local s, status, partial = connection:receive(2^10)
	if status == "timeout" then
		coroutine.yield(connection)
	end
	return s or partial, status
end

function get(host, file)
	local co = coroutine.create(
		function ()
			download(host, file)
		end
	)

	table.insert(threads, co)
end

threads = {}
function dispatch()
	local i = 1
	local timedout = {}
	while true do
		if threads[i] == nil then
			if threads[1] == nil then break end
			i = 1
			timedout = {}
		end

		local status, res = coroutine.resume(threads[i])
		if not res then
			table.remove(threads, i)
		else
			i = i + 1
			timedout[#timedout + 1] = res
			if #timedout == #threads then
				socket.select(timedout)
			end
		end
	end
end

host = "www.w3.org"

get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatch()
