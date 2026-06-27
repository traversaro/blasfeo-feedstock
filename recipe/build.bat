rmdir /s /q build
mkdir build
cd build

cmake ^
    -G "Ninja" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_TESTING:BOOL=ON ^
    -DBLASFEO_TESTING:BOOL=OFF ^
    -DBLASFEO_EXAMPLES:BOOL=OFF ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DTARGET=%BLASFEO_TARGET% ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Test.
:: if errorlevel 1 exit 1
:: ctest --output-on-failure -C Release
