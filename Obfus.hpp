#ifndef OBFUS_HPP
#define OBFUS_HPP

#include <llvm/IR/PassManager.h>
#include <llvm/IR/Function.h>

struct Obfus : llvm::PassInfoMixin<Obfus> {
public:
    llvm::PreservedAnalyses run(llvm::Function &F, llvm::FunctionAnalysisManager &);
};

#endif