/*
 *	Chapter 28, Exercise 1
 *
 * 	Implement a filter function in C. It should receive a list and a predicate
 * 	and return a new list with all elements from the fiven list that satisfy the predicate:
 *
 * 		t = filter({1, 3, 20, -4, 5}, function (x) return x < 5 end)
 * 		-- t = {1, 3, -4}
 *
 * 	(A predicate is just a function that tests some condition, returning a boolean.)
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_filter(lua_State *L) {
	// get table length
	lua_len(L, 1);
	int len = lua_tonumber(L, -1);
	lua_pop(L, 1);
	// create return table
	lua_createtable(L, len, 0);

	//push return table to second position
	lua_insert(L, 2);

	//copy function to be on top
	lua_pushvalue(L, 3);

	int i;
	for(i = 1; i <= len; i++) {
		// getvalue from table
		lua_rawgeti(L, 1, i);

		// call function
		lua_call(L, 1, 1);

		// get result
		int filter = lua_toboolean(L, -1);
		// remove result
		lua_pop(L, 1);

		//add to return table
		if(filter) {
			lua_rawgeti(L, 1, i);

			//get return table length
			lua_len(L, 2);
			int retlen = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_rawseti(L, 2, retlen + 1);
		}

		//copy function to be on top
		lua_pushvalue(L, 3);
	}

	// remove functions
	lua_pop(L, 2);

	// return table
	return 1;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_filter);
	lua_setglobal(L, "filter");

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
