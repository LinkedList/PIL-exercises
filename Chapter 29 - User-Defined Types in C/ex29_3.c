/*
 *	Chapter 29, Exercise 3
 *
 * 	Modify the implementation of the __tostring metamethod so that it shows the full contents of the array in a
 * 	appropriate way. Use the buffer facility (Section 28.2) to create the resulting string.
 *
 *	Solution:
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

#define BITS_PER_WORD 	(CHAR_BIT*sizeof(unsigned int))
#define I_WORD(i)		((unsigned int)(i) / BITS_PER_WORD)
#define I_BIT(i)		(1 << ((unsigned int)(i) % BITS_PER_WORD))

typedef struct NumArray {
	int size;
	unsigned int values[1];	/* variable part */
} NumArray;

#define checkarray(L) 	(NumArray *)luaL_checkudata(L, 1, "LuaBook.array")

static int newarray(lua_State *L) {
	int i;
	size_t nbytes;
	NumArray *a;

	int n = luaL_checkint(L, 1);
	luaL_argcheck(L, n >= 1, 1, "invalid size");
	nbytes = sizeof(NumArray) + I_WORD(n - 1)*sizeof(unsigned int);
	a = (NumArray *)lua_newuserdata(L, nbytes);

	a->size = n;
	for (i = 0; i <= I_WORD(n - 1); i++)	{
		a->values[i] = 0;
	}
	luaL_getmetatable(L, "LuaBook.array");
	lua_setmetatable(L, -2);
	return 1;
}

static unsigned int *geti(NumArray *a, int index, unsigned int *mask) {
	if(index < 0 || index >= a->size) {
		fprintf(stderr, "Index out of range.\n");
		exit(EXIT_FAILURE); /* indicate failure.*/
	}

	*mask = I_BIT(index);
	return &a->values[I_WORD(index)];
}

static unsigned int *getindex(lua_State *L, unsigned int *mask) {
	NumArray *a = checkarray(L);
	int index = luaL_checkint(L, 2) - 1;

	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

	*mask = I_BIT(index);
	return &a->values[I_WORD(index)];
}

static int setarray(lua_State *L) {
	unsigned int mask;
	unsigned int *entry = getindex(L, &mask);
	luaL_checkany(L, 3);

	if(lua_toboolean(L, 3)) {
		*entry |= mask;
	} else {
		*entry &= ~mask;
	}
	return 0;
}

static int getarr(NumArray *a, int index) {
	unsigned int mask;
	unsigned int *entry = geti(a, index, &mask);
	return *entry & mask;
}

static int getarray(lua_State *L) {
	unsigned int mask;
	unsigned int *entry = getindex(L, &mask);

	lua_pushboolean(L, *entry & mask);
	return 1;
}

static int getsize(lua_State *L) {
	NumArray *a = checkarray(L);
	lua_pushinteger(L, a->size);
	return 1;
}

static char* toboolean(int num) {
	if(num > 0) {
		return "true";
	} else {
		return "false";
	}
}

int array2string(lua_State *L) {
	NumArray *a = checkarray(L);

	luaL_Buffer b;
	luaL_buffinit(L, &b);

	luaL_addstring(&b, "array(");
	lua_pushinteger(L, a->size);
	luaL_addvalue(&b);
	luaL_addstring(&b, "):\n");

	int i;
	for(i = 0; i < a->size; i++) {
		luaL_addstring(&b, toboolean(getarr(a, i)));
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
