@echo off

FOR /F "tokens=* USEBACKQ" %%F IN (`vswhere.exe -property catalog_productLineVersion -all`) DO ( SET VS_VERSION=%%F )
for /l %%a in (1,1,128) do if "!VS_VERSION:~-1!"==" " set VS_VERSION=!VS_VERSION:~0,-1!

echo %VS_VERSION%
