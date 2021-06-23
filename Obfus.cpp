#include "Obfus.hpp"

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

#include <cstdlib>

#include "Transforms.hpp"

llvm::PreservedAnalyses Obfus::run(llvm::Function &F, llvm::FunctionAnalysisManager &) {
    bool changed = false;
    const auto &name = F.getName();

    if (name == "main") {
#ifdef DEBUG
        llvm::errs() << "Skipping " << name << ", blacklisted\n";
#endif
        // skip main for now because that has our tests
        return llvm::PreservedAnalyses::all();
    }

#ifdef DEBUG
    llvm::errs() << "Attempting " << name << "\n";
#endif

    for (auto &BB : F) {
        // ORIGINAL ORDER:
        // changed |= obfus::TransformBinaryOperatorBasicBlock(BB);
        // changed |= obfus::TransformIntegerConstants(BB);
        // NEW ORDER:
        changed |= obfus::TransformIntegerConstants(BB);
        changed |= obfus::TransformBinaryOperatorBasicBlock(BB);
    }

#ifdef DEBUG
    if (changed) {
        llvm::errs() << "Obfuscated " << F.getName() << "\n";
    } else {
        llvm::errs() << "Did not change " << F.getName() << "\n";
    }
#endif

    return changed ? llvm::PreservedAnalyses::none() : llvm::PreservedAnalyses::all();
};

// make our plugin load by default so it works with clang
extern "C" LLVM_ATTRIBUTE_WEAK llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "Obfus Pass", LLVM_VERSION_STRING,
            [](llvm::PassBuilder &PB) {
                // constexpr const int seed = 0;
                const int seed = std::time(nullptr);
                srand(seed);
#ifdef DEBUG
                llvm::errs() << "Random seed: " << seed << "\n";
#endif

                // for opt command
                PB.registerPipelineParsingCallback(
                    [](llvm::StringRef Name, llvm::FunctionPassManager &FPM,
                       llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {
                        FPM.addPass(Obfus());
                        return true;
                    });

                /*
                auto register for clang
                need to use at least O1 for it to register - there is no
                other "default" callback for clang we can get aside from
                the optimization ones
                there is two options - register before optimizations have run, or after.
                running before means some of your obfuscation will probably be obfuscated
                away.  this is useful during development to make sure you make your
                obfuscations more rigorous.  however in production in may be desirable
                to run obfuscations after optimizations, in which case you can uncomment
                the registerOptimizerLastEPCallback code and comment the registerPipelineStartEPCallback
                code
                */
                PB.registerPipelineStartEPCallback(
                    [](llvm::ModulePassManager &MPM) {
                        MPM.addPass(createModuleToFunctionPassAdaptor(Obfus()));
                    });
                // PB.registerOptimizerLastEPCallback(
                //     [](ModulePassManager &MPM, PassBuilder::OptimizationLevel) {
                //         MPM.addPass(createModuleToFunctionPassAdaptor(Obfus()));
                //     });
            }};
}
