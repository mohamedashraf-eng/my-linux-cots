#pragma once

/**
 * @class Component
 * @brief This class serves as a base class for all decorators.
 *
 * This class is part of the Decorator Design Pattern. The Decorator pattern allows us to add additional responsibilities to an
 * object dynamically by wrapping it with one or more decorator objects.
 *
 * The Component class defines the interface for objects that can have responsibilities added to them dynamically.
 *
 * @note This class is pure virtual and cannot be instantiated directly.
 */
class Component {
public:
    /**
     * @brief Virtual destructor.
     *
     * This destructor is declared as virtual so that it can be overridden by derived classes.
     *
     * This destructor is defined as a pure virtual function (i.e., it does not contain any implementation) since it is
     * intended to be overridden by derived classes.
     */
    virtual ~Component() {}

    /**
     * @brief Pure virtual function that defines the primary operation of the component.
     *
     * This function is declared as pure virtual and must be implemented by any class that inherits from Component.
     *
     * The operation() function is responsible for defining the primary behavior of the component. This function is
     * typically called by the client code to perform an operation on the component.
     *
     * @throws None
     */
    virtual void operation() = 0;
};
