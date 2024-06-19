/**
 * @file main.cpp
 * 
 * @brief Modern C++ - Simple menu project
 * 
 * @details
 *      
**/
#include <iostream>
#include <array>
#include <string>

constexpr uint8_t USER_CHOOSE_PIZZA = '1'; 
constexpr uint8_t USER_CHOOSE_PASTA = '2'; 

int main(void) {
    char choice = 0;

    std::cout << "Food menu" << "\n";
    std::cout << "1. Pizza" << "\n";
    std::cout << "2. Pasta" << "\n";

    std::cout << "Enter your choice: ";
    std::cin.get(choice);

    if(USER_CHOOSE_PIZZA == choice) {
        std::cout << "Your pizza is $4" << "\n";
    } else if(USER_CHOOSE_PASTA == choice) {
        std::cout << "Your pasta is $5" << "\n";
    } else {
        std::cout << "Invalid option" << "\n";
    }

    return 0;
}