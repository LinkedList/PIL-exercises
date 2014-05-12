--[[
--  Chapter 11, Exercise 4
--
--	Assume the graph represenation of the previous exercise, where the label of each arc represents
--	the distance between its end nodes.
--	Write a function to find the shortest path between two given nodes. (Hint: use Dijkstra's algorithm.)
--
--  Solution:
--]]

local function name2node(graph, name)
	local node = graph[name]

	if not node then
		--node does not exist; create a new one
		node = {name = name, incident_set = {}}
		graph[name] = node
	end
	return node
end

local function name2arc(label, nodeto)
	return {label = label, nameto = nodeto}
end

function readgraph()
	local graph = {}
	for line in io.lines() do
		local namefrom, nameto, label= string.match(line, "(%S+)%s+(%S+)%s+(%d+)")

		local from  = name2node(graph, namefrom)
		local to = name2node(graph, nameto)
		local arc = name2arc(label, nameto)
		from.incident_set[#from.incident_set + 1] = arc
	end
	return graph
end

--returns the value of shortest path from initial node to finish node and a table with path
function shortestpath(graph, initial, finish)
	--asign distance value
	--add visited attribute
	--add previous attribute
	for _, node in pairs(graph) do
		if node == initial then
			node.distance = 0
		else
			node.distance = math.huge
		end
		node.visited = false
		node.previous = nil
	end

	--dijkstra algorithm implementation
	local function dijkstra(g, curr, finish)
		--visit all neighbours and update distance
		for _, arc in pairs(curr.incident_set) do
			local to = name2node(g, arc.nameto)
			if to.visited == false and to.distance > tonumber(arc.label) + curr.distance then
				to.distance = tonumber(arc.label) + curr.distance
				to.previous = curr.name
			end
		end
		curr.visited = true

		if finish.visited then
			return finish.distance
		end

		--end if all smallest distances of not visited nodes are infinity
		local smallest_distance = math.huge
		for _, node in pairs(g) do
			if node.visited == false and node.distance < math.huge then
				smallest_distance = node.distance
				break
			end
		end

		if smallest_distance == math.huge then return math.huge end

		--find next smallest distance node and run again
		local smallest_node = {distance = math.huge}
		for _, node in pairs(g) do
			if node.visited == false and node.distance < smallest_node.distance then
				smallest_node = node
			end
		end

		dijkstra(g, smallest_node, finish)
	end

	dijkstra(graph, initial, finish)

	--create reverse path arrray from previous attribute
	local reverse_path = {}
	reverse_path[#reverse_path + 1] = finish

	local i = 1
	while true do
		local node = name2node(graph, reverse_path[i].previous)
		reverse_path[#reverse_path + 1] = node

		if node == initial then break end
		i = i + 1
	end

	-- reverse reversed path :D
	local path = {}
	for i = #reverse_path, 1, -1 do
		path[#path + 1] = reverse_path[i]
	end


	return finish.distance, path
end

function printpath(path)
	for i=1,#path do
		if i == #path then
			io.write(path[i].name)
		else
			local to = path[i + 1].name
			local arcname
			for _, arc in pairs(path[i].incident_set) do
				if arc.nameto == to then
					arcname = arc.label
					break
				end
			end
			io.write(path[i].name .. " --".. arcname .."--> ")
		end
	end
end

g = readgraph()
a = name2node(g, "A")
b = name2node(g, "B")
distance, path = shortestpath(g, a, b)
print(distance)
printpath(path)
