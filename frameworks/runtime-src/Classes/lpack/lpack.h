#ifndef __LAPCK_H__
#define __LAPCK_H__

#ifdef __cplusplus
extern "C" {
#endif
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
extern "C" {
#endif
	int luaopen_pack(lua_State *L);
#ifdef __cplusplus
}
#endif

#endif