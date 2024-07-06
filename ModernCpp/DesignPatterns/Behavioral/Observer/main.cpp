//! Learning Design Patterns 
//! @author Mohamed Ashraf
//
#include "Sensor.hpp"
#include "Display.hpp"

//! Observer Design Pattern in C++
//! The Observer design pattern defines a one-to-many dependency between objects
//! so that when one object changes state, all its dependents are notified and updated automatically.
//! It is mainly used to implement distributed event handling systems.
//! The Observer pattern is also known as Dependents or Publish-Subscribe.

//! Components of Observer Design Pattern:
//! 1. Subject: The object that has some interesting state.
//! 2. Observer: The object that wants to be notified when the Subject changes.
//! 3. ConcreteSubject: The object that stores the state of interest to ConcreteObserver objects.
//! 4. ConcreteObserver: The object that implements the Observer interface to keep its state consistent with the Subject's.

//! Usage Example for Embedded Linux:
//! In an embedded Linux environment, the Observer pattern can be used to manage 
//! event notifications between different modules, such as sensors and the main control unit.

//! Example Scenario:
//! 1. A sensor module (ConcreteSubject) continuously monitors a physical parameter.
//! 2. Multiple display modules (ConcreteObservers) need to be updated whenever the sensor value changes.
//! 3. The sensor module notifies all registered display modules when there is a change in the sensor value.

//! In the embedded Linux system, the implementation may involve:
//! - Using a message queue or shared memory for communication between the sensor and display modules.
//! - The sensor module would act as the Subject and send notifications (messages) to the observers (display modules).
//! - The display modules would register themselves with the sensor module to receive updates.

int main() {
    Sensor sensor;
    Display display1(sensor);
    Display display2(sensor);

    sensor.setSensorValue(42); // Both displays will be updated
    sensor.setSensorValue(84); // Both displays will be updated

    return 0;
}
