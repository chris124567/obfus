#ifndef OBFUS_HPP
#define OBFUS_HPP

#include <llvm/IR/Function.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassPlugin.h>

namespace obfus {
struct Obfus : llvm::PassInfoMixin<Obfus> {
   public:
    llvm::PreservedAnalyses run(llvm::Function &F, llvm::FunctionAnalysisManager &);
};
}  // namespace obfus

extern "C" LLVM_ATTRIBUTE_WEAK llvm::PassPluginLibraryInfo llvmGetPassPluginInfo();

#endif