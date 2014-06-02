/*
 *	Chapter 27, Exercise 5
 *
 * 	Rewrite function foreach, from the previous exercise, so that the function being
 * 	called can yield.
 *
 *	Solution:
 *	Example of calling in interpreter:
 *		function foo() foreach({a = 10, b = "ahoy", c="lol"}, function (k, v) coroutine.yield(k, v) end) end
 *		co = coroutine.create(foo)
 *		print(coroutine.resume(co))
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_foreach_cont(lua_State *L) {
	// copy function
	lua_pushvalue(L, -1);
	// move stored key to the top
	lua_pushvalue(L, 1);
	lua_remove(L, 1);

	if (lua_next(L, -4) != 0) {
		// copy key and store it at 1
		lua_pushvalue(L, -2);
		lua_insert(L, 1);
		// call function
		lua_callk(L, 2, 0, 0, l_foreach_cont);
	}

	return 0;
}

static int l_foreach(lua_State *L) {
	// copy function
	lua_pushvalue(L, -1);
	// add first key
	lua_pushnil(L);

	while (lua_next(L, -4) != 0) {
		// copy key and store it at 1
		lua_pushvalue(L, -2);
		lua_insert(L, 1);

		// call function
		lua_callk(L, 2, 0, 0, l_foreach_cont);

		// copy function
		lua_pushvalue(L, -1);
		// move stored key to the top
		lua_pushvalue(L, 1);
		lua_remove(L, 1);
	}

	return 0;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_foreach);
	lua_setglobal(L, "foreach");

	while(fgets(buff, sizeof(buff), stdin) != NULL) {
		error = luaL_loadstring(L, buff) || lua_pcall(L, 0, 0, 0);

		if(error) {
			fprintf(stderr, "%s\n", lua_tostring(L, -1));
			lua_pop(L, 1);
		}
	}

	lua_close(L);
	return 0;
}
