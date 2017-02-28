# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lpack C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

add_definitions ( -DluaL_reg=luaL_Reg )

install_lua_module ( pack lpack.c pack.def )
install_data ( README )
install_test ( test.lua )

add_lua_test ( test.lua )
#improve: add better test suite.
