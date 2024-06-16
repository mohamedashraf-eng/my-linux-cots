/**
 * @file main.cpp
 * 
 * @brief Modern C++ - Operator overload
 * 
 * @details
 *      
**/
#include <iostream>

// Operator overload
// Treat the operator as function with highlited syntax
// operator<x> for example: operator+, operator-, operator&
//
// General form: return_type operator<x>(const_reference_type a, const_reference_type b)
std::string operator+(std::string&a, std::string&b) {
    std::cout << "Operator overload as string \n";

    // Action
    std::string result = a.append(b);

    return result;
}
// Operator overload as function overload 
std::string operator+(int a, std::string b) {
    std::cout << "Operator overload as int \n";

    // Action
    std::string result = std::to_string(a).append(b);

    return result;
}

int main(void) {


    std::cout << 5 + std::string{"Ashraf"} << "\n";

    return 0;
}