#!/bin/sh

rm -rf build
mkdir build
cd build

# BLASFEO_TARGET is set in the meta.yaml's
# script_env section, depending on the microarch
# level being built
cmake ${CMAKE_ARGS} -GNinja .. \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING:BOOL=ON \
      -DBLASFEO_TESTING:BOOL=OFF \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DTARGET=${BLASFEO_TARGET}

cmake --build . --config Release
cmake --build . --config Release --target install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --output-on-failure -C Release
fi
