/**
 * @file main.cpp
 * 
 * @brief Modern C++ - Array
 * 
 * @details
 *      
**/
#include <iostream>
#include <array>

int main(void) {
    constexpr int n_arr = 5;

    // init blank (cpp-guideline refuses) &
    // Refused by cpp core-guideline
    // std::array<int8_t, n_arr> myarr_init_blank;

    // init with value
    std::array<int8_t, n_arr> myarr_init_values {1, 2, 3, 4, 5};

    // Iterate 
    for (auto& elem : myarr_init_values) {
        std::cout << elem << " ";
    }
    std::cout << "\n";

    // operations
    std::cout << "Array front: " <<  myarr_init_values.front() << "\n";
    std::cout << "Array back: " <<  myarr_init_values.back() << "\n"; 
    std::cout << "Array size: " <<  myarr_init_values.size() << "\n";
    std::cout << "Array max_size: " <<  myarr_init_values.max_size() << "\n";
    std::cout << "Array empty: " <<  myarr_init_values.empty() << "\n";
    std::cout << "Array data: " <<  myarr_init_values.data() << "\n";

    // fill
    myarr_init_values.fill(10);

    return 0;
}