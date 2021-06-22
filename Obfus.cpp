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
        const int value_replace_index = (x_value) ? 0 : 1;
        const auto value_replace = (value_replace_index == 0) ? x_value : y_value;

        const auto same = (value_replace_index == 0) ? y : x;
        const auto int_type = value_replace->getType();
        // std::vector<Value *> vars{same, ConstantInt::get(int_type, std::rand() % 255), ConstantInt::get(int_type, std::rand() % 255)};
        // std::vector<Value *> vars{same, ConstantInt::get(int_type, std::rand() % 255)};

        llvm::IRBuilder<> builder(icmp_op);
        std::vector<Value *> vars{same, ConstantInt::get(int_type, std::rand() % 255), ConstantInt::get(int_type, std::rand() % 255)};
        const auto zero_expr = GenerateRandomMBAIdentity(builder, int_type, vars);
        if (value_replace->getSExtValue() == 0) {
            icmp_op->setOperand(value_replace_index, zero_expr);
        } else {
            // convoluted add - x ^ 0 = x
            icmp_op->setOperand(value_replace_index, builder.CreateXor(zero_expr, value_replace->getSExtValue()));
        }
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
        const auto val_negative_2 = ConstantInt::get(bin_op->getType(), -2);
        const auto val_1 = ConstantInt::get(bin_op->getType(), 1);
        const auto val_2 = ConstantInt::get(bin_op->getType(), 2);
        const auto val_3 = ConstantInt::get(bin_op->getType(), 3);
        // const auto rand_1 = ConstantInt::get(bin_op->getType(), rand() % 255);
        // const auto rand_2 = ConstantInt::get(bin_op->getType(), rand() % 255);
        const auto x = bin_op->getOperand(0);
        const auto y = bin_op->getOperand(1);

        Value *new_value = nullptr;
        /*
Compiled from various stackoverflow posts and some experimentation.
Only obfuscations that aren't simplified with -Ofast -flto -march=native
are kept.  To see the disassembly of a function to verify this, run

    gdb -batch -ex 'file ./test/test' -ex 'disassemble function_name'


To test proofs, run this first (python):
>>> import z3
>>> x, y = z3.BitVecs('x y', 64)
        */
        const int rand = std::rand();
#ifdef DEBUG
        errs() << "Opcode: Instruction::" << I->getOpcodeName() << "\n";
#endif

        std::vector<Value *> vars{x, y, ConstantInt::get(bin_op->getType(), std::rand() % 255)};
        const auto identity = GenerateRandomMBAIdentity(builder, bin_op->getType(), vars);

        switch (I->getOpcode()) {
            case Instruction::Add:
                /*
            >>> z3.prove((x + y) == ((x ^ y) + 2*(x & y)))
            proved
            >>> z3.prove((x + y) == ((x ^ y) - ((-2*x - 1) | (-2*y - 1)) -1))
            proved
            >>> z3.prove((x + y) == (2*(x | y) - (~x & y) - (x & ~y)))
            proved
            >>> z3.prove((x + y) == ((x | y) + y - (~x & y)))
            proved
            >>> z3.prove((x + y) == (x ^ y) + 2*y - 2*(~x & y))
            proved
                */
                // switch (rand % 5) {
                //     case 0:
                //         new_value = builder.CreateAdd(builder.CreateXor(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));
                //         break;
                //     case 1:
                //         new_value = builder.CreateSub(builder.CreateXor(x, y), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_negative_2, y), val_1)), val_1));
                //         break;
                //     case 2:
                //         new_value = builder.CreateSub(builder.CreateMul(val_2, builder.CreateOr(x, y)), builder.CreateAdd(builder.CreateAnd(builder.CreateNot(x), y), builder.CreateAnd(x, builder.CreateNot(y))));
                //         break;
                //     case 3:
                //         new_value = builder.CreateSub(builder.CreateAdd(builder.CreateOr(x, y), y), builder.CreateAnd(builder.CreateNot(x), y));
                //         break;
                //     case 4:
                //         new_value = builder.CreateSub(builder.CreateAdd(builder.CreateXor(x, y), builder.CreateMul(val_2, y)), builder.CreateMul(val_2, builder.CreateAnd(builder.CreateNot(x), y)));
                //         break;
                // }
                new_value = builder.CreateAdd(builder.CreateAdd(x, identity), y);

                break;
            case Instruction::Sub:
                /*
            >>> z3.prove((x - y) == ((x ^ (~y+1)) - ((-2*x - 1) | (2*y - 1)) - 1))
            proved
            >>> z3.prove((x - y) == ((x & ~y) - (~x & y)))
            proved
            >>> z3.prove((x - y) == ~(~x + y))
            proved
            >>> z3.prove((x - y) == (3*(x & ~y) + ~x) - ((x ^ y) + ~(x & y)))
            proved
                */
                // switch (rand % 4) {
                //     case 0:
                //         new_value = builder.CreateSub(builder.CreateXor(x, builder.CreateAdd(builder.CreateNot(y), val_1)), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_2, y), val_1)), val_1));
                //         break;
                //     case 1:
                //         new_value = builder.CreateSub(builder.CreateAnd(x, builder.CreateNot(y)), builder.CreateAnd(builder.CreateNot(x), y));
                //         break;
                //     case 2:
                //         new_value = builder.CreateNot(builder.CreateAdd(builder.CreateNot(x), y));
                //         break;
                //     case 3:
                //         new_value = builder.CreateSub(builder.CreateAdd(builder.CreateMul(val_3, builder.CreateAnd(x, builder.CreateNot(y))), builder.CreateNot(x)), builder.CreateAdd(builder.CreateXor(x, y), builder.CreateNot(builder.CreateAnd(x, y))));
                //         break;
                // }

                new_value = builder.CreateSub(builder.CreateAdd(x, identity), y);

                break;
            case Instruction::Xor:
                /*
                >>> z3.prove((x ^ y) == (x + y - 2*(x & y)))
                proved
                */
                // new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));

                new_value = builder.CreateXor(builder.CreateAdd(x, identity), y);

                break;
            case Instruction::Or:
                /*
                >>> z3.prove((x | y) == (x + y - (x & y)))
                proved
                */
                // new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateAnd(x, y));

                new_value = builder.CreateOr(builder.CreateAdd(x, identity), y);

                break;
            case Instruction::And:
                /*
                >>> z3.prove((x & y) == (x + y - (x|y)))
                proved
                */
                // new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateOr(x, y));

                new_value = builder.CreateAnd(builder.CreateAdd(x, identity), y);

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
        // ORIGINAL ORDER:
        changed |= TransformBinaryOperatorBasicBlock(BB);
        changed |= TransformIntegerConstants(BB);
        // NEW ORDER:
        // changed |= TransformIntegerConstants(BB);
        // changed |= TransformBinaryOperatorBasicBlock(BB);
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
                // constexpr const int seed = 0;
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
