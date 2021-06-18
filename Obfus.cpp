#include "Obfus.hpp"

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include <z3++.h>

#include <cstdlib>
#include <iostream>

#include "DeriveZeroMBA.hpp"

using namespace llvm;

// use global variable to prevent having to re-init every loop
static z3::context ctx;
static std::vector<z3::expr> vars;
static constexpr const unsigned int kNumVars = 3;

static bool TransformIntegerConstants(BasicBlock &BB) {
    bool changed = false;

    // see https://sci-hub.ee/https://link.springer.com/chapter/10.1007/978-3-540-77535-5_5
    // TODO: turn integer constants into complex expressions
    for (auto I = BB.begin(); I != BB.end(); ++I) {
        const auto icmp_op = dyn_cast<ICmpInst>(I);
        if (!icmp_op || !icmp_op->getType()->isIntOrPtrTy()) {
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
        const auto value_replace = (x_value) ? x_value : y_value;
        const auto value_replace_raw = value_replace->getSExtValue();
        // we only support 0 for now
        if (value_replace_raw != 0) {
            continue;
        }

        z3::expr identity = GenerateRandomMBAIdentity(ctx, vars);
        if (!identity.is_app()) {
            // if the identity we generate is somehow not a function application
            continue;
        }
        // std::cout << "Identity: " << identity << "\n";
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
        const auto val_negative_1 = ConstantInt::get(bin_op->getType(), -1);
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
            >>> z3.prove((x + y) == ((x | y) + (x & y)))
            proved
            >>> z3.prove((x + y) == (~(~(x+y)|~(x+y))|~(~(x+y)|~(x+y))))
            proved
                */
                switch (rand % 5) {
                    case 0:
                        new_value = builder.CreateAdd(builder.CreateXor(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateXor(x, y), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_negative_2, y), val_1)), val_1));
                        break;
                    case 2:
                        new_value = builder.CreateSub(builder.CreateMul(val_2, builder.CreateOr(x, y)), builder.CreateAdd(builder.CreateAnd(builder.CreateNot(x), y), builder.CreateAnd(x, builder.CreateNot(y))));
                        break;
                    case 3:
                        new_value = builder.CreateAdd(builder.CreateOr(x, y), builder.CreateAnd(x, y));
                        break;
                    case 4:
                        new_value = builder.CreateOr(builder.CreateNot(builder.CreateOr(builder.CreateNot(builder.CreateAdd(x, y)), builder.CreateNot(builder.CreateAdd(x, y)))), builder.CreateNot(builder.CreateOr(builder.CreateNot(builder.CreateAdd(x, y)), builder.CreateNot(builder.CreateAdd(x, y)))));
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
                switch (rand % 4) {
                    case 0:
                        new_value = builder.CreateAdd(x, builder.CreateAdd(builder.CreateXor(y, val_negative_1), val_1));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateXor(x, builder.CreateAdd(builder.CreateNot(y), val_1)), builder.CreateAdd(builder.CreateOr(builder.CreateSub(builder.CreateMul(val_negative_2, x), val_1), builder.CreateSub(builder.CreateMul(val_2, y), val_1)), val_1));
                        break;
                    case 2:
                        new_value = builder.CreateSub(builder.CreateAnd(x, builder.CreateNot(y)), builder.CreateAnd(builder.CreateNot(x), y));
                        break;
                    case 3:
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
                switch (rand % 2) {
                    case 0:
                        new_value = builder.CreateSub(builder.CreateOr(x, y), builder.CreateAnd(x, y));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateMul(val_2, builder.CreateAnd(x, y)));
                        break;
                }
                break;
            case Instruction::Or:
                /*
            Replace inclusive or with (x ^ y) ^ (x & y) or (x + y - (x & y))
            >>> z3.prove((x | y) == ((x ^ y) ^ (x & y)))
            proved
            >>> z3.prove((x | y) == (x + y - (x & y)))
            proved
                */
                switch (rand % 2) {
                    case 0:
                        new_value = builder.CreateXor(builder.CreateXor(x, y), builder.CreateAnd(x, y));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateAnd(x, y));
                        break;
                }
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
                switch (rand % 3) {
                    case 0:
                        new_value = builder.CreateSub(val_negative_1, builder.CreateOr(builder.CreateSub(val_negative_1, x), builder.CreateSub(val_negative_1, y)));
                        break;
                    case 1:
                        new_value = builder.CreateSub(builder.CreateAdd(x, y), builder.CreateOr(x, y));
                        break;
                    case 2:
                        new_value = builder.CreateSub(builder.CreateOr(x, y), builder.CreateAdd(builder.CreateAnd(builder.CreateNot(x), y), builder.CreateAnd(x, builder.CreateNot(y))));
                        break;
                }
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
        changed |= TransformBinaryOperatorBasicBlock(BB);
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
                constexpr const auto seed = 0;
                srand(seed);

                // configure z3
                z3::set_param("sat.random_seed", seed);
                // dont split expressions with intermediate variables (let a!1...) when printing
                z3::set_param("pp.min_alias_size", 1000);
                z3::set_param("pp.max_depth", 1000);

                // initialize z3 variables
                // go through the alphabet for variable names
                char c = 'a';
                for (unsigned int i = 0; i < kNumVars; i++) {
                    vars.push_back(ctx.bv_const(std::string(1, c++).c_str(), 64));
                }

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
