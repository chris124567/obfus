#!/bin/sh
set -eux

# not actually necessary for this to function
CFLAGS="-g -ggdb -ffunction-sections -fdata-sections -std=c++17"
CFLAGS="$CFLAGS -DDEBUG=1 -DARMA_NO_DEBUG=1"
CFLAGS="$CFLAGS -Wall -Wextra -Wstrict-prototypes -pedantic  -Wno-unused-parameter"
CFLAGS="$CFLAGS -Wl,--no-export-dynamic -Wl,--no-omagic -Wl,--discard-all -Wl,-z,defs -Wl,-z,nodelete -Wl,-z,nodump -Wl,-z,nodlopen -Wl,--no-demangle -Wl,--gc-sections -Wl,--disable-new-dtags -Wl,--hash-style=sysv -Wl,--build-id=none"
CFLAGS="$CFLAGS -Ofast -march=native -fmerge-all-constants"
CFLAGS="$CFLAGS -lgtest -lgtest_main -lpthread"
# fails to build unless libraries to link are at the end for some reason (???)
clang++-11 -fexperimental-new-pass-manager -fpass-plugin=./obfus.so test/test.cpp -o test/test $CFLAGS

./test/test