#include "test.hpp"

#include <gtest/gtest.h>
#include <stdint.h>
#include <stdio.h>

int __attribute__((optnone)) add(int x, int y) {
    return x + y;
}

int __attribute__((optnone)) sub(int x, int y) {
    return x - y;
}

// "1" suffix after names to prevent weird clang-format glitch that messes up formatting

int __attribute__((optnone)) xor1(int x, int y) {
    return x ^ y;
}

int __attribute__((optnone)) or1(int x, int y) {
    return x | y;
}

int __attribute__((optnone)) and1(int x, int y) {
    return x & y;
}

int __attribute__((optnone)) return5000(void) {
    return 5000;
}

// TODO: codegen this
static constexpr const int testArray[7][2] = {{-5, -6}, {0, 0}, {1, -6}, {1, 1}, {1, 2}, {3, 4}, {2147483640, 7}};
static constexpr const int testArrayAdd[7] = {-11, 0, -5, 2, 3, 7, 2147483647};
static constexpr const int testArraySub[7] = {1, 0, 7, 0, -1, -1, 2147483633};
static constexpr const int testArrayXor[7] = {1, 0, -5, 0, 3, 7, 2147483647};
static constexpr const int testArrayOr[7] = {-5, 0, -5, 1, 3, 7, 2147483647};
static constexpr const int testArrayAnd[7] = {-6, 0, 0, 1, 0, 0, 0};

TEST(BinaryOperators, BinaryOperators) {
    // iterate over subarrays in testArray
    for (int i = 0; i < sizeof(testArray) / sizeof(testArray[0]); i++) {
        auto const x = testArray[i][0];
        auto const y = testArray[i][1];
        EXPECT_EQ(testArrayAdd[i], add(x, y));
        EXPECT_EQ(testArraySub[i], sub(x, y));
        EXPECT_EQ(testArrayXor[i], xor1(x, y));
        EXPECT_EQ(testArrayOr[i], or1(x, y));
        EXPECT_EQ(testArrayAnd[i], and1(x, y));
    }
};

// TODO: exempt this function somehow???
TEST(ConstantCalculation, ConstantCalculation) {
    EXPECT_EQ(5000, return5000());
};
