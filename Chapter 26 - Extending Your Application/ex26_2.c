/*
 *	Chapter 26, Exercise 2
 *
 * 	Modify function call_va (Listing 26.5) to handle boolean values.
 *
 *	Solution:
 */

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "lua5.2/lua.h"
#include "lua5.2/lauxlib.h"
#include "lua5.2/lualib.h"

void call_va(lua_State *L, const char *func, const char *sig, ...) {
	va_list vl;
	int narg, nres;

	va_start(vl, sig);
	lua_getglobal(L, func);

	for(narg = 0; *sig; narg++) {
		luaL_checkstack(L, 1, "too many arguments");

		switch (*sig++) {
			case 'd':
				lua_pushnumber(L, va_arg(vl, double));
				break;

			case 'i':
				lua_pushinteger(L, va_arg(vl, int));
				break;

			case 's':
				lua_pushstring(L, va_arg(vl, char *));
				break;

			case 'b':
				lua_pushboolean(L, va_arg(vl, int));
				break;

			case '>':
				goto endargs;

			default:
				printf("invalid option (%c)", *(sig - 1));
		}
	}
	endargs:

	nres = strlen(sig);

	if(lua_pcall(L, narg, nres, 0) != 0) {
		printf("error calling '%s' : %s", func, lua_tostring(L, -1));
	}

	nres = -nres;

	while(*sig){
		switch (*sig++) {

			case 'd': {
				int isnum;
				double n = lua_tonumberx(L, nres, &isnum);
				if(!isnum) {
					printf("wrong result type");
				}
				*va_arg(vl, double *) = n;
				break;
			}

			case 'i': {
				int isnum;
				int n = lua_tointegerx(L, nres, &isnum);
				if(!isnum) {
					printf("wrong result type");
				}
				*va_arg(vl, int *) = n;
				break;
			}

			case 's': {
				const char *s = lua_tostring(L, nres);
				if(s == NULL) {
					printf("wrong result type");
				}
				*va_arg(vl, const char **) = s;
				break;
			}

			case 'b': {
				int b = lua_toboolean(L, nres);
				*va_arg(vl, int *) = b;
				break;
			}
			defaul: {
				printf("invalid option (%c)", *(sig - 1));
			}
		}
		nres++;
	}

	va_end(vl);
}

int main (void) {
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	if (luaL_loadfile(L, "ex26_2.lua") || lua_pcall(L, 0, 0, 0)) {
		printf("cannot run ex26_2.lua: %s", lua_tostring(L, -1));;
	}

	int b;
	printf("\n");
	printf("is 20 a number: call_va(L, 'isnumber', 'i>b', 20, &b)\n");
	call_va(L, "isnumber", "i>b", 20, &b);
	printf("b is %i\n", b);
	if(b) {
		printf("TRUE\n");
	} else {
		printf("FALSE\n");
	}
	printf("\n");

	const char *s = "test_string";
	printf("is 'test_string' a number: call_va(L, 'isnumber', 's>b', s, &b)\n");
	call_va(L, "isnumber", "s>b", s, &b);
	printf("b is %i\n", b);
	if(b) {
		printf("TRUE\n");
	} else {
		printf("FALSE\n");
	}
	printf("\n");

	lua_close(L);
	return 0;
}
