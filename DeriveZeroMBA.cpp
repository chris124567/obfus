#include "DeriveZeroMBA.hpp"

#include <llvm/IR/IRBuilder.h>

#include <cmath>

// implementation of https://link.springer.com/chapter/10.1007/F978-3-540-77535-5_5

// columns = vars count
static const constexpr int kMaxVars = 4;
// rows = 2**vars
static const constexpr int kMaxRows = 1 << kMaxVars;

static bool FVEqualsZero(const int rows, const int columns, const int matrix[kMaxRows][kMaxVars], const int vector[kMaxVars]) {
    for (int r = 0; r < rows; r++) {
        int sum = 0;
        for (int column = 0; column < columns; column++) {
            sum += matrix[r][column] * vector[column];
        }
        if (sum != 0) {
            return false;
        }
    }
    return true;
}

llvm::Value *GenerateRandomMBAIdentity(llvm::IRBuilder<> &builder, llvm::Type *type, const std::vector<llvm::Value *> &vars) {
    const unsigned int vars_count = vars.size();
    const unsigned int rows_count = 1 << vars_count;
    const unsigned int nullspace_attempts = pow(4, vars_count);

    int F[kMaxRows][kMaxVars] = {{0}};
    int solutions[kMaxVars] = {0};

    bool found_solution = false;
    while (!found_solution) {
        for (size_t i = 0; i < rows_count; i++) {
            // truth table
            F[i][0] = (i >> (vars_count - 1)) & 1;
            // random data
            for (size_t j = 1; j < vars_count; j++) {
                F[i][j] = std::rand() % 2;
            }
        }

        // bruteforce nontrivial (mathematical meaning) nullspace calculation
        const constexpr int kValidNullspaceValues[] = {-1, -1, 1, 1};
        for (unsigned int i = 0; i < nullspace_attempts; i++) {
            for (unsigned int j = 0; j < vars_count; j++) {
                solutions[j] = kValidNullspaceValues[(i >> (2 * j)) & 3];
            }
            found_solution = FVEqualsZero(rows_count, vars_count, F, solutions);
            if (found_solution) {
                break;
            }
        }
    }

    llvm::Value *start = nullptr;
    for (size_t i = 0; i < vars_count; i++) {
        llvm::Value *col_form = nullptr;
        for (size_t j = 0; j < rows_count; j++) {
            if (F[j][i] == 1) {
                llvm::Value *row_expr = nullptr;

                // convert to SOP form
                for (unsigned int k = 0; k < vars_count; k++) {
                    const auto &cur = (((j >> (vars_count - k - 1)) & 1) == 0) ? builder.CreateNot(vars.at(k)) : vars.at(k);
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