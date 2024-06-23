#pragma once

/**
 * @class LEDInterface
 * @brief Interface for controlling LEDs.
 * 
 * This class is an interface for controlling LEDs. It declares methods to turn
 * on and off the LEDs. The declaration of these methods is pure virtual, which
 * means they have to be implemented by the concrete classes.
 * 
 * The destructor is declared as virtual to ensure proper cleanup of the
 * derived classes.
 */
class LEDInterface {
public:
    /**
     * @brief Turn on the LED.
     * 
     * This method is pure virtual and must be implemented by the concrete
     * classes. It is used to turn on the LED.
     */
    virtual void turnOn() = 0;
    
    /**
     * @brief Turn off the LED.
     * 
     * This method is pure virtual and must be implemented by the concrete
     * classes. It is used to turn off the LED.
     */
    virtual void turnOff() = 0;
    
    /**
     * @brief Destructor.
     * 
     * The destructor is declared as virtual to ensure proper cleanup of the
     * derived classes.
     */
    virtual ~LEDInterface() {}
};
