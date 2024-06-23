#pragma once

#include "LEDInterface.h"
/**
 * @class RaspberryPiLED
 * @brief This class represents a LED attached to a Raspberry Pi board.
 * 
 * The class implements the LEDInterface interface and provides implementation for the turnOn() and turnOff() methods.
 * 
 * @see LEDInterface
 */
class RaspberryPiLED : public LEDInterface {
public:
    /**
     * @brief Turn on the LED
     */
    void turnOn() override {
        std::cout << "Raspberry Pi LED is ON" << std::endl;
    }

    /**
     * @brief Turn off the LED
     */
    void turnOff() override {
        std::cout << "Raspberry Pi LED is OFF" << std::endl;
    }
};
