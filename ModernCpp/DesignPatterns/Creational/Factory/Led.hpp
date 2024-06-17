#include "IO.hpp"

//! Led class
class Led : public __ODev {
public:
    Led() = default;

    void TurnOn();
    void TurnOff();

    ~Led() = default;
};