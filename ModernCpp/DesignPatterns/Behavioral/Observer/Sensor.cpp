#include "Sensor.hpp"
#include "Observer.hpp"

void Sensor::attach(Observer* obs) {
    observers.push_back(obs);
}

void Sensor::detach(Observer* obs) {
    observers.erase(std::remove(observers.begin(), observers.end(), obs), observers.end());
}

void Sensor::notify() {
    for (auto* obs : observers) {
        obs->update();
    }
}

void Sensor::setSensorValue(uint8_t value) {
    sensorValue = value;
    notify();
}

uint8_t Sensor::getSensorValue() const {
    return sensorValue;
}
