local string = "<![CDATA[\n  Hello World\n]]"
print(string)
string = [===[
<![CDATA[
  Hello World		
]]
]===]
print(string)
