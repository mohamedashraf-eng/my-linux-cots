#pragma once

#include "Component.hpp"

/**
 * @class Decorator
 * @brief Decorator class that wraps an object to add additional responsibilities dynamically.
 *
 * This class is part of the Decorator Design Pattern. The Decorator pattern allows us to add additional
 * responsibilities to an object dynamically by wrapping it with one or more decorator objects.
 *
 * The Decorator class is a wrapper that adds behavior to an object (the component) by implementing the
 * Component interface. It maintains a reference to the component it is decorating. The Decorator class
 * provides a default implementation of the Component interface by simply calling the operation() method
 * of the component it is decorating.
 *
 * @note This class is abstract and cannot be instantiated directly. It must be subclassed to provide the
 * specific behavior of the decorator.
 *
 * @section Examples
 *
 * - Embedded Linux:
 *   + The Command pattern can be used to handle various operations, such as starting, stopping, or resetting
 *     hardware components like sensors, actuators, or communication interfaces.
 *
 * @section See Also
 *
 * - Component
 */
class Decorator : public Component {
protected:
    /**
     * @brief Pointer to the component being decorated.
     */
    Component* component;
public:
    /**
     * @brief Constructor that initializes the component reference.
     *
     * @param comp Pointer to the component being decorated.
     */
    Decorator(Component* comp) : component(comp) {}

    /**
     * @brief Implementation of the operation method.
     *
     * This method calls the operation() method of the component it is decorating.
     *
     * @throws None
     */
    void operation() override {
        component->operation();
    }
};
