/*
 *	Chapter 28, Exercise 4
 *
 * 	Implement a library with a modification of transliterate so that the transliteration table is not given as an
 * 	argument, but instead is kept by the library. Your library should offer the following functions:
 *
 * 		lib.settrans (table) 	-- set the transliteration table
 * 		lib.gettrans ()			-- get the transliteration table
 * 		lib.transliterate(s)	-- transliterate 's' according to the current table
 *
 * 	Use the registry to keep the transliteration table.
 *
 *	Solution:
 *	Compiled this file using this command:
 *
 *		gcc -shared -o mylib.so -fPIC ex28_4.c
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

static char *Key = "trans_table";

int static l_settrans(lua_State *L) {
	luaL_checktype(L, 1, LUA_TTABLE);

	lua_rawsetp(L, LUA_REGISTRYINDEX, (void *)&Key);
	return 0;
}

int static l_gettrans(lua_State *L) {
	lua_rawgetp(L, LUA_REGISTRYINDEX, (void *)&Key);

	return 1;
}

int static l_transliterate(lua_State *L) {
	const char *s = luaL_checkstring(L, 1);
	lua_rawgetp(L, LUA_REGISTRYINDEX, (void *)&Key);

	// length of string
	lua_len(L, 1);
	int len = lua_tonumber(L, -1);
	lua_pop(L, 1);

	// string buffer
	luaL_Buffer b;
	luaL_buffinitsize(L, &b, len);

	int i;
	for(i = 0; i < len; i++) {
		// get char from original
		char c[] = "x";
		c[0] = s[i];
		// getfield of key s[i]
		lua_getfield(L, 2, c);

		// test if nil
		int nil = lua_isnil(L, -1);
		if(nil){
			// if nil don't change anything
			luaL_addchar(&b, s[i]);
		} else {
			// if not add value from transliterate table
			const char *c = lua_tostring(L, -1);
			luaL_addstring(&b, c);
		}
		// remove pushed field
		lua_pop(L, 1);
	}

	//return built string
	luaL_pushresult(&b);
	return 1;
}

static const struct luaL_Reg mylib [] = {
	{"settrans", l_settrans},
	{"gettrans", l_gettrans},
	{"transliterate", l_transliterate},
	{NULL, NULL}
};

int luaopen_mylib(lua_State *L){
	luaL_newlib(L, mylib);
	return 1;
}
