#include "DeriveZeroMBA.hpp"

#include <llvm/IR/IRBuilder.h>

#include <cmath>

// implementation of https://link.springer.com/chapter/10.1007/F978-3-540-77535-5_5

// columns = vars count
static const constexpr int kMaxVars = 4;
// rows = 2**vars
static const constexpr int kMaxRows = 1 << kMaxVars;

// check if F * v = 0: used to check nullspace if calculation is correct
static __attribute__((const)) constexpr bool FVEqualsZero(const int matrix[kMaxRows][kMaxVars], const int vector[kMaxVars], const int rows, const int columns) {
    for (int row = 0; row < rows; row++) {
        int sum = 0;
        for (int column = 0; column < columns; column++) {
            sum += matrix[row][column] * vector[column];
        }
        if (sum != 0) {
            return false;
        }
    }
    return true;
}

namespace obfus {
// generate expressions that equal 0 regardless of the value of the variables
// pointers in vars should not be null
llvm::Value *GenerateRandomMBAIdentity(llvm::IRBuilder<> &builder, llvm::Type *type, const std::vector<llvm::Value *> &vars) {
    // this many columns
    const int vars_count = vars.size();
    // 2**vars_count rows
    const int rows_count = 1 << vars_count;
    // 2 choices - 1 or -1
    const int nullspace_attempts = pow(2, vars_count);

    int F[kMaxRows][kMaxVars] = {{0}};
    int solutions[kMaxVars] = {0};

    for (int i = 0; i < rows_count; i++) {
        // truth table: we dont unnecessarily recalculate every loop below
        F[i][0] = (i >> (vars_count - 1)) & 1;
    }

    bool found_solution = false;
    while (!found_solution) {
        for (int i = 0; i < rows_count; i++) {
            // random data:  j=1 ensures we dont overwrite truth table
            for (int j = 1; j < vars_count; j++) {
                F[i][j] = std::rand() % 2;
            }
        }

        // bruteforce nontrivial nullspace
        for (int i = 0; i < nullspace_attempts; i++) {
            for (int j = 0; j < vars_count; j++) {
                solutions[j] = ((i >> (2 * j)) & 1) ? 1 : -1;
            }
            found_solution = FVEqualsZero(F, solutions, rows_count, vars_count);
            if (found_solution) {
                break;
            }
        }
    }

    llvm::Value *start = nullptr;
    // columns
    for (int i = 0; i < vars_count; i++) {
        llvm::Value *col_form = nullptr;
        // rows
        for (int j = 0; j < rows_count; j++) {
            if (F[j][i] == 1) {
                llvm::Value *row_expr = nullptr;

                // convert to SOP form
                for (int k = 0; k < vars_count; k++) {
                    const auto cur = (((j >> (vars_count - k - 1)) & 1) == 0) ? builder.CreateNot(vars.at(k)) : vars.at(k);
                    // if we dont have anything for the row expression assign it
                    // to the current variable.  if we do have something AND it with
                    // the current variable
                    row_expr = (!row_expr) ? cur : (builder.CreateAnd(row_expr, cur));
                }
                // if we dont have anything for the start expression assign it
                // to the current variable.  if we do have something OR it with
                // the current variable
                col_form = (!col_form) ? row_expr : (builder.CreateOr(col_form, row_expr));
            }
        }

        const int scalar = solutions[i];
        // if we get a result for this column
        if (col_form) {
            const auto res = (!start) ? builder.CreateMul(col_form, llvm::ConstantInt::get(type, scalar)) : col_form;

            if (!start) {
                start = res;
            } else {
                if (scalar > 0) {
                    start = builder.CreateAdd(start, res);
                } else {
                    start = builder.CreateSub(start, res);
                }
            }
        }
    }
    return start;
}
}  // namespace obfus