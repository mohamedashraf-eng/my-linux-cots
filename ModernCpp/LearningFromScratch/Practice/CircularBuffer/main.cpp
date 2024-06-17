//! @author Mohamed Ashraf
//
//! Used to import stadnard (cout, cin)
#include <iostream>
#include "circular_buffer.hpp"

int main(void) {
    std::cout << "Circular buffer modern C++ \n"; 
    
    constexpr uint32_t size = 10;
    buffer::CircularBuffer<int, size> mybuffer;

    return 0;
}