set CC=c:\\work\\llvm-dev\\build\\bin\\clang-cl.exe

set CXX=c:\\work\\llvm-dev\\build\\bin\\clang-cl.exe

set FF="c:/work/llvm-dev/build/bin/flang-new.exe"
::
set NO_STOP_MESSAGE=1

cmake -G Ninja -DTEST_SUITE_FORTRAN=ON -DCMAKE_Fortran_COMPILER=%FF% -DTEST_SUITE_COLLECT_COMPILE_TIME=ON -DTEST_SUITE_LIT=c:\\work\\llvm-dev\\build\\bin\\llvm-lit.py  -DTEST_SUITE_SUBDIRS="Fortran" ..\\llvm-test-suite

:: cmake -G Ninja -DCMAKE_C_COMPILER="c:/work/llvm-dev/build/bin/clang-cl.exe" -DTEST_SUITE_COLLECT_COMPILE_TIME=OFF -DTEST_SUITE_LIT=c:\\work\\llvm-dev\\build\\bin\\llvm-lit.py  -DTEST_SUITE_SUBDIRS="SingleSource" ..\\llvm-test-suite
