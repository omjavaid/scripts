@echo off

:: REM Check if %1 is either amd64 or arm64
:: IF "%1" NEQ "amd64" IF "%1" NEQ "arm64" (
::    echo Invalid architecture specified. Only amd64 and arm64 are supported.
::    EXIT /B 0
::)

REM Check the architecture and convert to lowercase
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set ARCH=amd64
    set ALT_ARCH=x64
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set ARCH=arm64
    set ALT_ARCH=arm64
) else (
    echo Invalid architecture. Only amd64 and arm64 are supported.
    EXIT /B 0
)

:: set CUSTOM_PYHOME=C:\Users\%USERNAME%\scoop\apps\python\current
:: set CUSTOM_PYHOME=C:\Users\omair\AppData\Local\Programs\Python\Python311-arm64

set "DEBUG_DEPS=c:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt;c:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\%ALT_ARCH%\ucrt"

set DIA_SDK_DEPS=c:\Program Files\Microsoft Visual Studio\2022\Community\DIA SDK\bin\%ARCH%
IF NOT EXIST "%DIA_SDK_DEPS%" (
    echo "Invalid path %DIA_SDK_DEPS%"
    EXIT /B 0
)

:: set PYTHONHOME=%CUSTOM_PYHOME%

set LLVM_LIT_DIR=

:: set "BUILTINS=%TOOLS_DIR%\\LLVM\\lib\\clang\\15.0.1\\lib\windows\\clang_rt.builtins-aarch64.lib"
:: set PERL_DIR=C:\Users\omair\Downloads\strawberry-perl-5.32.1.1-64bit-portable\perl\bin

set "PATH=%DIA_SDK_DEPS%;%DEBUG_DEPS%;%PATH%"

set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"

set "LLDB_USE_LLDB_SERVER=1"

set LIT_OPTS="-svj 4"

IF "%ARCH%"=="arm64" (
    "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsamd64_arm64.bat"
) else IF "%ARCH%"=="amd64" (
    "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
) else (
    echo Environment initialization for %ARCH% Failed...
)
