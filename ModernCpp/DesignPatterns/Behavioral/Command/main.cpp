//! Learning Design Patterns CPP_GOF_Singleton
//! @author Mohamed Ashraf
//

//! Command Design Pattern in C++
//! The Command design pattern is a behavioral design pattern in which an object is used to encapsulate 
//! all information needed to perform an action or trigger an event at a later time.
//! This information includes the method name, the object that owns the method, and values for the method parameters.

//! Components of Command Design Pattern:
//! 1. Command: Declares an interface for executing an operation.
//! 2. ConcreteCommand: Defines a binding between a Receiver object and an action. Implements Execute by invoking the corresponding operation(s) on Receiver.
//! 3. Client: Creates a ConcreteCommand object and sets its receiver.
//! 4. Invoker: Asks the command to carry out the request.
//! 5. Receiver: Knows how to perform the operations associated with carrying out a request.

//! Usage Example for Embedded Linux:
//! In an embedded Linux environment, the Command pattern can be used to handle various operations,
//! such as starting, stopping, or resetting hardware components like sensors, actuators, or communication interfaces.
 
#include <iostream>
#include <vector>

//! Explanation:
//! 1. The `Command` interface declares an `execute` method.
//! 2. The `LED` class is the receiver that knows how to perform specific actions (turning the LED on and off).
//! 3. `LEDOnCommand` and `LEDOffCommand` are concrete implementations of the `Command` interface, binding the `LED` actions.
//! 4. The `RemoteControl` class acts as the invoker that triggers the commands.
//! 5. In the client code, we create the receiver (`LED`), concrete commands (`LEDOnCommand` and `LEDOffCommand`), and the invoker (`RemoteControl`).
//!    We then set the command in the invoker and execute it by pressing the button.
 
// Command interface
class Command {
public:
    virtual ~Command() {}
    virtual void execute() = 0;
};

// Receiver class
class LED {
public:
    void on() {
        std::cout << "LED is ON" << std::endl;
    }
    void off() {
        std::cout << "LED is OFF" << std::endl;
    }
};

// ConcreteCommand classes
class LEDOnCommand : public Command {
public:
    LEDOnCommand(LED* led) : led_(led) {}
    void execute() override {
        led_->on();
    }
private:
    LED* led_;
};

class LEDOffCommand : public Command {
public:
    LEDOffCommand(LED* led) : led_(led) {}
    void execute() override {
        led_->off();
    }
private:
    LED* led_;
};

// Invoker class
class RemoteControl {
public:
    void setCommand(Command* command) {
        command_ = command;
    }
    void pressButton() {
        if (command_) {
            command_->execute();
        }
    }
private:
    Command* command_ = nullptr;
};

// Client code
int main() {
    // Create a receiver
    LED led;
    
    // Create ConcreteCommand objects
    LEDOnCommand ledOn(&led);
    LEDOffCommand ledOff(&led);
    
    // Create an invoker
    RemoteControl remote;
    
    // Execute commands through the invoker
    remote.setCommand(&ledOn);
    remote.pressButton();
    
    remote.setCommand(&ledOff);
    remote.pressButton();
    
    return 0;
}


