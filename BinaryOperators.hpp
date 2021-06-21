#ifndef BINARYOPERATORS_HPP
#define BINARYOPERATORS_HPP

#include <llvm/IR/Value.h>

llvm::Value *ObfuscateAdd(llvm::Value *x, llvm::Value *y);

#endif