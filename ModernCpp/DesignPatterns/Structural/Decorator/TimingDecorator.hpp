#pragma once

#include "Decorator.hpp"
#include <iostream>
#include <chrono>

/**
 * @class TimingDecorator
 * @brief Decorator that times the duration of an operation.
 *
 * This class is part of the Decorator Design Pattern. The Decorator pattern allows us to add additional responsibilities to an
 * object dynamically by wrapping it with one or more decorator objects.
 *
 * The TimingDecorator class is a concrete implementation of the Decorator interface. It adds the ability to measure the duration
 * of an operation. When the operation() method is called, it records the start time, calls the operation() method of the
 * component it is decorating, and finally calculates the duration of the operation and logs it.
 *
 * @note This class is instantiated by the client code to add the timing behavior to a component.
 *
 * @section Examples
 *
 * - Embedded Linux:
 *   + The TimingDecorator can be used to measure the duration of various operations in a system, such as starting,
 *     stopping, or resetting hardware components like sensors, actuators, or communication interfaces.
 *
 * @section See Also
 *
 * - Decorator
 * - Component
 */
class TimingDecorator : public Decorator {
public:
    /**
     * @brief Constructor that initializes the component reference.
     *
     * @param comp Pointer to the component being decorated.
     */
    TimingDecorator(Component* comp) : Decorator(comp) {}

    /**
     * @brief Implementation of the operation method.
     *
     * This method records the start time, calls the operation() method of the component it is decorating,
     * and finally calculates the duration of the operation and logs it.
     *
     * @throws None
     */
    void operation() override {
        auto start = std::chrono::high_resolution_clock::now();
        Decorator::operation();
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;
        std::cout << "Timing: Operation took " << duration.count() << " seconds." << std::endl;
    }
};
