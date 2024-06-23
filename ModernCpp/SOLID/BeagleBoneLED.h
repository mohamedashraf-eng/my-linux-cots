#pragma once

#include "LEDInterface.h"
/**
 * @class BeagleBoneLED
 * @brief Concrete implementation of the LEDInterface for BeagleBone.
 *
 * This class implements the LEDInterface for BeagleBone. It provides the
 * functionality to turn on and turn off the BeagleBone LED.
 *
 * @see LEDInterface
 */
class BeagleBoneLED : public LEDInterface {
public:
    /**
     * @brief Turns on the LED on BeagleBone.
     *
     * This function is a part of the LEDInterface and is used to turn on the LED
     * on BeagleBone. It overrides the turnOn() function declared in LEDInterface.
     *
     * @see LEDInterface::turnOn()
     */
    void turnOn() override {
        std::cout << "BeagleBone LED is ON" << std::endl;
    }

    /**
     * @brief Turns off the LED on BeagleBone.
     *
     * This function is a part of the LEDInterface and is used to turn off the LED
     * on BeagleBone. It overrides the turnOff() function declared in LEDInterface.
     *
     * @see LEDInterface::turnOff()
     */
    void turnOff() override {
        std::cout << "BeagleBone LED is OFF" << std::endl;
    }
};
