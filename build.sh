#!/bin/sh
set -eux

LINKERARGS="-Wl,--no-export-dynamic -Wl,--no-omagic -Wl,-z,nodelete -Wl,-z,nodump -Wl,--no-demangle -Wl,--gc-sections -Wl,--disable-new-dtags -Wl,--hash-style=sysv -Wl,--build-id=none"
clang-format-11 -i -style="{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}" *.cpp test/*.cpp
clang++-11 -DDEBUG=1 -fPIC -shared *.cpp $(llvm-config-11 --cxxflags) -fno-rtti -o obfus.so -Wall -Wextra -Wstrict-prototypes -Ofast -march=native -fmerge-all-constants -Wno-unused-parameter -std=c++17 -pedantic $LINKERARGS