#!/bin/sh
set -eux

CFLAGS="-fno-rtti -fPIC -shared -std=c++17 -fdata-sections -ffunction-sections"
CFLAGS="$CFLAGS -DDEBUG=1"
CFLAGS="$CFLAGS -Wall -Wextra -Wstrict-prototypes -pedantic -Wno-unused-parameter"
CFLAGS="$CFLAGS -flto -Ofast -march=native -fmerge-all-constants"
# CFLAGS="$CFLAGS -fsanitize=leak"
clang-format-11 -i -style="{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}" *.cpp *.hpp test/*.c
clang++-11 *.cpp $(llvm-config-11 --cxxflags) -o obfus.so $CFLAGS

# clang++-11 -fexperimental-new-pass-manager -fpass-plugin=./obfus.so *.cpp $(llvm-config-11 --cxxflags) -o obfus1.so $CFLAGS
