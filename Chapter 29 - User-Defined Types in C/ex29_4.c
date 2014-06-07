/*
 *	Chapter 29, Exercise 4
 *
 * 	Based on the example for boolean arrays, implement a small C library for integer arrays.
 *
 *	Solution:
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"


typedef struct IntArray {
	int size;
	unsigned int values[1];	/* variable part */
} IntArray;

static int newarray(lua_State *L) {
	int i;
	IntArray *a;
	size_t nbytes;

	int n = luaL_checkint(L, 1);
	luaL_argcheck(L, n >= 1, 1, "invalid size");
	nbytes = sizeof(IntArray) + (n - 1)*sizeof(unsigned int);
	a = (IntArray *)lua_newuserdata(L, nbytes);

	a->size = n;
	for (i = 0; i <= (n - 1); i++)	{
		a->values[i] = 0;
	}
	luaL_getmetatable(L, "LuaBook.array");
	lua_setmetatable(L, -2);
	return 1;
}

static int setarray(lua_State *L) {
	IntArray *a = (IntArray *)luaL_checkudata(L, 1, "LuaBook.array");
	int index = luaL_checkint(L, 2) - 1;
	int value = luaL_checkint(L, 3);

	luaL_argcheck(L, 0<= index && index < a->size, 2, "index out of range");

	a->values[index] = value;
	return 0;
}

static int getarray(lua_State *L) {
	IntArray *a = (IntArray *)luaL_checkudata(L, 1, "LuaBook.array");
	int index = luaL_checkint(L, 2) - 1;

	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

	lua_pushinteger(L, a->values[index]);
	return 1;
}

static int getsize(lua_State *L) {
	IntArray *a = (IntArray *)luaL_checkudata(L, 1, "LuaBook.array");
	lua_pushinteger(L, a->size);
	return 1;
}

int array2string(lua_State *L) {
	IntArray *a = (IntArray *)luaL_checkudata(L, 1, "LuaBook.array");

	luaL_Buffer b;
	luaL_buffinit(L, &b);

	luaL_addstring(&b, "array(");
	lua_pushinteger(L, a->size);
	luaL_addvalue(&b);
	luaL_addstring(&b, "):\n");

	int i;
	for(i = 0; i < a->size; i++) {
		lua_pushinteger(L, a->values[i]);
		luaL_addvalue(&b);
		luaL_addstring(&b, " ");
	}
	luaL_pushresult(&b);
	return 1;
}

static const struct luaL_Reg arraylib_f [] = {
	{"new", newarray},
	{NULL, NULL}
};

static const struct luaL_Reg arraylib_m [] = {
	{"__tostring", array2string},
	{"set", setarray},
	{"get", getarray},
	{"size", getsize},
	{NULL, NULL}
};

int luaopen_array(lua_State *L) {
	luaL_newmetatable(L, "LuaBook.array");

	lua_pushvalue(L, -1);
	lua_setfield(L, -2, "__index");

	luaL_setfuncs(L, arraylib_m, 0);
	luaL_newlib(L, arraylib_f);

	return 1;
}
