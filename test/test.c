#include <stdio.h>
#include <stdlib.h>

int __attribute__((optnone)) add(const int x, const int y) {
    return x + y;
}

int __attribute__((optnone)) sub(const int x, const int y) {
    return x - y;
}

int __attribute__((optnone)) mul(const int x, const int y) {
    return x * y;
}

/*
"1" suffix after names to prevent weird clang-format glitch
*/
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
    if (input >= 0) {
        return 1337;
    } else {
        return -1;
    }
}

int __attribute__((optnone)) return5000(void) {
    return 5000;
}

/* TODO: codegen this */
static const int testArray[7][2] = {{-5, -6}, {0, 0}, {1, -6}, {1, 1}, {1, 2}, {3, 4}, {2147483640, 7}};
static const int testArrayAdd[7] = {-11, 0, -5, 2, 3, 7, 2147483647};
static const int testArraySub[7] = {1, 0, 7, 0, -1, -1, 2147483633};
static const int testArrayMul[7] = {30, 0, -6, 1, 2, 12, 2147483592};
static const int testArrayXor[7] = {1, 0, -5, 0, 3, 7, 2147483647};
static const int testArrayOr[7] = {-5, 0, -5, 1, 3, 7, 2147483647};
static const int testArrayAnd[7] = {-6, 0, 0, 1, 0, 0, 0};

#define EXPECT_EQ(name, x, y) ((x == y) ? 0 : printf("EXPECT_EQ: %s: %d != %d\n", name, x, y))

int main(void) {
    unsigned int i;
    for (i = 0; i < sizeof(testArray) / sizeof(testArray[0]); i++) {
        const int x = testArray[i][0];
        const int y = testArray[i][1];
        EXPECT_EQ("add", testArrayAdd[i], add(x, y));
        EXPECT_EQ("sub", testArraySub[i], sub(x, y));
        EXPECT_EQ("mul", testArrayMul[i], mul(x, y));
        EXPECT_EQ("xor", testArrayXor[i], xor1(x, y));
        EXPECT_EQ("or", testArrayOr[i], or1(x, y));
        EXPECT_EQ("and", testArrayAnd[i], and1(x, y));
    }
    EXPECT_EQ("password(5000)", password(5000), 1337);
    EXPECT_EQ("password(0)", password(0), 1337);
    EXPECT_EQ("password(-1)", password(-1), -1);
    EXPECT_EQ("return5000()", return5000(), 5000);

    return EXIT_SUCCESS;
}
