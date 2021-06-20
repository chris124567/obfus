#include "Obfus.hpp"

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

#include <cstdlib>
#include <iostream>

#include "DeriveZeroMBA.hpp"

using namespace llvm;

static bool TransformIntegerConstants(BasicBlock &BB) {
    bool changed = false;

    // see https://sci-hub.ee/https://link.springer.com/chapter/10.1007/978-3-540-77535-5_5
    // TODO: turn integer constants into complex expressions
    for (auto I = BB.begin(); I != BB.end(); ++I) {
        const auto icmp_op = dyn_cast<ICmpInst>(I);
        if (!icmp_op || !icmp_op->getType()->isIntegerTy()) {
            // if its not an integer comparison, go to next instruction
            continue;
        }
        // if we do not have two operands
        if (icmp_op->getNumOperands() != 2) {
            continue;
        }

        const auto x = icmp_op->getOperand(0);
        const auto y = icmp_op->getOperand(1);
        const auto x_value = dyn_cast<ConstantInt>(x);
        const auto y_value = dyn_cast<ConstantInt>(y);
        // if neither are const integers
        if (!x_value && !y_value) {
            continue;
        }
        const auto value_replace_index = (x_value) ? 0 : 1;
        const auto value_replace = (value_replace_index == 0) ? x_value : y_value;
        // we only support 0 for now
        if (value_replace->getSExtValue() != 0) {
            continue;
        }

        const auto same = (value_replace_index == 0) ? y : x;
        // std::vector<Value *> vars{same, ConstantInt::get(value_replace->getType(), std::rand()), same};
        std::vector<Value *> vars{same, ConstantInt::get(value_replace->getType(), std::rand()), ConstantInt::get(value_replace->getType(), std::rand())};

        llvm::IRBuilder<> builder(icmp_op);
        icmp_op->setOperand(value_replace_index, GenerateRandomMBAIdentity(builder, value_replace->getType(), vars));
        changed = true;
    }

    return changed;
}

