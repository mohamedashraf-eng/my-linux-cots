//! Learning Design Patterns CPP_GOF_Singleton
//! @author Mohamed Ashraf
//
//! Used to import standard (cout, cin)
#include <iostream>
#include <string>

//! Interface for Legacy UART
//! This interface defines the basic operations for UART communication.
//! Any class that implements this interface must provide implementations for the read and write methods.
class LegacyUART {
public:
    virtual ~LegacyUART() = default;
    virtual void read() = 0;      //! Method to read data from UART
    virtual void write(const std::string& data) = 0; //! Method to write data to UART
};

//! Interface for SPI
//! This interface defines the basic operation for SPI communication.
//! Any class that implements this interface must provide an implementation for the transfer method.
class SPI {
public:
    virtual ~SPI() = default;
    virtual void transfer(const std::string& data) = 0; //! Method to transfer data over SPI
};

//! Concrete implementation of SPI
//! This class provides an implementation of the SPI interface.
//! It defines how data is transferred over SPI.
class SPIImpl : public SPI {
public:
    void transfer(const std::string& data) override {
        std::cout << "Transferring data over SPI: " << data << std::endl;
    }
};

//! Adapter class that makes UART compatible with SPI
//! This class adapts the LegacyUART interface to work with the SPI interface.
//! It implements the LegacyUART interface and uses an SPI object to perform the actual data transfer.
class UARTToSPIAdapter : public LegacyUART {
private:
    SPI& spi;  //! Reference to an SPI object
public:
    //! Constructor that initializes the SPI reference
    UARTToSPIAdapter(SPI& spi) : spi(spi) {}

    //! Implementation of the read method for UART
    //! This method adapts the read operation to be compatible with SPI.
    void read() override {
        std::cout << "Reading data via SPI adapter." << std::endl;
    }

    //! Implementation of the write method for UART
    //! This method adapts the write operation to call the transfer method of the SPI interface.
    void write(const std::string& data) override {
        std::cout << "Writing data via SPI adapter." << std::endl;
        spi.transfer(data); //! Call the SPI transfer method
    }
};

//! Concrete implementation of UART
//! This class provides an implementation of the LegacyUART interface.
//! It defines how data is read from and written to UART.
class UARTImpl : public LegacyUART {
public:
    void read() override {
        std::cout << "Reading data from UART." << std::endl;
    }

    void write(const std::string& data) override {
        std::cout << "Writing data to UART: " << data << std::endl;
    }
};

int main() {
    //! System testing
    
    //! Create an SPI object
    SPIImpl spi;
    
    //! Create an adapter to make UART compatible with SPI
    UARTToSPIAdapter adapter(spi);
    
    //! Using the adapter to perform UART operations via SPI
    adapter.read(); //! Read data using the adapter (via SPI)
    adapter.write("Hello, SPI!"); //! Write data using the adapter (via SPI)

    return 0;
}
