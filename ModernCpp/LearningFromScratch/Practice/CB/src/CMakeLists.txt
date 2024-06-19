cmake_minimum_required(VERSION 3.22)

project(circular_buffer)

set(SRC_FILES main.cpp circular_buffer.cpp)

add_executable(${PROJECT_NAME} ${SRC_FILES})
