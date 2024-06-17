cmake_minimum_required(VERSION 3.22)

project(circular_buffer)

option(COMPILE "Enable code compile" OFF)

if(COMPILE)
    add_subdirectory(src)
else()
    add_subdirectory(tests)
endif()

