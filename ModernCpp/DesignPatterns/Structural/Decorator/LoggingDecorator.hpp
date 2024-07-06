#pragma once

#include "Decorator.hpp"
#include <iostream>

/**
 * @class LoggingDecorator
 * @brief Decorator that logs the start and end of an operation.
 *
 * This class is part of the Decorator Design Pattern. The Decorator pattern allows us to add additional responsibilities to an
 * object dynamically by wrapping it with one or more decorator objects.
 *
 * The LoggingDecorator class is a concrete implementation of the Decorator interface. It adds the ability to log the start and
 * end of an operation. When the operation() method is called, it logs a message indicating that the operation has started,
 * then calls the operation() method of the component it is decorating, and finally logs a message indicating that the operation
 * has ended.
 *
 * @note This class is instantiated by the client code to add the logging behavior to a component.
 *
 * @section Examples
 *
 * - Embedded Linux:
 *   + The LoggingDecorator can be used to log the start and end of various operations in a system, such as starting,
 *     stopping, or resetting hardware components like sensors, actuators, or communication interfaces.
 *
 * @section See Also
 *
 * - Decorator
 * - Component
 */
class LoggingDecorator : public Decorator {
public:
    /**
     * @brief Constructor that initializes the component reference.
     *
     * @param comp Pointer to the component being decorated.
     */
    LoggingDecorator(Component* comp) : Decorator(comp) {}

    /**
     * @brief Implementation of the operation method.
     *
     * This method logs a message indicating that the operation has started, then calls the operation() method of the
     * component it is decorating, and finally logs a message indicating that the operation has ended.
     *
     * @throws None
     */
    void operation() override {
        std::cout << "Logging: Operation started." << std::endl;
        Decorator::operation();
        std::cout << "Logging: Operation ended." << std::endl;
    }
};
