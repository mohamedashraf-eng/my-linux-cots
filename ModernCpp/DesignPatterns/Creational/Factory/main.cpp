//! Learning Design Patterns CPP_GOF_Singleton
//! @author Mohamed Ashraf
//
//! Used to import standard (cout, cin)
#include <iostream>
#include "IO.hpp"
#include "Led.hpp"
#include "Buzzer.hpp"
#include "factory.hpp"

//! Creational Design Patterns
//! The Factory pattern is a creational design pattern that provides an interface for creating objects
//! in a superclass, but allows subclasses to alter the type of objects that will be created.
//! It defines a method for creating objects but lets subclasses decide which class to instantiate.

//! The pattern involves three main components:
//! 1. Product: The interface or abstract class that defines the type of objects the factory method creates.
//! 2. Concrete Product: A class that implements the Product interface.
//! 3. Creator: An abstract class or interface that declares the factory method, which returns an object of type Product.
//! 4. Concrete Creator: A class that implements the Creator and overrides the factory method to return an instance of a Concrete Product.!

//! Usage of Factory Pattern:
//! - Define an interface or abstract class (Product) that defines the object type to be created.
//! - Create Concrete Product classes that implement the Product interface.
//! - Define a Creator class that declares the factory method to create objects of type Product.
//! - Implement Concrete Creator classes that override the factory method to instantiate Concrete Product objects.

//! Benefits of the Factory Pattern:
//! - It promotes loose coupling by reducing the dependency of a class on its concrete implementations.
//! - It makes the code more flexible and reusable by allowing the addition of new products without changing the existing code.
//! - It provides a single point of control for creating objects, which can include additional logic for object creation.

//! Example Scenario:
//! - Suppose we have different types of I/O devices such as LED, Speaker, and Buzzer.
//! - We use the Factory pattern to create instances of these devices through a unified interface,
//!   allowing the client code to request devices without knowing their concrete implementations.

int main() {
    //! System testing

    //! 
    __ODev* my_led = IOFactory().GetODevHandle(IOFactory::ODevLed);

    //! 
    __ODev* my_buzzer = IOFactory().GetODevHandle(IOFactory::ODevBuzzer);
    
    my_led->TurnOn();
    my_buzzer->TurnOn();

    return 0;
}
