@echo off

set START_PATH=%cd%
set VERSION=%1
set LUA_NAME=lua-%1
set BUILD_DIR=build\lua-%1

if not exist build mkdir build
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
del /Q %BUILD_DIR%
cd %BUILD_DIR%

cl /MD /O2 /c /DLUA_BUILD_AS_DLL ..\..\%LUA_NAME%\src\*.c
ren lua.obj lua.o
ren luac.obj luac.o
link /DLL /IMPLIB:%LUA_NAME%.lib /OUT:%LUA_NAME%.dll *.obj
link /OUT:%LUA_NAME%.exe lua.o %LUA_NAME%.lib
lib /OUT:%LUA_NAME%-static.lib *.obj
link /OUT:luac-%VERSION%.exe luac.o %LUA_NAME%-static.lib

del *.obj
del *.o
del *.exp
del luac-%VERSION%.lib

cd %START_PATH%
