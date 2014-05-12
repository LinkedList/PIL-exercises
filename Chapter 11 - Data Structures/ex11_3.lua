--[[
--  Chapter 11, Exercise 3
--
--  Modify the graph structure so that it can keep a label for each arc.
--  The structure should represent each arc by an object, too, with two fields:
--  its label and the node it points to. Instead of an adjacent set, each node keeps
--  an incident set that contains the arcs that originate at that node.
--  Adapt the readgraph function to read two node names plus a label from each line
--  in the input file. (Assume that the label is a number.)
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

function findpath(graph, curr, to, path, visited)
	path = path or {}
	visited = visited or {}

	if visited[curr] then
		return nil
	end

	visited[curr] = true
	path[#path + 1] = curr
	if curr == to then
		return path
	end

	for _, arc in pairs(curr.incident_set) do
		local node = name2node(graph, arc.nameto)
		local p = findpath(graph, node, to, path, visited)
		if p then return p end
	end
	path[#path] = nil
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
path = findpath(g, a, b)
printpath(path)
