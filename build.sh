#!/bin/sh
set -eux

CFLAGS="-fno-rtti -fPIC -shared -std=c++17"
CFLAGS="$CFLAGS -DDEBUG=1 -DARMA_NO_DEBUG=1"
CFLAGS="$CFLAGS -Wall -Wextra -Wstrict-prototypes -pedantic  -Wno-unused-parameter"
CFLAGS="$CFLAGS -Wl,--no-export-dynamic -Wl,--no-omagic -Wl,-z,nodelete -Wl,-z,nodump -Wl,--no-demangle -Wl,--gc-sections -Wl,--disable-new-dtags -Wl,--hash-style=sysv -Wl,--build-id=none"
CFLAGS="$CFLAGS -flto -Ofast -march=native -fmerge-all-constants -fdata-sections -ffunction-sections"
CFLAGS="$CFLAGS -larmadillo"
# CFLAGS="$CFLAGS -fsanitize=leak"
clang-format-11 -i -style="{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}" *.cpp test/*.c
clang++-11  *.cpp $(llvm-config-11 --cxxflags) -o obfus.so $CFLAGS
