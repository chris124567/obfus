#include "DeriveZeroMBA.hpp"

#include <llvm/IR/IRBuilder.h>

#include <armadillo>
#include <array>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <functional>
#include <iostream>
#include <numeric>
#include <tuple>
#include <vector>

// implementation of https://link.springer.com/chapter/10.1007/F978-3-540-77535-5_5
static std::tuple<arma::fmat, arma::fvec> GenerateSolution(const unsigned int vars_count) {
    while (true) {
        arma::fmat F(1 << vars_count, vars_count);
        for (size_t i = 0; i < F.n_rows; i++) {
            // truth table
            F(i, 0) = (i >> (vars_count - 1)) & 1;
            // random data
            for (size_t j = 1; j < F.n_cols; j++) {
                F(i, j) = std::rand() % 2;
            }
        }

        const arma::fmat &solutions = arma::null(F);
        if (solutions.n_cols == 0) {
            continue;
        }

        bool has_zero = false;
        solutions.for_each([&has_zero](const auto val) {
            // if value is approximately 0
            if (val > -0.01 && val < 0.01) {
                has_zero = true;
            }
        });
        if (!has_zero) {
            return std::make_tuple(F, arma::vectorise(solutions));
        }
    }
}

static llvm::Value *TableToExpression(llvm::IRBuilder<> &builder, const std::vector<llvm::Value *> &vars, const arma::fvec &table) {
    const unsigned int vars_count = vars.size();

    llvm::Value *start_expr = nullptr;
    for (size_t i = 0; i < table.size(); i++) {
        if (table.at(i) == 1) {
            llvm::Value *row_expr = nullptr;

            // convert to SOP form
            for (unsigned int j = 0; j < vars_count; j++) {
                const auto cur = (((i >> (vars_count - j - 1)) & 1) == 0) ? builder.CreateNot(vars.at(j)) : vars.at(j);
                // if we dont have anything for the row expression assign it
                // to the current variable.  if we do have something AND it with
                // the current variable
                row_expr = (!row_expr) ? cur : (builder.CreateAnd(row_expr, cur));
            }
            // if we dont have anything for the start expression assign it
            // to the current variable.  if we do have something OR it with
            // the current variable
            start_expr = (!start_expr) ? row_expr : (builder.CreateOr(start_expr, row_expr));
        }
    }
    return start_expr;
}

static llvm::Value *MBAIdentity(llvm::IRBuilder<> &builder, llvm::Type *type, const std::vector<llvm::Value *> &vars, const arma::fmat &F, const arma::fvec &sol_matrix) {
    llvm::LLVMContext *llvmcx;
    static llvm::LLVMContext MyGlobalContext;
    llvmcx = &MyGlobalContext;
    llvm::Value *start = nullptr;
    for (size_t i = 0; i < F.n_cols; i++) {
        const auto col_form = TableToExpression(builder, vars, F.col(i));
        llvm::errs() << "col_form: " << col_form << "\n";
        // armadillo often gives us nullspace values like [-.57, -.57, .57] but we can just do (in this case) [-1, -1, 1] to simplify things because we're basically just multiplying by a scalar constant so F*v=0 holds
        const int scalar = sol_matrix.at(i) > 0 ? 1 : -1;
        const auto res = (!start) ? builder.CreateMul(col_form, llvm::ConstantInt::get(type, scalar)) : col_form;

        if (!bool(start)) {
            start = res;
        } else {
            if (scalar > 0) {
                start = builder.CreateAdd(start, res);
            } else {
                start = builder.CreateSub(start, res);
            }
        }
    }
    return start;
}

llvm::Value *GenerateRandomMBAIdentity(llvm::IRBuilder<> &builder, llvm::Type *type, const std::vector<llvm::Value *> &vars) {
    const auto [F, sol_matrix] = GenerateSolution(vars.size());

    return MBAIdentity(builder, type, vars, F, sol_matrix);
}
