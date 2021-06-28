#ifndef TRANSFORMS_HPP
#define TRANSFORMS_HPP

#include <llvm/IR/BasicBlock.h>

namespace obfus {

bool TransformBinaryOperatorBasicBlock(llvm::BasicBlock &BB);
bool TransformIntegerConstants(llvm::BasicBlock &BB);
bool TransformFlatten(llvm::Function &F);

}  // namespace obfus

#endif