@echo off
setlocal ENABLEDELAYEDEXPANSION

set START_PATH=%cd%
set VERSION=%1
set ARCH=%2
set BITS=32

if "%ARCH%"=="x64" set BITS=64

FOR /F "tokens=* USEBACKQ" %%F IN (`vswhere.exe -property installationPath -all`) DO ( SET VSPATH=%%F )
for /l %%a in (1,1,128) do if "!VSPATH:~-1!"==" " set VSPATH=!VSPATH:~0,-1!

FOR /F "tokens=* USEBACKQ" %%F IN (`vswhere.exe -property catalog_productLineVersion -all`) DO ( SET VSVER=%%F )
for /l %%a in (1,1,128) do if "!VSVER:~-1!"==" " set VSVER=!VSVER:~0,-1!

call "%VSPATH%\VC\Auxiliary\Build\vcvars%BITS%.bat"

set LUA_NAME=lua-%1
set BUILD_DIR=build\lua-%1-vs%VSVER%-%ARCH%

if not exist build mkdir build
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
del /Q %BUILD_DIR%
cd %BUILD_DIR%

cl /MD /MP /O2 /c /DLUA_BUILD_AS_DLL ..\..\%LUA_NAME%\src\*.c
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