static bool TransformBinaryOperatorBasicBlock(BasicBlock &BB) {
    bool changed = false;

    for (auto I = BB.begin(); I != BB.end(); ++I) {
        // Skip non-binary (e.g. unary or compare) instructions
        const auto bin_op = dyn_cast<BinaryOperator>(I);
        if (!bin_op || !bin_op->getType()->isIntegerTy()) {
            continue;
        }

        IRBuilder<> builder(bin_op);

        // useful variables in building the instruction for substitution
        // const auto val_negative_1 = ConstantInt::get(bin_op->getType(), -1);
        const auto val_negative_2 = ConstantInt::get(bin_op->getType(), -2);
        const auto val_1 = ConstantInt::get(bin_op->getType(), 1);
        const auto val_2 = ConstantInt::get(bin_op->getType(), 2);
        const auto x = bin_op->getOperand(0);
        const auto y = bin_op->getOperand(1);

        Value *new_value = nullptr;
        /*
Compiled from various stackoverflow posts and some experimentation

To test proofs, run this first (python):
>>> import z3
>>> x, y = z3.BitVecs('x y', 64)
        */
        const auto rand = std::rand();
#ifdef DEBUG
        errs() << "Opcode: Instruction::" << I->getOpcodeName() << "\n";
#endif

        switch (I->getOpcode()) {
            case Instruction::Add:
                /*
            Replace addition with ((x ^ y) + 2*(x & y)) or ((x ^ y) - ((-2*x - 1) | (-2*y - 1)) -1) or (2*(x | y) - (~x & y) - (x & ~y))
            >>> z3.prove((x + y) == ((x ^ y) + 2*(x & y)))
            proved
            >>> z3.prove((x + y) == ((x ^ y) - ((-2*x - 1) | (-2*y - 1)) -1))
            proved
            >>> z3.prove((x + y) == (2*(x | y) - (~x & y) - (x & ~y)))
            proved
                */
                switch (rand % 3) {
                    case 0:
                        new_value = builder.CreateAdd(builder.CreateXor(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateXor(x, y), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_negative_2, y), val_1)), val_1));
                        break;
                    case 2:
                        new_value = builder.CreateSub(builder.CreateMul(val_2, builder.CreateOr(x, y)), builder.CreateAdd(builder.CreateAnd(builder.CreateNot(x), y), builder.CreateAnd(x, builder.CreateNot(y))));
                        break;
                }
                break;
            case Instruction::Sub:
                /*
            Replace subtraction with (x + ((y^-1) + 1)) or ((x ^ (~y+1)) - ((-2*x - 1) | (2*y - 1)) - 1) or ((x & ~y) - (~x & y)) or (~(~x + y))
            >>> z3.prove((x - y) == (x + ((y^-1) + 1)))
            proved
            >>> z3.prove((x - y) == ((x ^ (~y+1)) - ((-2*x - 1) | (2*y - 1)) - 1))
            proved
            >>> z3.prove((x - y) == ((x & ~y) - (~x & y)))
            proved
            >>> z3.prove((x - y) == ~(~x + y))
            proved
                */
                switch (rand % 3) {
                    case 0:
                        new_value = builder.CreateSub(builder.CreateXor(x, builder.CreateAdd(builder.CreateNot(y), val_1)), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_2, y), val_1)), val_1));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateAnd(x, builder.CreateNot(y)), builder.CreateAnd(builder.CreateNot(x), y));
                        break;
                    case 2:
                        new_value = builder.CreateNot(builder.CreateAdd(builder.CreateNot(x), y));
                        break;
                }
                break;
            case Instruction::Xor:
                /*
                Replace exclusive or with ((x|y) - (x&y)) or  (x + y - 2*(x & y))
                >>> z3.prove((x ^ y) == ((x|y) - (x&y)))
                proved
                >>> z3.prove((x ^ y) == (x + y - 2*(x & y)))
                proved
                    */
                new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));
                break;
            case Instruction::Or:

                /*
                Replace inclusive or with (x ^ y) ^ (x & y) or (x + y - (x & y))
                >>> z3.prove((x | y) == ((x ^ y) ^ (x & y)))
                proved
                >>> z3.prove((x | y) == (x + y - (x & y)))
                proved
                    */
                new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateAnd(x, y));
                break;
            case Instruction::And:
                /*
                Replace and with (-1 - ((-1 - x) | (-1 - y))) or (x + y - (x|y)) or ((x | y) - (~x & y) - (x & ~y))
                >>> z3.prove((x & y) == (-1 - ((-1 - x) | (-1 - y))))
                proved
                >>> z3.prove((x & y) == (x + y - (x|y)))
                proved
                >>> z3.prove((x & y) == ((x | y) - (~x & y) - (x & ~y)))
                proved
                    */
                new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateOr(x, y));
                break;
        }
        // if we have something to replace the instruction with, replace it
        if (new_value) {
            bin_op->replaceAllUsesWith(new_value);
            changed = true;
        }
    }
    return changed;
}

PreservedAnalyses Obfus::run(Function &F, FunctionAnalysisManager &) {
    bool changed = false;
    const auto &name = F.getName();

#ifdef DEBUG
    errs() << "Attempting " << name << "\n";
#endif

    for (auto &BB : F) {
        // changed |= TransformBinaryOperatorBasicBlock(BB);
        changed |= TransformIntegerConstants(BB);
    }

#ifdef DEBUG
    if (changed) {
        errs() << "Obfuscated " << F.getName() << "\n";
    } else {
        errs() << "Did not change " << F.getName() << "\n";
    }
#endif

    return changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
};

// make our plugin load by default so it works with clang
extern "C" LLVM_ATTRIBUTE_WEAK ::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "Obfus Pass", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                // constexpr const int seed = 1624216247;
                const int seed = std::time(nullptr);
                errs() << "Random seed: " << seed << "\n";
                srand(seed);

                // for opt command
                PB.registerPipelineParsingCallback(
                    [](StringRef Name, FunctionPassManager &FPM,
                       ArrayRef<PassBuilder::PipelineElement>) {
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
                    [](ModulePassManager &MPM) {
                        MPM.addPass(createModuleToFunctionPassAdaptor(Obfus()));
                    });
                // PB.registerOptimizerLastEPCallback(
                //     [](ModulePassManager &MPM, PassBuilder::OptimizationLevel) {
                //         MPM.addPass(createModuleToFunctionPassAdaptor(Obfus()));
                //     });
            }};
}
