//! Learning Design Patterns 
//! @author Mohamed Ashraf
//

//! Strategy Design Pattern in C++
//! The Strategy design pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable.
//! This pattern lets the algorithm vary independently from the clients that use it.
//! 
//! Components of Strategy Design Pattern:
//! 1. Strategy: Declares an interface common to all supported algorithms.
//! 2. ConcreteStrategy: Implements the algorithm using the Strategy interface.
//! 3. Context: Maintains a reference to a Strategy object and uses it to call the algorithm defined by a ConcreteStrategy.
//! 
//! Usage Example for Embedded Linux:
//! In an embedded Linux environment, the Strategy pattern can be used to handle different power-saving strategies
//! depending on the system state or user preference.

#include <iostream>

//! Explanation:
//! 1. The `PowerSavingStrategy` interface declares a `savePower` method.
//! 2. `NormalPowerSaving` and `AggressivePowerSaving` are concrete implementations of the `PowerSavingStrategy` interface.
//!    They provide specific implementations for the `savePower` method.
//! 3. The `PowerManager` class acts as the context. It maintains a reference to a `PowerSavingStrategy` object and uses it to apply the power-saving strategy.
//! 4. In the client code, we create instances of `NormalPowerSaving` and `AggressivePowerSaving` and set them as the strategy in the `PowerManager`.
//!   We then call the `applyStrategy` method to execute the chosen power-saving strategy.

// Strategy interface
class PowerSavingStrategy {
public:
    virtual ~PowerSavingStrategy() {}
    virtual void savePower() = 0;
};

// ConcreteStrategy classes
class NormalPowerSaving : public PowerSavingStrategy {
public:
    void savePower() override {
        std::cout << "Normal power-saving strategy activated." << std::endl;
        // Implementation for normal power saving
    }
};

class AggressivePowerSaving : public PowerSavingStrategy {
public:
    void savePower() override {
        std::cout << "Aggressive power-saving strategy activated." << std::endl;
        // Implementation for aggressive power saving
    }
};

// Context class
class PowerManager {
public:
    void setStrategy(PowerSavingStrategy* strategy) {
        strategy_ = strategy;
    }
    void applyStrategy() {
        if (strategy_) {
            strategy_->savePower();
        }
    }
private:
    PowerSavingStrategy* strategy_ = nullptr;
};

// Client code
int main() {
    // Create ConcreteStrategy objects
    NormalPowerSaving normalPowerSaving;
    AggressivePowerSaving aggressivePowerSaving;
    
    // Create a context
    PowerManager powerManager;
    
    // Apply normal power-saving strategy
    powerManager.setStrategy(&normalPowerSaving);
    powerManager.applyStrategy();
    
    // Apply aggressive power-saving strategy
    powerManager.setStrategy(&aggressivePowerSaving);
    powerManager.applyStrategy();
    
    return 0;
}
