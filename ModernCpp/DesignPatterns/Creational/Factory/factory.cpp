#include "factory.hpp"
#include "Led.hpp"
#include "Buzzer.hpp"

__ODev* IOFactory::GetODevHandle(IOFactory::IODevices dev) {
    //! Allocate
    __ODev* handle = nullptr;
    
    switch(dev) {
        case ODevLed    : {
            handle = new Led();
            //! Add some processes before returnning the handle. 
            break; 
        }   
        case ODevBuzzer : {
            handle = new Buzzer();
            //! Add some processes before returnning the handle.
            break; 
        }   

        //! throw error
        default: std::cout << "Device not recognized \n";
    }
    //! Process
    if(handle == nullptr) {
        std::cout << "Error creating device \n";
        //! throw error
        return nullptr;
    }

    m_allocated_odevs.push_back(handle);
    //! Return
    return handle;
}

__IDev* IOFactory::GetIDevHandle(IOFactory::IODevices dev) {
    //! @TODO: Implement
    return nullptr;
}

IOFactory::~IOFactory() {

    // if(!m_allocated_odevs.empty()) {
    //     for(const auto& e : m_allocated_odevs) {
    //         delete e;
    //     }
    // }

    //! @TODO: Implement IDevs
}