/*
 *	Chapter 25, Exercise 2
 *
 * 	Assume the stack is empty. What will be its contents after the following sequence of calls?
 *
 * 		lua_pushnumber(L, 3.5);
 * 		lua_pushstring(L, "hello");
 * 		lua_pushnil(L);
 * 		lua_pushvalue(L, -2);
 * 		lua_remove(L, 1);
 * 		lua_insert(L, -2);
 *
 *	Solution:
 *	1. {3.5}
 *	2. {3.5, "hello"}
 *	3. {3.5, "hello", nil}
 *	4. {3.5, "hello", nil, "hello"}
 *	5. {"hello", nil, "hello"}
 *	5. {"hello", "hello", nil}
 */
