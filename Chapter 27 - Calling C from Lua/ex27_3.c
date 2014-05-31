/*
 *	Chapter 27, Exercise 3
 *
 * 	Write a function that receives any number of parameters and returns them in reverse order.
 *
 * 		print(reverse(1, "hello", 20)) --> 20	hello	1
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_reverse(lua_State *L) {
	int n = lua_gettop(L);
	int i;
	// push in reversed order
	for(i = n; i > 0; i--) {
		lua_pushvalue(L, i);
	}

	// remove first parameters
	for(i = 1; i <= n; i++) {
		lua_remove(L, 1);
	}

	return n;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_reverse);
	lua_setglobal(L, "reverse");

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
