--[[
--  Chapter 10, Exercise 4
--
--  Generalize the Markov-chain algorithm so that it can use any size for the sequence
--  of previous words used in the choice of the next word.
--
--  Solution:
--]]


function markov_chain_pseudorand(pref_lengt, maxgen)
	local NOWORD = "\n"
	local statetab = {}

	local pref_length = pref_length or 2
	local maxgen = maxgen or 10000

	function allwords()
		local line = io.read()
		local pos = 1
		return function ()
			while line do
				local s, e = string.find(line, "%w+", pos)
				if s then
					pos = e + 1
					return string.sub(line, s, e)
				else
					line = io.read()
					pos = 1
				end

			end
			return nil
		end
	end

	function prefix(...)
		ret_string = ""
		for i, v in ipairs{...} do
			ret_string = ret_string .. v .. " "
		end
		return ret_string
	end


	function insert (index, value)
		local list = statetab[index]
		if list == nil then
			statetab[index] = {value}
		else
			list[#list + 1] = value
		end
	end

	function build()
		local current_table = {}
		for i=1, pref_length do
			current_table[i] = NOWORD
		end

		for w in allwords() do
			insert(prefix(table.unpack(current_table)), w)
			for i=1, (pref_length - 1) do
				current_table[i] = current_table[i+1]
			end
			current_table[pref_length] = w
		end

		insert(prefix(table.unpack(current_table)), NOWORD)
	end

	function generate()
		local current_table = {}
		for i=1, pref_length do
			current_table[i] = NOWORD
		end

		for i=0,maxgen do
			local list = statetab[prefix(table.unpack(current_table))]
			local r = math.random(#list)
			local nextword = list[r]
			if nextword == NOWORD then return end
			io.write(nextword, " ")

			for i=1, (pref_length - 1) do
				current_table[i] = current_table[i+1]
			end
			current_table[pref_length] = nextword
		end
	end

	build()
	generate()
end

markov_chain_pseudorand(3)
