cmake_minimum_required(VERSION 3.22)

project(circular_buffer_test)

set(CMAKE_CXX_STANDARD 20)

# Add source files
set(TEST_FILES circular_buffer_test.cpp)
set(SRC_FILES )

# Add executable
add_executable(${PROJECT_NAME} ${TEST_FILES} ${SRC_FILES})

# Unit testing
enable_testing()
find_package(GTest REQUIRED)
target_link_libraries(${PROJECT_NAME} GTest::gtest GTest::gtest_main)

# Include directories
target_include_directories(${PROJECT_NAME} 
    PRIVATE ${GTEST_INCLUDE_DIRS}
    PRIVATE ${CMAKE_SOURCE_DIR}/src
)

gtest_discover_tests(${PROJECT_NAME})

# Option to enable code coverage
option(CODE_COVERAGE "Enable code coverage" OFF)
# Code coverage target
if(CODE_COVERAGE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -ftest-coverage -fprofile-arcs")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage")
    find_program(GCOVR gcovr)
    if (NOT GCOVR)
        message(FATAL_ERROR "gcovr not found! Please install it to enable code coverage.")
    endif()
    add_custom_target(coverage
        COMMAND ${GCOVR} -r ${CMAKE_SOURCE_DIR} --html --html-details -o ${CMAKE_BINARY_DIR}/coverage.html
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating coverage report"
    )
endif()
