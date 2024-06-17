#pragma once

#include <vector>
#include <algorithm>
#include <cstdint>
#include <iostream>

// Forward declaration of Observer class
class Observer;

// Subject class
class Sensor {
private:
    std::vector<Observer*> observers;
    uint8_t sensorValue;

public:
    void attach(Observer* obs);
    void detach(Observer* obs);
    void notify();
    void setSensorValue(uint8_t value);
    uint8_t getSensorValue() const;
};

