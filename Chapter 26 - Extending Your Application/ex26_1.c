/*
 *	Chapter 26, Exercise 1
 *
 * 	Write a C program that reads a Lua file defining a function
 * 	f from numbers to numbers and plots that function.
 * 	(You do not need to do anything fancy; the program can plot the results printing ASCII
 * 	asterisks as we did in Section 8.1)
 *
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

double f (lua_State *L, double x) {
	int isnum;
	double z;

	lua_getglobal(L, "f");
	lua_pushnumber(L, x);

	if(lua_pcall(L, 1, 1, 0) != LUA_OK) {
		printf("error running function 'f': %s", lua_tostring(L, -1));
	}

	z = lua_tonumberx(L, -1, &isnum);

	if(!isnum) {
		printf("function 'f' must return a number");
	}

	lua_pop(L, 1);
	return z;
}

int main (void) {
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	if (luaL_loadfile(L, "ex26_1.lua") || lua_pcall(L, 0, 0, 0)) {
		printf("cannot run ex26_1.lua: %s", lua_tostring(L, -1));;
	}

	int i;
	for(i = -5; i <= 5; i++){
		int n = f(L, i);

		int j;
		for (j = 0; j < n; ++j)
		{
			printf(" ");
		}
		printf("*\n");
	}

	lua_close(L);
	return 0;
}
