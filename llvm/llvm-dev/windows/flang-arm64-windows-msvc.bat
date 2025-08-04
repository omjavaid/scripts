@echo off
:: This script builds LLVM from scratch on AArch64 Windows.
:: It requires MSVC tools along with clang-cl WoA release.

:: This script is to be run from llvm build directory.
:: If current directory is not empty, user is given a 
:: choice for a clean build or script will exit.
dir /A /B  | findstr /R ".">NUL && goto error_dir_not_empty

:do_llvm_build

:: Set MSVC build environment to x86_arm64
:: call "c:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsx86_arm64.bat"

:: TODO: Allow for debug builds via commandline arguments.
:: TODO: Allow selection between clang-cl and cl via commandline arguments.
:: TODO: Allow user to select projects to build. Currently building LLDB, LLD and Clang.
:: -DLLVM_NATIVE_ARCH=AArch64 ^
:: -DLLVM_HOST_TRIPLE=aarch64-windows-msvc ^
:: -DLLVM_DEFAULT_TARGET_TRIPLE=aarch64-windows-msvc ^
:: -DLLVM_TARGETS_TO_BUILD="AArch64;ARM" ^
:: -DLLVM_ENABLE_ASSERTIONS=False ^
:: -DCLANG_DEFAULT_LINKER=lld ^

:: -DCMAKE_C_COMPILER=clang-cl ^
:: -DCMAKE_CXX_COMPILER=clang-cl ^
:: -DLLVM_PARALLEL_LINK_JOBS=4 
:: -DLLVM_ENABLE_RUNTIMES="compiler-rt" ^

:: -DCMAKE_EXE_LINKER_FLAGS=%builtins% ^
:: -DCMAKE_SHARED_LINKER_FLAGS=%builtins% ^
:: -DCMAKE_STATIC_LINKER_FLAGS=%builtins% ^
:: -DCMAKE_MODULE_LINKER_FLAGS=%builtins% ^
:: -DCLANG_DEFAULT_LINKER=lld ^
:: -DCMAKE_EXPORT_COMPILE_COMMANDS=True ^
:: -DCLANG_DEFAULT_RTLIB=compiler-rt ^
:: -DLLVM_OPTIMIZED_TABLEGEN=True ^
:: -DCOMPILER_RT_BUILD_SANITIZERS=False ^
:: -DCOMPILER_RT_BUILD_PROFILE=OFF ^
:: -DCOMPILER_RT_BUILD_CRT=OFF ^
:: -DLLVM_FORCE_USE_OLD_TOOLCHAIN=True ^
:: -DCOMPILER_RT_BUILD_SANITIZERS=OFF -DCOMPILER_RT_BUILD_MEMPROF=OFF -DCOMPILER_RT_BUILD_XRAY=OFF 
:: -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;flang;mlir;llvm;lld;lldb;compiler-rt" ^
:: -DCOMPILER_RT_SANITIZERS_TO_BUILD="dfsan;msan;hwasan;tsan;cfi" ^

:: -DLLDB_TEST_USER_ARGS="--skip-category=watchpoint" ^
:: -DLLDB_TEST_COMPILER=cl.exe ^
:: -DLLVM_ENABLE_LTO=ON ^
:: -DLLVM_PARALLEL_LINK_JOBS=1 ^
:: -DCOMPILER_RT_BUILD_SANITIZERS=False ^
:: -DCOMPILER_RT_BUILD_PROFILE=OFF ^


cmake -G Ninja ^
-DCMAKE_BUILD_TYPE=Release ^
-DLLVM_TARGETS_TO_BUILD=X86;AArch64 ^
-DLLVM_ENABLE_ASSERTIONS=True ^
-DCMAKE_TRY_COMPILE_CONFIGURATION=Release ^
-DLLVM_ENABLE_PROJECTS="clang;llvm;lld;mlir;flang" ^
-DLLVM_CCACHE_BUILD=ON ^
-DCLANG_DEFAULT_LINKER=lld ^
-DLLVM_ENABLE_RUNTIMES="compiler-rt;flang-rt;openmp" ^
-DCOMPILER_RT_BUILD_SANITIZERS=False ^
..\llvm-project\llvm


goto end

:clean_build_dir
set BUILD_DIR=%cd%
cd ..
rd /S /Q %BUILD_DIR%
mkdir %BUILD_DIR%
cd %BUILD_DIR%
endlocal
goto do_llvm_build

:error_dir_not_empty
echo LLVM build directory is not empty
setlocal
set /P SURE=Do you want to do a clean build (Y/[N])?
IF /I "%SURE%" EQU "Y" goto clean_build_dir
goto end

:end
pause
