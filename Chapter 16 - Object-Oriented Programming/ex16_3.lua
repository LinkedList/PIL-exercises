--[[
--  Chapter 16, Exercise 3
--
--  Another way to provide privacy for objects is to implement them using proxies
--  (Section 13.4). Each object is represented by an empty proxy table. An internal
--  table maps proxies to tables that carry the object state. This internal table is
--  not accessible from the outside, but methods use it to translate their self
--  parameters to the real tables where they operate. Implement the Account example
--  using this approach and discuss its pros and cons.
--  (There is a small problem with this approach. Try to figure it out or see
--  Section 17.3, which also presents a solution.)
--
--  Solution:
--]]

Proxy = {
   proxy = {},

   mt = {
      __index = function (acc, func)
         local account = Proxy.proxy[acc]

         if not account then error("No account") end
         if type(account[func]) ~= "function" then error("No access to fields") end
         return account[func]
      end
   }, 

   doProxy = function (account)
      local p = {}
      Proxy.proxy[p] = account
      setmetatable(p, Proxy.mt)
      return p
   end
}

Account = {balance = 0}
function Account:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Account:deposit(v)
   self.balance = self.balance + v
end 

function Account:withdraw(v)
   if v > self.balance then error("insufficient funds") end
   self.balance = self.balance - v
end

function Account:current_balance()
   return self.balance
end

acc = Proxy.doProxy(Account:new())

acc:deposit(1000)
acc:withdraw(500)
print(acc:current_balance())

print(acc.balance) --> throws error
