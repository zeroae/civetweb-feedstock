#!/bin/bash
set -eu

### Create Makefiles
cmake -S . \
      -B output \
      ${CMAKE_ARGS} \
      -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}\
      -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCIVETWEB_ENABLE_CXX=ON \
      -DCIVETWEB_ENABLE_WEBSOCKETS=ON

## Build
cmake --build output -- -j${CPU_COUNT}

### Checking requires a recompile with DEBUG enabled
$GCC unittest/cgi_test.c -o output/cgi_test.cgi
CTEST_OUTPUT_ON_FAILURE=1 cmake --build output -- test

### Install
cmake --build output -- install
