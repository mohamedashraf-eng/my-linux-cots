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

int main() {
    LEDInterface* rpiLED = new RaspberryPiLED();
    LEDInterface* bbLED = new BeagleBoneLED();

    LEDController controller(rpiLED);
    controller.turnOn();
    controller.turnOff();

    controller = LEDController(bbLED);
    controller.turnOn();
    controller.turnOff();

    delete rpiLED;
    delete bbLED;

    return 0;
}
