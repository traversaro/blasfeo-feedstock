rmdir /s /q build
mkdir build
cd build

:: CMake scripts treat backslashes as escape characters. Normalize the
:: install prefix to forward slashes to avoid invalid escapes such as \s.
set "CMAKE_INSTALL_PREFIX_FWD=%LIBRARY_PREFIX:\=/%"

cmake %CMAKE_ARGS% ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%CMAKE_INSTALL_PREFIX_FWD%" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
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
