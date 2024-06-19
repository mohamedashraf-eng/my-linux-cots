# This article is about how to include gtest/gcovr to your development.

## GTest
1. First you need to install gtest library.

For linux:

```bash
git clone git clone https://github.com/google/googletest.git gtest/ && cd gtest/

makedir build && cd build

cmake ..
make -j$(nproc)
make install -j$(nproc)
```

2. Second you need to add gtest to your project.  

Using cmake:
```cmake
cmake_minimum_required(VERSION 3.22)

project(xyz)

set(CMAKE_CXX_STANDARD 20)

# Add source files
set(SRC_FILES )
set(TEST_FILES xyz.cpp)

# Add executable
add_executable(${PROJECT_NAME} ${SRC_FILES} ${TEST_FILES})

# Unit testing
enable_testing()
find_package(GTest REQUIRED)
target_link_libraries(${PROJECT_NAME} GTest::gtest GTest::gtest_main)
target_include_directories(${PROJECT_NAME} 
    PRIVATE ${GTEST_INCLUDE_DIRS}
    PRIVATE ${CMAKE_SOURCE_DIR}/src
)

gtest_discover_tests(${PROJECT_NAME})
```

By running your cmake command, you will get a new target called `xyz_test` in your project.
and to view test cases you need to run `./tests/xyz`

## Gcovr
1. First you need to install gcovr library.
```bash
apt-get install gcovr
```

2. Second you need to add gcovr to your project.
```CMakeLists.txt
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
```

By running `make coverage` you will get a new target called `coverage` in your project.
and to view coverage report by openning the `build/coverage.html`