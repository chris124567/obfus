#ifndef TRANSFORMS_HPP
#define TRANSFORMS_HPP

#include <llvm/IR/BasicBlock.h>

namespace obfus {
    bool TransformBinaryOperatorBasicBlock(llvm::BasicBlock &BB);
    bool TransformIntegerConstants(llvm::BasicBlock &BB);
    bool TransformControlFlow(llvm::BasicBlock &BB);
}

#endif