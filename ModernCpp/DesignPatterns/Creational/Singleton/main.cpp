//! Learning Design Patterns CPP_GOF_Singleton
//! @author Mohamed Ashraf
//
//! Used to import standard (cout, cin)
#include <iostream>

//! Creational Patterns
//! The Singleton pattern is a creational design pattern that ensures a class has only one instance
//! and provides a global access point to this instance. This is useful when exactly one object is needed
//! to coordinate actions across the system.

//! The pattern involves two main components:
//! 1. Singleton Class: A class that is responsible for creating and managing its single instance. 
//!    It provides a static method to access the instance.
//! 2. Global Access Point: The method that allows access to the single instance.

//! Usage of Singleton Pattern:
//! - Define a private static member variable to hold the single instance of the class.
//! - Define a private constructor to prevent other classes from instantiating the class directly.
//! - Provide a public static method that returns the instance of the class. This method creates
//!   the instance if it does not already exist and returns the existing instance if it does.

//! Benefits of the Singleton Pattern:
//! - Ensures a class has only one instance and provides a single point of access to it.
//! - Useful in scenarios where a single resource or shared state is required, such as configuration settings,
//!   logging, or connection pools.

//! Example Scenario:
//! - Suppose we have a ParkingSystem class that manages a fixed number of parking slots.
//! - We use the Singleton pattern to ensure that only one instance of the ParkingSystem exists,
//!   avoiding multiple instances that could lead to inconsistent states.

//! Rules for singleton
//! Private constructor
//      : The class object will not be created outside the class.
//! Static instance with access method.
//      : static keyword will make the method not affected by the object which makes it accessible.
//      : static keyword will make the instance lifetime is class lifetime within program lifetime.

template <uint32_t total_available_slots>
class ParkingSystemSingleton {
private:
    int m_slots[total_available_slots]; //!< Array to store the car IDs in the parking slots.
    uint8_t m_slot_count;               //!< Counter to keep track of the number of occupied slots.
    uint8_t m_capacity;                 //!< Maximum capacity of the parking system.

    //! Private constructor to prevent instantiation.
    ParkingSystemSingleton() : m_slot_count(0), m_capacity(10) {
        for (auto& slot : m_slots) {
            slot = 0; //!< Initialize all slots to 0 indicating they are empty.
        }
    }

public:
    //! Singleton instance access method
    [[ nodiscard ]]
    static ParkingSystemSingleton& getInstance() {
        static ParkingSystemSingleton instance;
        return instance;
    }

    //! Method to add a car to the parking system.
    bool addCar(int carId) noexcept {
        if (m_slot_count == m_capacity) {
            std::cout << "Parking capacity full.\n";
            return false;
        }
        for (uint8_t i = 0; i < m_capacity; ++i) {
            if (m_slots[i] == 0) {
                m_slots[i] = carId;
                std::cout << "Added car with ID: " << carId << "\n";
                ++m_slot_count;
                return true;
            }
        }
        return false;
    }

    //! Method to remove a car from the parking system.
    bool leave(int carId) noexcept {
        for (uint8_t i = 0; i < m_capacity; ++i) {
            if (m_slots[i] == carId) {
                m_slots[i] = 0;
                std::cout << "Car with ID: " << carId << " removed\n";
                --m_slot_count;
                return true;
            }
        }
        std::cout << "Car with ID: " << carId << " is not found\n";
        return false;
    }

    //! Method to display the cars currently in the parking system.
    void show_cars() const noexcept {
        for (uint8_t i = 0; i < m_capacity; ++i) {
            if (m_slots[i] != 0) {
                std::cout << "Car with ID: " << m_slots[i] << " @slot " << static_cast<int>(i) << "\n";
            }
        }
    }

    //! Destructor (defaulted)
    ~ParkingSystemSingleton() = default;

    //! Deleting copy constructor and assignment operator to prevent multiple instances.
    ParkingSystemSingleton(const ParkingSystemSingleton&) = delete;
    ParkingSystemSingleton& operator=(const ParkingSystemSingleton&) = delete;
};

//! Creating a singleton pattern class
//! Singleton pattern means creating a single instance of a class
//! and providing a global access point to it.
//! We need the singleton pattern to avoid multiple instances of the class which leads to data conflict.
//! Note: Better naming convention for singleton pattern is to add it with the class name & class instance.
constexpr uint32_t total_available_slots = 100;
constexpr uint32_t open_capacity = 10;

int main() {
    //! System testing

    //! Get the singleton instance
    std::cout << "> Developer 1 is running on his .cpp \n";
    ParkingSystemSingleton<total_available_slots>& parking_system_singleton = ParkingSystemSingleton<total_available_slots>::getInstance();

    //! Add car with ID: i
    for (int i = 1; i <= static_cast<int>(open_capacity); ++i) {
        parking_system_singleton.addCar(i);
    }

    //! Here we are trying to add a car with ID: 11, but the capacity is full
    parking_system_singleton.addCar(12);

    //! Show cars
    parking_system_singleton.show_cars();

    //! Leave car with ID: 4, 6, 10
    parking_system_singleton.leave(4);
    parking_system_singleton.leave(6);
    parking_system_singleton.leave(10);

    //! Show cars
    parking_system_singleton.show_cars();

    //! The point here that the developer 2 develops on the same instance of the class.
    //! Developing compatibility.
    std::cout << "> Developer 2 is running on his .cpp \n";
    ParkingSystemSingleton<total_available_slots>& parking_system_singleton_2 = ParkingSystemSingleton<total_available_slots>::getInstance();
    parking_system_singleton_2.show_cars();

    return 0;
}
