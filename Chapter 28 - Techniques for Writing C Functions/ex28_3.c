/*
 *	Chapter 28, Exercise 3
 *
 * 	Reimplement the transliterate function (Exercise 21.3) in C.
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

static void stackDump(lua_State *L) {
	int i;
	int top = lua_gettop(L);

	for(i = 1; i <= top; i++) {
		int t = lua_type(L, i);

		switch(t){
			case LUA_TSTRING: {
				printf("'%s'", lua_tostring(L, i));
				break;
			}

			case LUA_TBOOLEAN: {
				printf(lua_toboolean(L, i) ? "true" : "false");
				break;
			}

			case LUA_TNUMBER: {
				printf("'%g'", lua_tonumber(L, i));
				break;
			}

			default: {
				printf("'%s'", lua_typename(L, t));
				break;
			}
		}
		printf(" ");
	}

	printf("\n");
}
int static l_transliterate(lua_State *L) {
	const char *s = luaL_checkstring(L, 1);
	luaL_checktype(L, 2, LUA_TTABLE);

	// length of string
	lua_len(L, 1);
	int len = lua_tonumber(L, -1);
	lua_pop(L, 1);

	luaL_Buffer b;
	luaL_buffinitsize(L, &b, len);

	int i;
	for(i = 0; i < len; i++) {
		char c[] = "x";
		c[0] = s[i];
		lua_getfield(L, 2, c);

		int nil = lua_isnil(L, -1);
		if(nil){
			luaL_addchar(&b, s[i]);
		} else {
			const char *c = lua_tolstring(L, -1, 1);
			fprintf(stdout, "%s", c);
			luaL_addchar(&b, c);
		}
		lua_pop(L, 1);
	}

	luaL_pushresult(&b);
	return 1;
}

int main (void) {
	char buff[256];
	int error;
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, l_transliterate);
	lua_setglobal(L, "transliterate");

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
