#include "Obfus.hpp"

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

#include <cstdlib>

using namespace llvm;

static bool transformIntegerConstants(BasicBlock &BB) {
    bool changed = false;

    // see https://sci-hub.ee/https://link.springer.com/chapter/10.1007/978-3-540-77535-5_5
    // TODO: turn integer constants into complex expressions
    for (auto I = BB.begin(); I != BB.end(); ++I) {
    }

    return changed;
}

static bool transformBinaryOperatorBasicBlock(BasicBlock &BB) {
    bool changed = false;

    for (auto I = BB.begin(); I != BB.end(); ++I) {
        // Skip non-binary (e.g. unary or compare) instructions
        const auto binOp = dyn_cast<BinaryOperator>(I);
        if (!binOp) {
            continue;
        }

        IRBuilder<> builder(binOp);

        // useful variables in building the instruction for substitution
        const auto &valNegative1 = ConstantInt::get(binOp->getType(), -1);
        const auto &val1 = ConstantInt::get(binOp->getType(), 1);
        const auto &val2 = ConstantInt::get(binOp->getType(), 2);
        const auto &x = binOp->getOperand(0);
        const auto &y = binOp->getOperand(1);

        Value *newValue = nullptr;
        /*
Compiled from various stackoverflow posts and some experimentation

To test proofs, run this first (python):
>>> import z3
>>> x, y = z3.BitVecs('x y', 64)
        */
        switch (I->getOpcode()) {
            case Instruction::Add:
#ifdef DEBUG
                errs() << "Instruction::Add\n";
#endif

                /*
            Replace addition with ((x ^ y) + 2*(x & y))
            >>> z3.prove(((x ^ y) + 2*(x & y)) == (x + y))
            proved
                */
                newValue = builder.CreateAdd(builder.CreateXor(x, y), builder.CreateMul(val2, builder.CreateAnd(x, y)));
                break;
            case Instruction::Sub:
#ifdef DEBUG
                errs() << "Instruction::Sub\n";
#endif
                /*
            Replace subtraction with (x + ((y^-1) + 1))
            >>> z3.prove((x - y) == (x + ((y^-1) + 1)))
            proved
                */
                newValue = builder.CreateAdd(x, builder.CreateAdd(builder.CreateXor(y, valNegative1), val1));
                break;
            case Instruction::Xor:
#ifdef DEBUG
                errs() << "Instruction::Xor\n";
#endif
                /*
            Replace exclusive or with ((x|y) - (x&y))
            >>> z3.prove(((x|y) - (x&y)) == (x^y))
            proved
                */
                newValue = builder.CreateSub(builder.CreateOr(x, y), builder.CreateAnd(x, y));
                break;
            case Instruction::Or:
#ifdef DEBUG
                errs() << "Instruction::Or\n";
#endif
                /*
            Replace inclusive or with (x ^ y) ^ (x & y)
            >>> z3.prove((x | y) == ((x ^ y) ^ (x & y)))
            proved
                */
                newValue = builder.CreateXor(builder.CreateXor(x, y), builder.CreateAnd(x, y));
                break;
            case Instruction::And:
#ifdef DEBUG
                errs() << "Instruction::And\n";
#endif
                /*
            Replace and with (-1 - ((-1 - x) | (-1 - y)))
            >>> z3.prove((-1 - ((-1 - x) | (-1 - y))) == (x & y))
            proved
                */
                newValue = builder.CreateSub(valNegative1, builder.CreateOr(builder.CreateSub(valNegative1, x), builder.CreateSub(valNegative1, y)));
                break;
        }
        // if we have something to replace the instruction with, replace it
        if (newValue) {
            binOp->replaceAllUsesWith(newValue);
            changed = true;
        }
    }
    return changed;
}

PreservedAnalyses Obfus::run(Function &F, FunctionAnalysisManager &) {
    bool changed = false;

    for (auto &BB : F) {
        changed |= transformBinaryOperatorBasicBlock(BB);
        changed |= transformIntegerConstants(BB);
    }
#ifdef DEBUG
    if (changed) {
        errs() << "Obfuscated " << F.getName() << "\n\n";
    }
#endif

    return changed ? llvm::PreservedAnalyses::none() : llvm::PreservedAnalyses::all();
};

// make our plugin load by default so it works with clang
extern "C" LLVM_ATTRIBUTE_WEAK ::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "Obfus Pass", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                // initialize random seed - TODO: make configurable
                srand(0);

                // for opt command
                PB.registerPipelineParsingCallback(
                    [](StringRef Name, FunctionPassManager &FPM,
                       ArrayRef<PassBuilder::PipelineElement>) {
                        FPM.addPass(Obfus());
                        return true;
                    });

                // auto register for clang
                // need to use at least O1 for it to register - there is no
                // other "default" callback for clang we can get aside from
                // the optimization ones
                // FIXME: using -flto prevents many of the obfuscations from working,
                // likely because it runs after regular optimizations. need to find
                // callback that runs right after lto is finished.
                PB.registerOptimizerLastEPCallback(
                    [](ModulePassManager &MPM, PassBuilder::OptimizationLevel) {
                        MPM.addPass(createModuleToFunctionPassAdaptor(Obfus()));
                    });
            }};
}
