#!/bin/bash

make_build=$1
run_tests=$2
run_project=$3

if [ "$make_build" = "1" ]; then
    make -C build/ -j$(nproc)
fi

if [ "$run_tests" = "1" ]; then
    ./build/tests/circular_buffer_test
    make -C build/ coverage
fi

if [ "$run_project" = "1" ]; then
    ./build/main
fi
