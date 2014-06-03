/*
 *	Chapter 27, Exercise 6
 *
 * 	Create a C module with all functions from the previous exercises.
 *
 *	Solution:
 *	Compiled this file using this command:
 *
 *		gcc -shared -o mylib.so -fPIC ex27_6.c
 *
 *	Loaded in interpreter:
 *
 *		mylib = require("mylib")
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

// ex27_1 function summation
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

// ex27_2 function tablepack
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

// ex72_3 function reverse
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

// ex27_4 function foreach
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

// ex27_5 function foreach with yield
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

static int l_foreachyield(lua_State *L) {

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

static const struct luaL_Reg mylib [] = {
	{"summation", l_summation},
	{"tablepack", l_tablepack},
	{"reverse", l_reverse},
	{"foreach", l_foreach},
	{"foreachyield", l_foreachyield},
	{NULL, NULL}
};

int luaopen_mylib(lua_State *L){
	luaL_newlib(L, mylib);
	return 1;
}

