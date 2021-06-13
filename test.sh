#!/bin/sh
set -eux

# not actually necessary for this to function
LINKERARGS="-Wl,--no-export-dynamic -Wl,--no-omagic -Wl,--discard-all -Wl,-z,defs -Wl,-z,nodelete -Wl,-z,nodump -Wl,-z,nodlopen -Wl,--no-demangle -Wl,--gc-sections -Wl,--disable-new-dtags -Wl,--hash-style=sysv -Wl,--build-id=none"
# fails to build unless libraries to link are at the end for some reason (???)
clang++-11 -Ofast -march=native -fexperimental-new-pass-manager -fpass-plugin=./obfus.so test/test.cpp -o test/test -std=c++17 -lgtest -lgtest_main -lpthread $LINKERARGS

./test/test