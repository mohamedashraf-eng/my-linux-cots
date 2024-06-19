#pragma once

#include "IO.hpp"
#include <vector>

//! Factory is a creational design pattern used to abstract and secure 
//! the creation of objects of your module.


//! For example here is a factory for the I/O modules provided.
//! The main rule is to create a class that inherits from the base class and implements the interface.
//! The factory will create the object and return a pointer to it.
class IOFactory {
private:
    std::vector<__ODev*> m_allocated_odevs;
    std::vector<__IDev*> m_allocated_idevs;
public:
    IOFactory() = default;

    //! A support enum used to make code readable.
    typedef enum {
        ODevLed,
        ODevSpeaker,
        ODevBuzzer,
        IDevButton,
        IODevNone //! < Used as default value.
    } IODevices;

    __ODev* GetODevHandle(IODevices dev);
    __IDev* GetIDevHandle(IODevices dev);

    virtual ~IOFactory();
};