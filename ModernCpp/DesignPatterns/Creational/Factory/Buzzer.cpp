#include "Buzzer.hpp"

void Buzzer::TurnOn() {
    std::cout << "Turned on Buzzer @" << this << "\n";
}

void Buzzer::TurnOff() {
    std::cout << "Turned off Buzzer @" << this << "\n";
}