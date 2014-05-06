--[[
--  Chapter 9, Exercise 1
--
--	Use coroutines to transform the function in Exercise 5.4 into a generator for combinations
--	to be used like here:
--		for c in combinations({"a", "b", "c"}, 2) do
--			printResult(c)
--		end
--  Solution:
--]]

function comb(arr, r)
	-- do noting if r is bigger then length of arr
	if(r > #arr) then
		return {}
	end

	--for r = 0 there is only one possible solution and that is a combination of lenght 0
	if(r == 0) then
		return {}
	end

	if(r == 1) then
		-- if r == 1 than retrn only table with single elements in table
		-- e.g. {{1}, {2}, {3}, {4}}

		local return_table = {}
		for i=1,#arr do
			table.insert(return_table, {arr[i]})
		end

		return return_table
	else
		-- else return table with multiple elements like this
		-- e.g {{1, 2}, {1, 3}, {1, 4}}

		local return_table = {}

		--create new array without the first element
		local arr_new = {}
		for i=2,#arr do
			table.insert(arr_new, arr[i])
		end

		--combinations of (arr-1, r-1)
		for i, val in pairs(comb(arr_new, r-1)) do
			local curr_result = {}
			table.insert(curr_result, arr[1]);
			for j,curr_val in pairs(val) do
				table.insert(curr_result, curr_val)
			end
			table.insert(return_table, curr_result)
		end

		--combinations of (arr-1, r)
		for i, val in pairs(comb(arr_new, r)) do
			table.insert(return_table, val)
		end

		return return_table
	end
end

function printResult(a)
	for i=1,#a do
		io.write(a[i], " ")
	end
	io.write("\n")
end

function combinations_generator(array, r)
	for i, val in pairs(comb(array, r)) do
		coroutine.yield(val)
	end
end

function combinations (array, r)
	local co = coroutine.create(
		function ()
			combinations_generator(array, r)
		end
	)
	return function ()
		local code, res = coroutine.resume(co)
		return res
	end
end

array = {1,2,3,4,5}

for p in combinations(array, 3) do
	printResult(p)
end
