@echo on

set CUSTOM_PYHOME=C:\Users\Omair\scoop\apps\python\current

:: Same for both WoA and WoX if SDK 19041 is installed
Set DEBUG_DEPS=c:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\arm64\ucrt

:: WoX amd64 - WoA arm64
SET DIA_SDK_DEPS=c:\Program Files\Microsoft Visual Studio\2022\Community\DIA SDK\bin\amd64

set PYTHONHOME=%CUSTOM_PYHOME%

:: set LLVM_LIT_DIR=


:: set "BUILTINS=%TOOLS_DIR%\\LLVM\\lib\\clang\\15.0.1\\lib\windows\\clang_rt.builtins-aarch64.lib"
:: set PERL_DIR=C:\Users\omair\Downloads\strawberry-perl-5.32.1.1-64bit-portable\perl\bin

set "PATH=%DIA_SDK_DEPS%;%DEBUG_DEPS%;%PATH%"

set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"

set "LLDB_USE_LLDB_SERVER=1"

set LIT_OPTS="-svj 4"

"c:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
:: "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
:: "c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsarm64.bat"
