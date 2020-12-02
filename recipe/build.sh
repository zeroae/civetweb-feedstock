#!/bin/bash
set -eu

### Create Makefiles
cmake -S src \
      -B build \
      -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH\
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DPORTABLE=ON \
      -DCIVETWEB_ENABLE_CXX=ON \
      -DCIVETWEB_ENABLE_WEBSOCKETS=ON

## Build
cmake --build build -- -j${CPU_COUNT}

## Test
cmake --build build -- test

### Install
cmake --build build -- install

### Checking requires a recompile with DEBUG enabled
# cmake --build build -- check
