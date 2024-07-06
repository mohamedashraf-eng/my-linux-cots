#pragma once

#include "Component.hpp"
#include <iostream>

/**
 * @class ConcreteComponent
 * @brief Concrete implementation of the Component interface.
 *
 * This class is part of the Decorator Design Pattern. The Decorator pattern allows us to add additional responsibilities to an
 * object dynamically by wrapping it with one or more decorator objects.
 *
 * The ConcreteComponent class is a concrete implementation of the Component interface. It defines the behavior of the
 * component and provides the implementation of the operation() method.
 *
 * @note This class cannot be instantiated directly. It must be subclassed to provide the specific behavior of the component.
 */
class ConcreteComponent : public Component {
public:
    /**
     * @brief Performs the operation defined by the component.
     *
     * This method is part of the Component interface and is implemented by the ConcreteComponent class. It provides the
     * specific behavior of the component and is called by the client code.
     *
     * @throws None
     */
    void operation() override {
        std::cout << "Performing operation in ConcreteComponent." << std::endl;
    }
};
