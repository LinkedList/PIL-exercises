/*
 *	Chapter 25, Exercise 3
 *
 * 	Use the simple stand-alone interpreter (Listing 25.1) and the stackDump function (Listing 25.2)
 * 	to check your answer to the previous exercise.
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

int main (void) {
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushnumber(L, 3.5);
	printf("lua_pushnumber(L, 3.5)\n");
	stackDump(L);
	printf("\n");

	lua_pushstring(L, "hello");
	printf("lua_pushstring(L, 'hello')\n");
	stackDump(L);
	printf("\n");

	lua_pushnil(L);
	printf("lua_pushnil(L)\n");
	stackDump(L);
	printf("\n");

	lua_pushvalue(L, -2);
	printf("lua_pushvalue(L, -2)\n");
	stackDump(L);
	printf("\n");

	lua_remove(L, 1);
	printf("lua_remove(L, 1)\n");
	stackDump(L);
	printf("\n");

	lua_insert(L, -2);
	printf("lua_insert(L, -2)\n");
	stackDump(L);
	printf("\n");

	lua_close(L);
	return 0;
}
