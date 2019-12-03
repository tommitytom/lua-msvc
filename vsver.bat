@echo off

FOR /F "tokens=1 usebackq" %%F IN (`vswhere.exe -property catalog_productLineVersion -all`) DO ( SET VS_VERSION=%%F )
CALL :TRIM %VS_VERSION% VS_VERSION

echo "%VS_VERSION%"
GOTO :EOF

:TRIM
SET %2=%1
GOTO :EOF
