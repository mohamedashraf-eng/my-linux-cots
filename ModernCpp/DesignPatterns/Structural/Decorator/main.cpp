//! Learning Design Patterns 
//! @author Mohamed Ashraf
//

#include <iostream>
#include "ConcreteComponent.hpp"
#include "LoggingDecorator.hpp"
#include "TimingDecorator.hpp"

/**
 * Main function that demonstrates the usage of the Decorator design pattern.
 *
 * @return 0 indicating successful execution
 *
 * @throws None
 */
int main() {
    Component* component = new ConcreteComponent();
    Component* loggingDecorator = new LoggingDecorator(component);
    Component* timingDecorator = new TimingDecorator(loggingDecorator);
    
    timingDecorator->operation();

    delete timingDecorator;
    delete loggingDecorator;
    delete component;

    return 0;
}


