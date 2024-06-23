#pragma once

#include "LEDInterface.h"
/**
 * @class LEDController
 * @brief This class represents a controller for controlling an LED.
 *
 * The LEDController class acts as a controller for controlling an LED.
 * It encapsulates the LEDInterface object and provides methods to turn
 * the LED on and off.
 *
 * @section sec_usage Usage
 *
 * To use the LEDController class, create an instance of the LEDController
 * class and pass a pointer to an LEDInterface object to the constructor.
 * You can then call the `turnOn()` and `turnOff()` methods to control the LED.
 *
 * @code
 * LEDInterface* led = new RaspberryPiLED();
 * LEDController controller(led);
 * controller.turnOn();
 * controller.turnOff();
 * @endcode
 *
 * @section sec_members Members
 *
 * The LEDController class has the following members:
 *
 * @var LEDInterface* led
 * The LEDInterface object that represents the LED.
 *
 * @section sec_methods Methods
 *
 * The LEDController class has the following methods:
 *
 * @fn LEDController(LEDInterface* led)
 * Constructor for the LEDController class.
 *
 * @param led A pointer to the LEDInterface object.
 *
 * @fn void turnOn()
 * Turns on the LED.
 *
 * @fn void turnOff()
 * Turns off the LED.
 *
 * @section sec_example Example
 *
 * @code
 * LEDInterface* led = new RaspberryPiLED();
 * LEDController controller(led);
 * controller.turnOn();
 * controller.turnOff();
 * @endcode
 */
class LEDController {
private:
    LEDInterface* led;  //!< The LEDInterface object that represents the LED.
public:
    /**
     * @brief Constructor for the LEDController class.
     *
     * @param led A pointer to the LEDInterface object.
     */
    LEDController(LEDInterface* led) : led(led) {}

    /**
     * @brief Turns on the LED.
     */
    void turnOn() {
        led->turnOn();
    }

    /**
     * @brief Turns off the LED.
     */
    void turnOff() {
        led->turnOff();
    }
};
