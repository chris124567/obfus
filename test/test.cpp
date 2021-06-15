// #include "test.hpp"

#include <gtest/gtest.h>
#include <stdint.h>
#include <stdio.h>

int __attribute__((optnone)) add(const int x, const int y) {
    return x + y;
}

int __attribute__((optnone)) sub(const int x, const int y) {
    return x - y;
}

int __attribute__((optnone)) mul(const int x, const int y) {
    return x * y;
}

// "1" suffix after names to prevent weird clang-format glitch that messes up formatting

int __attribute__((optnone)) xor1(const int x, const int y) {
    return x ^ y;
}

int __attribute__((optnone)) or1(const int x, const int y) {
    return x | y;
}

int __attribute__((optnone)) and1(const int x, const int y) {
    return x & y;
}

int __attribute__((optnone)) password(const int input) {
    if (input == 0) {
        return 1337;
    } else {
        return -1;
    }
}

int __attribute__((optnone)) return5000(void) {
    return 5000;
}

// TODO: codegen this
static constexpr const int testArray[7][2] = {{-5, -6}, {0, 0}, {1, -6}, {1, 1}, {1, 2}, {3, 4}, {2147483640, 7}};
static constexpr const int testArrayAdd[7] = {-11, 0, -5, 2, 3, 7, 2147483647};
static constexpr const int testArraySub[7] = {1, 0, 7, 0, -1, -1, 2147483633};
static constexpr const int testArrayMul[7] = {30, 0, -6, 1, 2, 12, 2147483592};  // overflow on last test: just ignore
static constexpr const int testArrayXor[7] = {1, 0, -5, 0, 3, 7, 2147483647};
static constexpr const int testArrayOr[7] = {-5, 0, -5, 1, 3, 7, 2147483647};
static constexpr const int testArrayAnd[7] = {-6, 0, 0, 1, 0, 0, 0};

TEST(BinaryOperators, BinaryOperators) {
    // iterate over subarrays in testArray
    for (unsigned int i = 0; i < sizeof(testArray) / sizeof(testArray[0]); i++) {
        const auto x = testArray[i][0];
        const auto y = testArray[i][1];
        EXPECT_EQ(testArrayAdd[i], add(x, y));
        EXPECT_EQ(testArraySub[i], sub(x, y));
        EXPECT_EQ(testArrayMul[i], mul(x, y));
        EXPECT_EQ(testArrayXor[i], xor1(x, y));
        EXPECT_EQ(testArrayOr[i], or1(x, y));
        EXPECT_EQ(testArrayAnd[i], and1(x, y));
    }
};

// TODO: exempt this function from transforms somehow???
TEST(ConstantCalculation, ConstantCalculation) {
    EXPECT_EQ(1337, password(0));
    EXPECT_EQ(-1, password(1));
    EXPECT_EQ(5000, return5000());
};
