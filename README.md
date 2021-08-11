## Obfus
LLVM obfuscation pass.  Works natively with clang and LLVM's `opt` tool.  Refer to `test.sh` for information on using it with clang.

## Features

- Control flow flattening
- Replacing integer constants with complex expressions
- Replacing binary operations with complex expressions

## TODO

- Most of the transformations used by Snapchat described [here](https://hot3eed.github.io/2020/06/18/snap_p1_obfuscations.html): "joint functions", scratch arguments, etc.
