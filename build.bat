@echo off

set START_PATH=%cd%

if not exist build mkdir build
del /Q build\%1
if not exist build\%1 mkdir build\%1
cd build\%1

cl /MD /O2 /c /DLUA_BUILD_AS_DLL ..\..\%1\src\*.c
ren lua.obj lua.o
ren luac.obj luac.o
link /DLL /IMPLIB:%1.lib /OUT:%1.dll *.obj 
link /OUT:%1.exe lua.o %1.lib 
lib /OUT:%1-static.lib *.obj
link /OUT:luac.exe luac.o %1-static.lib

del *.obj
del *.o
del *.exp
del luac.lib

cd %START_PATH%
