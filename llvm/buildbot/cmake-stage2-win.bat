setlocal

:: Check if argument is supplied
if "%1"=="" (
    echo Error: No argument supplied!
    exit /b 1
)

set "compilerPath=%1"

:: Check clang-cl version
"%compilerPath%" --version >nul 2>&1
if errorlevel 1 (
    echo Error: %compilerPath% is not a valid clang-cl compiler path!
    exit /b 1
) else (
    echo %compilerPath% is a valid clang-cl compiler path.
)

cmake -G Ninja ^
-DCMAKE_C_COMPILER=%compilerPath% ^
-DCMAKE_CXX_COMPILER=%compilerPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DLLVM_ENABLE_ASSERTIONS=True ^
-DLLVM_LIT_ARGS='-v' ^
-DCMAKE_INSTALL_PREFIX=..\stage2.install ^
-DCMAKE_TRY_COMPILE_CONFIGURATION=Release ^
-DCMAKE_C_COMPILER_LAUNCHER=ccache ^
-DCMAKE_CXX_COMPILER_LAUNCHER=ccache ^
-DCOMPILER_RT_BUILD_SANITIZERS=OFF ^
-DCOMPILER_RT_BUILD_PROFILE=OFF ^
-DLLVM_ENABLE_PROJECTS=lld;clang;llvm;mlir;flang;clang-tools-extra ^
-DLLVM_ENABLE_RUNTIMES=compiler-rt ^
..\llvm-project\llvm
