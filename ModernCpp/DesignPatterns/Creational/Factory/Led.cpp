#include "Led.hpp"


void Led::TurnOn() {
    std::cout << "Turned on Led @" << this << "\n";
}

void Led::TurnOff() {
    std::cout << "Turned off Led @" << this << "\n";
}
