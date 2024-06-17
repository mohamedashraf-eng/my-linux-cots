#pragma once

#include <iostream>

//! Input Devices Interface 
class __IDev {
public:
    __IDev() = default;

    //! Method to read state of input devices
    //! such as buttons.
    virtual void GetState() = 0;

    ~__IDev() = default;
};

//! Output Devices Interface
class __ODev {
public:
    __ODev() = default;

    //! Methods to turn on/off output devices
    //! such as leds.
    virtual void TurnOn() = 0;
    virtual void TurnOff() = 0;

    ~__ODev() = default;
};

