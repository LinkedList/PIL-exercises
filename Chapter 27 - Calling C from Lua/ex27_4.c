/*
 *	Chapter 27, Exercise 4
 *
 * 	Write a function foreach that receives a table and a function and calls that
 * 	function for each pair key-value in the table.
 *
 * 		foreach({x = 10, y = 20}, print)
 * 			--> x	10
 * 			--> y	20
 *
 * 	(Hint: check function lua_next in the Lua manual.)
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

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
		lua_call(L, 2, 0);

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
