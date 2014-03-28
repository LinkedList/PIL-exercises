function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n-1) 
	end
end

a = -1
while a < 0 do
	print("enter a positive number:")
	a = io.read("*n")
end
print(fact(a))
