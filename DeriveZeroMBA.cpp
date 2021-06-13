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
std::vector<int> GenerateTable(int vars_count, std::function<int(std::vector<int>)> lambda) {
    std::vector<int> table;
    std::vector<int> row;
    for (int i = 0; i < (1 << vars_count); i++) {
        row.clear();
        for (int j = 0; j < vars_count; j++) {
            row.push_back((i >> (vars_count - j - 1)) & 1);
        }
        table.push_back(lambda(row));
    }
    return table;
}

std::vector<int> GenerateTableTrue(int vars_count, int i) {
    return GenerateTable(vars_count, [i](std::vector<int> xs) { return xs.at(i); });
}

std::vector<int> GenerateTableBinaryOperator(int vars_count, std::function<int(int, int)> func) {
    return GenerateTable(vars_count, [func](std::vector<int> xs) { return std::accumulate(xs.begin(), xs.end(), xs.at(0), func); });
}

std::vector<int> GenerateTableRandom(int vars_count) {
    std::vector<int> v(1 << vars_count);
    std::generate(v.begin(), v.end(), [] { return std::rand() % 2; });
    return v;
}

std::tuple<arma::mat, arma::vec> GenerateMBA(int vars_count) {
    while (true) {
        const auto &table_true = GenerateTableTrue(vars_count, 0);
        const auto &table_random1 = GenerateTableRandom(vars_count);
        const auto &table_random2 = GenerateTableRandom(vars_count);

        arma::mat F(1 << vars_count, vars_count);
        for (size_t i = 0; i < F.n_rows; i++) {
            F(i, 0) = table_true.at(i);
        }
        for (size_t i = 0; i < F.n_rows; i++) {
            F(i, 1) = table_random1.at(i);
        }
        for (size_t i = 0; i < F.n_rows; i++) {
            F(i, 2) = table_random2.at(i);
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

z3::expr TableToExpression(z3::context &ctx, const std::vector<z3::expr> &vars, arma::vec table) {
    int vars_count = log2(table.size());

    z3::expr start_expr(ctx);
    for (size_t i = 0; i < table.size(); i++) {
        if (table.at(i) == 1) {
            z3::expr row_expr(ctx);

            for (int j = 0; j < vars_count; j++) {
                const int x = (i >> (vars_count - j - 1)) & 1;
                auto cur = vars.at(j);

                if (x == 0) {
                    cur = ~cur;
                }

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
    if (!bool(start_expr)) {
        start_expr = ctx.bv_val(0, 64);
    }
    return start_expr;
}

z3::expr MBAIdentity(z3::context &ctx, int vars_count, arma::mat F, arma::vec sol_matrix) {
    std::vector<z3::expr> vars;
    for (int i = 0; i < vars_count; i++) {
        vars.push_back(ctx.bv_const(("vars[" + std::to_string(i) + "]").c_str(), 64));
    }

    z3::expr start(ctx);
    for (size_t i = 0; i < F.n_cols; i++) {
        z3::expr res(ctx);
        const auto col_form = TableToExpression(ctx, vars, F.col(i));

        float scalar = sol_matrix.at(i);
        if (scalar > 0) {
            scalar = 1;
        } else if (scalar < 0) {
            scalar = -1;
        }

        if (!bool(start)) {
            // dont complicate things by multiplying by 1 since it doesn't change anything
            if (scalar < 1) {
                res = col_form * ctx.bv_val(int(scalar), 64);
            }
        } else {
            res = col_form * ctx.bv_val(std::abs(int(scalar)), 64);
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
    // srand(0);
    srand(time(nullptr));

    while (true) {
        z3::context ctx;
        constexpr const int kNumVars = 3;
        const auto [F, sol_matrix] = GenerateMBA(kNumVars);
        const auto &identity = MBAIdentity(ctx, kNumVars, F, sol_matrix);
        std::cout << "Expression:\n" << identity << std::endl;

        const auto &conjecture = (identity != 0);

        z3::solver solver(ctx);
        solver.add(conjecture);
        switch (solver.check()) {
            case z3::sat:
                std::cout << "Invalid MBA identity: " << solver.get_model() << std::endl;
                // std::cout << "Failure!" << std::endl;
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