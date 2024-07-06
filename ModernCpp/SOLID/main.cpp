#include <iostream>
#include "LEDController.h"
#include "RaspberryPiLED.h"
#include "BeagleBoneLED.h"

//! 
//! SRP: Each class has a single responsibility (e.g., RaspberryPiLED controls the LED specific to Raspberry Pi).
//! OCP: New platform-specific LED classes can be added without modifying existing ones.
//! LSP: The LEDController can use any derived class of LEDInterface without issues.
//! ISP: Each platform has its specific implementation without forcing methods that are not used.
//! DIP: LEDController depends on the LEDInterface abstraction, not concrete implementations.

//! LEDInterface: The interface for LED control, ensuring all derived classes implement turnOn and turnOff methods.
//! RaspberryPiLED and BeagleBoneLED: Platform-specific implementations of the LED control interface.
//! LEDController: The high-level module that uses an instance of LEDInterface to control the LED, demonstrating dependency inversion.
//! Main: Demonstrates how to switch between different platform implementations without changing the LEDController logic, 
//! adhering to the open/closed principle.


/**
 * @brief Main function that demonstrates the usage of the LEDController.
 *
 * @return int The exit status of the program.
 *
 * @throws None
 */
int main() {
    RaspberryPiLED* rpiLED = new RaspberryPiLED();
    BeagleBoneLED* bbLED = new BeagleBoneLED();

    LEDController<RaspberryPiLED> controllerRpi(rpiLED);
    controllerRpi.turnOn();
    controllerRpi.turnOff();

    LEDController<BeagleBoneLED> controllerBb(bbLED);
    controllerBb.turnOn();
    controllerBb.turnOff();

    delete rpiLED;
    delete bbLED;

    return 0;
}
