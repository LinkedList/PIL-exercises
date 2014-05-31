/*
 *	Chapter 27, Exercise 2
 *
 * 	Implement a function equivalent to table.pack, from the standard library.
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_tablepack(lua_State *L) {
	// total number of parameters to tablepack
	int n = lua_gettop(L);
	// create new table at the top of the stack
	lua_createtable (L, n, 1);
	// add the table to the bottom
	lua_insert(L, 1);
	int i;
	// set values to the table from the biggest to 1
	for(i = n; i > 0; i--) {
		lua_rawseti(L, 1, i);
	}

	// set field n
	lua_pushinteger(L, n);
	lua_setfield(L, 1, "n");

	return 1;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_tablepack);
	lua_setglobal(L, "tablepack");

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
