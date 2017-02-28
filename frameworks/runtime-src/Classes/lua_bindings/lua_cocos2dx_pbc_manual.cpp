#include "lua_bindings/lua_cocos2dx_pbc_manual.h"

#include "platform/CCPlatformConfig.h"
#include "base/ccConfig.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"

#include "lua_bindings/pbc-lua.h"

#include "cocos/platform/CCFileUtils.h"

int read_file_c(lua_State *L){
	std::string str = tolua_tostring(L, 1, "");
	std::string path = FileUtils::getInstance()->fullPathForFilename(str);
	Data data = FileUtils::getInstance()->getDataFromFile(path);
	lua_pushlstring(L, (const char*)data.getBytes(), data.getSize());
	return 1;
}

TOLUA_API int register_pbc_module(lua_State* L)
{
	lua_getglobal(L, "_G");
	if (lua_istable(L, -1))//stack:...,_G,
	{
		lua_register(L, "read_file_c", read_file_c);
		luaopen_protobuf_c(L);
	}
	lua_pop(L, 1);
	return 1;
}