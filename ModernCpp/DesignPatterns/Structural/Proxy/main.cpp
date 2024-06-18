//! Learning Design Patterns CPP_GOF_Singleton
//! @author Mohamed Ashraf
//
//! Used to import standard (cout, cin)
#include <iostream>


//! Proxy Design Pattern

//! Definition:
//! The Proxy structural design pattern provides a surrogate or placeholder for another object to control access to it.
//! This pattern is used to provide controlled access to a resource, such as a remote object, a large object in memory, or a secure resource.
//! 
//! Components:
//! 1. Subject: Defines the common interface for RealSubject and Proxy.
//! 2. RealSubject: The real object that the proxy represents.
//! 3. Proxy: Controls access to the RealSubject, implementing the same interface as the RealSubject.

//! Usage:
//! - Controlling access to a resource.
//! - Implementing lazy initialization (virtual proxy).
//! - Adding a layer of security (protection proxy).
//! - Managing remote resources (remote proxy).

//! Problem Solved:
//! The Proxy pattern solves the problem of controlling access to an object by providing a surrogate or placeholder that clients interact with, instead of the real object.
//! 
//! Example in Embedded Systems:
//! Consider an embedded system where accessing a sensor might be expensive or require security checks. A Proxy can be used to control access to the sensor.

//! Sensor defined interface
class ISensor {
public:
    virtual ~ISensor() {};
    virtual float read() = 0;
};

//! Real sensor code exist
class RealSensor : public ISensor {
public:
    float read() {
        std::cout << "Reading sensor \n";
        //! Random sensor read
        return 100.0f;
    }
};

//! Proxy sensor 
class ProxySensor : public ISensor {
private:
    RealSensor* m_realSensor;
    bool m_access;
public:
    ProxySensor() : m_realSensor(new RealSensor()), m_access(false) {}

    void grant_access() {
        m_access = true;
    }

    void revoke_address() {
        m_access = false;
    }

    float read() override {
        if (m_access) {
            return m_realSensor->read();
        }
        //! throw exception 
        std::cout << "Access denied to sensor @" << m_realSensor << "\n";
        return -1;
    }

    ~ProxySensor() override {
        if (m_realSensor) {
            delete m_realSensor;
        }
    }
};

//! Explanation:
//! 1. **Sensor**: This is the Subject interface that defines the common interface for the RealSubject and Proxy.
//! 2. **RealSensor**: This is the RealSubject that implements the actual sensor reading functionality.
//! 3. **SensorProxy**: This is the Proxy that controls access to the RealSensor. It implements the same interface as the RealSubject.
//! 4. **Client code**: The client code interacts with the SensorProxy, which controls access to the RealSensor.
//! 
//! In this example, the Proxy controls access to the RealSensor. The client must request access from the Proxy, which can grant or deny access to the sensor.
//! This adds a layer of control and security to the sensor access.
int main() {
    //! System testing
    
    ProxySensor* sensor = new ProxySensor();
    
    //! Reading sensor value with access
    sensor->grant_access();
    std::cout << sensor->read() << "\n";
    
    //! Try to read sensor value without access
    sensor->revoke_address();
    std::cout << sensor->read() << "\n";

    delete sensor;

    return 0;
}
