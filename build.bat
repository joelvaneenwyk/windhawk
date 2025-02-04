@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

:: Usage:
:: build.bat Debug ""
:: build.bat Release :rebuild

SET "VSCMD_START_DIR=%CD%"
IF "%FrameworkVersion%" == "" CALL "%ProgramFiles%\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvars64.bat"

SET "POSTFIX=%~2"
SET "CONFIG=%~1"
IF "%CONFIG%" == "" SET "CONFIG=Debug"

MSBuild.exe "%~dp0src\windhawk\windhawk.sln" /m /t:"app%POSTFIX%" /p:Configuration="%CONFIG%" /p:Platform="Win32" || GOTO fail
MSBuild.exe "%~dp0src\windhawk\windhawk.sln" /m /t:"engine%POSTFIX%" /p:Configuration="%CONFIG%" /p:Platform="Win32" || GOTO fail
MSBuild.exe "%~dp0src\windhawk\windhawk.sln" /m /t:"engine%POSTFIX%" /p:Configuration="%CONFIG%" /p:Platform="x64" || GOTO fail

:: Done
EXIT /b 0

:fail
EXIT /b %ERRORLEVEL%
