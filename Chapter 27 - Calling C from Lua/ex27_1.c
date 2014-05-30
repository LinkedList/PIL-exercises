/*
 *	Chapter 27, Exercise 1
 *
 *	Write a summation function, in C, that computes the sum of its
 *	variable number of numeric arguments:
 *
 *		print(summation()) 				--> 0
 *		print(summation(2.3, 5.4)) 		--> 7.7
 *		print(summation(2.3, 5.4, -34)) --> -26.3
 *		print(summation(2.3, 5.4, {})) 	--> stdin:1 bad argument #3 to 'summation' (number expected, got table)
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_summation(lua_State *L) {
	int n = lua_gettop(L);

	lua_Number sum = 0;

	int i;
	for(i = 1; i <= n; i++) {
		if(!lua_isnumber(L, i)) {
			lua_pushstring(L, "bad argument to 'summation'");
			lua_error(L);
		}
		sum += lua_tonumber(L, i);
	}

	lua_pushnumber(L, sum);
	return 1;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_summation);
	lua_setglobal(L, "summation");

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
