@echo off

REM Check if %1 is either amd64 or arm64
IF "%1" NEQ "amd64" IF "%1" NEQ "arm64" (
    echo Invalid architecture specified. Only amd64 and arm64 are supported.
    EXIT /B 0
)

:: set CUSTOM_PYHOME=C:\Users\%USERNAME%\scoop\apps\python\current
:: set CUSTOM_PYHOME=C:\Users\omair\AppData\Local\Programs\Python\Python311-arm64
IF "%1" EQU "amd64" (
    set "DEBUG_DEPS=c:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\ucrt"
) else (
    set "DEBUG_DEPS=c:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\arm64\ucrt"
)

IF NOT EXIST "%DEBUG_DEPS%" (
    echo "Invalid path %DEBUG_DEPS%"
    EXIT /B 0
)

SET DIA_SDK_DEPS=c:\Program Files\Microsoft Visual Studio\2022\Community\DIA SDK\bin\%1
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

IF "%1"=="arm64" (
    "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsarm64.bat"
) else IF "%1"=="amd64" (
    "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
) else (
    echo Environment initialization for %1 Failed...
)
