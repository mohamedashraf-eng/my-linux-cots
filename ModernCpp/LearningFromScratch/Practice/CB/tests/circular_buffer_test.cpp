#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include "circular_buffer.hpp"

class circular_buffer_test : public ::testing::Test {
    void SetUp() override {

    }

    void TearDown() override {
    }
};

/**
 * @brief A unit test for the circular_buffer class template.
 * @details This test checks the functionality of the circular_buffer class template by
 *          testing its push_back, pop, head, tail, tsize, csize, and empty methods.
 *          It also tests the constructor with an initializer list.
 */
TEST(CircularBufferTest, AllTests) {
    // Create a circular buffer of size 5 and initialize it with values {1, 2, 3, 4, 5}
    circular_buffer<int, 5> cb({1, 2, 3, 4, 5});

    // Test the push_back method
    cb.push_back(6);
    EXPECT_EQ(cb.tail(), 6);
    EXPECT_EQ(cb.csize(), 6);

    // Test the pop method
    cb.pop();
    EXPECT_EQ(cb.head(), 2);
    EXPECT_EQ(cb.csize(), 5);

    // Test the head method
    EXPECT_EQ(cb.head(), 2);

    // Test the tail method
    EXPECT_EQ(cb.tail(), 6);

    // Test the tsize method
    EXPECT_EQ(cb.tsize(), 5);

    // Test the csize method
    EXPECT_EQ(cb.csize(), 5);

    // Test the empty method
    EXPECT_FALSE(cb.empty());

    // Test the constructor with an initializer list
    circular_buffer<int, 3> cb2({1, 2, 3});
    EXPECT_EQ(cb2.head(), 1);
    EXPECT_EQ(cb2.tail(), 3);
    EXPECT_EQ(cb2.csize(), 3);
}
