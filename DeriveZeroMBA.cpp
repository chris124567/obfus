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

std::tuple<arma::mat, arma::vec> GenerateMBA(const int vars_count) {
    arma::mat F(1 << vars_count, vars_count);
    while (true) {
        for (size_t i = 0; i < F.n_rows; i++) {
            F(i, 0) = (i >> (vars_count - 1)) & 1;
        }
        for (size_t i = 0; i < F.n_rows; i++) {
            for (size_t j = 1; j < F.n_cols; j++) {
                F(i, j) = std::rand() % 2;
            }
        }

        arma::mat solutions = arma::null(F);
        if (!solutions.is_vec() || solutions.n_cols == 0) {
            continue;
        }

        bool has_zero = false;
        solutions.for_each([&has_zero](arma::mat::elem_type &val) {
            if (val == 0) {
                has_zero = true;
            }
        });
        if (!has_zero) {
            return std::make_tuple(F, arma::vectorise(solutions));
        }
    }
}

z3::expr TableToExpression(z3::context &ctx, const std::vector<z3::expr> &vars, const arma::vec &table) {
    const int vars_count = vars.size();

    z3::expr start_expr(ctx);
    for (size_t i = 0; i < table.size(); i++) {
        if (table.at(i) == 1) {
            z3::expr row_expr(ctx);

            for (int j = 0; j < vars_count; j++) {
                const int x = (i >> (vars_count - j - 1)) & 1;
                const auto cur = (x == 0) ? ~vars.at(j) : vars.at(j);

                if (!bool(row_expr)) {
                    row_expr = cur;
                } else {
                    row_expr = row_expr & cur;
                }
            }
            if (!bool(start_expr)) {
                start_expr = row_expr;
            } else {
                start_expr = start_expr | row_expr;
            }
        }
    }
    // if we never assign start_expr to anything, just assign it to 0
    if (!bool(start_expr)) {
        start_expr = ctx.bv_val(0, 64);
    }
    return start_expr;
}

z3::expr MBAIdentity(z3::context &ctx, const std::vector<z3::expr> &vars, const arma::mat &F, const arma::vec &sol_matrix) {
    z3::expr start(ctx);
    for (size_t i = 0; i < F.n_cols; i++) {
        z3::expr res(ctx);
        const auto col_form = TableToExpression(ctx, vars, F.col(i));

        // armadillo often gives us nullspace values like [-.57, -.57, .57] but we can just do (in this case) [-1, -1, 1] to simplify things
        const int scalar = sol_matrix.at(i) > 0 ? 1 : -1;

        if (!bool(start)) {
            res = col_form * ctx.bv_val(int(scalar), 64);
        } else {
            res = col_form;
        }

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
    // srand(3);
    srand(time(nullptr));

    z3::context ctx;

    // initialize variables
    std::vector<z3::expr> vars;
    constexpr const int kNumVars = 3;
    if (kNumVars != 2 && kNumVars != 3) {
        std::cout << "Using 1 variable breaks code and using more than 3 variables drastically worsens performs and breaks some of the code here" << std::endl;
        exit(EXIT_FAILURE);
    }

    // go through the alphabet for variable names
    char c = 'a';
    for (int i = 0; i < kNumVars; i++) {
        vars.push_back(ctx.bv_const(std::string(1, c++).c_str(), 64));
    }

    z3::solver solver(ctx);
    for (int i = 0; i < 100; i++) {
        const auto [F, sol_matrix] = GenerateMBA(kNumVars);
        const auto &identity = MBAIdentity(ctx, vars, F, sol_matrix);
        // std::cout << "Expression: " << identity << std::endl;

        solver.reset();
        // ensure the identity is always 0
        solver.add((identity != 0));
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
                break;
        }
    }

    return EXIT_SUCCESS;
}