@echo off
setlocal

:: Set version and directories
set LIBXML_VERSION=2.9.12
set LIBXML_DIR=%cd%\libxml2-v%LIBXML_VERSION%
set INSTALL_DIR=%cd%\libxml2_static
set BUILD_DIR=%cd%\libxml2_build

:: Download libxml2 source
if not exist libxml2-v%LIBXML_VERSION%.tar.gz (
    echo Downloading libxml2 version %LIBXML_VERSION%
    curl -O https://gitlab.gnome.org/GNOME/libxml2/-/archive/v%LIBXML_VERSION%/libxml2-v%LIBXML_VERSION%.tar.gz || exit /b 1
)

:: Extract the source
if not exist %LIBXML_DIR% (
    echo Extracting libxml2
    tar zxf libxml2-v%LIBXML_VERSION%.tar.gz || exit /b 1
)

:: Create build and install directories
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
if not exist %INSTALL_DIR% mkdir %INSTALL_DIR%

:: Move to build directory
cd %BUILD_DIR%

:: Configure the build using CMake with Ninja
echo Configuring libxml2 for static build using CMake and Ninja

cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% ^
  -DBUILD_SHARED_LIBS=OFF -DLIBXML2_WITH_C14N=OFF -DLIBXML2_WITH_CATALOG=OFF ^
  -DLIBXML2_WITH_DEBUG=OFF -DLIBXML2_WITH_DOCB=OFF -DLIBXML2_WITH_FTP=OFF ^
  -DLIBXML2_WITH_HTML=OFF -DLIBXML2_WITH_HTTP=OFF -DLIBXML2_WITH_ICONV=OFF ^
  -DLIBXML2_WITH_ICU=OFF -DLIBXML2_WITH_ISO8859X=OFF -DLIBXML2_WITH_LEGACY=OFF ^
  -DLIBXML2_WITH_LZMA=OFF -DLIBXML2_WITH_MEM_DEBUG=OFF -DLIBXML2_WITH_MODULES=OFF ^
  -DLIBXML2_WITH_OUTPUT=ON -DLIBXML2_WITH_PATTERN=OFF -DLIBXML2_WITH_PROGRAMS=OFF ^
  -DLIBXML2_WITH_PUSH=OFF -DLIBXML2_WITH_PYTHON=OFF -DLIBXML2_WITH_READER=OFF ^
  -DLIBXML2_WITH_REGEXPS=OFF -DLIBXML2_WITH_RUN_DEBUG=OFF -DLIBXML2_WITH_SAX1=OFF ^
  -DLIBXML2_WITH_SCHEMAS=OFF -DLIBXML2_WITH_SCHEMATRON=OFF -DLIBXML2_WITH_TESTS=OFF ^
  -DLIBXML2_WITH_THREADS=ON -DLIBXML2_WITH_THREAD_ALLOC=OFF -DLIBXML2_WITH_TREE=ON ^
  -DLIBXML2_WITH_VALID=OFF -DLIBXML2_WITH_WRITER=OFF -DLIBXML2_WITH_XINCLUDE=OFF ^
  -DLIBXML2_WITH_XPATH=OFF -DLIBXML2_WITH_XPTR=OFF -DLIBXML2_WITH_ZLIB=OFF ^
  -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded ^
  %LIBXML_DIR% || exit /b 1

:: Build the library using Ninja
echo Building libxml2 with Ninja
ninja || exit /b 1

:: Install the library to the specified location
echo Installing libxml2
ninja install || exit /b 1

:: Display success message
echo libxml2 has been built and installed as a static library in %INSTALL_DIR%.

endlocal
pause

