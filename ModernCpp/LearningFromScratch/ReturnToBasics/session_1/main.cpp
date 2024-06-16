/**
 * @file main.cpp
 * 
 * @brief Modern C++ - String
 * 
 * @details
 *      
**/
#include <iostream>
#include <string>

void print_str(std::string& str) {
    // Iterator
    if (!str.empty()) {
        for(auto& e : str) {
            std::cout << e << "";
        } std::cout << "\n";
    }
}

int main(void) {
    // Init as array/vector
    std::string str {"Hello World"};

    std::cout << "Size: " << str.size() << "\n";
    std::cout << "Length: " << str.length() << "\n";
    std::cout << "Capacity: " << str.capacity() << "\n";
    std::cout << "Empty: " << str.empty() << "\n";
    std::cout << "Data: " << str.data() << "\n";
    std::cout << "Front: " << str.front() << "\n";
    std::cout << "Back: " << str.back() << "\n";
    std::cout << "At: " << str.at(0) << "\n";

    // Modifiers
    print_str(str);

    return 0;
}