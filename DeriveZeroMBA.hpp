#ifndef DERIVE_ZERO_MBA_HPP
#define DERIVE_ZERO_MBA_HPP

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Value.h>

llvm::Value *GenerateRandomMBAIdentity(llvm::IRBuilder<> &builder, llvm::Type *type, const std::vector<llvm::Value *> &vars);

#endif