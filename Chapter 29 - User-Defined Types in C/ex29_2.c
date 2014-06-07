/*
 *	Chapter 29, Exercise 2
 *
 * 	We can see a boolean array as a set of integers (the indices with true values in the array).
 * 	Add to the implementation of boolean arrays a functions to compute the union and intersection
 * 	of two arrays. These functions should receive two arrays and return a new one, without modifying
 * 	it's parameters.
 *
 *	Solution:
 *	Compiled this file using this command:
 *
 *		gcc -shared -o array.so -fPIC ex29_2.c
 *
 *	Loaded in interpreter:
 *
 *		array = require("array")
 *
 *	I added functions getarr and setarr that mirror setarray and getarray, but are used in the library internally,
 *	so that intersect and union are easier to write.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
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
	return 1;
}

static void setarr(NumArray *a, int index, int bool) {
	if(a == NULL) {
		fprintf(stderr, "NumArray a is NULL.\n");
		exit(EXIT_FAILURE); /* indicate failure.*/
	}

	if(0 > index || index > a->size) {
		fprintf(stderr, "Index out of range.\n");
		exit(EXIT_FAILURE); /* indicate failure.*/
	}

	if(bool) {
		a->values[I_WORD(index)] |= I_BIT(index);
	} else {
		a->values[I_WORD(index)] &= ~I_BIT(index);
	}
}

static int setarray(lua_State *L) {
	NumArray *a = (NumArray *)lua_touserdata(L, 1);
	int index = luaL_checkint(L, 2) - 1;

	luaL_argcheck(L, a != NULL, 1, "'array' expected");
	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");
	luaL_checktype(L, 3, LUA_TBOOLEAN);

	if(lua_toboolean(L, 3)) {
		a->values[I_WORD(index)] |= I_BIT(index);
	} else {
		a->values[I_WORD(index)] &= ~I_BIT(index);
	}
	return 0;
}

static int getarr(NumArray *a, int index) {
	if (0 > index || index > a->size) {
		fprintf(stderr, "Index out of range.\n");
		exit(EXIT_FAILURE); /* indicate failure.*/
	}

	return a->values[I_WORD(index)] & I_BIT(index);
}

static int tobool(int num) {
	return num > 0;
}

static int getarray(lua_State *L) {
	NumArray *a = (NumArray *)lua_touserdata(L, 1);
	int index = luaL_checkint(L, 2) - 1;

	luaL_argcheck(L, a != NULL, 1, "'array' expected");
	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

	lua_pushboolean(L, a->values[I_WORD(index)] & I_BIT(index));
	return 1;
}

static int getsize(lua_State *L) {
	NumArray *a = (NumArray *)lua_touserdata(L, 1);

	luaL_argcheck(L, a != NULL, 1, "'array' expected");
	lua_pushinteger(L, a->size);
	return 1;
}

static int intersect(lua_State *L) {
	NumArray *a = (NumArray *)lua_touserdata(L, 1);
	NumArray *b = (NumArray *)lua_touserdata(L, 2);

	size_t nbytes;
	NumArray *res;

	luaL_argcheck(L, a != NULL, 1, "'array' expected");
	luaL_argcheck(L, b != NULL, 2, "'array' expected");

	int size = a->size < b->size ? a->size : b->size;
	nbytes = sizeof(NumArray) + I_WORD(size - 1)*sizeof(unsigned int);
	res = (NumArray *)lua_newuserdata(L, nbytes);
	res->size = size;

	int i;
	for (i = 0; i < res->size; i++)	{
		int a_val = tobool(getarr(a, i));
		int b_val = tobool(getarr(b, i));

		if(a_val == b_val && a_val == 1) {
			setarr(res, i, 1);
		} else {
			setarr(res, i, 0);
		}
	}
	return 1;
}

static int unionarr(lua_State *L) {
	NumArray *a = (NumArray *)lua_touserdata(L, 1);
	NumArray *b = (NumArray *)lua_touserdata(L, 2);

	size_t nbytes;
	NumArray *res;

	luaL_argcheck(L, a != NULL, 1, "'array' expected");
	luaL_argcheck(L, b != NULL, 2, "'array' expected");

	int size = a->size > b->size ? a->size : b->size;
	nbytes = sizeof(NumArray) + I_WORD(size - 1)*sizeof(unsigned int);
	res = (NumArray *)lua_newuserdata(L, nbytes);
	res->size = size;

	int i;
	for (i = 0; i < res->size; i++)	{
		int a_val = tobool(getarr(a, i));
		int b_val = tobool(getarr(b, i));

		if(a_val == 1 || b_val == 1) {
			setarr(res, i, 1);
		} else {
			setarr(res, i, 0);
		}
	}
	return 1;
}

static const struct luaL_Reg arraylib [] = {
	{"new", newarray},
	{"set", setarray},
	{"get", getarray},
	{"size", getsize},
	{"intersect", intersect},
	{"union", unionarr},
	{NULL, NULL}
};

int luaopen_array(lua_State *L) {
	luaL_newlib(L, arraylib);
	return 1;
}
