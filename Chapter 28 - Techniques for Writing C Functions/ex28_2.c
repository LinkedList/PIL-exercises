/*
 *	Chapter 28, Exercise 2
 *
 * 	Modify function l_split (from Listing 28.2) so that it can work with strings containing zeros.
 * 	(Among other changes, it should use memchr instead of strchr.)
 *
 *	Solution:
 *	Use like this in interpreter:
 *
 *		t = split("ho:HO:hoo\0ooo:hu", ":")
 *		for k, v in pairs(t) do print(k, v) end
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static int l_split(lua_State *L) {
	const char *s = luaL_checkstring(L, 1); // subject
	const char *sep = luaL_checkstring(L, 2); // separator
	lua_len(L, 1);
	int len = lua_tonumber(L, -1);
	lua_pop(L, 1);

	const char *e;
	int i = 1;

	lua_newtable(L); // result table

	while((e = memchr(s, *sep, len)) != NULL) {
		lua_pushlstring(L, s, e-s); // push substring
		lua_rawseti(L, -2, i++); // insert it in table
		s = e + 1; // skip separator
	}

	// insert last substring
	lua_pushstring(L, s);
	lua_rawseti(L, -2, i);

	return 1; // return the table
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_split);
	lua_setglobal(L, "split");

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
