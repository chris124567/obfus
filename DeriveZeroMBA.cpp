#include <z3++.h>

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

std::tuple<arma::fmat, arma::fvec> GenerateSolution(const unsigned int vars_count) {
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

z3::expr TableToExpression(z3::context &ctx, const std::vector<z3::expr> &vars, const arma::fvec &table) {
    const unsigned int vars_count = vars.size();

    z3::expr start_expr(ctx);
    for (size_t i = 0; i < table.size(); i++) {
        if (table.at(i) == 1) {
            z3::expr row_expr(ctx);

            // convert to SOP form
            for (unsigned int j = 0; j < vars_count; j++) {
                const auto &cur = (((i >> (vars_count - j - 1)) & 1) == 0) ? ~vars.at(j) : vars.at(j);
                // if we dont have anything for the row expression assign it
                // to the current variable.  if we do have something AND it with
                // the current variable
                row_expr = (!bool(row_expr)) ? cur : (row_expr & cur);
            }
            // if we dont have anything for the start expression assign it
            // to the current variable.  if we do have something OR it with
            // the current variable
            start_expr = (!bool(start_expr)) ? row_expr : (start_expr | row_expr);
        }
    }
    // if we never assign start_expr to anything, just assign it to 0
    if (!bool(start_expr)) {
        start_expr = ctx.bv_val(0, 64);
    }
    return start_expr;
}

z3::expr MBAIdentity(z3::context &ctx, const std::vector<z3::expr> &vars, const arma::fmat &F, const arma::fvec &sol_matrix) {
    z3::expr start(ctx);
    for (size_t i = 0; i < F.n_cols; i++) {
        const auto &col_form = TableToExpression(ctx, vars, F.col(i));

        // armadillo often gives us nullspace values like [-.57, -.57, .57] but we can just do (in this case) [-1, -1, 1] to simplify things
        const int scalar = sol_matrix.at(i) > 0 ? 1 : -1;
        const auto &res = (!bool(start)) ? (col_form * ctx.bv_val(int(scalar), 64)) : col_form;

        if (!bool(start)) {
            start = res;
        } else {
            if (scalar > 0) {
                start = start + res;
            } else {
                start = start - res;
            }
        }
    };
    return start;
}

int main(void) {
    // const constexpr auto seed = 0;
    const auto seed = std::time(nullptr);
    srand(seed);
    arma::arma_rng::set_seed(seed);

    z3::context ctx;

    // initialize variables
    std::vector<z3::expr> vars;
    constexpr const unsigned int kNumVars = 3;
    if (kNumVars != 2 && kNumVars != 3) {
        std::cout << "Using 1 variable breaks code and using more than 3 variables drastically worsens performs and breaks some of the code here" << std::endl;
        exit(EXIT_FAILURE);
    }

    // go through the alphabet for variable names
    char c = 'a';
    for (unsigned int i = 0; i < kNumVars; i++) {
        vars.push_back(ctx.bv_const(std::string(1, c++).c_str(), 64));
    }

    z3::solver solver(ctx);
    for (int i = 0; i < 1000; i++) {
        const auto [F, sol_matrix] = GenerateSolution(kNumVars);
        const auto &identity = MBAIdentity(ctx, vars, F, sol_matrix);
        // std::cout << "Expression:\n" << identity << std::endl;

        solver.reset();
        // ensure the identity is always 0
        solver.add((identity != 0));
        std::cout << "smt2:\n"
                  << solver.to_smt2() << std::endl;
        switch (solver.check()) {
            case z3::sat:
                std::cout << "Invalid MBA identity: " << solver.get_model() << std::endl;
                std::cout << "Failure!" << std::endl;
                exit(EXIT_FAILURE);
                break;
            case z3::unsat:
                std::cout << "Success!" << std::endl;
                break;
            case z3::unknown:
                std::cout << "Unknown!" << std::endl;
                exit(EXIT_FAILURE);
                break;
        }
    }

    return EXIT_SUCCESS;
}