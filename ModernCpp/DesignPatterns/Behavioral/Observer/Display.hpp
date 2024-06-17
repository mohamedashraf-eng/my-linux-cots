#pragma once

#include "Observer.hpp"
#include "Sensor.hpp"
#include <iostream>

// Concrete Observer class
class Display : public Observer {
private:
    Sensor& sensor;

public:
    Display(Sensor& s) : sensor(s) {
        sensor.attach(this);
    }

    ~Display() {
        sensor.detach(this);
    }

    void update() override {
        std::cout << "Display: Sensor value updated to " << static_cast<int>(sensor.getSensorValue()) << std::endl;
    }
};
