#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include "circular_buffer.hpp"

class circular_buffer_test : public ::testing::Test {
    void SetUp() override {

    }

    void TearDown() override {
    }
};

TEST_F(circular_buffer_test, TEST_CB_GETTERS) { 
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    cb.push_back(1);
    cb.push_back(2);
    cb.push_back(3);
    cb.push_back(4);

    EXPECT_EQ(cb.head(), 1);
    EXPECT_EQ(cb.tail(), 0);
    EXPECT_EQ(cb.empty(), false);
    EXPECT_EQ(cb.tsize(), n);
    EXPECT_EQ(cb.csize(), 4);
}

TEST_F(circular_buffer_test, TEST_CB_PB_CHECK_HEAD) {
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    cb.push_back(1);
    cb.push_back(2);

    EXPECT_EQ(cb.head(), 1);
}

TEST_F(circular_buffer_test, TEST_CB_PB_CHECK_TAIL) {
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    cb.push_back(1);
    cb.push_back(2);
    EXPECT_EQ(cb.tail(), 0);
    cb.push_back(3);
    EXPECT_EQ(cb.tail(), 0);
    cb.push_back(4);
    EXPECT_EQ(cb.tail(), 0);
}

TEST_F(circular_buffer_test, TEST_CB_PB_CHECK_LIMIT) {
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    for(uint8_t i = 0; i < 6; ++i) {
        cb.push_back(i);
    }

    EXPECT_EQ(cb.head(), 1);
    EXPECT_EQ(cb.tail(), 1);
}

TEST_F(circular_buffer_test, TEST_CB_PB_WITH_POB) { 
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    cb.push_back(1);
    cb.push_back(2);
    cb.push_back(3);
    cb.push_back(4);
    cb.push_back(5);
    cb.push_back(6);

    EXPECT_EQ(cb.head(), 2);
    EXPECT_EQ(cb.tail(), 2);
    cb.pop();
    EXPECT_EQ(cb.tail(), 2);
    EXPECT_EQ(cb.head(), 3);
}

TEST_F(circular_buffer_test, TEST_CB_PB_OVER_POB) { 
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    cb.push_back(1);
    cb.push_back(2);
    cb.push_back(3);
    cb.push_back(4);
    cb.push_back(5);
    cb.push_back(6);

    for(uint8_t i = 0; i < 5; ++i) {
        cb.pop();
    }

    EXPECT_THROW(cb.pop(), std::runtime_error);
}

TEST_F(circular_buffer_test, TEST_CB_PB_OVER_POB_NO_DATA) { 
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb;

    EXPECT_THROW(cb.pop(), std::runtime_error);
}

TEST_F(circular_buffer_test, TEST_CB_INIT_LIST) { 
    constexpr uint32_t n = 5u;
    circular_buffer<int, n> cb {1, 2, 3, 4, 5};
    std::vector<int> expected {1, 2, 3, 4, 5};
    std::vector<int> actual;

    while(!cb.empty()) {
        actual.push_back(cb.head());
        cb.pop();
    }

    EXPECT_EQ(actual, expected);
}

TEST_F(circular_buffer_test, TEST_CB_INIT_LIST_EXCEED) { 
    try {
        constexpr uint32_t n = 5u;
        circular_buffer<int, n> cb {1, 2, 3, 4, 5, 6};
        FAIL();
    } catch( std::runtime_error& e) {
        EXPECT_TRUE(true);
    } catch(...) {
        FAIL();
    }
}
