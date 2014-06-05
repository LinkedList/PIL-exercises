/*
 *	Chapter 28, Exercise 5
 *
 * 	Repeat the previous exercise using an upvalue to keep the transliteration table.
 *
 *	Solution:
 *	Compiled this file using this command:
 *
 *		gcc -shared -o mylib.so -fPIC ex28_5.c
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

int static l_settrans(lua_State *L) {
	luaL_checktype(L, 1, LUA_TTABLE);
	// set transliteration table as a key in upvalue table
	lua_setfield(L, lua_upvalueindex(1), "trans_table");

	return 0;
}

int static l_gettrans(lua_State *L) {
	// get transliteration from upvalue table
	lua_pushvalue(L, lua_upvalueindex(1));
	lua_getfield(L, 1, "trans_table");

	return 1;
}

int static l_transliterate(lua_State *L) {
	const char *s = luaL_checkstring(L, 1);
	lua_pushvalue(L, lua_upvalueindex(1));
	// get transliteration table
	lua_getfield(L, 2, "trans_table");
	// remove upvalue table from stack
	lua_remove(L, 2);

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
	luaL_newlibtable(L, mylib);
	lua_newtable(L);
	luaL_setfuncs(L, mylib, 1);
	return 1;
}
