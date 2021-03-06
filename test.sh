#!/bin/sh
set -eux

CFLAGS="-g -ggdb -ffunction-sections -fdata-sections"
CFLAGS="$CFLAGS -ansi -std=c89 -pedantic"
CFLAGS="$CFLAGS -Wall -Wextra -Wstrict-prototypes -pedantic  -Wno-unused-parameter"
CFLAGS="$CFLAGS -flto -Ofast -march=native -fmerge-all-constants"
# clang-11 -S -emit-llvm test/test.c -o test/test.ll $CFLAGS
clang-11 -fexperimental-new-pass-manager -fpass-plugin=./obfus.so test/test.c -o test/test $CFLAGS
# clang-11 test/test.c -o test/test $CFLAGS

./test/test
