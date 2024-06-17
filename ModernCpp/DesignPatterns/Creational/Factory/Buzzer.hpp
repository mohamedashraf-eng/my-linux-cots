#include "IO.hpp"

//! Buzzer class
class Buzzer : public __ODev {
public:
    Buzzer() = default;

    void TurnOn();
    void TurnOff();

    ~Buzzer() = default;
};